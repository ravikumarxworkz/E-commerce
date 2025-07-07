package com.commerce.entity;

import jakarta.persistence.*;
import lombok.*;
import java.util.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "customer_order")
public class Order {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@ManyToOne
	private User user;

	private Date createdDate;

	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn(name = "order_id") // create foreign key in OrderItem table
	private List<OrderItem> items;

}
