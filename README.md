## 👨‍💼 EmployeeManager Pro

A full-stack **Java EE web application** to manage employee records, built using **Servlets, JSP, Hibernate (JPA), and MySQL**. It allows users to register, update, view, and delete employee information through a modern UI.

---

## 🚀 Features

- 🔐 User Registration & Login
- ➕ Add New Employees
- 🔍 View All Employees
- ✏️ Update Existing Employees
- ❌ Delete Employees
- 📊 Dashboard with Navigation
- 🔒 Session-based Authentication
- 📦 SweetAlert Integration for UI Alerts

---

## 📁 Project Structure

EmployeeManagement/
├── src/
│ ├── main/
│ │ ├── java/
│ │ │ └── com.company/
│ │ │ ├── controller/
│ │ │ │ ├── DeleteEmployee.java
│ │ │ │ ├── FetchEmployee.java
│ │ │ │ ├── LoginServlet.java
│ │ │ │ ├── LogOutServlet.java
│ │ │ │ ├── RegisterEmployeeServlet.java
│ │ │ │ ├── RegisterUserServlet.java
│ │ │ │ └── UpdateEmployeeServlet.java
│ │ │ ├── entity/
│ │ │ │ ├── Employee.java
│ │ │ │ └── User.java
│ │ │ └── services/
│ │ │ ├── EmployeeService.java
│ │ │ └── UserService.java
│ │ ├── resources/
│ │ │ └── META-INF/
│ │ │ └── persistence.xml
│ │ └── webapp/
│ │ ├── WEB-INF/
│ │ │ └── web.xml
│ │ ├── allemployee.jsp
│ │ ├── dashboard.jsp
│ │ ├── delete.jsp
│ │ ├── employee.jsp
│ │ ├── error.jsp
│ │ ├── index.html
│ │ ├── registeremployee.jsp
│ │ ├── update.jsp
│ │ ├── updateemployee.jsp
│ │ ├── userregister.html
│ │ └── viewsemployee.jsp
├── test/
├── target/
├── pom.xml


---

## 🔧 Setup Instructions

### 1. 📦 Clone the Repository

```bash
git clone https://github.com/DakhinTudu/Simple-Employee-Management-System-Java_project.git
cd Simple-Employee-Management-System-Java_project

2. 💻 Import into Eclipse IDE
Pre-requisite: Install Eclipse IDE with Maven and JEE support

Open Eclipse

Go to: File → Import → Maven → Existing Maven Projects

Browse to the project folder and Finish

3. 🛢️ Setup MySQL Database

CREATE DATABASE ems_servlet2;

Optional: Create user and grant access
CREATE USER 'root'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON ems_servlet2.* TO 'root'@'localhost';
FLUSH PRIVILEGES;

🔗 DB Config Location
<property name="jakarta.persistence.jdbc.url" value="jdbc:mysql://localhost:3306/ems_servlet2" />
<property name="jakarta.persistence.jdbc.user" value="root" />
<property name="jakarta.persistence.jdbc.password" value="password" />


4. 🚀 Run on Apache Tomcat
Right-click project → Run As → Run on Server

Choose Apache Tomcat v10.1+

App starts at:
http://localhost:8080/EmployeeManagement/index.html
```

## 🛠 Technologies Used
- Java 17+
- Servlets & JSP
- JPA with Hibernate
- MySQL
- Lombok
- Apache Tomcat 10
- Maven
- Eclipse IDE
- SweetAlert

##🔐 Authentication Flow
Session check is performed on each page using:
```bash
<%
session = request.getSession(false);
if (session == null || !"success".equals(session.getAttribute("logincheck"))) {
	response.sendRedirect("index.html");
	return;
}
%>
```
## 📸 Screenshots
<details> <summary><strong>Click to expand</strong></summary>
	
##🏠 Home Page
![homepage png](https://github.com/user-attachments/assets/7ba3d0f2-6213-41f7-b61e-c5d726d78a09)


##🔐 Login Page
![login png](https://github.com/user-attachments/assets/0b1fe5df-a981-45bc-810f-d67d8f138086)


##🧑‍💼 Admin Dashboard
![admin-dashboard png](https://github.com/user-attachments/assets/fad3e5e8-ed36-4fd3-acdf-63f9d76cc344)


##➕ Register Employee
![register-employee png](https://github.com/user-attachments/assets/d0ecce1f-77a3-46bb-83a5-53a99dd4558f)


##✏️ Update Employee
![update-employee png](https://github.com/user-attachments/assets/f729365d-a3a4-427c-b60c-cb5b1d34eb03)


##👁️ View Employee
![view-employee png](https://github.com/user-attachments/assets/dea44f64-5e36-4727-998b-48f7b9d6b51c)


##❌ Delete Employee
![delete-employee png](https://github.com/user-attachments/assets/fbf2bc21-67c6-4167-984f-9f57dd9e4771)

</details>

## 👨‍💻 Author

Dakhin Tudu
🔗 [GitHub Profile](https://github.com/DakhinTudu)

## 🤝 Contribution

Feel free to fork and contribute to this project! For major changes, please open an issue first.

## 📜 License

MIT License — Feel free to use and modify this project.

## 📩 Contact

For suggestions or feedback:
📧 dtudu195@gmail.com
🔗 [GitHub Profile](https://github.com/DakhinTudu)
