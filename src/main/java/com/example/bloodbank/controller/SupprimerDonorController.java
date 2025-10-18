package com.example.bloodbank.controller;

import com.example.bloodbank.service.DonneurService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class SupprimerDonorController extends HttpServlet {
    private DonneurService  donneurService;

    @Override
    public void init() throws ServletException {
         donneurService = new DonneurService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        String  message ="";
        try {
            long userId = Long.parseLong(request.getParameter("userId"));

            donneurService.supprimerDonor(userId);
            message = "Donneur supprimé avec succès !";

        }catch (Exception e)
        {
            message = "Format d'ID invalide.";

            e.printStackTrace();

        }

        request.getSession().setAttribute("assocMessage", message);

        response.sendRedirect(request.getContextPath() + "/receveur/liste_donneurs");


    }
}
