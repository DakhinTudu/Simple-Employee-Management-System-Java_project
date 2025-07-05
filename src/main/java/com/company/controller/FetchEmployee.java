package com.company.controller;

import java.io.IOException;
import java.io.PrintWriter;

import com.company.entity.Employee;
import com.company.services.EmployeeService;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/fetchemployee")
public class FetchEmployee extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private EmployeeService employeeService = new EmployeeService();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		PrintWriter pw = resp.getWriter();

		if (!isLoggedIn(req)) {
			pw.println("<script type='text/javascript'>");
			pw.println("alert('User is not logged in');");
			pw.println("location='index.html';");
			pw.println("</script>");
		} else {
			try {
				Integer id = Integer.parseInt(req.getParameter("id"));
				Employee emp = employeeService.findEmployeeById(id);

				if (emp != null) {
					req.setAttribute("employee", emp);
					RequestDispatcher rd = req.getRequestDispatcher("/employee.jsp");
					rd.forward(req, resp);
				} else {
					pw.println("<script type='text/javascript'>");
					pw.println("alert('No employee found with ID: " + id + "');");
					pw.println("location='viewsemployee.jsp';"); // your form page
					pw.println("</script>");
				}

			} catch (NumberFormatException e) {
				pw.println("<script type='text/javascript'>");
				pw.println("alert('Invalid ID');");
				pw.println("location='viewsemployee.jsp';");
				pw.println("</script>");
			}
		}
	}

	private boolean isLoggedIn(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		if (cookies == null) return false;

		for (Cookie cookie : cookies) {
			if ("logintest".equals(cookie.getName()) && "success".equals(cookie.getValue()))
				return true;
		}
		return false;
	}
}

