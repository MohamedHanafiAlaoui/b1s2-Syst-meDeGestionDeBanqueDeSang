package com.example.bloodbank.controller;

import com.example.bloodbank.entity.Receveur;
import com.example.bloodbank.entity.enums.*;
import com.example.bloodbank.service.ReceveurService;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.RequestDispatcher;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class ModifierReceveur extends HttpServlet {

    private ReceveurService receveurService;

    @Override
    public void init() throws ServletException {
        receveurService = new ReceveurService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Paramètre id manquant !");
            return;
        }

        Long id;
        try {
            id = Long.parseLong(idStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Paramètre id invalide !");
            return;
        }

        Receveur receveur = receveurService.getReceveurById(id);
        if (receveur == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Receveur introuvable !");
            return;
        }

        // Préparer les listes des enums pour les selects
        request.setAttribute("listeSexes", Sexe.values());
        request.setAttribute("listeGroupes", GroupeSanguin.values());
        request.setAttribute("StatutReceveurValues", StatutReceveur.values());
        request.setAttribute("UrgenceReceveurValues", UrgenceReceveur.values());

        // Préparer les valeurs actuelles sous forme de String pour les selects
        request.setAttribute("sexeStr", receveur.getSexe() != null ? receveur.getSexe().name() : "");
        request.setAttribute("groupeSanguinStr", receveur.getGroupeSanguin() != null ? receveur.getGroupeSanguin().name() : "");
        request.setAttribute("statutStr", receveur.getStatut() != null ? receveur.getStatut().name() : "");
        request.setAttribute("urgenceStr", receveur.getUrgence() != null ? receveur.getUrgence().name() : "");

        if (receveur.getDateNaissance() != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            request.setAttribute("dateNaissanceStr", sdf.format(receveur.getDateNaissance()));
        } else {
            request.setAttribute("dateNaissanceStr", "");
        }

        request.setAttribute("receveur", receveur);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/receveur/modifierReceveur.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Long id = Long.parseLong(request.getParameter("id"));
            Receveur receveur = receveurService.getReceveurById(id);

            if (receveur == null) {
                afficherErreur(request, response, "Receveur introuvable !");
                return;
            }

            String nom = request.getParameter("nom");
            String prenom = request.getParameter("prenom");
            String cin = request.getParameter("cin");
            String telephone = request.getParameter("telephone");
            String dateNaissanceStr = request.getParameter("dateNaissance");
            String sexeStr = request.getParameter("sexe");
            String groupeSanguinStr = request.getParameter("groupeSanguin");
            String statutStr = request.getParameter("statut");
            String urgenceStr = request.getParameter("urgence");
            String nbPochesReqStr = request.getParameter("nombrePochesRequises");
            String nbPochesRecuesStr = request.getParameter("nombrePochesRecues");

            if (nom == null || nom.trim().isEmpty() || prenom == null || prenom.trim().isEmpty() ||
                    cin == null || cin.trim().isEmpty() || telephone == null || telephone.trim().isEmpty()) {
                afficherErreur(request, response, "Tous les champs obligatoires doivent être remplis !");
                return;
            }

            receveur.setNom(nom);
            receveur.setPrenom(prenom);
            receveur.setCin(cin);
            receveur.setTelephone(telephone);

            // Date de naissance
            if (dateNaissanceStr != null && !dateNaissanceStr.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date dateNaissance = sdf.parse(dateNaissanceStr);
                receveur.setDateNaissance(dateNaissance);
            }

            // Enum conversions
            if (sexeStr != null && !sexeStr.isEmpty()) {
                receveur.setSexe(Sexe.valueOf(sexeStr));
            }
            if (groupeSanguinStr != null && !groupeSanguinStr.isEmpty()) {
                receveur.setGroupeSanguin(GroupeSanguin.valueOf(groupeSanguinStr));
            }
            if (statutStr != null && !statutStr.isEmpty()) {
                receveur.setStatut(StatutReceveur.valueOf(statutStr));
            }
            if (urgenceStr != null && !urgenceStr.isEmpty()) {
                receveur.setUngence(UrgenceReceveur.valueOf(urgenceStr));
            }

            // Nombres de poches
            if (nbPochesReqStr != null && !nbPochesReqStr.isEmpty()) {
                receveur.setNombrePochesRequises(Integer.parseInt(nbPochesReqStr));
            }
            if (nbPochesRecuesStr != null && !nbPochesRecuesStr.isEmpty()) {
                receveur.setNombrePochesRecues(Integer.parseInt(nbPochesRecuesStr));
            }

            // Modifier en base
            receveurService.modifierReceveur(receveur);

            request.getSession().setAttribute("message", "Receveur modifié avec succès !");
            response.sendRedirect(request.getContextPath() + "/receveur/modifierReceveur?id=" + receveur.getId());

        } catch (Exception e) {
            e.printStackTrace();
            afficherErreur(request, response, "Erreur lors de la modification : " + e.getMessage());
        }
    }

    private void afficherErreur(HttpServletRequest request, HttpServletResponse response, String message)
            throws ServletException, IOException {
        request.setAttribute("erreur", message);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/receveur/modifierReceveur.jsp");
        dispatcher.forward(request, response);
    }
}
