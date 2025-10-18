package com.example.bloodbank.controller;

import com.example.bloodbank.entity.enums.GroupeSanguin;
import com.example.bloodbank.entity.enums.Sexe;
import com.example.bloodbank.entity.enums.StatutDonneur;
import com.example.bloodbank.service.DonneurService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Period;
import java.time.ZoneId;
import java.util.Date;

public class DonneurController extends HttpServlet {

    private DonneurService donneurService;

    @Override
    public void init() {
        try {
            donneurService = new DonneurService();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Erreur lors de l'initialisation de DonneurService", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/donneur/ajouterDonneur.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 🔹 Récupération des paramètres
            String cin = request.getParameter("cin");
            String nom = request.getParameter("nom");
            String prenom = request.getParameter("prenom");
            String telephone = request.getParameter("telephone");
            String dateNaissanceStr = request.getParameter("dateNaissance");
            String dateDernierDonStr = request.getParameter("dateDernierDon");
            String sexeStr = request.getParameter("sexe");
            String groupeSanguinStr = request.getParameter("groupeSanguin");
            String poidsStr = request.getParameter("poids");
            String contreIndicattionsStr = request.getParameter("contreindicattions");

            if (cin == null || cin.trim().isEmpty()) {
                afficherErreur(request, response, "Le champ CIN est obligatoire !");
                return;
            }
            if (nom == null || nom.trim().isEmpty()) {
                afficherErreur(request, response, "Le champ Nom est obligatoire !");
                return;
            }
            if (prenom == null || prenom.trim().isEmpty()) {
                afficherErreur(request, response, "Le champ Prénom est obligatoire !");
                return;
            }
            if (poidsStr == null || poidsStr.trim().isEmpty()) {
                afficherErreur(request, response, "Le poids est obligatoire !");
                return;
            }

            double poids = Double.parseDouble(poidsStr);
            if (poids < 50) {
                afficherErreur(request, response, "Le poids doit être supérieur à 50 kg !");
                return;
            }

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");


            Date dateNaissance = (dateNaissanceStr != null && !dateNaissanceStr.isEmpty())
                    ? sdf.parse(dateNaissanceStr)
                    : null;

            if (dateNaissance != null) {
                LocalDate naissanceLocal = dateNaissance.toInstant()
                        .atZone(ZoneId.systemDefault())
                        .toLocalDate();
                int age = Period.between(naissanceLocal, LocalDate.now()).getYears();
                if (age < 18 || age > 65) {
                    afficherErreur(request, response, "L'âge doit être compris entre 18 et 65 ans !");
                    return;
                }
            }


            Date dateDernierDon = (dateDernierDonStr != null && !dateDernierDonStr.isEmpty())
                    ? sdf.parse(dateDernierDonStr)
                    : null;




            Sexe sexe = (sexeStr != null && !sexeStr.isEmpty()) ? Sexe.valueOf(sexeStr) : null;
            GroupeSanguin groupeSanguin = (groupeSanguinStr != null && !groupeSanguinStr.isEmpty())
                    ? GroupeSanguin.valueOf(groupeSanguinStr)
                    : null;
            boolean contreindicattions = "true".equalsIgnoreCase(contreIndicattionsStr)
                    || "on".equalsIgnoreCase(contreIndicattionsStr);

            StatutDonneur statut = StatutDonneur.NON_ELIGIBLE;

            donneurService.creerDonneur(cin, nom, prenom, dateNaissance, telephone, sexe,
                    groupeSanguin, poids, contreindicattions, dateDernierDon, statut);

            request.setAttribute("message", "Donneur ajouté avec succès !");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/donneur/ajouterDonneur.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            afficherErreur(request, response, "Erreur : " + e.getMessage());
        }
    }

    private void afficherErreur(HttpServletRequest request, HttpServletResponse response, String message)
            throws ServletException, IOException {
        request.setAttribute("error", message);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/donneur/ajouterDonneur.jsp");
        dispatcher.forward(request, response);
    }
}
