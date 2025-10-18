package com.example.bloodbank.service;

import com.example.bloodbank.dao.AssociationDonDAO;
import com.example.bloodbank.entity.AssociationDon;
import com.example.bloodbank.entity.Donor;
import com.example.bloodbank.entity.Receveur;
import com.example.bloodbank.entity.enums.GroupeSanguin;

import java.util.*;

public class AssociationDonService {

    public  final AssociationDonDAO associationDonDAO;
    private  static  final Map<GroupeSanguin, List<GroupeSanguin>>   compatibilityMap = new HashMap<>();
    static{
        compatibilityMap.put(GroupeSanguin.O_NEGATIF, Arrays.asList(GroupeSanguin.O_NEGATIF));
        compatibilityMap.put(GroupeSanguin.O_POSITIF, Arrays.asList(GroupeSanguin.O_NEGATIF, GroupeSanguin.O_POSITIF));
        compatibilityMap.put(GroupeSanguin.A_NEGATIF, Arrays.asList(GroupeSanguin.O_NEGATIF, GroupeSanguin.A_NEGATIF));
        compatibilityMap.put(GroupeSanguin.A_POSITIF, Arrays.asList(GroupeSanguin.O_NEGATIF, GroupeSanguin.O_POSITIF, GroupeSanguin.A_NEGATIF, GroupeSanguin.A_POSITIF));
        compatibilityMap.put(GroupeSanguin.B_NEGATIF, Arrays.asList(GroupeSanguin.O_NEGATIF, GroupeSanguin.B_NEGATIF));
        compatibilityMap.put(GroupeSanguin.B_POSITIF, Arrays.asList(GroupeSanguin.O_NEGATIF, GroupeSanguin.O_POSITIF, GroupeSanguin.B_NEGATIF, GroupeSanguin.B_POSITIF));
        compatibilityMap.put(GroupeSanguin.AB_NEGATIF, Arrays.asList(GroupeSanguin.O_NEGATIF, GroupeSanguin.A_NEGATIF, GroupeSanguin.B_NEGATIF, GroupeSanguin.AB_NEGATIF));
        compatibilityMap.put(GroupeSanguin.AB_POSITIF, Arrays.asList(GroupeSanguin.O_NEGATIF, GroupeSanguin.O_POSITIF, GroupeSanguin.A_NEGATIF, GroupeSanguin.A_POSITIF, GroupeSanguin.B_NEGATIF, GroupeSanguin.B_POSITIF, GroupeSanguin.AB_NEGATIF, GroupeSanguin.AB_POSITIF));
    }

    public AssociationDonService()
    {
        this.associationDonDAO = new AssociationDonDAO();
    }

    public void ajouterAssocDonService(Date dateAssociation, boolean donEffecture, Date dateDonEffecture, Donor donor, Receveur receveur)
    {
        AssociationDon associationDon = new AssociationDon();

        associationDon.setDateAssociation(dateAssociation);
        associationDon.setDonEffecture(donEffecture);
        associationDon.setDateDonEffecture(dateDonEffecture);
        associationDon.setDonor(donor);
        associationDon.setReceveur(receveur);

        associationDonDAO.ajouterAssocDon(associationDon);
        System.out.println("Donneur ajouté avec succès !");
    }



    public List<Receveur> getSansReceveurs()
    {
        return associationDonDAO.getSansReceveurs();
    }
    public List<Donor> getDonneursSansReceveurs()
    {
        return  associationDonDAO.getDonnersSansReceveurs();
    }

   public List<Receveur> getSansReceveursParGroupe (GroupeSanguin groupe)
   {
       if (groupe != null)
       return associationDonDAO.getSansReceveursParGroupe(groupe);

       return associationDonDAO.getSansReceveurs();
   }
    public List<Donor> getDonneursSansReceveursParGroupe(GroupeSanguin groupe)
    {

        if (groupe != null)
        {
            return associationDonDAO.getDonneursSansReceveursParGroupe(groupe);
        }

        return associationDonDAO.getDonnersSansReceveurs();

    }


    public  boolean isCompatible(GroupeSanguin  receiver , GroupeSanguin donor )
    {
        List<GroupeSanguin> compatibleDonors = compatibilityMap.get(receiver);

        return compatibleDonors != null && compatibleDonors.contains(donor);


    }


    public  void modifierAssocDonIdRecveur(long id ,long recveur_id)
    {
        associationDonDAO.modifierAssocDonIdRecveur(id,recveur_id);
    }




}
