package com.example.bloodbank.entity;

import com.example.bloodbank.entity.enums.GroupeSanguin;
import com.example.bloodbank.entity.enums.Sexe;
import com.example.bloodbank.entity.enums.StatutDonneur;
import com.example.bloodbank.entity.enums.UrgenceReceveur;
import jakarta.persistence.*;

import java.util.Date;
@Entity
@Table(name = "Receveur")
public class Receveur extends Utilisateur
{
    @Enumerated(EnumType.STRING)
    private UrgenceReceveur ungence;
    private int nombrePochesRequises;
    private int nombrePochesRecues;

    @Enumerated(EnumType.STRING)
    private StatutDonneur statut;

    public Receveur()
    {
        super();
    }

    public Receveur(long id, String cin, String nom , String prenom , Date dateNaissance, String telephone, Sexe sexe, GroupeSanguin groupeSanguin,UrgenceReceveur ungence,int nombrePochesRequises,int nombrePochesRecues,StatutDonneur statut)
    {
        super( id, cin, nom , prenom , dateNaissance, telephone, sexe,  groupeSanguin);
        this.ungence = ungence;
        this.nombrePochesRequises = nombrePochesRequises;
        this.nombrePochesRecues = nombrePochesRecues;
        this.statut = statut;
    }

    public  UrgenceReceveur getUrgence()
    {
        return ungence;
    }
    public int getNombrePochesRequises()
    {
        return nombrePochesRequises;
    }
    public int getNombrePochesRecues()
    {
        return nombrePochesRecues;
    }

    public void setUngence(UrgenceReceveur  ungence)
    {
        this.ungence = ungence;
    }

    public void setNombrePochesRequises(int nombrePochesRequises)
    {
        this.nombrePochesRequises = nombrePochesRequises;
    }

    public void  setNombrePochesRecues(int nombrePochesRecues)
    {
        this.nombrePochesRecues = nombrePochesRecues;
    }
}
