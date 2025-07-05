package com.company.controller;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogOutServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// Servlet Context

		ServletContext context = getServletContext();
		System.out.println(context.getInitParameter("domain"));
		System.out.println(context.getInitParameter("email"));

		//

		// Invalidate session if exists
		HttpSession session = req.getSession(false);
		if (session != null) {
			session.invalidate();
		}

		// Remove login cookie
		Cookie[] cookies = req.getCookies();
		if (cookies != null) {
			for (Cookie c : cookies) {
				if ("logintest".equals(c.getName())) {
					c.setValue("");
					c.setMaxAge(0);
					c.setPath("/");
					resp.addCookie(c);
					break;
				}
			}
		}

		resp.sendRedirect("index.html");
//		PrintWriter pw = resp.getWriter();
//		pw.println("<script type='text/javascript'>");
//		pw.println("alert('You have been logged out successfully');");
//		pw.println("location='index.html';"); // redirect after alert, change to your desired page
//		pw.println("</script>");
	}

}
