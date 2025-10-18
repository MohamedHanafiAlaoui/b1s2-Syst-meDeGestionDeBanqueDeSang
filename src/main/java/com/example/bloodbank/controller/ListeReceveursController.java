package com.example.bloodbank.controller;

import com.example.bloodbank.entity.Receveur;
import com.example.bloodbank.entity.enums.GroupeSanguin;
import com.example.bloodbank.service.AssociationDonService;
import com.example.bloodbank.service.DonneurService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class ListeReceveursController extends HttpServlet {
    private final AssociationDonService associationDonService = new AssociationDonService();


    @Override
    protected  void doGet(HttpServletRequest request , HttpServletResponse response)
        throws ServletException, IOException
    {
        String groupe = request.getParameter("groupe");

        List<Receveur> receveurs;
        if (groupe != null && !groupe.isEmpty())
        {
            try {
                GroupeSanguin groupeSanguin = GroupeSanguin.valueOf(groupe);
                receveurs = associationDonService.getSansReceveursParGroupe(groupeSanguin);

            }catch (IllegalArgumentException e)
            {
                receveurs = associationDonService.getSansReceveurs();
            }
        }
        else
        {
            receveurs = associationDonService.getSansReceveurs();
        }


        request.setAttribute("receveurs", receveurs);
        request.setAttribute("filterGroupe", groupe);
        request.getRequestDispatcher("/donneur/liste_receveurs.jsp").forward(request, response);

    }




}
