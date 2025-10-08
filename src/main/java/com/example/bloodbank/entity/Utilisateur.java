package com.example.bloodbank.entity;

import java.util.Date;

import com.example.bloodbank.entity.enums.GroupeSanguin;
import com.example.bloodbank.entity.enums.Sexe;
import com.example.bloodbank.entity.enums.StatutDonneur;

public abstract class Utilisateur {
    private  Long id;
    private  String cin;
    private  String nom;
    private  String prenom;
    private Date dateNaissance;
    private  String telephone;
    private  Sexe sexe;
    private GroupeSanguin groupeSanguin;
    private StatutDonneur statut;

}
