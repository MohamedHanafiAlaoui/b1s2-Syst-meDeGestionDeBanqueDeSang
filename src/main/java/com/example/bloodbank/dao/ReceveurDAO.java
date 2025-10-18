package com.example.bloodbank.dao;


import com.example.bloodbank.entity.Donor;
import com.example.bloodbank.entity.Receveur;
import com.example.bloodbank.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;

import java.util.List;

public class ReceveurDAO
{

    public  void  ajouterReceveur(Receveur receveur)
    {
        EntityManager em = JPAUtil.getEntityManagerFactory(false).createEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();
            em.persist(receveur);
            tx.commit();
            System.out.println("receveur ajouté avec succès !");
        }catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        }finally {
           em.close();
        }

    }

    public  Receveur getReceveurId(long id)
    {
        EntityManager em = JPAUtil.getEntityManagerFactory(false).createEntityManager();
        EntityTransaction tx = em.getTransaction();
        Receveur receveur = null;
        try {
            receveur = em.find(Receveur.class, id);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        finally {
            em.close();
        }
        return receveur;
    }

    public List<Receveur> getAllReceveur()
    {
        EntityManager em = JPAUtil.getEntityManagerFactory(false).createEntityManager();
        List<Receveur> receveurs = null;
        try {
            receveurs = em.createQuery("SELECT r FROM  Receveur r",Receveur.class).getResultList();
        }
        finally {
            em.close();
        }
        return receveurs;
    }

    public  void  modifierReceveur(Receveur receveur)
    {
        EntityManager em = JPAUtil.getEntityManagerFactory(false).createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(receveur);
            tx.commit();
            System.out.println(" Receveur modifié avec succès !");
        }
        catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        }
        finally {
            em.close();
        }
    }

    public Receveur getReceveurByCin(String cin) {
        EntityManager em = JPAUtil.getEntityManagerFactory(false).createEntityManager();
        try {
            return em.createQuery("SELECT r FROM Receveur r WHERE r.cin = :cin", Receveur.class)
                    .setParameter("cin", cin)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    public  void  supprimerReceveur(long id)
    {
        EntityManager em = JPAUtil.getEntityManagerFactory(false).createEntityManager();
        EntityTransaction tx = em.getTransaction();
        Receveur receveur = null;
        try {
            tx.begin();
            receveur = em.find(Receveur.class, id);
            if (receveur != null) {
                em.remove(receveur);
                System.out.println("Receveur supprimé avec succès !");
            }
            tx.commit();

        }catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        }
        finally {
            em.close();
        }
    }


}
