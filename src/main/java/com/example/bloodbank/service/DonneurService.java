package com.example.bloodbank.service;

import com.example.bloodbank.dao.DonorDAO;
import com.example.bloodbank.entity.Donor;
import com.example.bloodbank.entity.enums.GroupeSanguin;
import com.example.bloodbank.entity.enums.Sexe;
import com.example.bloodbank.entity.enums.StatutDonneur;

import java.util.Date;
import java.time.LocalDate;
import java.time.ZoneId;

public class DonneurService  {

    private DonorDAO donorDAO;

    public DonneurService() {
        this.donorDAO = new DonorDAO();
    }

    public Donor getDonorByCin(String cin) {
        return donorDAO.getDonorByCin(cin);
    }

    public void creerDonneur(String cin, String nom, String prenom, Date dateNaissance,
                             String telephone, Sexe sexe, GroupeSanguin groupesanguin, double poids,
                             boolean contreindicattions, Date datedernierdon, StatutDonneur statut) {

        if (cin == null || cin.trim().isEmpty()) {
            throw new IllegalArgumentException("Le CIN est obligatoire !");
        }
        if (!cin.matches("[A-Z]{2}\\d{6}")) {
            throw new IllegalArgumentException("Le CIN doit être au format AA123456 !");
        }
        if (donorDAO.getDonorByCin(cin) != null) {
            throw new IllegalArgumentException("Un donneur avec ce CIN existe déjà !");
        }

        if (nom == null || nom.trim().isEmpty() || !nom.matches("[A-Za-zÀ-ÿ\\-\\s]+")) {
            throw new IllegalArgumentException("Nom invalide !");
        }
        if (prenom == null || prenom.trim().isEmpty() || !prenom.matches("[A-Za-zÀ-ÿ\\-\\s]+")) {
            throw new IllegalArgumentException("Prénom invalide !");
        }

        if (dateNaissance == null || dateNaissance.after(new Date())) {
            throw new IllegalArgumentException("Date de naissance invalide !");
        }

        if (telephone == null || !telephone.matches("\\d{10}")) {
            throw new IllegalArgumentException("Téléphone invalide !");
        }

        if (sexe == null) {
            throw new IllegalArgumentException("Le sexe est obligatoire !");
        }
        if (groupesanguin == null) {
            throw new IllegalArgumentException("Le groupe sanguin est obligatoire !");
        }

        if (poids <= 0) {
            throw new IllegalArgumentException("Le poids doit être supérieur à 0 !");
        }

        if (datedernierdon != null && datedernierdon.after(new Date())) {
            throw new IllegalArgumentException("Date du dernier don invalide !");
        }

        Donor donor = new Donor();
        donor.setCin(cin);
        donor.setNom(nom);
        donor.setPrenom(prenom);
        donor.setDateNaissance(dateNaissance);
        donor.setTelephone(telephone);
        donor.setSexe(sexe);
        donor.setGroupeSanguin(groupesanguin);
        donor.setPoids(poids);
        donor.setContreIndicattions(contreindicattions);
        donor.setDateDernierDon(datedernierdon);
        donor.setstatut(statut != null ? statut : StatutDonneur.NON_ELIGIBLE);

        donorDAO.ajouterDonor(donor);
        System.out.println("Donneur ajouté avec succès !");
    }

    private LocalDate convertToLocalDate(Date date) {
        return date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
    }

    private Date convertToDate(LocalDate localDate) {
        return Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
    }


    public void  modifierDonorstatut(long donorId ,StatutDonneur statut)
    {
        donorDAO.modifierDonorstatut(donorId, statut);

    }

    public void supprimerDonor(long donorId)
    {
        donorDAO.supprimerDonor(donorId);
    }


    public void  modifierDonor(Donor donor)
    {
        donorDAO.modifierDonor(donor);
    }


    public  Donor  getDonorByids(long id)
    {
        return donorDAO.getDonorByid(id);
    }


}
