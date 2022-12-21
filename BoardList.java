package com.ezen.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BoardController {
	@Autowired
	private BoardService boardService;
	
	@RequestMapping("/board_list")
	public String getBoardList(Integer page, Integer pageSize, Model model) {
		if(page == null) page = 1;
		if(pageSize == null) pageSize = 10;
		
		int totalCount = boardService.getCount();
		PageHandler pageHandler = new PageHandler(totalCount, page, pageSize);
		
		Map map = new HashMap();
		map.put("offset", (page-1)*pageSize);
		map.put("pageSize", pageSize);
		
		List<BoardDTO> boardList= boardService.getPage(map);
		model.addAttribute("boardList", boardList);
		model.addAttribute("pageHandler", pageHandler);
	}
}
