package com.example.bloodbank.dao;

import com.example.bloodbank.entity.AssociationDon;
import com.example.bloodbank.entity.Receveur;
import com.example.bloodbank.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;

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
                System.out.println("⚠ AssociationDon introuvable avec id = " + id);
                return;
            }

            Receveur receveur = em.find(Receveur.class, recveur_id);
            if (receveur == null)
            {
                System.out.println("Aucun Receveur trouvé avec id = " +  recveur_id );
                return;

            }

            assDon.setReceveur(receveur);
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
}
