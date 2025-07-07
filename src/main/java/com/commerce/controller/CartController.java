package com.commerce.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import com.commerce.entity.*;
import com.commerce.repository.CartItemRepository;
import com.commerce.repository.ProductRepository;
import com.commerce.repository.UserRepository;

import java.util.List;

@RestController
@RequestMapping("/customer/cart")
public class CartController {

	@Autowired
	private CartItemRepository cartItemRepo;

	@Autowired
	private UserRepository userRepo;

	@Autowired
	private ProductRepository productRepo;

	@GetMapping("/items")
	public List<CartItem> viewCart(Authentication auth) {
		User user = userRepo.findByUsername(auth.getName()).orElseThrow();
		return cartItemRepo.findByUser(user);
	}

	@PostMapping("/add")
	public CartItem addToCart(Authentication auth, @RequestParam Long productId, @RequestParam int quantity) {
		User user = userRepo.findByUsername(auth.getName()).orElseThrow();
		Product product = productRepo.findById(productId).orElseThrow();
		CartItem item = new CartItem(null, user, product, quantity);
		return cartItemRepo.save(item);
	}

	@PutMapping("/update/{itemId}")
	public CartItem updateCart(@PathVariable Long itemId, @RequestParam int quantity) {
		CartItem item = cartItemRepo.findById(itemId).orElseThrow();
		item.setQuantity(quantity);
		return cartItemRepo.save(item);
	}

	@DeleteMapping("/remove/{itemId}")
	public String removeFromCart(@PathVariable Long itemId) {
		cartItemRepo.deleteById(itemId);
		return "Item removed from cart";
	}
}