package com.example.bloodbank.controller;

import com.example.bloodbank.service.ReceveurService;

import javax.servlet.http.HttpServlet;

public class SupprimerReceveur  extends HttpServlet {


    private ReceveurService receveurService;

    @Override
    public  void  init() throws
    {
        receveurService = new ReceveurService();
    }
}
