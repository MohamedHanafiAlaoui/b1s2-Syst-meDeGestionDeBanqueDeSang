package com.example.bloodbank.service;

import com.example.bloodbank.dao.ReceveurDAO;
import com.example.bloodbank.entity.Receveur;
import com.example.bloodbank.entity.enums.*;

import java.util.Date;
import java.util.List;

public class ReceveurService {

    private final ReceveurDAO receveurDAO;

    public ReceveurService() {
        this.receveurDAO = new ReceveurDAO();
    }

    public Receveur getReceveurByCin(String cin) {
        return receveurDAO.getReceveurByCin(cin);
    }


    public void creerReceveur(String cin, String nom, String prenom, Date dateNaissance,
                              String telephone, Sexe sexe, GroupeSanguin groupeSanguin,
                              UrgenceReceveur urgence, int nombrePochesRequises,
                              int nombrePochesRecues, StatutReceveur statut) {

        if (cin == null || cin.trim().isEmpty()) throw new IllegalArgumentException("Le CIN est obligatoire !");
        if (!cin.matches("[A-Z]{2}\\d{6}")) throw new IllegalArgumentException("Le CIN doit être au format AA123456 !");
        if (nom == null || nom.trim().isEmpty() || !nom.matches("[A-Za-zÀ-ÿ\\-\\s]+")) throw new IllegalArgumentException("Nom invalide !");
        if (prenom == null || prenom.trim().isEmpty() || !prenom.matches("[A-Za-zÀ-ÿ\\-\\s]+")) throw new IllegalArgumentException("Prénom invalide !");
        if (dateNaissance == null || dateNaissance.after(new Date())) throw new IllegalArgumentException("Date de naissance invalide !");
        if (telephone == null || !telephone.matches("\\d{10}")) throw new IllegalArgumentException("Téléphone invalide !");
        if (sexe == null) throw new IllegalArgumentException("Le sexe est obligatoire !");
        if (groupeSanguin == null) throw new IllegalArgumentException("Le groupe sanguin est obligatoire !");
        if (urgence == null) throw new IllegalArgumentException("Le niveau d'urgence est obligatoire !");
        if (nombrePochesRequises <= 0) throw new IllegalArgumentException("Le nombre de poches requises doit être supérieur à 0 !");
        if (nombrePochesRecues < 0) throw new IllegalArgumentException("Le nombre de poches reçues ne peut pas être négatif !");

        if (statut == null) {
            statut = StatutReceveur.EN_ATTENTE;
        }

        Receveur receveur = new Receveur(
                cin, nom, prenom, dateNaissance,
                telephone, sexe, groupeSanguin,
                urgence, nombrePochesRequises, nombrePochesRecues,
                statut
        );

        receveurDAO.ajouterReceveur(receveur);
        System.out.println(" Receveur ajouté avec succès !");
    }

    public Receveur getReceveurById(long id) {
        return receveurDAO.getReceveurId(id);
    }

    public List<Receveur> getAllReceveurs() {
        return receveurDAO.getAllReceveur();
    }

    public void modifierReceveur(Receveur receveur) {

        receveurDAO.modifierReceveur(receveur);
    }

    public void supprimerReceveur(long id) {
        receveurDAO.supprimerReceveur(id);
    }


}
