package com.commerce.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class DashboardController {

	@GetMapping("/customer-dashboard")
	public String customerDashboard(HttpServletRequest request, Model model) {
		String username = (String) request.getSession().getAttribute("username");
		String role = (String) request.getSession().getAttribute("role");

		model.addAttribute("username", username);
		model.addAttribute("role", role);
		return "customer_dashboard";
	}

	@GetMapping("/admin-dashboard")
	public String adminDashboard(HttpServletRequest request, Model model) {
		String username = (String) request.getSession().getAttribute("username");
		String role = (String) request.getSession().getAttribute("role");
		model.addAttribute("username", username);
		model.addAttribute("role", role);
		System.out.println("data is coming from ui");
		return "admin_dashboard"; // Maps to /WEB-INF/views/admin_dashboard.jsp
	}
}
