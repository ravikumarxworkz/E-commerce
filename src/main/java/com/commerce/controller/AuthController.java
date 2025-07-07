package com.commerce.controller;

import lombok.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.*;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import com.commerce.entity.User;
import com.commerce.repository.UserRepository;
import com.commerce.security.JwtUtil;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/auth")
public class AuthController {

	@Autowired
	private AuthenticationManager authenticationManager;

	@Autowired
	private JwtUtil jwtUtil;

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private PasswordEncoder passwordEncoder;

	@PostMapping("/login")
	public ResponseEntity<?> login(@RequestBody AuthRequest request, HttpServletRequest httpRequest) {
		Authentication authentication = authenticationManager
				.authenticate(new UsernamePasswordAuthenticationToken(request.getUsername(), request.getPassword()));

		// Store in session (optional)
		HttpSession session = httpRequest.getSession();
		session.setAttribute("username", request.getUsername());

		// Get user from DB
		Optional<User> userOptional = userRepository.findByUsername(request.getUsername());
		if (userOptional.isEmpty()) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("User not found");
		}

		User user = userOptional.get();
		httpRequest.getSession().setAttribute("username", user.getUsername());
		httpRequest.getSession().setAttribute("role", user.getRole());

		// Return role and JWT token
		String token = jwtUtil.generateToken(request.getUsername());
	
		return ResponseEntity.ok(Map.of("message", "Login successful", "role", user.getRole(), "token", token));
	}

	@PostMapping("/register")
	public String register(@RequestBody AuthRequest request) {
		Optional<User> existing = userRepository.findByUsername(request.getUsername());
		if (existing.isPresent())
			return "User already exists";

		User user = new User();
		user.setUsername(request.getUsername());
		user.setPassword(passwordEncoder.encode(request.getPassword()));
		user.setRole("CUSTOMER");
		userRepository.save(user);
		return "User registered successfully";
	}

	@Data
	static class AuthRequest {
		private String username;
		private String password;
	}
}