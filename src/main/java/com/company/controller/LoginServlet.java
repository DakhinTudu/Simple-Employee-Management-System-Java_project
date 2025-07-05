package com.company.controller;

import java.io.IOException;



import com.company.entity.User;
import com.company.services.UserService;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebInitParam;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = { "/login", "/checkin" }, initParams = { @WebInitParam(name = "date", value = "01-07-25"),
		@WebInitParam(name = "time", value = "02:30 PM") })
public class LoginServlet extends HttpServlet {

	User user = null;
	UserService userService = new UserService();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// Servlet Context

		ServletContext context = getServletContext();
		System.out.println(context.getInitParameter("domain"));
		System.out.println(context.getInitParameter("email"));

		// Servlet Config

		ServletConfig config = getServletConfig();
		System.out.println(config.getInitParameter("date"));
		System.out.println(config.getInitParameter("time"));
		//

		String name = req.getParameter("username");
		String password = req.getParameter("password");

		
		Object[] loginResponse = userService.userLoginValidation(name, password);

		Boolean b = (Boolean) loginResponse[0];

		if (b) {
			Cookie c = new Cookie("logintest", "success");
			c.setMaxAge(600);
			c.setPath("/");
			resp.addCookie(c);
			HttpSession session = req.getSession();
			session.setAttribute("logincheck", "success");
			session.setAttribute("name",name);
			resp.sendRedirect("dashboard.jsp");
		} else {
			Cookie c = new Cookie("logintest", "failed");
			resp.addCookie(c);
			c.setPath("/");
			HttpSession session = req.getSession();
			session.setAttribute("logincheck", "failed");
			resp.sendRedirect("error.jsp");
		}

//		PrintWriter pw = resp.getWriter();
//		pw.println("<script type='text/javascript'>");
//		pw.println("alert('Logged in successfully');");
//		pw.println("location='dashboard.jsp';");
//		pw.println("</script>");

	}

}
