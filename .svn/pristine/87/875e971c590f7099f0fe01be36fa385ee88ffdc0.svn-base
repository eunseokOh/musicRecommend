package net.musicrecommend.www.music;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import net.musicrecommend.www.util.PageNation;
import net.musicrecommend.www.vo.ArtistVO;

@Controller
@RequestMapping(value="artist")
public class ArtistController {
	
	private static final Logger logger = LoggerFactory.getLogger(ArtistController.class);
	
	@Autowired
	ArtistService artistService;
	
	@RequestMapping(value="list")
	public void articleList(Model model){
		List<ArtistVO> list = null;
		
		ArtistVO artistVO = new ArtistVO();
		
		try {
			list = artistService.selectArtistList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		System.out.println(list.toString());
		 
		model.addAttribute("list", list);
	}
}
