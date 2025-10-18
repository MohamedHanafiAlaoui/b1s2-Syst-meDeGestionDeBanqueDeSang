package com.example.bloodbank.dao;

import com.example.bloodbank.entity.AssociationDon;
import com.example.bloodbank.entity.Donor;
import com.example.bloodbank.entity.Receveur;
import com.example.bloodbank.entity.enums.GroupeSanguin;
import com.example.bloodbank.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

public class AssociationDonDAO {

    public  void ajouterAssocDon(AssociationDon don)
    {
        EntityManager em = JPAUtil.getEntityManagerFactory(false).createEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();
            em.persist(don);
            tx.commit();
            System.out.println("AssociationDon ajouté avec succès !");
        }catch (Exception e)
        {
            tx.rollback();
        }
        finally
        {
            em.close();
        }

    }

    public  void modifierAssocDonIdRecveur(long id ,long recveur_id)
    {
        EntityManager em = JPAUtil.getEntityManagerFactory(false).createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            AssociationDon assDon = em.find(AssociationDon.class, id);

            if (assDon == null)
            {
                System.out.println(" AssociationDon introuvable avec id = " + id);
                return;
            }

            Receveur receveur = em.find(Receveur.class, recveur_id);
            if (receveur == null)
            {
                System.out.println("Aucun Receveur trouvé avec id = " +  recveur_id );
                return;

            }

            assDon.setReceveur(receveur);
            assDon.setDonEffecture(true);
            assDon.setDateDonEffecture(new Date());

            em.merge(assDon);
            tx.commit();
            System.out.println(" Receveur associé avec succès à l'AssociationDon " + id);
        }
        catch (Exception e)
            {
                if (tx.isActive()) tx.rollback();
                e.printStackTrace();
            }
        finally
        {
            em.close();
        }

    }

    public List<Donor> getDonnersSansReceveurs() {
        EntityManager em = JPAUtil.getEntityManagerFactory(false).createEntityManager();
        List<Donor> donnors = null;

        try {
            donnors = em.createQuery(
                    "SELECT  d FROM Donor d " +
                            "JOIN fetch d.associationDonList a  " +
                            "WHERE a.receveur IS NULL",
                    Donor.class
            ).getResultList();
        } finally {
            em.close();
        }

        return donnors;
    }

    public List<Donor> getDonneursSansReceveursParGroupe(GroupeSanguin groupe)
    {
        EntityManager em = JPAUtil.getEntityManagerFactory(false).createEntityManager();
        List<Donor> donnors = null;
        try {
            donnors = em.createQuery(
                            "select distinct d from Donor d " +"JOIN d.associationDonList a " +
                                    "WHERE a.receveur IS NULL" +
                                    " and d.groupesanguin = :groupe", Donor.class)
                    .setParameter("groupe", groupe)
                    .getResultList();
        } finally {
            em.close();
        }

        return donnors;
    }



    public List<Receveur> getSansReceveurs() {
        EntityManager em = JPAUtil.getEntityManagerFactory(false).createEntityManager();
        List<Receveur> receveur = null;

        try {
            receveur = em.createQuery("select distinct r from Receveur r order by  r.nombrePochesRecues", Receveur.class).getResultList();
        } finally {
            em.close();
        }

        return receveur;
    }

    public List<Receveur> getSansReceveursParGroupe(GroupeSanguin groupe)
    {
        List<Receveur> receveurs = getSansReceveurs();
        return  receveurs.stream()
                .filter(r->r.getGroupeSanguin().equals(groupe))
                .collect(Collectors.toList());

    }

    public AssociationDon getAssociationDon(long id)
    {
        EntityManager em = JPAUtil.getEntityManagerFactory(false).createEntityManager();
        AssociationDon don = null;
        try {
            don = em.find(AssociationDon.class, id);
        }
        finally {
            em.close();
        }
        return don;


    }

}
