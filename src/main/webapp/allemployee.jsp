<%@page import="java.util.List"%>
<%@page import="com.company.services.EmployeeService"%>
<%@page import="com.company.entity.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee Details</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
body {
	font-family: 'Segoe UI', sans-serif;
	background-color: #f4f6f8;
	padding: 20px;
}

.logout-btn {
	background: #ff4757;
	color: #fff;
	padding: 10px 20px;
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
	background: #e84118;
}

.container {
	max-width: 1000px;
	margin: auto;
	background: #fff;
	padding: 20px 30px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	border-radius: 12px;
}

h2 {
	text-align: center;
	margin-bottom: 25px;
	color: #333;
}

table {
	width: 100%;
	border-collapse: collapse;
	border-radius: 8px;
	overflow: hidden;
}

th, td {
	padding: 14px 18px;
	text-align: left;
}

th {
	background-color: #007BFF;
	color: white;
}


tr:nth-child(even) {
	background-color: #f9f9f9;
}

tr:hover {
	background-color: #eef2f7;
}

.actions {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 5px;
}

.edit-button {
	background-color: #007BFF;
	color: white;
	display: flex;
	flex-direction: column;
	border: none;
	padding: 6px 12px;
	border-radius: 5px;
	cursor: pointer;
	font-size: 14px;
	transition: 0.3s ease;
	text-decoration: none;
	border: none;
}

.edit-button:hover {
	background-color: #0056b3;
}
</style>
</head>
<body>

	<div
		style="display: flex; gap: 1rem; align-items: flex-start; padding: 20px;">
		<button onclick="history.back()" class="logout-btn">
			<i class="fas fa-arrow-left"></i>
		</button>
	</div>
	<div class="container">
		<h2>Employee Information</h2>
		<table>
			<thead>
				<tr>
					<th>ID</th>
					<th>Name</th>
					<th>Age</th>
					<th>Address</th>
					<th>Experience</th>
					<th>Reporting MGR</th>
					<th style="text-align:center">Action</th>
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
						<div class="actions">
							<form action="updateemployee.jsp" method="get"
								style="display: inline;">
								<input type="hidden" name="id" value="<%=emp.getId()%>" />
								<button type="submit" class="edit-button">Edit</button>
							</form>
							<form action="deleteemployee" method="get">
								<input type="hidden" name="empId" value="<%=emp.getId()%>" />
								<button type="submit" class="edit-button"
									style="background-color: red;">Delete</button>
							</form>
						</div>
					</td>
				</tr>
				<%
				}
				} else {
				%>
				<tr>
					<td colspan="6" style="text-align: center;">No Employee Data
						Found</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>

</body>
</html>
