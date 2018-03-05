package net.musicrecommend.www.recommend;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.musicrecommend.www.util.PageNation;
import net.musicrecommend.www.vo.SongVO;

@Service
public class RecommendServiceImpl implements RecommendService {
	@Autowired
	RecommendMapper recommendMapper;

	

	@Override
	public boolean insertRecommend(RecommendVO recommendVO) throws Exception {
		//이미 입력된 평가가 있을시 업데이트
		if (recommendMapper.checkRecommendExist(recommendVO) > 0) {
			if(recommendMapper.updateRecommend(recommendVO)>0){
				return true;
			}else{
				return false;
			}
		} else {
			if (recommendMapper.insertRecommend(recommendVO) > 0) {
				return true;
			} else {
				return false;
			}

		}
	}



	@Override
	public long getTotalCount() throws Exception {
		return recommendMapper.getTotalCount();
	}

}
