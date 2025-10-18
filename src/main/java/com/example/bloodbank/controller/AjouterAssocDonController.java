package com.example.bloodbank.controller;

import com.example.bloodbank.dao.DonorDAO;
import com.example.bloodbank.entity.Donor;
import com.example.bloodbank.entity.Receveur;
import com.example.bloodbank.entity.enums.StatutDonneur;
import com.example.bloodbank.service.AssociationDonService;
import com.example.bloodbank.service.DonneurService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.rowset.serial.SerialException;
import java.io.IOException;
import java.util.Date;

public class AjouterAssocDonController  extends HttpServlet {
    private AssociationDonService associationDonService;

    @Override
    public void init() throws ServletException {
        associationDonService = new AssociationDonService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        String message ="";
        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("userId") == null) {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }

            long userId = ((Number) session.getAttribute("userId")).longValue();



            Donor donor = new DonorDAO().getDonorByid(userId);

        if(donor.getStatut() != StatutDonneur.DISPONIBLE)
            {
                message = "Le donneur n'est pas disponible pour un don.";

            }else if(donor.isContreIndicattions())
            {
                message = "Le donneur présente des contre-indications;";

            }else
            {
                DonneurService donneurService = new DonneurService();
                donneurService.modifierDonorstatut(donor.getId(), StatutDonneur.NON_ELIGIBLE);
                associationDonService.ajouterAssocDonService(null, false, new Date(), donor, null);
                message = "Ajout réussi !";
            }

        } catch (Exception e) {
            e.printStackTrace();
            message = "Erreur lors de l'ajout : " ;
        }

        request.getSession().setAttribute("assocMessage", message);

        response.sendRedirect(request.getContextPath() + "/donneur/liste_receveurs");
    }


}
