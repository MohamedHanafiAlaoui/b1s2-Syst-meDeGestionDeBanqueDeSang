package com.example.bloodbank.controller;

import com.example.bloodbank.entity.Donor;
import com.example.bloodbank.entity.Receveur;
import com.example.bloodbank.service.DonneurService;
import com.example.bloodbank.service.ReceveurService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class LoginController extends HttpServlet {

    private DonneurService donneurService;
    private ReceveurService receveurService;

    @Override
    public void init() {
        donneurService = new DonneurService();
        receveurService = new ReceveurService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cin = request.getParameter("cin");
        String userType = request.getParameter("usertype");
        if (cin == null || cin.trim().isEmpty() || userType == null || userType.trim().isEmpty()) {
            request.setAttribute("error", "CIN et type d'utilisateur obligatoires !");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession();

        try {
            if ("donneur".equalsIgnoreCase(userType)) {
                Donor donor = donneurService.getDonorByCin(cin);
                if (donor != null) {
                    session.setAttribute("userId", donor.getId());
                    session.setAttribute("usertype", "donneur");
                    response.sendRedirect(request.getContextPath());
                    return;
                }
            } else if ("receveur".equalsIgnoreCase(userType)) {
                Receveur receveur = receveurService.getReceveurByCin(cin);
                if (receveur != null) {
                    session.setAttribute("userId", receveur.getId());
                    session.setAttribute("usertype", "receveur");
                    response.sendRedirect(request.getContextPath() );
                    return;
                }
            }

            request.setAttribute("error", "CIN introuvable !");
            request.getRequestDispatcher("/login.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur serveur : " + e.getMessage());
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
