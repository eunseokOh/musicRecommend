package net.musicrecommend.www.music;

import java.util.List;

import net.musicrecommend.www.util.PageNation;
import net.musicrecommend.www.vo.ArtistVO;

public interface ArtistMapper {

	int getArtistTotalCount() throws Exception;

	List<ArtistVO> selectArtistList() throws Exception;
}
