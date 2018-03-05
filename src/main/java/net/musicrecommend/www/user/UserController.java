package net.musicrecommend.www.user;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import net.musicrecommend.www.util.PageNation;

@Controller
@RequestMapping("user")
public class UserController {

	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	@Value("${upload_path}")
	private String uploadUrl;

	@Inject
	UserService userService;

	private void createUploadDir() {
		File dir = new File(uploadUrl);
		if (!dir.exists()) {// 議댁옱 �븯吏� �븡�쑝硫�
			dir.mkdirs(); // �뤃�뜑瑜� 留뚮뱾�뼱 以��떎.

		}
	}

	private String getUniqueFileName(String fileName) {
		String uniqueFileName = null;
		String uuid = UUID.randomUUID().toString().replace("-", "").toLowerCase();

		int fileIndex = fileName.lastIndexOf(".");

		if (fileIndex != -1) {
			String extension = fileName.substring(fileIndex + 1);
			uniqueFileName = uuid + "." + extension;
		} else {
			logger.info("getUniqueFileName() Error!");
		}

		return uniqueFileName;

	}

	@RequestMapping(value = "join", method = RequestMethod.GET)
	public void userJoin() {

	}

	@RequestMapping(value = "join", method = RequestMethod.POST)
	public void userJoinAction(@ModelAttribute UserVO userVO) throws IllegalStateException, IOException {
		CommonsMultipartFile cmf = userVO.getUser_img_file();

		String originalFilename = cmf.getOriginalFilename();
		String contentType = cmf.getContentType();

		boolean isImage = contentType.substring(0, 6).equals("image/");

		String ext = "." + contentType.substring(6, contentType.length());

		String uniqueFileName = getUniqueFileName(originalFilename);
		File file = new File(uploadUrl, uniqueFileName);// �썝�븯�뒗 寃쎈줈濡� �씠�룞�븯湲� �쐞�빐

		userVO.setUser_uuid(uniqueFileName);
		try {
			cmf.transferTo(file);
		} catch (FileNotFoundException e1) {
			// �뤃�뜑媛� �뾾�쓣寃쎌슦 �뙆�씪�궖�뙆�슫�뱶 �씡�뀎�뀡
			createUploadDir(); // �뾾�쓣寃쎌슦 �뤃�뜑瑜� 留뚮뱾�뼱以��떎.
			cmf.transferTo(file);
		} catch (IOException e) {
			e.printStackTrace();
			// ��遺�遺꾩쓽 �뿉�윭�뒗 沅뚰븳 ,�븯�뱶 �슜�웾, �뙆�씪�씠 �뾾嫄곕굹
		}

		try {
			userService.insertUser(userVO);
			logger.info("�쉶�썝媛��엯 �젙蹂� �솗�씤" + userVO);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	@RequestMapping("list")
	public String userList(Model model, @PathVariable int pg) {
		int total_article_count = -1;
		List<UserVO> userList = null;
		try {
			total_article_count = userService.getUserTotalCount();
			PageNation pageNation = new PageNation(pg, total_article_count);

			userList = userService.selectUserList(pageNation);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		model.addAttribute("userList", userList);

		return "user/list";
	}

	// �븘�씠�뵒 以묐났泥댄겕 �솗�씤\\
	@RequestMapping(value = "idcheck", method = RequestMethod.POST)
	@ResponseBody
	public int id_check(@ModelAttribute UserVO userVO, Model model) throws Exception {

		int check_id = userService.idCheck(userVO.getUser_id());

		logger.info("�븘�씠�뵒 �닔�떊 泥댄겕 : " + userVO);
		logger.info("以묐났 �븘�씠�뵒 媛��닔 �솗�씤 :" + check_id);
		return check_id;

	}

	// 濡쒓렇�씤\\
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public ModelAndView cacaoLogin(@ModelAttribute UserVO userVO, Model mode, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		//session.invalidate();
		if (userVO.getUser_id() != null) {

			UserVO cacaoUser = new UserVO();

			cacaoUser.setUser_id(userVO.getUser_id());
			cacaoUser.setUser_nick(userVO.getUser_nick());
			cacaoUser.setUser_img(userVO.getUser_img());

			logger.info("移댁뭅�삤 怨꾩젙�꽭�똿" + cacaoUser.toString());

			int result = userService.checkCacaoUser(cacaoUser);
			logger.info("移댁뭅�삤怨꾩젙 以묐났 媛��닔 : " + result);
			if (result == 0) {
				userService.insertCacaoUser(userVO);
				logger.info("移댁뭅�삤怨꾩젙 異붽��셿猷�");

			} else if (result == 1) {
				logger.info("移댁뭅�삤怨꾩젙 �씠誘� 議댁옱");
				session.setAttribute("user_id", cacaoUser.getUser_id());
			}

			mav.setViewName("/user/result");
			mav.addObject("msg", "移댁뭅�삤 濡쒓렇�씤 �꽦怨�");
			mav.addObject("url", "../operation/chartList");

			mav.addObject("user_id", cacaoUser.getUser_id());
			mav.addObject("user_nick", cacaoUser.getUser_nick());
			mav.addObject("user_img", cacaoUser.getUser_img());

		}

		return mav;
	}

	@RequestMapping(value = "login", method = RequestMethod.POST)
	public ModelAndView userLoginAction(Model mode, HttpSession session, HttpServletRequest request) throws Exception {

		String id = request.getParameter("user_id");
		String pw = request.getParameter("user_pw");

		session.setAttribute("user_id", id);

		logger.info("�쁽�옱 濡쒓렇�씤 怨꾩젙 : " + session.getAttribute("user_id"));

		ModelAndView mav = new ModelAndView();

		UserVO user = new UserVO();

		user.setUser_id(id);
		user.setUser_pw(pw);

		logger.info("濡쒓렇�씤 �젙蹂� :" + user.toString());

		user = userService.checkUser(user);

		logger.info("濡쒓렇�씤 �젙蹂� �씪移섏뿬遺� :" + user);

		if (user == null) {
			mav.setViewName("/user/result");
			mav.addObject("msg", "濡쒓렇�씤 �젙蹂닿� �씪移섑븯吏� �븡�뒿�땲�떎.");
			mav.addObject("url", "../user/login");
		} else if (user != null) {

			mav.setViewName("/user/result");
			mav.addObject("msg", "濡쒓렇�씤 �꽦怨�");
			mav.addObject("url", "../operation/chartList");

			session.setAttribute("user_nick", user.getUser_nick());
			session.setAttribute("user_img", user.getUser_img());

		}

		return mav;

	}

}
