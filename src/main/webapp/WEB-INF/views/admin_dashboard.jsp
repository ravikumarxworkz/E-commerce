<%@ page contentType="text/html;charset=UTF-8" session="true" %>
<%@ page contentType="text/html;charset=UTF-8" session="true" %>
<html>
<head>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<!-- ✅ NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <span class="navbar-brand">Admin Dashboard</span>
        <div class="collapse navbar-collapse justify-content-end">
            <span class="navbar-text text-white me-3">Welcome, Admin</span>
            <button class="btn btn-outline-light" onclick="logout()">Logout</button>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <h3>Product Management</h3>

    <!-- ✅ Add Product Form -->
    <div class="card p-3 mb-4">
        <h5>Add New Product</h5>
        <div class="row g-2">
            <div class="col"><input type="text" id="name" class="form-control" placeholder="Name"></div>
            <div class="col"><input type="text" id="category" class="form-control" placeholder="Category"></div>
            <div class="col"><input type="number" step="0.01" id="price" class="form-control" placeholder="Price"></div>
            <div class="col"><input type="text" id="description" class="form-control" placeholder="Description"></div>
            <div class="col"><button class="btn btn-primary" onclick="addProduct()">Add</button></div>
        </div>
    </div>

    <!-- ✅ Product Table -->
    <table class="table table-bordered table-striped">
        <thead class="table-dark">
        <tr>
            <th>ID</th><th>Name</th><th>Category</th><th>Price</th><th>Description</th><th>Action</th>
        </tr>
        </thead>
        <tbody id="productTableBody"></tbody>
    </table>
</div>

<script>
    // ✅ Include JWT in all requests
    $.ajaxSetup({
        beforeSend: function(xhr) {
            const token = localStorage.getItem("token");
            if (token) {
                xhr.setRequestHeader("Authorization", "Bearer " + token);
            }
        }
    });

    // ✅ Load Products
    function loadProducts() {
        $.get('products/all', function(products) {
            var tbody = $('#productTableBody').empty();
            products.forEach(function(p) {
                tbody.append(
                    '<tr>' +
                        '<td>' + p.id + '</td>' +
                        '<td><input type="text" value="' + p.name + '" id="name_' + p.id + '" class="form-control"/></td>' +
                        '<td><input type="text" value="' + p.category + '" id="category_' + p.id + '" class="form-control"/></td>' +
                        '<td><input type="number" step="0.01" value="' + p.price + '" id="price_' + p.id + '" class="form-control"/></td>' +
                        '<td><input type="text" value="' + p.description + '" id="desc_' + p.id + '" class="form-control"/></td>' +
                        '<td>' +
                            '<button class="btn btn-success btn-sm me-2" onclick="updateProduct(' + p.id + ')">Update</button>' +
                            '<button class="btn btn-danger btn-sm" onclick="deleteProduct(' + p.id + ')">Delete</button>' +
                        '</td>' +
                    '</tr>'
                );
            });
        });
    }

    // ✅ Add Product
    function addProduct() {
        var data = {
            name: $('#name').val(),
            category: $('#category').val(),
            price: $('#price').val(),
            description: $('#description').val()
        };

        $.ajax({
            url: 'products/admin/add',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function() {
                alert("Product added!");
                loadProducts();
                $('#name, #category, #price, #description').val('');
            }
        });
    }

    // ✅ Update Product
    function updateProduct(id) {
        var data = {
            name: $('#name_' + id).val(),
            category: $('#category_' + id).val(),
            price: $('#price_' + id).val(),
            description: $('#desc_' + id).val()
        };

        $.ajax({
            url: 'products/admin/update/' + id,
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function() {
                alert("Product updated!");
                loadProducts();
            }
        });
    }

    // ✅ Delete Product
    function deleteProduct(id) {
        if (!confirm("Are you sure you want to delete this product?")) return;
        $.ajax({
            url: 'products/admin/delete/' + id,
            type: 'DELETE',
            success: function() {
                alert("Product deleted!");
                loadProducts();
            }
        });
    }

    // ✅ Logout
    function logout() {
        localStorage.removeItem("token");
        window.location.href = "login-page";
    }

    // ✅ Load Products on Page Ready
    $(document).ready(function () {
        loadProducts();
    });
</script>

</body>
</html>

