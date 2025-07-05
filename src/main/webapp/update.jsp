<%@page import="java.util.List"%>
<%@page import="com.company.services.EmployeeService"%>
<%@page import="com.company.entity.Employee"%>
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
<html>
<head>
<meta charset="UTF-8">
<title>All Employees | EmployeeManager</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
	background-color: #f4f6f8;
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

/* Table Container */
.table-container {
	max-width: 100%;
	margin: 2rem;
	background: #fff;
	padding: 20px 30px;
	box-shadow: var(--card-shadow);
	border-radius: var(--border-radius);
}

.section-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 1.5rem;
	flex-wrap: wrap;
	gap: 1rem;
}

.section-title {
	font-size: 1.5rem;
	color: var(--dark-color);
}

/* Search Bar */
.search-container {
	position: relative;
	width: 300px;
}

.search-input {
	width: 100%;
	padding: 10px 15px 10px 40px;
	border: 1px solid #ddd;
	border-radius: var(--border-radius);
	font-size: 1rem;
	transition: all 0.3s;
}

.search-input:focus {
	outline: none;
	border-color: var(--primary-color);
	box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
}

.search-icon {
	position: absolute;
	left: 15px;
	top: 50%;
	transform: translateY(-50%);
	color: var(--warning-color);
}

/* Table Styles */
.data-table {
	width: 100%;
	border-collapse: collapse;
	border-radius: var(--border-radius);
	overflow: hidden;
}

.data-table th, .data-table td {
	padding: 14px 18px;
	text-align: left;
	border-bottom: 1px solid #eee;
}

.data-table th {
	background-color: var(--primary-color);
	color: white;
	font-weight: 600;
}

.data-table tr:nth-child(even) {
	background-color: #f9f9f9;
}

.data-table tr:hover {
	background-color: #eef2f7;
}

/* Action Buttons */
.action-buttons {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 0.5rem;
}

.btn {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	gap: 0.3rem;
	padding: 8px 12px;
	border-radius: var(--border-radius);
	font-weight: 500;
	text-decoration: none;
	cursor: pointer;
	transition: all 0.3s;
	border: none;
	font-size: 0.9rem;
}

.btn-primary {
	background-color: var(--primary-color);
	color: white;
}

.btn-primary:hover {
	background-color: #3a56d4;
}

.btn-danger {
	background-color: var(--danger-color);
	color: white;
}

.btn-danger:hover {
	background-color: #c0392b;
}

/* Buttons in Header */
.logout-btn {
	background: var(--danger-color);
	color: #fff;
	padding: 0.5rem 1rem;
	border: none;
	border-radius: var(--border-radius);
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
	border-radius: var(--border-radius);
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

.header-actions {
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
@media ( max-width : 768px) {
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
	.header-actions {
		padding: 0 1rem;
	}
	.table-container {
		margin: 1rem;
		padding: 15px;
	}
	.data-table th, .data-table td {
		padding: 10px 12px;
		font-size: 0.9rem;
	}
	.search-container {
		width: 100%;
	}
	.section-header {
		flex-direction: column;
		align-items: flex-start;
	}
}
</style>
</head>
<body>
	<div class="container">
		<div class="sidebar-overlay"></div>
		<aside class="sidebar">
			<div class="logo">
				<img
					src="https://img.freepik.com/premium-vector/employee-management-icon-vector-image-can-be-used-project-management_120816-121037.jpg"
					alt="EmployeeManager Logo">
				<h2>EmployeeManager</h2>
			</div>
			<ul class="nav-menu">
				<li class="nav-item"><a href="dashboard.jsp" class="nav-link"><i
						class="fas fa-home"></i><span>Dashboard</span></a></li>
				<li class="nav-item"><a href="registeremployee.jsp"
					class="nav-link"><i class="fas fa-user-plus"></i><span>Register
							Employee</span></a></li>
				<li class="nav-item"><a href="viewsemployee.jsp"
					class="nav-link"><i class="fas fa-users"></i><span>View
							Employees</span></a></li>
				<li class="nav-item"><a href="update.jsp"
					class="nav-link active"><i class="fas fa-user-edit"></i><span>Update
							Employee</span></a></li>
				<li class="nav-item"><a href="delete.jsp" class="nav-link"><i
						class="fas fa-user-times"></i><span>Delete Employee</span></a></li>
			</ul>
			<div class="divider"></div>
			<ul class="nav-menu">
				<li class="nav-item"><a href="error.jsp" class="nav-link"><i
						class="fas fa-chart-line"></i><span>Reports</span></a></li>
				<li class="nav-item"><a href="#" class="nav-link"><i
						class="fas fa-cog"></i><span>Settings</span></a></li>
			</ul>
			<form action="logout" method="GET" style="margin-left: 30px;">
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
					<h1>All Employees</h1>
					<p>View and manage all employee records</p>
				</div>

			</header>

			<!-- <div class="header-actions">
                <button onclick="history.back()" class="back-btn">
                    <i class="fas fa-arrow-left"></i> Back
                </button>
            </div> -->

			<div class="table-container">
				<div class="section-header">
					<h2 class="section-title">Employee Records</h2>
					<div class="search-container">
						<i class="fas fa-search search-icon"></i> <input type="text"
							id="searchInput" class="search-input"
							placeholder="Search employees...">
					</div>
				</div>

				<table class="data-table" id="employeeTable">
					<thead>
						<tr>
							<th>ID</th>
							<th>Name</th>
							<th>Age</th>
							<th>Address</th>
							<th>Experience</th>
							<th>Reporting MGR</th>
							<th style="text-align: center">Actions</th>
						</tr>
					</thead>
					<tbody>
						<%
						EmployeeService empService = new EmployeeService();
						List<Employee> empList = empService.findAllEmployee();

						if (empList != null && !empList.isEmpty()) {
							for (Employee emp : empList) {
						%>
						
						
						
						<tr>
							<td><%=emp.getId()%></td>
							<td><%=emp.getName()%></td>
							<td><%=emp.getAge()%></td>
							<td><%=emp.getAddress()%></td>
							<td><%=emp.getYoe()%></td>
							<td><%=emp.getReportingManager()%></td>
							<td>
								<div class="action-buttons">
									<form action="updateemployee.jsp" method="get"
										style="display: inline;">
										<input type="hidden" name="id" value="<%=emp.getId()%>" />
										<button type="submit" class="btn btn-primary">
											<i class="fas fa-edit"></i> Edit
										</button>
									</form>
									<form action="deleteemployee" method="get"
										style="display: inline;">
										<input type="hidden" name="empId" value="<%=emp.getId()%>" />
										<button type="submit" class="btn btn-danger">
											<i class="fas fa-trash-alt"></i> Delete
										</button>
									</form>
								</div>
							</td>
						</tr>
						<%
						}
						} else {
						%>
						<tr>
							<td colspan="7" style="text-align: center;">No Employee Data
								Found</td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
			</div>
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
        
        // Search functionality
       // Search functionality (by ID only)
document.getElementById('searchInput').addEventListener('input', function() {
    const searchValue = this.value.toLowerCase();
    const rows = document.querySelectorAll('#employeeTable tbody tr');
    
    rows.forEach(row => {
        const idCell = row.querySelector('td'); // Get the first <td> (ID)
        const idText = idCell.textContent.toLowerCase();
        
        row.style.display = idText.includes(searchValue) ? '' : 'none';
    });
});

    </script>
</body>
</html>