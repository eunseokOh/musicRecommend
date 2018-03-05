package net.musicrecommend.www.operation;

import java.util.List;

import net.musicrecommend.www.vo.AlbumVO;
import net.musicrecommend.www.vo.ArtistVO;
import net.musicrecommend.www.vo.GenreVO;
import net.musicrecommend.www.vo.SongVO;

public interface OperationMapper {

	void insertArtist(ArtistVO artistVO) throws Exception;

	int checkArtistId(ArtistVO artistVO) throws Exception;

	int checkAlbumId(AlbumVO albumVO) throws Exception;

	void insertAlbum(AlbumVO albumVO) throws Exception;
	
	//은석
	void insertSong(SongVO songVO) throws Exception;

	long checkSong(long song_key) throws Exception;

	List<GenreVO> getGenreList() throws Exception;

}
