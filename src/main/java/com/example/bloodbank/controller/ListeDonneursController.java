package com.example.bloodbank.controller;

import com.example.bloodbank.entity.Donor;
import com.example.bloodbank.entity.enums.GroupeSanguin;
import com.example.bloodbank.service.AssociationDonService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class ListeDonneursController extends HttpServlet {
    private final AssociationDonService associationDonService = new AssociationDonService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String groupe = request.getParameter("groupeSanguin");

        List<Donor> donneurs;
        if (groupe != null && !groupe.isEmpty()) {
            try {
                GroupeSanguin groupeEnum = GroupeSanguin.valueOf(groupe);
                donneurs = associationDonService.getDonneursSansReceveursParGroupe(groupeEnum);
            } catch (IllegalArgumentException e) {
                donneurs = associationDonService.getDonneursSansReceveurs();
            }
        } else
        {
                donneurs = associationDonService.getDonneursSansReceveurs();
        }

        request.setAttribute("donneurs", donneurs);
        request.setAttribute("filtreGroupe", groupe);
        request.getRequestDispatcher("/receveur/liste_donneurs.jsp").forward(request, response);
    }

}
