package com.commerce.config;

import com.commerce.security.JwtFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.*;
import org.springframework.security.authentication.*;
import org.springframework.security.config.annotation.authentication.configuration.*;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
public class SecurityConfig {

	@Autowired
	private JwtFilter jwtFilter;

	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		http.csrf().disable().authorizeHttpRequests()

				// ✅ Allow public endpoints
				.requestMatchers("/", "/login-page", "/registerPage", "/auth/**", "/error").permitAll()
				.requestMatchers("/css/**", "/js/**", "/images/**").permitAll()

				// ✅ Role-based secured paths
				.requestMatchers("/admin/**", "/admin-dashboard").hasRole("ADMIN")
				.requestMatchers("/customer/**", "/customer-dashboard").hasRole("CUSTOMER")

				// ✅ Any other request must be authenticated
				.anyRequest().authenticated()

				.and()

				// ✅ Enable sessions for JSP use (but still stateless for APIs)
				.sessionManagement().sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED);

		// ✅ Add your JWT filter before Spring's default auth filter
		http.addFilterBefore(jwtFilter, UsernamePasswordAuthenticationFilter.class);

		return http.build();
	}

	@Bean
	public WebSecurityCustomizer webSecurityCustomizer() {
		return web -> web.ignoring().requestMatchers("/WEB-INF/**", "/resources/**", "/static/**", "/public/**",
				"/error");
	}

	@Bean
	public AuthenticationManager authenticationManager(AuthenticationConfiguration config) throws Exception {
		return config.getAuthenticationManager();
	}

	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
}
