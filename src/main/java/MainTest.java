package com.example.bloodbank.test;

import com.example.bloodbank.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;

public class MainTest {
    public static void main(String[] args) {

        EntityManagerFactory emf = JPAUtil.getEntityManagerFactory();
        EntityManager em = null;

        try {
            em = emf.createEntityManager();

            em.getTransaction().begin();

            Object result = em.createNativeQuery("SELECT 1").getSingleResult();
            System.out.println("✅ Connection test successful: " + result);

            em.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
            JPAUtil.close();
        }
    }
}
