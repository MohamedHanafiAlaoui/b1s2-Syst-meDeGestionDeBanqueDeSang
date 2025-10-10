package com.example.bloodbank.entity;

import java.util.Date;

import com.example.bloodbank.entity.enums.GroupeSanguin;
import com.example.bloodbank.entity.enums.Sexe;
import jakarta.persistence.*;
@MappedSuperclass
public  class Utilisateur {
    @Column(nullable = false ,unique = true,length = 20)
    private  String cin;
    @Column(nullable = false ,length = 100)
    private  String nom;
    @Column(nullable = false ,length = 100)
    private  String prenom;
    @Temporal(TemporalType.DATE)
    private Date datenaissance;
    @Column(nullable = false ,length = 20)
    private  String telephone;
    @Enumerated(EnumType.STRING)
    private  Sexe sexe;
    @Enumerated(EnumType.STRING)
    private GroupeSanguin groupesanguin;



    public  Utilisateur() {}


    public Utilisateur(String cin, String nom , String prenom , Date  datenaissance, String telephone,Sexe sexe,GroupeSanguin groupesanguin)
    {


        this.cin = cin;
        this.nom = nom;
        this.prenom = prenom;
        this.datenaissance = datenaissance;
        this.telephone = telephone;
        this.sexe = sexe;
        this.groupesanguin = groupesanguin;

    }


    public String getCin() {
        return cin;
    }

    public void setCin(String cin) {
        this.cin = cin;
    }
    public String getNom() {
        return nom;
    }
    public void setNom(String nom) {
        this.nom = nom;
    }
    public String getPrenom() {
        return prenom;
    }
    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }
    public Date getDateNaissance() {
        return datenaissance;
    }
    public void setDateNaissance(Date dateNaissance) {
        this.datenaissance = dateNaissance;
    }
    public String getTelephone() {
        return telephone;
    }
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }
    public Sexe getSexe() {
        return sexe;
    }

    public void setSexe(Sexe sexe) {
        this.sexe = sexe;
    }
    public GroupeSanguin getGroupeSanguin() {
        return groupesanguin;
    }
    public void setGroupeSanguin(GroupeSanguin groupeSanguin) {
        this.groupesanguin = groupeSanguin;
    }




}
