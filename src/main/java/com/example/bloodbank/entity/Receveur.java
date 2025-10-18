package com.example.bloodbank.entity;

import com.example.bloodbank.entity.enums.*;
import jakarta.persistence.*;

import java.util.Date;
@Entity
@Table(name = "Receveur")
public class Receveur extends Utilisateur
{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private  Long id;
    @Enumerated(EnumType.STRING)
    private UrgenceReceveur urgence;

    @Enumerated(EnumType.STRING)
    private StatutReceveur statut;
    private int nombrepochesrequises;
    private int nombrePochesRecues;


    public Receveur()
    {
        super();
    }

    public Receveur(String cin, String nom , String prenom , Date datenaissance, String telephone, Sexe sexe, GroupeSanguin groupesanguin, UrgenceReceveur urgence, int nombrepochesrequises, int nombrePochesRecues, StatutReceveur  statut)
    {
        super(  cin, nom , prenom , datenaissance, telephone, sexe,  groupesanguin);
        this.urgence = urgence;
        this.nombrepochesrequises = nombrepochesrequises;
        this.nombrePochesRecues = nombrePochesRecues;
        this.statut = statut;
    }
    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }


    public  UrgenceReceveur getUrgence()
    {
        return urgence;
    }
    public int getNombrePochesRequises()
    {
        return nombrepochesrequises;
    }
    public int getNombrePochesRecues()
    {
        return nombrePochesRecues;
    }

    public void setUngence(UrgenceReceveur  ungence)
    {
        this.urgence = ungence;
    }

    public void setNombrePochesRequises(int nombrePochesRequises)
    {
        this.nombrepochesrequises = nombrePochesRequises;
    }

    public void  setNombrePochesRecues(int nombrePochesRecues)
    {
        this.nombrePochesRecues = nombrePochesRecues;
    }

    public StatutReceveur getStatut()
        {
        return statut;
        }
        public void setStatut(StatutReceveur  statut)
            {
            this.statut = statut;
            }
}
