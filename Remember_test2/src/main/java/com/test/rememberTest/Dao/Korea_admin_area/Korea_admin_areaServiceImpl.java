package  com.test.rememberTest.Dao.Korea_admin_area;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.rememberTest.Dto.BusRouteDto;
import com.test.rememberTest.Dto.korea_admin_areaDto;


@Service
public class Korea_admin_areaServiceImpl implements Korea_admin_areaService{

	 @Autowired
	    private Korea_admin_areaDao korea_admin_areaDao;

	@Override
	public List<korea_admin_areaDto> selectArea_cityName() {
		return korea_admin_areaDao.selectArea_cityName();
	}

	@Override
	public List<korea_admin_areaDto> selectArea_districtName(String cityCode) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("cityCode", cityCode);
		return korea_admin_areaDao.selectArea_districtName(map);
	}

	@Override
	public List<korea_admin_areaDto> selectArea_townshipName(String districtCode) {
		System.out.println("selectArea_townshipName에서"+districtCode);
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("districtCode", districtCode);
		return korea_admin_areaDao.selectArea_townshipName(map);
	}

	@Override
	public List<korea_admin_areaDto> selectArea_gu(String si) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("si", si);
		return korea_admin_areaDao.selectArea_gu(map);
	}

	@Override
	public List<korea_admin_areaDto> selectArea_dong(String gu) {
		Map<String, Object> map = new HashMap<String, Object>();       
        map.put("gu", gu);
		return korea_admin_areaDao.selectArea_dong(map);
	}

	
}
