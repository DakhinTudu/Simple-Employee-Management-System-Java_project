package com.company.services;

import java.util.List;

import com.company.entity.User;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import jakarta.persistence.Query;

public class UserService {

	// static because single data base connection object will be shared

	// but if non-static then each object of these data will generate different
	// database connection
	private static final EntityManagerFactory emf;
	private static final EntityManager em;
	private static final EntityTransaction et;

	// During class loading time we do not which one will first get executes that's
	// why initializing with static block
	// first loaded then initialized with static block
	static {
		emf = Persistence.createEntityManagerFactory("qspbhub");
		em = emf.createEntityManager();
		et = em.getTransaction();
	}

	// method to save to the user data into the database
	public boolean saveUserService(String name, String password) {
		User user = new User(null, name, password);

		try {
			et.begin();
			em.persist(user);
			et.commit();
		} catch (Exception e) {
			e.printStackTrace();

			return false;
		}

		return true;
	}

	// method to validate the user login
	public Object[] userLoginValidation(String username, String password) {
		try {
			Query q = em.createQuery("SELECT u FROM User u WHERE u.username = ?1 "+"AND u.password = ?2");

			q.setParameter(1, username);
			q.setParameter(2, password);


			List<User> user = q.getResultList();


			if (user.isEmpty()) {
				Object response[] = new Object[2];
				response[0] = false;
				response[1] = "invalid credentials";
				return response;
			} else {
				Object response[] = new Object[2];
				response[0] = true;
				response[1] = "login successful";
				return response;
			}
		} catch (Exception e) {
			e.printStackTrace();

			Object response[] = new Object[2];
			response[0] = false;
			response[1] = "unexpected error occurred while logging in";
			return response;
		}
	}

}
