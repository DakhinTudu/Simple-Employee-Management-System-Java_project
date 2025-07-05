<%@page import="java.time.LocalTime"%>
<%@page import="java.time.Month"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Collections"%>
<%@page import="com.company.entity.Employee"%>
<%@page import="java.util.List"%>
<%@page import="com.company.services.EmployeeService"%>
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
<title>Admin Dashboard | EmployeeManager</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
:root {
	--sidebar-width: 250px;
	--primary-color: #4361ee;
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
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

body {
	background-color: #f7f9fc;
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
}

/* Dashboard Cards */
.dashboard-cards {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
	gap: 1.5rem;
	margin-bottom: 2rem;
}

.card {
	background-color: #fff;
	border-radius: 10px;
	box-shadow: var(--card-shadow);
	padding: 1.5rem;
	transition: transform 0.3s;
}

.card:hover {
	transform: translateY(-5px);
}

.card-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 1rem;
}

.card-title {
	font-size: 1rem;
	font-weight: 600;
	color: #555;
}

.card-icon {
	font-size: 1.5rem;
	width: 40px;
	height: 40px;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
}

.card-icon.employees {
	color: var(--primary-color);
	background-color: rgba(67, 97, 238, 0.1);
}

.card-icon.register {
	color: var(--success-color);
	background-color: rgba(46, 204, 113, 0.1);
}

.card-icon.update {
	color: var(--warning-color);
	background-color: rgba(243, 156, 18, 0.1);
}

.card-icon.delete {
	color: var(--danger-color);
	background-color: rgba(231, 76, 60, 0.1);
}

.card-icon.reports {
	color: #9b59b6;
	background-color: rgba(155, 89, 182, 0.1);
}

.card-value {
	font-size: 1.8rem;
	font-weight: 700;
	margin-bottom: 0.5rem;
	color: var(--dark-color);
}

.card-change {
	font-size: 0.85rem;
	margin-bottom: 1rem;
	display: flex;
	align-items: center;
	gap: 0.3rem;
}

.card-change.positive {
	color: var(--success-color);
}

.card-change.negative {
	color: var(--danger-color);
}

.view-all {
	color: var(--primary-color);
	text-decoration: none;
	font-size: 0.9rem;
	font-weight: 600;
	display: inline-block;
}

/* Dashboard Sections */
.dashboard-row {
	display: flex;
	gap: 2rem;
	margin-top: 2rem;
	flex-wrap: wrap;
}

.dashboard-col {
	flex: 1;
	min-width: 300px;
}

.section-header {
	margin-bottom: 1.5rem;
}

.section-title {
	font-size: 1.2rem;
	color: var(--dark-color);
}

/* Data Table */
.data-table {
	width: 100%;
	border-collapse: collapse;
	background-color: #fff;
	border-radius: 10px;
	overflow: hidden;
	box-shadow: var(--card-shadow);
}

.data-table th, .data-table td {
	padding: 1rem;
	text-align: left;
	border-bottom: 1px solid #eee;
}

.data-table th {
	background-color: #f8f9fa;
	font-weight: 600;
	color: #555;
}

.data-table tr:hover {
	background-color: #f8f9fa;
}

.badge {
	display: inline-block;
	padding: 0.35rem 0.65rem;
	font-size: 0.75rem;
	font-weight: 600;
	line-height: 1;
	text-align: center;
	white-space: nowrap;
	vertical-align: baseline;
	border-radius: 50rem;
}

.badge-success {
	color: #fff;
	background-color: var(--success-color);
}

/* Buttons */
.btn {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	gap: 0.5rem;
	padding: 0.75rem 1.5rem;
	border-radius: 6px;
	font-weight: 600;
	text-decoration: none;
	cursor: pointer;
	transition: all 0.3s;
	border: none;
}

.btn-primary {
	background-color: var(--primary-color);
	color: white;
}

.btn-primary:hover {
	background-color: #3a56d4;
}

.btn-group {
	display: flex;
	flex-direction: column;
	gap: 1rem;
}

/* User Profile in Header */
.user-profile {
	display: flex;
	align-items: center;
	gap: 1rem;
}

.user-avatar {
	width: 40px;
	height: 40px;
	border-radius: 50%;
	background-color: #ddd;
	display: flex;
	align-items: center;
	justify-content: center;
	overflow: hidden;
}

.user-info {
	display: flex;
	flex-direction: column;
}

.user-name {
	font-weight: 600;
}

.user-role {
	font-size: 0.8rem;
	color: #777;
}

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
}
</style>
</head>
<body>


	<%
	EmployeeService empService = new EmployeeService();
	List<Employee> empList = empService.findAllEmployee();

	int empCount = empList.size();

	int currentMonth = LocalDate.now().getMonthValue();

	long empCountCurrentMonth = empList.stream()
			.filter(emp -> emp.getJoiningDate() != null && emp.getJoiningDate().getMonthValue() == currentMonth).count();
	
	long birthdayCount = empList.stream()
			.filter(emp -> emp.getDob() != null && emp.getDob().getMonthValue() == currentMonth).count();
	
	request.setAttribute("empCount", empCount);
	%>

	<div class="container">
		<div class="sidebar-overlay"></div>
		<aside class="sidebar">
			<div class="logo">
				<img src="https://img.freepik.com/premium-vector/employee-management-icon-vector-image-can-be-used-project-management_120816-121037.jpg"
					alt="EmployeeManager Logo">
				<h2>EmployeeManager</h2>
			</div>
			<ul class="nav-menu">
				<li class="nav-item"><a href="dashboard.jsp"
					class="nav-link active"><i class="fas fa-home"></i><span>Dashboard</span></a></li>
				<li class="nav-item"><a href="registeremployee.jsp"
					class="nav-link"><i class="fas fa-user-plus"></i><span>Register
							Employee</span></a></li>
				<li class="nav-item"><a href="viewsemployee.jsp"
					class="nav-link"><i class="fas fa-users"></i><span>View
							Employees</span></a></li>
				<li class="nav-item"><a href="update.jsp" class="nav-link"><i
						class="fas fa-user-edit"></i><span>Update Employee</span></a></li>
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
					<h1>
						Welcome back!
						<%=user%></h1>
				</div>

			</header>
			<section class="content-section">
				<div class="dashboard-cards">
					<div class="card">
						<div class="card-header">
							<span class="card-title">Total Employees</span> <i
								class="fas fa-users card-icon employees"></i>
						</div>
						<div class="card-value">${empCount}</div>
						<div class="card-change positive">
							<i class="fas fa-arrow-up"></i>
							<%=empCountCurrentMonth%>
							new this month
						</div>
						<a href="viewsemployee.jsp" class="view-all">View All</a>
					</div>
					<div class="card">
						<div class="card-header">
							<span class="card-title">Register Employee</span> <i
								class="fas fa-user-plus card-icon register"></i>
						</div>
						<div class="card-value">+ New</div>
						<div class="card-change">
							<i class="fas fa-arrow-right"></i> Add to system
						</div>
						<a href="registeremployee.jsp" class="view-all">Register Now</a>
					</div>
					<div class="card">
						<div class="card-header">
							<span class="card-title">Birthdays This Month</span> <i
								class="fas fa-birthday-cake card-icon birthday"></i>
						</div>
						<div class="card-value"><%=birthdayCount%></div>
						<div class="card-change">
							<i class="fas fa-gift"></i> Celebrate with team
						</div>
						<a href="error.jsp" class="view-all">View Birthdays</a>
					</div>

					<div class="card">
						<div class="card-header">
							<span class="card-title">Delete Employee</span> <i
								class="fas fa-user-times card-icon delete"></i>
						</div>
						<div class="card-value">3</div>
						<div class="card-change negative">
							<i class="fas fa-arrow-down"></i> Terminations
						</div>
						<a href="delete.jsp" class="view-all">Manage Employees</a>
					</div>
				</div>
				<div class="dashboard-row">
					<div class="dashboard-col" style="flex: 2;">
						<div class="section-header">
							<h2 class="section-title">Recent Activity</h2>
						</div>
						<table class="data-table">
							<thead>
								<tr>
									<th>Date</th>
									<th>Activity</th>
									<th>Employee</th>
									<th>Status</th>
								</tr>
							</thead>
							<tbody>

								<%
								Employee employee1 = empList.get(empList.size() - 1);
								Employee employee2 = empList.get(empList.size() - 2);
								Employee employee3 = empList.get(empList.size() - 3);
								%>

								<tr>
									<td><%=new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date())%></td>
									<td>New employee registered</td>
									<td><%=employee1.getName()%></td>
									<td><span class="badge badge-success">Completed</span></td>
								</tr>
								<tr>
									<td><%=new java.text.SimpleDateFormat("yyyy-MM-dd")
		.format(new java.util.Date(new java.util.Date().getTime() - 86400000))%></td>
									<td>New employee registered</td>
									<td><%=employee2.getName()%></td>
									<td><span class="badge badge-success">Completed</span></td>
								</tr>
								<tr>
									<td><%=new java.text.SimpleDateFormat("yyyy-MM-dd")
		.format(new java.util.Date(new java.util.Date().getTime() - 172800000))%></td>
									<td>New employee registered</td>
									<td><%=employee3.getName()%></td>
									<td><span class="badge badge-success">Completed</span></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="dashboard-col">
						<div class="section-header">
							<h2 class="section-title">Quick Actions</h2>
						</div>
						<div class="btn-group">
							<a href="registeremployee.jsp" class="btn btn-primary"><i
								class="fas fa-user-plus"></i> Register Employee</a> <a
								href="viewsemployee.jsp" class="btn btn-primary"><i
								class="fas fa-search"></i> Search Employees</a> <a href="update.jsp"
								class="btn btn-primary"><i class="fas fa-edit"></i> Update
								Records</a> <a href="delete.jsp" class="btn btn-primary"><i
								class="fas fa-trash-alt"></i> Manage Terminations</a>
						</div>
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