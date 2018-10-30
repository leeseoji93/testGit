package com.test.rememberTest;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

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
import org.apache.poi.util.ArrayUtil;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.test.rememberTest.Dto.RealTimeDto;
import com.test.rememberTest.Dto.RecordDto;

import antlr.collections.impl.LList;

@Component("AbstractExcelView")
public class listDown_Excel_vehicle extends AbstractExcelView{

	@Override
	protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String sCurTime = null;
        sCurTime = new SimpleDateFormat("yyyyMM", Locale.KOREA).format(new Date());
     
        String excelName = sCurTime + "_차량운행일지.xls";			// 다운로드 파일 명 (날짜 _제목.xls)
       
        Row row = null;
        
        CellStyle style = workbook.createCellStyle(); // 셀 스타일을 위한 변수
        HSSFDataFormat format = workbook.createDataFormat();	//엑셀 시간 서식하려고
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 글 위치를 중앙으로 설정
        style.setDataFormat(format.getFormat("hh:mm:ss")); 
        style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        style.setBorderRight(HSSFCellStyle.BORDER_THIN);
        style.setBorderTop(HSSFCellStyle.BORDER_THIN);
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        
        CellStyle style_normal = workbook.createCellStyle();
        style_normal.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        style_normal.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        style_normal.setBorderRight(HSSFCellStyle.BORDER_THIN);
        style_normal.setBorderTop(HSSFCellStyle.BORDER_THIN);
        style_normal.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        
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
        
        CellStyle style_tableTitle =  workbook.createCellStyle();
        style_tableTitle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        style_tableTitle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        style_tableTitle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        style_tableTitle.setBorderRight(HSSFCellStyle.BORDER_THIN);
        style_tableTitle.setBorderTop(HSSFCellStyle.BORDER_THIN);
        
        Font subtitle_font = workbook.createFont();
        subtitle_font.setFontHeightInPoints((short)12);
        subtitle_font.setBold(true);
        style_subTitle.setFont(subtitle_font);
        
        CellStyle style_subTitle2 =  workbook.createCellStyle();
        style_subTitle2.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
        Font subtitle_font2 = workbook.createFont();
        subtitle_font2.setFontHeightInPoints((short)11);
        subtitle_font2.setBold(true);
        style_subTitle2.setFont(subtitle_font2);
        
        
        List<RecordDto> listExcel = (List<RecordDto>) model.get("recordListArray");
        String route_name = (String) model.get("route_name");
        String bus_num = (String) model.get("bus_num"); 
       
        
        int nowDoc;					//지금 문서
        int saveDoc = 0;			//이전 문서
        int checkDoc =0;			//총 문서 개수
        int checkDailyList =0;		//하루 리스트 개수
        
        int startDoc =0;			//시작할 번호
        int lastDoc =0;				//마지막 정류장
        int totalDoc = listExcel.size();	//총 개수
        
        for(int check=0;check<listExcel.size();check++){
        	
        	if(check==0){				//문서 처음
        		saveDoc = listExcel.get(check).getDriv_doc();
        	}
        		nowDoc = listExcel.get(check).getDriv_doc();
        	if(saveDoc!=nowDoc || check==0){	//문서가 바꼈을 때 
        		System.out.println("=======checkDailyList:"+checkDailyList);
        		checkDoc++;
        		// 새로운 sheet를 생성한다.
        		HSSFSheet worksheet = null;
        		String createDateFormat = listExcel.get(check).getCreateDateFormat();
                worksheet = workbook.createSheet(createDateFormat);			//sheet 명 (엑셀 아랫 쪽에  시트 이름 명) -엑셀목록

                // 가장 첫번째 줄에 제목을 만든다.
//                row = worksheet.createRow(0);
                
                // 셀 병합 CellRangeAddress(시작 행, 끝 행, 시작 열, 끝 열)
//                worksheet.addMergedRegion(new CellRangeAddress(listExcel.size() + 1, listExcel.size() + 1, 0, 3));
                worksheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 3));
                worksheet.addMergedRegion(new CellRangeAddress(1, 1, 0, 3));
                worksheet.addMergedRegion(new CellRangeAddress(2, 2, 0, 3));
                
                // 병합 테스트를 위한 설정
                row = worksheet.createRow(0);			//타이틀
                row.createCell(0).setCellValue("차량운행일지");
                row.getCell(0).setCellStyle(style_Title); // 지정한 스타일을 입혀준다.
                
                Row row1 = null;
                row1 = worksheet.createRow(1);			//노선 및 차량 번호
                row1.createCell(0).setCellValue(route_name+"("+bus_num+")");
                row1.getCell(0).setCellStyle(style_subTitle); // 지정한 스타일을 입혀준다.
                
                Row row2 = null;						//운행일
                row2 = worksheet.createRow(2);
                row2.createCell(0).setCellValue("운행일:"+createDateFormat);
                row2.getCell(0).setCellStyle(style_subTitle2); // 지정한 스타일을 입혀준다.
                
                
                // 칼럼 길이 설정
                int columnIndex = 0;
                while (columnIndex < 4) {
                     
                    if(columnIndex == 0) {
                        worksheet.setColumnWidth(columnIndex, 3000);
                    } else if (columnIndex == 1) {
                        worksheet.setColumnWidth(columnIndex, 9000);
                    } else if (columnIndex == 2) {
                        worksheet.setColumnWidth(columnIndex, 5000);
                    } else if (columnIndex == 3) {
                        worksheet.setColumnWidth(columnIndex, 5000);
                    }
                    columnIndex++;
                }
                 
                // 헤더 설정
                row = worksheet.createRow(3);
                row.createCell(0).setCellValue("");
                row.createCell(1).setCellValue("정류장명");
                row.createCell(2).setCellValue("도착시간");
                row.createCell(3).setCellValue("소요시간");
                row.getCell(0).setCellStyle(style_tableTitle); // 지정한 스타일을 입혀준다.
                row.getCell(1).setCellStyle(style_tableTitle); // 지정한 스타일을 입혀준다.
                row.getCell(2).setCellStyle(style_tableTitle); // 지정한 스타일을 입혀준다.
                row.getCell(3).setCellStyle(style_tableTitle); // 지정한 스타일을 입혀준다.
                 
                int rowIndex = 4;
                 
                long brforeTime;	// 이전 정류장 도착 시간
                long afterTime;		// 지금 정류장 도착 시간
                long resultTime_h = 0; 	// 소요시간(시)
                long resultTime_m = 0; 	// 소요시간(분)
                long resultTime_s = 0; 	// 소요시간(초)
                
                
                
                String trafficTime;
                // 각 해당하는 셀에 값과 스타일을 넣음
                int j=0;
                
                
                lastDoc = listExcel.get(check).getDoccount();				//마지막 정류장
                System.out.println("\\\\\\\\\\\\\\\\lastDoc:"+lastDoc);
                totalDoc =0;	//총 개수
                
                for(int i=startDoc;i<(startDoc+lastDoc);i++) {
                		String resultTime_h_st="00";
                    	String resultTime_m_st="00";
                    	String resultTime_s_st="00";
                    	// 소요시간 구하기
                    	//listExcel.get(i).getTime()
                    	
                    	System.out.println("i:"+i);
                    	if(j>0){
                    		
                    		brforeTime = (listExcel.get(i).getTime()).getTime();
                            afterTime = (listExcel.get(i-1).getTime()).getTime();
                            
                            resultTime_m = (afterTime - brforeTime) / 60000;
                            resultTime_s = ((afterTime - brforeTime) - (resultTime_m*60000))/1000;
                            
                            resultTime_m = Math.abs(resultTime_m);
                            resultTime_s = Math.abs(resultTime_s);
                            
                            
                            if(resultTime_m>59){
                            	resultTime_h = resultTime_m/60;
                            	resultTime_m = resultTime_m%60;
                            }
                            
                            if(resultTime_h<10){
                            	resultTime_h_st = "0"+resultTime_h;
                            }else{
                            	resultTime_h_st = Long.toString(resultTime_h);
                            }
                            if(resultTime_m<10){
                            	resultTime_m_st = "0"+resultTime_m;
                            }else{
                            	resultTime_m_st = Long.toString(resultTime_m);
                            }
                            if(resultTime_s<10){
                            	resultTime_s_st = "0"+resultTime_s;
                            }else{
                            	resultTime_s_st = Long.toString(resultTime_s);
                            }
                            trafficTime = resultTime_h_st+":"+resultTime_m_st+":"+resultTime_s_st;
                            
                    	}else{
                    		trafficTime="";
                    	}
                        row = worksheet.createRow(rowIndex);
                        row.createCell(0).setCellValue(j+1);
                        row.createCell(1).setCellValue(listExcel.get(i).getStation_name());
//                        row.createCell(3).setCellValue(board.getWriter());
                        
                        // 데이터 처리
//                        row.createCell(2).setCellType(Cell.CELL_TYPE_NUMERIC);
                        row.createCell(2).setCellType(Cell.CELL_TYPE_STRING);
//                        	
                        double doubleTime =DateUtil.getExcelDate((Time)listExcel.get(i).getTime());
                        row.createCell(2).setCellValue(doubleTime-25569); // 1900년01월01일을 빼준다.
                        row.createCell(3).setCellValue(trafficTime);
                        
                        row.getCell(0).setCellStyle(style_normal);
                        row.getCell(1).setCellStyle(style_normal);
                        row.getCell(2).setCellStyle(style); // 지정한 스타일을 입혀준다.
                        row.getCell(3).setCellStyle(style_normal);
                        rowIndex++;
                        j++;
                }		
        	}
        	saveDoc = nowDoc;
        	checkDailyList++;
        	startDoc = lastDoc;
        }
        try {
            response.setHeader("Content-Disposition", "attachement; filename=\""
                + java.net.URLEncoder.encode(excelName, "UTF-8") + "\";charset=\"UTF-8\"");
          } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
          }
	}
}
