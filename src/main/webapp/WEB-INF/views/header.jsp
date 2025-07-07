
<html>
<head>
    <title>Customer Dashboard</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $.ajaxSetup({
            beforeSend: function (xhr) {
                const token = localStorage.getItem("token");
                if (token) {
                    xhr.setRequestHeader("Authorization", "Bearer " + token);
                }
            }
        });
    </script>
</head>
<body>
    <h1>Welcome, ${username}</h1>
</body>
</html>
