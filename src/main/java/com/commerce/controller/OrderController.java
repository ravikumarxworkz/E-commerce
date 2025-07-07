package com.commerce.controller;

import com.commerce.entity.*;
import com.commerce.repository.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import jakarta.transaction.Transactional;
//or if you're using spring's annotation: import org.springframework.transaction.annotation.Transactional;

@RestController
@RequestMapping("/customer/orders")
public class OrderController {

	@Autowired
	private OrderRepository orderRepo;

	@Autowired
	private CartItemRepository cartRepo;

	@Autowired
	private UserRepository userRepo;

	@PostMapping("/place")
	@Transactional
	public String placeOrder(Authentication auth) {
		User user = userRepo.findByUsername(auth.getName()).orElseThrow();
		List<CartItem> cartItems = cartRepo.findByUser(user);

		if (cartItems.isEmpty())
			return "Cart is empty";

		// Convert CartItem to OrderItem
		List<OrderItem> orderItems = cartItems.stream().map(c -> new OrderItem(null, c.getProduct(), c.getQuantity()))
				.collect(Collectors.toList());

		Order order = new Order();
		order.setUser(user);
		order.setCreatedDate(new Date());
		order.setItems(orderItems);

		orderRepo.save(order); // Order + OrderItems saved

		cartRepo.deleteByUser(user); // Now it's safe to delete

		return "Order placed successfully";
	}

	@GetMapping("/my")
	public List<Order> getMyOrders(Authentication auth) {
		User user = userRepo.findByUsername(auth.getName()).orElseThrow();
		return orderRepo.findByUser(user);
	}
}
