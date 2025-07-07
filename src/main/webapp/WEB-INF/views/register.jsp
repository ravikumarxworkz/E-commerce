<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Register</title>
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
        .register-container {
            max-width: 500px;
            margin: 0 auto;
            margin-top: 80px;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            background-color: white;
        }
        .register-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .form-control:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
        }
        .btn-register {
            width: 100%;
            padding: 10px;
            font-weight: 600;
        }
        .password-strength {
            height: 5px;
            margin-top: 5px;
            background-color: #e9ecef;
            border-radius: 3px;
            overflow: hidden;
        }
        .password-strength-bar {
            height: 100%;
            width: 0%;
            transition: width 0.3s ease;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="register-container">
            <div class="register-header">
                <i class="fas fa-user-plus fa-4x mb-3" style="color: #0d6efd;"></i>
                <h2>Create Your Account</h2>
                <p class="text-muted">Join us today - it only takes a minute</p>
            </div>
            
            <form id="registerForm">
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                        <input type="text" class="form-control" id="username" placeholder="Choose a username" required>
                    </div>
                    <div class="form-text">Must be 4-20 characters long</div>
                </div>
                
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                        <input type="password" class="form-control" id="password" placeholder="Create a password" required>
                        <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                    <div class="password-strength mt-2">
                        <div class="password-strength-bar" id="passwordStrengthBar"></div>
                    </div>
                    <div class="form-text">Use 8 or more characters with a mix of letters, numbers & symbols</div>
                </div>
                
                <div class="mb-4">
                    <label for="confirmPassword" class="form-label">Confirm Password</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                        <input type="password" class="form-control" id="confirmPassword" placeholder="Re-enter your password" required>
                    </div>
                    <div id="passwordMatch" class="form-text"></div>
                </div>
                
                <div class="mb-3 form-check">
                    <input type="checkbox" class="form-check-input" id="termsCheck" required>
                    <label class="form-check-label" for="termsCheck">I agree to the <a href="#" class="text-decoration-none">Terms of Service</a> and <a href="#" class="text-decoration-none">Privacy Policy</a></label>
                </div>
                
                <div class="d-grid mb-3">
                    <button type="submit" class="btn btn-primary btn-register">
                        <i class="fas fa-user-plus me-2"></i> Register
                    </button>
                </div>
                
                <div class="text-center">
                    <p class="mb-0">Already have an account? <a href="login-page" class="text-decoration-none">Sign in</a></p>
                </div>
            </form>
        </div>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        $(document).ready(function() {
            // Password visibility toggle
            $('#togglePassword').click(function() {
                const password = $('#password');
                const icon = $(this).find('i');
                const type = password.attr('type') === 'password' ? 'text' : 'password';
                password.attr('type', type);
                icon.toggleClass('fa-eye fa-eye-slash');
            });
            
            // Password strength indicator
            $('#password').on('input', function() {
                const password = $(this).val();
                let strength = 0;
                
                // Length check
                if (password.length >= 8) strength += 25;
                if (password.length >= 12) strength += 15;
                
                // Character variety checks
                if (/[A-Z]/.test(password)) strength += 15;
                if (/[a-z]/.test(password)) strength += 15;
                if (/[0-9]/.test(password)) strength += 15;
                if (/[^A-Za-z0-9]/.test(password)) strength += 15;
                
                // Update strength bar
                strength = Math.min(strength, 100);
                $('#passwordStrengthBar').css('width', strength + '%');
                
                // Update color based on strength
                if (strength < 40) {
                    $('#passwordStrengthBar').css('background-color', '#dc3545');
                } else if (strength < 70) {
                    $('#passwordStrengthBar').css('background-color', '#ffc107');
                } else {
                    $('#passwordStrengthBar').css('background-color', '#28a745');
                }
            });
            
            // Password confirmation check
            $('#confirmPassword').on('input', function() {W
                const password = $('#password').val();
                const confirmPassword = $(this).val();
                
                if (confirmPassword.length > 0) {
                    if (password === confirmPassword) {
                        $('#passwordMatch').html('<i class="fas fa-check-circle text-success"></i> Passwords match');
                    } else {
                        $('#passwordMatch').html('<i class="fas fa-times-circle text-danger"></i> Passwords do not match');
                    }
                } else {
                    $('#passwordMatch').text('');
                }
            });
            
            // Form submission
            $('#registerForm').submit(function (e) {
                e.preventDefault();
                
                // Validate password match
                if ($('#password').val() !== $('#confirmPassword').val()) {
                    const alert = $('<div class="alert alert-danger alert-dismissible fade show" role="alert">' +
                                   '<i class="fas fa-exclamation-circle me-2"></i> Passwords do not match!' +
                                   '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>' +
                                   '</div>');
                    $('.register-container').prepend(alert);
                    return;
                }
                
                // Add loading state
                const btn = $(this).find('button[type="submit"]');
                btn.html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Registering...');
                btn.prop('disabled', true);
                
                $.ajax({
                    url: 'auth/register',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({
                        username: $('#username').val(),
                        password: $('#password').val()
                    }),
                    success: function (msg) {
                        // Show success alert
                        const alert = $('<div class="alert alert-success alert-dismissible fade show" role="alert">' +
                                     '<i class="fas fa-check-circle me-2"></i> ' + msg + ' Redirecting to login...' +
                                     '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>' +
                                     '</div>');
                        $('.register-container').prepend(alert);
                        
                        setTimeout(() => {
                            window.location.href = 'login-page';
                        }, 2000);
                    },
                    error: function (xhr) {
                        // Reset button
                        btn.html('<i class="fas fa-user-plus me-2"></i> Register');
                        btn.prop('disabled', false);
                        
                        // Show error alert
                        let errorMsg = 'Registration failed!';
                        if (xhr.responseJSON && xhr.responseJSON.message) {
                            errorMsg = xhr.responseJSON.message;
                        }
                        
                        const alert = $('<div class="alert alert-danger alert-dismissible fade show" role="alert">' +
                                       '<i class="fas fa-exclamation-circle me-2"></i> ' + errorMsg +
                                       '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>' +
                                       '</div>');
                        $('.register-container').prepend(alert);
                    }
                });
            });
        });
    </script>
</body>
</html>