package net.musicrecommend.www.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("user/analysis")
public class UserAnalysisController {
	
	@Autowired
	UserService userService;
	
	@RequestMapping(value="{user_id}",method=RequestMethod.GET)
	public String getUserAnalysis(@PathVariable String user_id, HttpSession session,Model model){
		String loginUserId = session.getAttribute("user_id").toString();
		if(session.getAttribute("user_id")==null){
			model.addAttribute("msg","로그인해주세요");
			model.addAttribute("url","../../user/login");
			
			return "result";
		}
		model.addAttribute("target_user_id",user_id);
		model.addAttribute("login_user_id",loginUserId);		
		return "user/analysis";
	}
	
	@RequestMapping(value="{user_id}/prefer_Artist", produces="application/json; charset=UTF-8")
	@ResponseBody
	public List<Map<String, Long>> prefer_Artist(@PathVariable String user_id){
		List<Map<String, Long>> prefer_Artist = new ArrayList<Map<String, Long>>();
		
		
		try {
			long user_no = userService.getUserNo(user_id);
			prefer_Artist = userService.getPrefer_Artist(user_no);
			System.out.print(prefer_Artist.toString(	));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return prefer_Artist;
	}
	
	
	
}
