package com.company.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;

import com.company.entity.Employee;
import com.company.services.EmployeeService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/updateemployee")
public class UpdateEmployeeServlet extends HttpServlet {
	private EmployeeService employeeService = new EmployeeService();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		PrintWriter pw = resp.getWriter();
		if (!isLoggedIn(req)) {

			pw.println("<script type='text/javascript'>");
			pw.println("alert('User is not logged in');");
			pw.println("location='index.html';"); // redirect after alert, change to your desired page
			pw.println("</script>");
		} else {

			Employee emp = new Employee();

			emp.setId(Integer.parseInt(req.getParameter("id")));
			emp.setName(req.getParameter("name"));
			emp.setAddress(req.getParameter("address"));
			emp.setDob(LocalDate.parse(req.getParameter("dob")));
			emp.setYoe(Float.parseFloat(req.getParameter("yoe")));
			emp.setSalary(Float.parseFloat(req.getParameter("salary")));
			emp.setAge((LocalDate.now().getYear()) - (emp.getDob().getYear()));
			emp.setReportingManager(req.getParameter("reportingManager"));

			boolean success = employeeService.employeeUpdate(emp);

			String referer = req.getHeader("referer");
			
			
			
			resp.setContentType("text/html");

			String icon = success ? "success" : "error";
			String title = success ? "Updated!" : "Update Failed!";
			String message = success ? "Employee updated successfully!" : "Employee updation failed!";

			pw.println("<html>");
			pw.println("<head>");
			pw.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
			pw.println("</head>");
			pw.println("<body>");
			pw.println("<script>");
			pw.println("Swal.fire({");
			pw.println("  icon: '" + icon + "',");
			pw.println("  title: '" + title + "',");
			pw.println("  text: '" + message + "'");
			pw.println("}).then(() => {");
			pw.println("  window.location = '" + referer + "';");
			pw.println("});");
			pw.println("</script>");
			pw.println("</body>");
			pw.println("</html>");


//			if (success) {
//				pw.println("<script type='text/javascript'>");
//				pw.println("alert('Employee updated successfully!');");
//				pw.println("location='" + referer + "';");
//				pw.println("</script>");
//			} else {
//				pw.println("<script type='text/javascript'>");
//				pw.println("alert('Employee updation failed!');");
//				pw.println("location='" + referer + "';");
//				pw.println("</script>");
//			}

		}

	}

	private boolean isLoggedIn(HttpServletRequest request) {
		Cookie[] c = request.getCookies();

		if (c == null)
			return false;
		for (Cookie cookie : c) {
			if (cookie.getName().equals("logintest") && cookie.getValue().equals("success")) {
				return true;
			}
		}
		return false;
	}
}
