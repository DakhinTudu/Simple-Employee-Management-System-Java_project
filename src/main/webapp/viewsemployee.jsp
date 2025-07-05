<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
session = request.getSession(false);
if (session == null || !"success".equals(session.getAttribute("logincheck"))) {
    response.sendRedirect("index.html");
    return;
}
String user = (String) session.getAttribute("name");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Employees | EmployeeManager</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --sidebar-width: 250px;
            --primary-color: #4361ee;
            --primary-light: #4cc9f0;
            --success-color: #2ecc71;
            --warning-color: #f39c12;
            --danger-color: #e74c3c;
            --light-color: #f8f9fa;
            --dark-color: #343a40;
            --sidebar-bg: #2f3542;
            --sidebar-text: #f1f2f6;
            --header-bg: #ffffff;
            --card-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            --mobile-breakpoint: 768px;
            --border-radius: 8px;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background-color: #f5f7fa;
            color: #333;
            overflow-x: hidden;
        }
        
        .container {
            display: flex;
            min-height: 100vh;
            position: relative;
        }
        
        /* Sidebar Styles */
        .sidebar {
            width: var(--sidebar-width);
            background-color: var(--sidebar-bg);
            color: var(--sidebar-text);
            padding: 1.5rem 0;
            transition: all 0.3s ease;
            position: fixed;
            height: 100vh;
            z-index: 1000;
            transform: translateX(0);
        }
        
        .logo {
            display: flex;
            align-items: center;
            padding: 0 1.5rem;
            margin-bottom: 2rem;
        }
        
        .logo img {
            width: 40px;
            height: 40px;
            margin-right: 10px;
            border-radius: 50%;
        }
        
        .logo h2 {
            font-size: 1.2rem;
            font-weight: 600;
        }
        
        .nav-menu {
            list-style: none;
            padding: 0 1rem;
            margin-bottom: 1.5rem;
        }
        
        .nav-item {
            margin-bottom: 0.5rem;
        }
        
        .nav-link {
            display: flex;
            align-items: center;
            padding: 0.75rem 1rem;
            color: var(--sidebar-text);
            text-decoration: none;
            border-radius: 6px;
            transition: all 0.3s;
        }
        
        .nav-link:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }
        
        .nav-link.active {
            background-color: var(--primary-color);
        }
        
        .nav-link i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }
        
        .divider {
            height: 1px;
            background-color: rgba(255, 255, 255, 0.1);
            margin: 1.5rem 1rem;
        }
        
        /* Main Content Styles */
        .main-content {
            flex: 1;
            margin-left: var(--sidebar-width);
            padding: 0;
            transition: margin-left 0.3s ease;
        }
        
        .header {
            background-color: var(--header-bg);
            padding: 1rem 2rem;
            box-shadow: var(--card-shadow);
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 100;
        }
        
        .menu-toggle {
            display: none;
            background: none;
            border: none;
            color: var(--dark-color);
            font-size: 1.5rem;
            cursor: pointer;
            padding: 0.5rem;
        }
        
        .page-title h1 {
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
            color: var(--dark-color);
        }
        
        .page-title p {
            color: #666;
            font-size: 0.9rem;
        }
        
        .content-section {
            padding: 2rem;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 2rem;
        }
        
        /* Form Styles */
        .registration-container {
            width: 100%;
            max-width: 450px;
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
            overflow: hidden;
        }
        
        .form-header {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-light));
            color: white;
            padding: 25px;
            text-align: center;
        }
        
        .form-header h1 {
            font-size: 1.6rem;
            margin-bottom: 5px;
        }
        
        .form-body {
            padding: 25px 30px;
        }
        
        .form-group {
            margin-bottom: 20px;
            position: relative;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--dark-color);
            font-size: 0.95rem;
        }
        
        .input-field {
            position: relative;
        }
        
        .input-field input {
            width: 100%;
            padding: 12px 15px 12px 40px;
            font-size: 1rem;
            border: 1px solid #ddd;
            border-radius: var(--border-radius);
            transition: all 0.3s ease;
        }
        
        .input-field input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.2);
        }
        
        .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--warning-color);
        }
        
        .submit-btn {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, var(--primary-color), var(--primary-light));
            color: white;
            font-weight: 600;
            font-size: 1rem;
            border: none;
            border-radius: var(--border-radius);
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }
        
        .submit-btn:hover {
            opacity: 0.9;
            transform: translateY(-2px);
        }
        
        /* Buttons */
        .logout-btn {
            background: var(--danger-color);
            color: #fff;
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            transition: background 0.3s;
        }
        
        .logout-btn:hover {
            background: #c0392b;
        }
        
        .back-btn {
            background: #6c757d;
            color: #fff;
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            transition: background 0.3s;
            margin-right: 1rem;
        }
        
        .back-btn:hover {
            background: #5a6268;
        }
        
        .action-buttons {
            display: flex;
            gap: 1rem;
            margin-bottom: 1.5rem;
            padding: 0 2rem;
        }
        
        /* Overlay for mobile menu */
        .sidebar-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 999;
            display: none;
        }
        
        /* Responsive Styles */
        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
                width: 280px;
            }
            
            .sidebar.active {
                transform: translateX(0);
            }
            
            .main-content {
                margin-left: 0;
            }
            
            .menu-toggle {
                display: block;
            }
            
            .sidebar-overlay.active {
                display: block;
            }
            
            .action-buttons {
                padding: 0 1rem;
            }
            
            .form-body {
                padding: 20px;
            }
            
            .form-header {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="sidebar-overlay"></div>
        <aside class="sidebar">
            <div class="logo">
                <img src="https://img.freepik.com/premium-vector/employee-management-icon-vector-image-can-be-used-project-management_120816-121037.jpg" alt="EmployeeManager Logo">
                <h2>EmployeeManager</h2>
            </div>
            <ul class="nav-menu">
                <li class="nav-item"><a href="dashboard.jsp" class="nav-link"><i class="fas fa-home"></i><span>Dashboard</span></a></li>
                <li class="nav-item"><a href="registeremployee.jsp" class="nav-link"><i class="fas fa-user-plus"></i><span>Register Employee</span></a></li>
                <li class="nav-item"><a href="viewsemployee.jsp" class="nav-link active"><i class="fas fa-users"></i><span>View Employees</span></a></li>
                <li class="nav-item"><a href="update.jsp" class="nav-link"><i class="fas fa-user-edit"></i><span>Update Employee</span></a></li>
                <li class="nav-item"><a href="delete.jsp" class="nav-link"><i class="fas fa-user-times"></i><span>Delete Employee</span></a></li>
            </ul>
            <div class="divider"></div>
            <ul class="nav-menu">
                <li class="nav-item"><a href="error.jsp" class="nav-link"><i class="fas fa-chart-line"></i><span>Reports</span></a></li>
                <li class="nav-item"><a href="#" class="nav-link"><i class="fas fa-cog"></i><span>Settings</span></a></li>
            </ul>
            
              <form action="logout" method="GET" style="margin-left: 30px	;">
                    <button type="submit" class="logout-btn">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </button>
                </form>
        </aside>
        <main class="main-content">
            <header class="header">
                <button class="menu-toggle" id="menuToggle">
                    <i class="fas fa-bars"></i>
                </button>
                <div class="page-title">
                    <h1>View Employees</h1>
                    <p>Search for employees in the system</p>
                </div>
              
            </header>
            
            <!-- <div class="action-buttons">
                <button onclick="history.back()" class="back-btn">
                    <i class="fas fa-arrow-left"></i> Back
                </button>
            </div> -->
            
           <section class="content-section">
    <div class="registration-container">
        <div class="form-header">
            <h1><i class="fas fa-search"></i> Employee Search Panel</h1>
        </div>
        <div class="form-body">
            <form action="fetchemployee" method="GET" style="display: flex; flex-direction: column; gap: 1.5rem;">
                <!-- Search by ID -->
                <div class="form-group">
                    <label for="id">Search by ID</label>
                    <div class="input-field">
                        <i class="fas fa-id-badge input-icon"></i>
                        <input type="number" id="id" name="id" placeholder="Enter Employee ID">
                    </div>
                </div>
<!-- 
                Search by Name
                <div class="form-group">
                    <label for="name">Search by Name</label>
                    <div class="input-field">
                        <i class="fas fa-user input-icon"></i>
                        <input type="text" id="name" name="name" placeholder="Enter Employee Name">
                    </div>
                </div>

                Search by Email
                <div class="form-group">
                    <label for="email">Search by Email</label>
                    <div class="input-field">
                        <i class="fas fa-envelope input-icon"></i>
                        <input type="email" id="email" name="email" placeholder="Enter Email Address">
                    </div>
                </div>
 -->
                <!-- Search Buttons -->
                <div style="display: flex; flex-direction: column; gap: 1rem;">
                    <button type="submit" class="submit-btn">
                        <i class="fas fa-search"></i> Search Employee
                    </button>
                    <a href="allemployee.jsp" class="submit-btn" style="background: var(--success-color); text-decoration:none;">
                        <i class="fas fa-database"></i> Fetch All Employees
                    </a>
                </div>
            </form>
        </div>
    </div>
</section>

        </main>
    </div>

    <script>
        // Mobile menu toggle functionality
        const menuToggle = document.getElementById('menuToggle');
        const sidebar = document.querySelector('.sidebar');
        const sidebarOverlay = document.querySelector('.sidebar-overlay');
        
        menuToggle.addEventListener('click', function() {
            sidebar.classList.toggle('active');
            sidebarOverlay.classList.toggle('active');
        });
        
        sidebarOverlay.addEventListener('click', function() {
            sidebar.classList.remove('active');
            sidebarOverlay.classList.remove('active');
        });
        
        // Close menu when clicking on a nav link (for mobile)
        const navLinks = document.querySelectorAll('.nav-link');
        navLinks.forEach(link => {
            link.addEventListener('click', function() {
                if (window.innerWidth <= 768) {
                    sidebar.classList.remove('active');
                    sidebarOverlay.classList.remove('active');
                }
            });
        });
        
        // Handle window resize
        window.addEventListener('resize', function() {
            if (window.innerWidth > 768) {
                sidebar.classList.add('active');
                sidebarOverlay.classList.remove('active');
            }
        });
    </script>
</body>
</html>