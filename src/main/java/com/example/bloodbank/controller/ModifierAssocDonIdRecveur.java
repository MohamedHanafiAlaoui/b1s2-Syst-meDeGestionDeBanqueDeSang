package com.example.bloodbank.controller;

import com.example.bloodbank.dao.AssociationDonDAO;
import com.example.bloodbank.dao.DonorDAO;
import com.example.bloodbank.dao.ReceveurDAO;
import com.example.bloodbank.entity.AssociationDon;
import com.example.bloodbank.entity.Donor;
import com.example.bloodbank.entity.Receveur;
import com.example.bloodbank.service.AssociationDonService;

import com.example.bloodbank.entity.AssociationDon;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class ModifierAssocDonIdRecveur extends HttpServlet {

    private AssociationDonService associationDonService;

    @Override
    public  void  init() throws ServletException
    {
        associationDonService=new AssociationDonService();
    }

    @Override
    protected void  doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        String message ="";
        try {
            long id =Long.parseLong(request.getParameter("id"));
            long id_assoc =Long.parseLong(request.getParameter("id_assoc"));



            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("userId") == null) {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }

            long userId = ((Number) session.getAttribute("userId")).longValue();

            Receveur receveur = new ReceveurDAO().getReceveurId(userId);
            Donor donor = new DonorDAO().getDonorByid(id);
            AssociationDon association = new AssociationDonDAO().getAssociationDon(id_assoc);
            if(!associationDonService.isCompatible(receveur.getGroupeSanguin(),donor.getGroupeSanguin()))
            {
                message = "Le donor n'est pas compatible avec le receveur";
                return;
            }else
            {
                associationDonService.modifierAssocDonIdRecveur(id_assoc ,userId);
                message = "Association mise à jour avec succès";

            }


            request.getSession().setAttribute("assocMessage", message);

            response.sendRedirect(request.getContextPath() + "/receveur/liste_donneurs");



        }catch (Exception e){

            e.printStackTrace();

        }




    }


}
