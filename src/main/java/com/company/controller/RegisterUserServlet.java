package com.company.controller;

import java.io.IOException;
import java.io.PrintWriter;

import com.company.services.UserService;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/userregister")
public class RegisterUserServlet extends HttpServlet {

	private final UserService userService; // non-static because only servlet object is generated unlike Database
											// Connection

	// Servlet containers like Tomcat create only one instance of the servlet class
	// and then reuse it for handling multiple requests (multi-threaded).
	{
		userService = new UserService();
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uname = req.getParameter("username");
		String password = req.getParameter("password");

		boolean res = userService.saveUserService(uname, password);
		PrintWriter pw = resp.getWriter();

//		RequestDispatcher rd = req.getRequestDispatcher("/response.html");
//
//		if (res)
//			pw.println("<h1> User registered successfully</h1>");
//		else
//			pw.println("<h1> User registration failed</h1>");
//		rd.include(req, resp);

		if (res) {
			pw.println("<script type='text/javascript'>");
			pw.println("alert('User registered successfully!');");
			pw.println("location='dashboard.jsp';"); // redirect after alert, change to your desired page
			pw.println("</script>");
		} else {
			pw.println("<script type='text/javascript'>");
			pw.println("alert('User registration failed!');");
			pw.println("location='dashboard.jsp';"); // redirect after alert, change to your desired page
			pw.println("</script>");
		}

	}
}
