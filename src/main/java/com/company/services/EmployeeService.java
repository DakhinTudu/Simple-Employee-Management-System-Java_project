package com.company.services;

import java.util.List;

import com.company.entity.Employee;
import com.company.entity.User;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import jakarta.persistence.Query;

public class EmployeeService {
	private static final EntityManagerFactory emf;
	private static final EntityManager em;
	private static final EntityTransaction et;

	static {
		emf = Persistence.createEntityManagerFactory("qspbhub");
		em = emf.createEntityManager();
		et = em.getTransaction();
	}

	public boolean saveUserService(Employee employee) {

		try {
			et.begin();
			em.persist(employee);
			et.commit();
		} catch (Exception e) {
			e.printStackTrace();

			return false;
		}

		return true;
	}

	// method to delete employee
	public String deleteEmployeeById(Integer id) {
		Employee emp = em.find(Employee.class, id);
		if (emp == null)
			return "No employee found with id " + id;
		try {
			et.begin();
			em.remove(emp);
			et.commit();
		} catch (Exception e) {
			e.printStackTrace();
			return "Delete failed";

		}

		return "Deleted successfully ";
	}

	// method to update employee data

	public boolean employeeUpdate(Employee employee) {
		boolean isUpdated = false;
		Employee existingEmp = em.find(Employee.class, employee.getId());
		if (existingEmp == null)
			return false;

		try {
			et.begin();

			// Update fields
			existingEmp.setName(employee.getName());
			existingEmp.setAddress(employee.getAddress());
			existingEmp.setYoe(employee.getYoe());
			existingEmp.setSalary(employee.getSalary());
			existingEmp.setAge(employee.getAge());
			existingEmp.setReportingManager(employee.getReportingManager());

			em.merge(existingEmp);
			et.commit();
			isUpdated = true;

		} catch (Exception e) {
			e.printStackTrace();
	        if (et.isActive()) {
	            et.rollback();
	        }
	        return false;

		}
		return isUpdated;

	}

	// method to fetch employee data by id
	public Employee findEmployeeById(Integer id) {
		Employee emp = em.find(Employee.class, id);

		return emp;
	}

	// method to fetch all employee data
	public List<Employee> findAllEmployee() {
		String s = "select e from Employee e";
		Query query = em.createQuery(s);
		List<Employee> employees = query.getResultList();
		return employees;
	}
}
