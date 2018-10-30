package com.test.rememberTest;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.persistence.criteria.CriteriaBuilder.In;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.sl.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.test.rememberTest.Dto.RealTimeDto;
import com.test.rememberTest.Dto.RecordDto;
import com.test.rememberTest.Dto.Teach_bus_checkDto;

import antlr.collections.impl.LList;

//@Component("AbstractExcelView")
public class listDown_Excel_carCheck extends AbstractExcelView{

	@Override
	protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		System.out.println("listDown_Excel_carCheck 접속");
		String sCurTime = null;
        sCurTime = new SimpleDateFormat("yyyyMMdd", Locale.KOREA).format(new Date());
     
        String excelName = sCurTime + "_차량일일점검표.xls";			// 다운로드 파일 명 (날짜 _제목.xls)
        HSSFSheet worksheet = null;
        Row row = null;
        
        CellStyle style = workbook.createCellStyle(); // 셀 스타일을 위한 변수
        HSSFDataFormat format = workbook.createDataFormat();	//엑셀 시간 서식하려고
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 글 위치를 중앙으로 설정
        style.setDataFormat(format.getFormat("hh:mm:ss")); 
        style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        style.setBorderRight(HSSFCellStyle.BORDER_THIN);
        style.setBorderTop(HSSFCellStyle.BORDER_THIN);
        
        CellStyle style_normal = workbook.createCellStyle();
        style_normal.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        style_normal.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        style_normal.setBorderRight(HSSFCellStyle.BORDER_THIN);
        style_normal.setBorderTop(HSSFCellStyle.BORDER_THIN);
        
        CellStyle style_Title =  workbook.createCellStyle();
        style_Title.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        Font title_font = workbook.createFont();
        title_font.setFontHeightInPoints((short)14);
        title_font.setBold(true);
        style_Title.setFont(title_font);
//        style_Title.setBorderBottom(HSSFCellStyle.BORDER_THIN);
//        style_Title.setBorderLeft(HSSFCellStyle.BORDER_THIN);
//        style_Title.setBorderRight(HSSFCellStyle.BORDER_THIN);
//        style_Title.setBorderTop(HSSFCellStyle.BORDER_THIN);
        
        CellStyle style_subTitle =  workbook.createCellStyle();
        style_subTitle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        Font subtitle_font = workbook.createFont();
        subtitle_font.setFontHeightInPoints((short)12);
        subtitle_font.setBold(true);
        style_subTitle.setFont(subtitle_font);
//        style_subTitle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
//        style_subTitle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
//        style_subTitle.setBorderRight(HSSFCellStyle.BORDER_THIN);
//        style_subTitle.setBorderTop(HSSFCellStyle.BORDER_THIN);
        
        CellStyle style_subTitle2 =  workbook.createCellStyle();
        style_subTitle2.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
        Font subtitle_font2 = workbook.createFont();
        subtitle_font2.setFontHeightInPoints((short)11);
        subtitle_font2.setBold(true);
        style_subTitle2.setFont(subtitle_font2);
        
        List<Teach_bus_checkDto> routeList = (List<Teach_bus_checkDto>) model.get("routeList");
        List<Teach_bus_checkDto> dailycheckInfo = (List<Teach_bus_checkDto>) model.get("dailycheckInfo");
        List<Teach_bus_checkDto> checkList = (List<Teach_bus_checkDto>) model.get("checkList");
        
        List<Teach_bus_checkDto> teach_bus_ckecklistB = (List<Teach_bus_checkDto>) model.get("teach_bus_ckecklistB");
        List<Teach_bus_checkDto> teach_bus_ckecklistI = (List<Teach_bus_checkDto>) model.get("teach_bus_ckecklistI");
        List<Teach_bus_checkDto> teach_bus_ckecklistA = (List<Teach_bus_checkDto>) model.get("teach_bus_ckecklistA");
        
        String lastDay_s = (String) model.get("lastDay");
        System.out.println("lastDay:"+lastDay_s);
       
        int lastDay = Integer.parseInt(lastDay_s);
        
        System.out.println("routeList: "+routeList.size());
        System.out.println("dailycheckInfo: "+dailycheckInfo.size());
        System.out.println("teach_bus_ckecklistB: "+teach_bus_ckecklistB.size());
        System.out.println("teach_bus_ckecklistI: "+teach_bus_ckecklistI.size());
        System.out.println("teach_bus_ckecklistA: "+teach_bus_ckecklistA.size());
        
        // 새로운 sheet를 생성한다.
        worksheet = workbook.createSheet("차량일일점검표");
         
        // 가장 첫번째 줄에 제목을 만든다.
//        row = worksheet.createRow(0);
        
        // 셀 병합 CellRangeAddress(시작 행, 끝 행, 시작 열, 끝 열)
//        worksheet.addMergedRegion(new CellRangeAddress(listExcel.size() + 1, listExcel.size() + 1, 0, 3));
        worksheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 19));
        worksheet.addMergedRegion(new CellRangeAddress(1, 1, 0, 19));
        // 병합 테스트를 위한 설정
        row = worksheet.createRow(0);			//타이틀
        row.createCell(0).setCellValue("차량일일점검표");
        row.getCell(0).setCellStyle(style_Title); // 지정한 스타일을 입혀준다.
        
        Row row1 = null;
        row1 = worksheet.createRow(1);			//노선 및 차량 번호
        row1.createCell(0).setCellValue(dailycheckInfo.get(0).getRoute_name()+dailycheckInfo.get(0).getDrive_year()+dailycheckInfo.get(0).getDrive_mon());
        row1.getCell(0).setCellStyle(style_subTitle); // 지정한 스타일을 입혀준다.
        
        Row row2 = null;						//운행일
        row2 = worksheet.createRow(2);
        row2.createCell(4).setCellValue("노선명");
        row2.createCell(5).setCellValue(dailycheckInfo.get(0).getRoute_name());
        row2.createCell(6).setCellValue("차량번호");
        row2.createCell(7).setCellValue(dailycheckInfo.get(0).getBus_num());
        row2.createCell(8).setCellValue("운전자");
        row2.createCell(9).setCellValue(dailycheckInfo.get(0).getBus_staff());
        for(int i=4;i<10;i++){
        	row2.getCell(i).setCellStyle(style_subTitle2); // 지정한 스타일을 입혀준다.
        }
        
        Row row3 = null;						//운행일
        row3 = worksheet.createRow(3);
        row3.createCell(3).setCellValue("보험만료");
        row3.createCell(4).setCellValue(dailycheckInfo.get(0).getInsurformat());
        row3.createCell(5).setCellValue("운행시간");
        row3.createCell(6).setCellValue(dailycheckInfo.get(0).getRoute_start()+"-"+dailycheckInfo.get(0).getRoute_arrive());
        row3.createCell(7).setCellValue("마지막점검일");
        row3.createCell(8).setCellValue(dailycheckInfo.get(0).getFormatToday());
        for(int i=3;i<9;i++){
        	row3.getCell(i).setCellStyle(style_subTitle2); // 지정한 스타일을 입혀준다.
        }
        
        
        // 칼럼 길이 설정
        int columnIndex = 0;
        while (columnIndex < 4) {
             
            if(columnIndex == 0) {
                worksheet.setColumnWidth(columnIndex, 3000);
            } else if (columnIndex == 1) {
                worksheet.setColumnWidth(columnIndex, 3000);
            } else if (columnIndex == 2) {
                worksheet.setColumnWidth(columnIndex, 5000);
            } else if (columnIndex == 3) {
                worksheet.setColumnWidth(columnIndex, 5000);
            }
            columnIndex++;
        }
        
        int startDay;
        int endDay;
        int createRowIndex=4;			//몇번째 줄
        int colcnt=2;					//몇번째 셀
            	
        		startDay=1;
            	endDay=16;
               
            	row = worksheet.createRow(createRowIndex);		//4
                row.createCell(0).setCellValue("구분");
                row.createCell(1).setCellValue("점검내역");
                
                for(int day=startDay;day<=endDay;day++){
                	row.createCell(colcnt).setCellValue(day+"일");
                	row.getCell(colcnt).setCellStyle(style_subTitle); // 지정한 스타일을 입혀준다.
                	colcnt++;
                }
                
                createRowIndex++;								//5
                int rowsize = teach_bus_ckecklistB.size();
                System.out.println("rowsize:"+rowsize);
                
                String content_order;
                String teach_check;
                String checkDay;
                int type_order;
                int check_type_order;
                int check_result;
                for(int state=0;state<teach_bus_ckecklistB.size();state++){			//운행전
                	Row row4 = null;						//운행일
                	colcnt =2;
                    row4 = worksheet.createRow(createRowIndex);
                    
                    if(state==0){
                    	worksheet.addMergedRegion(new CellRangeAddress(createRowIndex, (createRowIndex+rowsize-1), 0, 0));
                    	row4.createCell(0).setCellValue(teach_bus_ckecklistB.get(state).getTeach_buslist_type());
                    }
                    row4.createCell(1).setCellValue(teach_bus_ckecklistB.get(state).getTeach_buslist_cont());
                    
                    content_order = checkList.get(0).getGroup_cont_order();					//DB 운행 전 질문 리스트
                    teach_check = checkList.get(0).getGroup_teach_check();					//DB 체크값
                    checkDay = checkList.get(0).getCheckDateD();							//DB 날짜
                    
                    String[] content_list_order = content_order.split(",");
                    String[] check_value = teach_check.split(",");
                    String[] checkDay_value = checkDay.split(",");
                    int now_buslist_con = teach_bus_ckecklistB.get(state).getTeach_buslist_cont_order();
                    
                    for(int day=startDay;day<endDay;day++){										//1~15일
                    	
                    	check_type_order = teach_bus_ckecklistB.get(state).getTeach_buslist_type_order();	//표 전중후
                    	type_order = checkList.get(1).getTeach_buslist_type_order();			//DB 전중후
                    	System.out.println("type_order:"+type_order);
                    	if(type_order==1){
                    		for(int cnt=0;cnt<content_list_order.length;cnt++){				//DB에 배열 길이 만큼 반복
                    			int content_list_order_i = Integer.parseInt(content_list_order[cnt]);
                    			int check_value_i = Integer.parseInt(check_value[cnt]);
                    			int check_day_i = Integer.parseInt(checkDay_value[cnt]);
                    			
                    			System.out.println("check_day:"+check_day_i+" || day:"+day+"\n"
                    					+" || now_buslist_con"+now_buslist_con+" || content_list_order_i:"+content_list_order_i+"\n"
                    					+" || check_value_i:"+check_value_i);
                    			
                    			if((check_day_i==day) && (now_buslist_con==content_list_order_i) && (check_value_i==1) ){
                    				row4.createCell(colcnt).setCellValue("Ⅴ");
                    				row4.getCell(colcnt).setCellStyle(style_subTitle2); // 지정한 스타일을 입혀준다.
                    			}else{
                    				row4.createCell(colcnt).setCellValue("");
                    				row4.getCell(colcnt).setCellStyle(style_subTitle2); // 지정한 스타일을 입혀준다.
                    			}
                    		}
                    	}
                    	colcnt++;
                    }
                    createRowIndex++;	
                }
                
                rowsize = teach_bus_ckecklistI.size();
                for(int state=0;state<teach_bus_ckecklistI.size();state++){			//운행중
                	Row row4 = null;						//운행일
                	colcnt =2;
                    row4 = worksheet.createRow(createRowIndex);
                    
                    if(state==0){
                    	worksheet.addMergedRegion(new CellRangeAddress(createRowIndex, (createRowIndex+rowsize-1), 0, 0));
                    	row4.createCell(0).setCellValue(teach_bus_ckecklistI.get(state).getTeach_buslist_type());
                    }
                    row4.createCell(1).setCellValue(teach_bus_ckecklistI.get(state).getTeach_buslist_cont());
                    for(int day=startDay;day<=endDay;day++){
                    	row4.createCell(colcnt).setCellValue(day+"일");		//운행중 요일에 대한 셀
                    	row4.getCell(colcnt).setCellStyle(style_subTitle); // 지정한 스타일을 입혀준다.
                    	colcnt++;
                    }
                    for(int i=2;i<colcnt;i++){
                    	row4.getCell(i).setCellStyle(style_subTitle2); // 지정한 스타일을 입혀준다.
                    }
                    createRowIndex++;	
                }
               
                rowsize = teach_bus_ckecklistA.size();
                for(int state=0;state<teach_bus_ckecklistA.size();state++){			//운행후
                	Row row4 = null;						//운행일
                	colcnt =2;
                    row4 = worksheet.createRow(createRowIndex);
                    
                    if(state==0){
                    	worksheet.addMergedRegion(new CellRangeAddress(createRowIndex, (createRowIndex+rowsize-1), 0, 0));
                    	row4.createCell(0).setCellValue(teach_bus_ckecklistA.get(state).getTeach_buslist_type());
                    }
                    row4.createCell(1).setCellValue(teach_bus_ckecklistA.get(state).getTeach_buslist_cont());
                    for(int day=startDay;day<=endDay;day++){
                    	row4.createCell(colcnt).setCellValue(day+"일");
                    	row4.getCell(colcnt).setCellStyle(style_subTitle); // 지정한 스타일을 입혀준다.
                    	colcnt++;
                    }
                    for(int i=2;i<colcnt;i++){
                    	row4.getCell(i).setCellStyle(style_subTitle2); // 지정한 스타일을 입혀준다.
                    }
                    createRowIndex++;	
                }
                
        
                
//                Row nextrow = null;
//                for(int state=1;state<teach_bus_ckecklistB.size();state++){
//                	if(state==1){
//                		nextrow = worksheet.createRow(5);
//                		worksheet.addMergedRegion(new CellRangeAddress(5, teach_bus_ckecklistB.size(), 0, 0));
//                		nextrow.createCell(0).setCellValue(teach_bus_ckecklistB.get(0).getTeach_buslist_type());
//                	}
//                	nextrow.createCell(2).setCellValue(teach_bus_ckecklistB.get(0).getTeach_buslist_cont());	
//                }
//				for(int state=1;state<teach_bus_ckecklistI.size();state++){
//					
//				}
//				for(int state=1;state<teach_bus_ckecklistA.size();state++){
//						
//				}
        	
            row.getCell(0).setCellStyle(style_subTitle); // 지정한 스타일을 입혀준다.
            row.getCell(1).setCellStyle(style_subTitle); // 지정한 스타일을 입혀준다.
            
            createRowIndex++;			// 다음 줄 
            colcnt=2;
            
//            row.createCell(0).setCellValue(teach_bus_ckecklistA.get(0).getTeach_buslist_cont());
        
        try {
            response.setHeader("Content-Disposition", "attachement; filename=\""
                + java.net.URLEncoder.encode(excelName, "UTF-8") + "\";charset=\"UTF-8\"");
          } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
          }
	}
}
