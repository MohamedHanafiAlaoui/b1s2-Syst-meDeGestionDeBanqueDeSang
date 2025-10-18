package com.example.bloodbank.controller;

import com.example.bloodbank.service.DonneurService;
import com.example.bloodbank.service.ReceveurService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class SupprimerReceveurController extends HttpServlet {


    private ReceveurService receveurService;

    @Override
    public void init() throws ServletException {
        receveurService = new ReceveurService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        String  message ="";
        try {
            long userId = Long.parseLong(request.getParameter("userId"));

            receveurService.supprimerReceveur(userId);
            message = "Receveur supprimé avec succès !";

        }catch (Exception e)
        {
            message = "Format d'ID invalide.";

            e.printStackTrace();

        }

        request.getSession().setAttribute("assocMessage", message);

        response.sendRedirect(request.getContextPath() + "/donneur/liste_receveurs");


    }
}

