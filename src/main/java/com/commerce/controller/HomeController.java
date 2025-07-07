package com.commerce.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class HomeController {

	@GetMapping("/")
	public String home() {
		return "login"; // goes to /WEB-INF/jsp/login.jsp
	}

	@GetMapping("/login-page")
	public String login() {
		return "login";
	}

	@GetMapping("/registerPage")
	public String register() {
		return "register";
	}
	
	  @GetMapping("/error")
	    public String error() {
	        return "error"; // maps to /WEB-INF/views/error.jsp
	    }

}
