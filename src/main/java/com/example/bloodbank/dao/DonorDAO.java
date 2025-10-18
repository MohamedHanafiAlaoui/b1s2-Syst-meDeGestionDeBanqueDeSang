package com.example.bloodbank.dao;

import com.example.bloodbank.entity.Donor;
import com.example.bloodbank.entity.enums.StatutDonneur;
import com.example.bloodbank.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;

import java.util.List;

public class DonorDAO {

    public void ajouterDonor(Donor donor)
    {
        EntityManager em  = JPAUtil.getEntityManagerFactory(false).createEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();
            em.persist(donor);
            tx.commit();
            System.out.println("Donneur ajouté avec succès !");
        }catch (Exception e)
        {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        }
        finally {
            em.close();
        }
    }

    public Donor getDonorByCin(String cin) {
        EntityManager em = JPAUtil.getEntityManagerFactory(false).createEntityManager();
        try {
            return em.createQuery("SELECT d FROM Donor d WHERE d.cin = :cin", Donor.class)
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

    public  Donor  getDonorByid(long id)
    {
        EntityManager em  = JPAUtil.getEntityManagerFactory(false).createEntityManager();
        EntityTransaction tx = em.getTransaction();
        Donor donor = null;
        try {
            donor = em.find(Donor.class,id);
        }
        catch (Exception e)
            {
            e.printStackTrace();
            }
        finally {
            em.close();
        }
        return donor;
    }

    public List<Donor> getDonors()
    {
        EntityManager em  = JPAUtil.getEntityManagerFactory(false).createEntityManager();
        EntityTransaction tx = em.getTransaction();
        List<Donor> donors = null;
        try {
            donors = em.createQuery("SELECT d FROM Donor d",Donor.class).getResultList();
        }
        finally {
            em.close();
        }
        return donors;
    }

    public void  modifierDonor(Donor donor)
    {
        EntityManager em  = JPAUtil.getEntityManagerFactory(false).createEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();
            em.merge(donor);
            tx.commit();
            System.out.println("Donneur modifié avec succès !");
        }catch (Exception e)
        {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        }finally {
            em.close();
        }
    }

    public void supprimerDonor(long id)
    {
        EntityManager em  = JPAUtil.getEntityManagerFactory(false).createEntityManager();
        EntityTransaction tx = em.getTransaction();
        Donor donor = null;
        try {
            tx.begin();
            donor = em.find(Donor.class,id);
            if(donor!=null)
            {
                em.remove(donor);
                System.out.println("Donneur supprimé avec succès !");
            }
            tx.commit();
        }catch (Exception e)
            {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
            }
        finally {
            em.close();
        }
    }


    public void  modifierDonorstatut(long donorId ,StatutDonneur statut)
    {
        EntityManager em  = JPAUtil.getEntityManagerFactory(false).createEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();
            Donor donor = em.find(Donor.class,donorId);

            if(donor!=null)
            {
                donor.setstatut(statut);

                em.merge(donor);

            } else {
                System.out.println("Aucun donneur trouvé avec l'ID: " + donorId);
            }
            tx.commit();

        }catch (Exception e)
        {
        if (tx.isActive()) tx.rollback();
        e.printStackTrace();
        } finally
        {
        em.close();
        }

    }
}
