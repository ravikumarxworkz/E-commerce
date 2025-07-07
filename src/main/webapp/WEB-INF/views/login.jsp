<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Login</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            background-color: #f8f9fa;
        }
        .login-container {
            max-width: 400px;
            margin: 0 auto;
            margin-top: 100px;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            background-color: white;
        }
        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .form-control:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
        }
        .btn-login {
            width: 100%;
            padding: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="login-container">
            <div class="login-header">
                <i class="fas fa-user-circle fa-4x mb-3" style="color: #0d6efd;"></i>
                <h2>Welcome Back</h2>
                <p class="text-muted">Please enter your credentials</p>
            </div>
            
            <form id="loginForm">
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                        <input type="text" class="form-control" id="username" placeholder="Enter username" required>
                    </div>
                </div>
                
                <div class="mb-4">
                    <label for="password" class="form-label">Password</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                        <input type="password" class="form-control" id="password" placeholder="Enter password" required>
                    </div>
                </div>
                
                <div class="d-grid mb-3">
                    <button type="submit" class="btn btn-primary btn-login">
                        <i class="fas fa-sign-in-alt me-2"></i> Login
                    </button>
                </div>
                
                <div class="text-center">
                    <a href="#" class="text-decoration-none">Forgot password?</a>
                </div>
            </form>
        </div>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // ✅ Attach JWT token to all future Ajax calls
    $.ajaxSetup({
        beforeSend: function (xhr) {
            const token = localStorage.getItem("token");
            if (token) {
                xhr.setRequestHeader("Authorization", "Bearer " + token);
            }
        }
    });

    $('#loginForm').submit(function (e) {
        e.preventDefault();
        const btn = $(this).find('button[type="submit"]');
        btn.html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Logging in...');
        btn.prop('disabled', true);

        $.ajax({
            url: 'auth/login',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                username: $('#username').val(),
                password: $('#password').val()
            }),
            success: function (response) {
                const role = response.role;
                const token = response.token;

                localStorage.setItem('token', token);
                 console.log(role);
                 console.log(token);
                if (role === 'ADMIN') {
                    loadDashboard('admin-dashboard');
                } else if (role === 'CUSTOMER') {
                    loadDashboard('customer-dashboard');
                } else {
                    alert("Unknown role");
                }
            },
            error: function () {
                alert("Invalid username or password");
                btn.html('<i class="fas fa-sign-in-alt me-2"></i> Login');
                btn.prop('disabled', false);
            }
        });
    });

    function loadDashboard(dashboardUrl) {
        $.ajax({
            url: dashboardUrl,
            type: 'GET',
            success: function (data) {
                document.open();
                document.write(data);
                document.close();
            },
            error: function () {
                alert("Failed to load dashboard");
            }
        });
    }
</script>

</body>
</html>