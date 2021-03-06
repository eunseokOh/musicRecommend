package net.musicrecommend.www.recommend;

import java.util.List;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import net.musicrecommend.www.util.PageNation;
import net.musicrecommend.www.vo.SongVO;

@Controller
@RequestMapping("/")
public class RecommendController {
	private static final Logger logger = LoggerFactory.getLogger(RecommendController.class);
	
	@Autowired
	RecommendService recommendService;
	
	@RequestMapping(value="recommend",method=RequestMethod.POST, produces={"Application/plain; charset=UTF-8"})
	@ResponseBody
	public String recom(@ModelAttribute RecommendVO recommendVO, HttpSession session){
			//int user_no = (Integer) session.getAttribute("user_no");
			String msg = "";
			recommendVO.setUser_no(3);
			try {
				recommendService.insertRecommend(recommendVO);
				msg = "평가 완료!";
			} catch (Exception e) {
				msg = "오류";
				e.printStackTrace();
			}
			
			return msg;
	}
	
	
}
