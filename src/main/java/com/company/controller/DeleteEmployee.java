package com.company.controller;

import java.io.IOException;
import java.io.PrintWriter;

import com.company.services.EmployeeService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/deleteemployee")
public class DeleteEmployee extends HttpServlet {

	EmployeeService employeeService = new EmployeeService();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		if (session.getAttribute("logincheck") == null || ((String) session.getAttribute("logincheck")) == "falied") {
			resp.sendRedirect("index.html"); // forward slash is not required here("/login.html")
		} else {
			Integer id = Integer.parseInt(req.getParameter("empId"));

			String msg = employeeService.deleteEmployeeById(id);

			String referer = req.getHeader("referer");
			resp.setContentType("text/html");
			PrintWriter pw = resp.getWriter();

			pw.println("<html>");
			pw.println("<head>");
			pw.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
			pw.println("</head>");
			pw.println("<body>");
			pw.println("<script>");
			pw.println("Swal.fire({");
			pw.println("  icon: '" + (msg.toLowerCase().contains("success") ? "success" : "error") + "',");
			pw.println("  title: '" + (msg.toLowerCase().contains("success") ? "Success!" : "Oops!") + "',");
			pw.println("  text: '" + msg + "'");
			pw.println("}).then(() => {");
			pw.println("  window.location = '" + referer + "';");
			pw.println("});");
			pw.println("</script>");
			pw.println("</body>");
			pw.println("</html>");


			
//			String referer = req.getHeader("referer");
//			PrintWriter pw = resp.getWriter();
//			pw.println("<script type='text/javascript'>");
//	        pw.println("alert('" + msg + "');");
//	        pw.println("window.location = '" + referer + "';");
//	        pw.println("</script>");
		}

	}
}


