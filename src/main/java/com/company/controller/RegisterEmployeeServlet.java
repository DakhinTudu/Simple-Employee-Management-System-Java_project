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

@WebServlet("/rgisteremployee")
public class RegisterEmployeeServlet extends HttpServlet {
	EmployeeService employeeService = new EmployeeService();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		PrintWriter pw = resp.getWriter();
		if (!isLoggedIn(req)) {

			pw.println("<script type='text/javascript'>");
			pw.println("alert('User is not logged in');");
			pw.println("location='index.html';"); // redirect after alert, change to your desired page
			pw.println("</script>");

		} else {

			String name = req.getParameter("name");
			String address = req.getParameter("address");
			LocalDate dob = LocalDate.parse(req.getParameter("dob"));
			Float yoe = Float.parseFloat(req.getParameter("yoe"));
			Float salary = Float.parseFloat(req.getParameter("salary"));
			Integer age = LocalDate.now().getYear()-dob.getYear();
			String reportingMgr = req.getParameter("reportingManager");
			LocalDate joiningDate = LocalDate.now();

			Employee employee = new Employee();

			employee.setName(name);
			employee.setAddress(address);
			employee.setDob(dob);
			employee.setYoe(yoe);
			employee.setSalary(salary);
			employee.setAge(age);
			employee.setReportingManager(reportingMgr);
			employee.setJoiningDate(joiningDate);

			System.out.println(employee.toString());
			
			boolean res = employeeService.saveUserService(employee);
			
			
			resp.setContentType("text/html");

			pw.println("<html>");
			pw.println("<head>");
			pw.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
			pw.println("</head>");
			pw.println("<body>");
			pw.println("<script>");

			if (res) {
			    pw.println("Swal.fire({");
			    pw.println("  icon: 'success',");
			    pw.println("  title: 'Success!',");
			    pw.println("  text: 'Employee registered successfully!'");
			    pw.println("}).then(() => {");
			    pw.println("  window.location = 'registeremployee.jsp';");
			    pw.println("});");
			} else {
			    pw.println("Swal.fire({");
			    pw.println("  icon: 'error',");
			    pw.println("  title: 'Registration Failed!',");
			    pw.println("  text: 'Employee registration failed!'");
			    pw.println("}).then(() => {");
			    pw.println("  window.location = 'registeremployee.jsp';");
			    pw.println("});");
			}

			pw.println("</script>");
			pw.println("</body>");
			pw.println("</html>");


//			if (res) {
//				pw.println("<script type='text/javascript'>");
//				pw.println("alert('Employee registered successfully!');");
//				pw.println("location='registeremployee.jsp';"); // redirect after alert, change to your desired page
//				pw.println("</script>");
//			} else {
//				pw.println("<script type='text/javascript'>");
//				pw.println("alert('Employee registration failed!');");
//				pw.println("location='registeremployee.jsp';"); // redirect after alert, change to your desired page
//				pw.println("</script>");
//			}
		}

	}

	private boolean isLoggedIn(HttpServletRequest request) {
		Cookie c[] = request.getCookies();
		if (c == null)
			return false;

		for (Cookie c1 : c) {
			if (c1.getName().equals("logintest") && c1.getValue().equals("success"))
				return true;
		}

		return false;
	}

}
