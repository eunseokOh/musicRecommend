package net.musicrecommend.www.recommend;

import java.util.List;

import net.musicrecommend.www.util.PageNation;
import net.musicrecommend.www.vo.SongVO;

public interface RecommendService {


	boolean insertRecommend(RecommendVO recommendVO) throws Exception;


	long getTotalCount() throws Exception;
	
}
