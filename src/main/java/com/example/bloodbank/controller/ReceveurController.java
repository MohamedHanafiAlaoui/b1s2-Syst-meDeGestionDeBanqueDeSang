package com.example.bloodbank.controller;

import com.example.bloodbank.entity.enums.*;
import com.example.bloodbank.service.ReceveurService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class ReceveurController extends HttpServlet {

    private ReceveurService receveurService;

    @Override
    public void init() {
        try {
            receveurService = new ReceveurService();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Erreur lors de l'initialisation de ReceveurService", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Afficher le formulaire
        RequestDispatcher dispatcher = request.getRequestDispatcher("/receveur/ajouterReceveur.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String cin = request.getParameter("cin");
            String nom = request.getParameter("nom");
            String prenom = request.getParameter("prenom");
            String telephone = request.getParameter("telephone");
            String dateNaissanceStr = request.getParameter("dateNaissance");
            String sexeStr = request.getParameter("sexe");
            String groupeSanguinStr = request.getParameter("groupeSanguin");
            String urgenceStr = request.getParameter("urgence");
            String nombrePochesRequisesStr = request.getParameter("nombrePochesRequises");
            String nombrePochesRecuesStr = request.getParameter("nombrePochesRecues");
            String statutStr = request.getParameter("statut");

            // 🔹 Validation simple
            if (cin == null || cin.trim().isEmpty()) {
                afficherErreur(request, response, "Le CIN est obligatoire !");
                return;
            }
            if (nom == null || nom.trim().isEmpty()) {
                afficherErreur(request, response, "Le Nom est obligatoire !");
                return;
            }
            if (prenom == null || prenom.trim().isEmpty()) {
                afficherErreur(request, response, "Le Prénom est obligatoire !");
                return;
            }

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date dateNaissance = (dateNaissanceStr != null && !dateNaissanceStr.isEmpty())
                    ? sdf.parse(dateNaissanceStr)
                    : null;

            Sexe sexe = (sexeStr != null && !sexeStr.isEmpty()) ? Sexe.valueOf(sexeStr.toUpperCase()) : null;
            GroupeSanguin groupeSanguin = (groupeSanguinStr != null && !groupeSanguinStr.isEmpty())
                    ? GroupeSanguin.valueOf(groupeSanguinStr.toUpperCase())
                    : null;
            UrgenceReceveur urgence = (urgenceStr != null && !urgenceStr.isEmpty())
                    ? UrgenceReceveur.valueOf(urgenceStr.toUpperCase())
                    : UrgenceReceveur.NORMAL;

            int nombrePochesRequises = (nombrePochesRequisesStr != null && !nombrePochesRequisesStr.isEmpty())
                    ? Integer.parseInt(nombrePochesRequisesStr)
                    : 1;

            int nombrePochesRecues = (nombrePochesRecuesStr != null && !nombrePochesRecuesStr.isEmpty())
                    ? Integer.parseInt(nombrePochesRecuesStr)
                    : 0;

            StatutReceveur statut = (statutStr != null && !statutStr.isEmpty())
                    ? StatutReceveur.valueOf(statutStr.toUpperCase())
                    : StatutReceveur.EN_ATTENTE;

            // 🔹 Création du receveur
            receveurService.creerReceveur(cin, nom, prenom, dateNaissance,
                    telephone, sexe, groupeSanguin, urgence,
                    nombrePochesRequises, nombrePochesRecues, statut);

            request.setAttribute("message", "Receveur ajouté avec succès !");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/receveur/ajouterReceveur.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            afficherErreur(request, response, "Erreur : " + e.getMessage());
        }
    }

    private void afficherErreur(HttpServletRequest request, HttpServletResponse response, String message)
            throws ServletException, IOException {
        request.setAttribute("error", message);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/receveur/ajouterReceveur.jsp");
        dispatcher.forward(request, response);
    }
}
