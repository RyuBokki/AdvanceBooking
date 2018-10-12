package com.ktds.concert.web;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ktds.concert.service.ConcertService;
import com.ktds.concert.vo.ConcertVO;

@Controller
public class ConcertController {
	
	@Autowired
	private ConcertService concertService;
	
	@RequestMapping("/concert/write")
	public ModelAndView doWriteConcertAction(@Valid@ModelAttribute ConcertVO concertVO
											  , Errors errors) {
		
		ModelAndView view = new ModelAndView("redirect:/concert/list");
		
		if ( errors.hasErrors() ) {
			view.setViewName("/concert/write");
			view.addObject("concertVO", concertVO);
			
			return view;
		}
		
		boolean isWriteSuccess = this.concertService.createOneConcert(concertVO);
		
		return view;
	}
	
	
}
