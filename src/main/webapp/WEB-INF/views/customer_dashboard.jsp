<%@ page contentType="text/html;charset=UTF-8" session="true" %>
<html>
<head>
    <title>Customer Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .navbar-brand {
            font-weight: bold;
        }
        .card-header {
            font-weight: 500;
        }
    </style>
</head>
<body>

<!-- ✅ NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <span class="navbar-brand">E-Commerce</span>
        <div class="collapse navbar-collapse justify-content-end">
            <span class="navbar-text text-white me-3">
                Welcome, <%= session.getAttribute("username") %>
            </span>
            <button class="btn btn-outline-light" onclick="logout()">Logout</button>
        </div>
    </div>
</nav>

<div class="container mt-4">

    <!-- ✅ PRODUCT LIST -->
    <h3>Available Products</h3>
    <table class="table table-bordered table-striped mt-3" id="productTable">
        <thead class="table-dark">
        <tr>
            <th>ID</th><th>Name</th><th>Price</th><th>Quantity</th><th>Action</th>
        </tr>
        </thead>
        <tbody></tbody>
    </table>

    <!-- ✅ CART SECTION -->
    <h3 class="mt-4">Your Cart</h3>
    <ul id="cartList" class="list-group mb-3"></ul>
    <div class="d-flex justify-content-between">
        <button class="btn btn-success" onclick="placeOrder()">Place Order</button>
        <button class="btn btn-outline-secondary" onclick="loadCart()">Refresh Cart</button>
    </div>

    <!-- ✅ ORDER HISTORY -->
    <h3 class="mt-5">Your Orders</h3>
    <div id="ordersContainer" class="mt-3"></div>
</div>

<!-- jQuery and Bootstrap -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    // Automatically add JWT token to all AJAX requests
    $.ajaxSetup({
        beforeSend: function (xhr) {
            const token = localStorage.getItem("token");
            if (token) {
                xhr.setRequestHeader("Authorization", "Bearer " + token);
            }
        }
    });

    // Load product list
    function loadProducts() {
        $.get('products/all', function(products) {
            const tbody = $('#productTable tbody').empty();
            products.forEach(p => {
                tbody.append(
                    '<tr>' +
                        '<td>' + p.id + '</td>' +
                        '<td>' + p.name + '</td>' +
                        '<td>₹' + p.price + '</td>' +
                        '<td><input type="number" min="1" value="1" id="qty_' + p.id + '" class="form-control" style="width:80px;"></td>' +
                        '<td><button class="btn btn-sm btn-primary" onclick="addToCart(' + p.id + ')">Add to Cart</button></td>' +
                    '</tr>'
                );
            });
        });
    }

    // Add product to cart (in DB)
    function addToCart(productId) {
        const qty = parseInt($('#qty_' + productId).val());
        if (qty <= 0) {
            alert("Quantity must be greater than 0");
            return;
        }

        $.ajax({
            url: 'customer/cart/add',
            type: 'POST',
            data: {
                productId: productId,
                quantity: qty
            },
            success: function(item) {
                alert("Added to cart: " + item.product.name);
                loadCart();
            },
            error: function() {
                alert("Failed to add to cart");
            }
        });
    }

    // Load cart items from DB
    function loadCart() {
        $.get('customer/cart/items', function(cartItems) {
            const list = $('#cartList').empty();
            if (cartItems.length === 0) {
                list.append('<li class="list-group-item text-muted">Cart is empty</li>');
                return;
            }

            cartItems.forEach(item => {
                list.append(
                    '<li class="list-group-item d-flex justify-content-between align-items-center">' +
                        item.product.name + ' - ₹' + item.product.price + ' x ' +
                        '<input type="number" min="1" value="' + item.quantity + '" style="width: 60px;" onchange="updateItem(' + item.id + ', this.value)">' +
                        '<button class="btn btn-sm btn-danger ms-2" onclick="removeItem(' + item.id + ')">Remove</button>' +
                    '</li>'
                );
            });

        });
    }
        
    // ✅ Update Quantity
    function updateItem(itemId, quantity) {
        $.ajax({
        	  url: 'customer/cart/update/' + itemId + '?quantity=' + quantity,
            type: 'PUT',
            success: function () {
                loadCart();
            }
        });
    }

    // ✅ Remove Item
    function removeItem(itemId) {
        $.ajax({
            url: 'customer/cart/remove/'+itemId,
            type: 'DELETE',
            success: function () {
                loadCart();
            }
        });
    }
    
    // Place Order
    function placeOrder() {
        $.post('customer/orders/place', function(msg) {
            alert(msg);
            loadCart();
        }).fail(function() {
            alert("Order failed");
        });
    }
    
    
    function loadOrders() {
        $.get('customer/orders/my', function (orders) {
            const container = $('#ordersContainer').empty();

            if (orders.length === 0) {
                container.append('<p class="text-muted">No orders found.</p>');
                return;
            }

            orders.forEach(order => {
                const orderCard = $('<div class="card shadow-sm mb-3"></div>');

                let itemsHtml = '';
                order.items.forEach(item => {
                    itemsHtml +=
                        '<li class="list-group-item">' +
                            item.product.name + ' - ₹' + item.product.price + ' × ' + item.quantity +
                        '</li>';
                });

                orderCard.html(
                    '<div class="card-header bg-info text-white">' +
                        'Order ID: ' + order.id + ' | Date: ' + new Date(order.createdDate).toLocaleString() +
                    '</div>' +
                    '<ul class="list-group list-group-flush">' + itemsHtml + '</ul>'
                );

                container.append(orderCard);
            });

        });
    }

    // ✅ Logout
    function logout() {
        localStorage.removeItem("token");
        window.location.href = "login-page";
    }

    // Load on page ready
    $(document).ready(function () {
    	 loadProducts();
    	    loadCart();
    	    loadOrders();
    });
</script>
</body>
</html>
