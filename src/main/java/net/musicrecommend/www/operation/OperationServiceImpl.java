package net.musicrecommend.www.operation;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.musicrecommend.www.vo.AlbumVO;
import net.musicrecommend.www.vo.ArtistVO;
import net.musicrecommend.www.vo.GenreVO;
import net.musicrecommend.www.vo.SongVO;

@Service
public class OperationServiceImpl implements OperationService{
	@Autowired 
	OperationMapper operationMapper;

	@Override
	public void insertArtist(ArtistVO artistVO) throws Exception {
		operationMapper.insertArtist(artistVO);
	}

	@Override
	public boolean checkArtistId(ArtistVO artistVO) throws Exception {
		if(operationMapper.checkArtistId(artistVO)>0){
			return true;
		}else{					
			return false;
		}
	}

	@Override
	public boolean checkAlbumId(AlbumVO albumVO) throws Exception {
		
		if(operationMapper.checkAlbumId(albumVO)>0){
			return true;
		}else{
			return false;
		}
	}

	@Override
	public void insertAlbum(AlbumVO albumVO) throws Exception {
		operationMapper.insertAlbum(albumVO);
		
	}

	@Override
	public void insertSong(SongVO songVO) throws Exception {
		operationMapper.insertSong(songVO);
		
	}

	@Override
	public long checkSong(long song_key) throws Exception {
		
		return operationMapper.checkSong(song_key);
	}

	@Override
	public List<GenreVO> getGenreList() throws Exception {
		return operationMapper.getGenreList();
	}

}
