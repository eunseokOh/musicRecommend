package net.musicrecommend.www.user;

import java.util.List;
import java.util.Map;

import net.musicrecommend.www.util.PageNation;


public interface UserService {

	void insertUser(UserVO userVO) throws Exception;

	int getUserTotalCount() throws Exception;

	List<UserVO> selectUserList(PageNation pageNation) throws Exception;

	int checkCacaoUser(UserVO cacaoUser) throws Exception;

	void insertCacaoUser(UserVO userVO) throws Exception;

	UserVO checkUser(UserVO user) throws Exception;

	int idCheck(String user_id) throws Exception;

	long getUserNo(String user_id) throws Exception;

	List<Map<String, Long>> getPrefer_Artist(long user_no) throws Exception;

	

}
