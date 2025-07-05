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
    margin: 0;
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
    max-width: 600px;
    margin: 40px auto;
    background: #fff;
    padding: 25px 35px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    border-radius: 12px;
}

h2 {
    text-align: center;
    margin-bottom: 25px;
    color: #333;
}

.employee-details {
    font-size: 1rem;
    line-height: 1.8;
    color: #444;
}

.employee-details p {
    margin: 12px 0;
    padding: 10px 15px;
    background-color: #f9f9f9;
    border-left: 5px solid #007BFF;
    border-radius: 6px;
}

.no-data {
    text-align: center;
    font-size: 1.1rem;
    color: #d9534f;
    background-color: #fbeaea;
    padding: 15px;
    border-radius: 8px;
    margin-top: 30px;
}

.edit-btn {
    display: flex;
    align-items: center;
    justify-content:center;
    gap:10px;
    text-align: center;
    margin-top: 25px;
    
}

.edit-btn button {
    padding: 10px 20px;
    background-color: #007BFF;
    color: white;
    border: none;
    border-radius: 6px;
    font-size: 15px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.edit-btn button:hover {
    background-color: #0056b3;
}
</style>
</head>
<body>
<div style="display: flex; gap: 1rem; align-items: flex-start; padding:20px;">
        <button onclick="history.back()" class="logout-btn">
            <i class="fas fa-arrow-left"></i>
        </button>
    </div>

<div class="container">
<%
    Employee emp = (Employee) request.getAttribute("employee");
    if (emp != null) {
%>
    <h2>Employee Details</h2>
    <div class="employee-details">
        <p><strong>ID:</strong> <%= emp.getId() %></p>
        <p><strong>Name:</strong> <%= emp.getName() %></p>
        <p><strong>Age:</strong> <%= emp.getAge() %></p>
        <p><strong>Address:</strong> <%= emp.getAddress() %></p>
        <p><strong>Experience:</strong> <%= emp.getYoe() %> years</p>
        <p><strong>Salary:</strong> ₹<%= emp.getSalary() %></p>
        <p><strong>Reporting Manager:</strong> <%= emp.getReportingManager() %></p>
    </div>

    <div class="edit-btn">
        <form action="updateemployee.jsp" method="get">
            <input type="hidden" name="id" value="<%= emp.getId() %>" />
            <button type="submit">Edit</button>
        </form>
        <form action="deleteemployee" method="get">
            <input type="hidden" name="empId" value="<%= emp.getId() %>"/>
            <button type="submit" style="background-color:red;">Delete</button>
        </form>
    </div>
<%
    } else {
%>
    <div class="no-data">No Employee Data Available</div>
<%
    }
%>
</div>

</body>
</html>
