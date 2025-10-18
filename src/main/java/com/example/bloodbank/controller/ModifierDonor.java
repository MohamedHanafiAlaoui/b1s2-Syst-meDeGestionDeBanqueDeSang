package com.example.bloodbank.controller;

import com.example.bloodbank.entity.Donor;
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
import java.util.Arrays;
import java.util.Date;

public class ModifierDonor extends HttpServlet {

    private DonneurService donneurService;

    @Override
    public void init() throws ServletException {
        donneurService = new DonneurService();
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        Long id;

        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Paramètre id manquant ! " );
            return;
        }

        try {
            id = Long.parseLong(idStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Paramètre id invalide !");
            return;
        }

        Donor donor = donneurService.getDonorByids(id);
        if (donor == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Donneur introuvable !" );
            return;
        }




        request.setAttribute("donneur", donor);
        request.setAttribute("listeGroupes", Arrays.asList(GroupeSanguin.values()));
        request.setAttribute("listeSexes", Arrays.asList(Sexe.values()));

        request.setAttribute("groupeSanguinStr", donor.getGroupeSanguin() != null ? donor.getGroupeSanguin().name() : "");
        request.setAttribute("sexeStr", donor.getSexe() != null ? donor.getSexe().name() : "");

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        request.setAttribute("dateNaissanceStr", donor.getDateNaissance() != null ? sdf.format(donor.getDateNaissance()) : "");
        request.setAttribute("dateDernierDonStr", donor.getDateDernierDon() != null ? sdf.format(donor.getDateDernierDon()) : "");

        request.getRequestDispatcher("/donneur/modifierDono.jsp").forward(request, response);



    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Long id = Long.parseLong(request.getParameter("id"));
            Donor donor = donneurService.getDonorByids(id);

            if (donor == null) {
                afficherErreur(request, response, "Donneur introuvable !");
                return;
            }

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

            donor.setCin(cin);
            donor.setNom(nom);
            donor.setPrenom(prenom);
            donor.setTelephone(telephone);
            donor.setSexe(sexe);
            donor.setPoids(poids);
            donor.setContreIndicattions(contreindicattions);
            donor.setGroupeSanguin(groupeSanguin);
            donor.setDateDernierDon(dateDernierDon);
            donor.setDateNaissance(dateNaissance);

            donor.setstatut(StatutDonneur.DISPONIBLE);

            donneurService.modifierDonor(donor);

            request.getSession().setAttribute("message", "Donneur modifié avec succès !");
            response.sendRedirect(request.getContextPath() + "/donneur/modifierDono?id=" + donor.getId());

        } catch (Exception e) {
            e.printStackTrace();
            afficherErreur(request, response, "Erreur lors de la modification : " + e.getMessage());
        }
    }

    private void afficherErreur(HttpServletRequest request, HttpServletResponse response, String message)
            throws ServletException, IOException {
        request.setAttribute("erreur", message);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/donneur/modifierDono.jsp");
        dispatcher.forward(request, response);
    }
}
