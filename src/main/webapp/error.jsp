<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Error | EmployeeManager</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f7f9fc;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            text-align: center;
        }
        .error-container {
            background-color: #fff;
            padding: 2rem 3rem;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            max-width: 500px;
        }
        .error-container h1 {
            color: #e84118;
            margin-bottom: 1rem;
        }
        .error-container p {
            font-size: 1rem;
            color: #555;
        }
        .btn-home {
            margin-top: 1.5rem;
            background-color: #2f3542;
            color: #fff;
            padding: 0.7rem 1.2rem;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: background 0.3s;
        }
        .btn-home:hover {
            background-color: #1e272e;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h1><i class="fas fa-exclamation-triangle"></i> Something Went Wrong</h1>
        <p>We're sorry, the operation could not be completed.<br>Please try again or contact the administrator.</p>
        <a href="dashboard.jsp" class="btn-home"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
    </div>
</body>
</html>