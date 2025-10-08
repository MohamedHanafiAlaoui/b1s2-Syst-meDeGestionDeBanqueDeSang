package com.example.bloodbank.entity;

import com.example.bloodbank.entity.enums.GroupeSanguin;
import com.example.bloodbank.entity.enums.Sexe;
import com.example.bloodbank.entity.enums.StatutDonneur;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Table;

import java.util.Date;

@Entity
@Table(name = "donneur")
public class Donor extends  Utilisateur
{
    private Double poids;
    private boolean ContreIndicattions;
    private Date dateDernierDon;
    @Enumerated(EnumType.STRING)
    private StatutDonneur statut;

    public  Donor()
    {
        super();
    }

    public Donor(long id, String cin, String nom , String prenom , Date dateNaissance,
                 String telephone, Sexe sexe, GroupeSanguin groupeSanguin, double poids,
                 boolean ContreIndicattions, Date dateDernierDon, StatutDonneur statut )
    {
        super( id, cin, nom , prenom , dateNaissance, telephone, sexe,  groupeSanguin);
        this.poids = poids;
        this.ContreIndicattions = ContreIndicattions;
        this.dateDernierDon = dateDernierDon;
        this.statut = statut ;
    }

    public Double getPoids()
    {
        return poids;
    }

    public void setPoids(Double poids)
    {
        this.poids = poids;
    }

    public boolean isContreIndicattions()
    {
        return ContreIndicattions;
    }

    public void setContreIndicattions(boolean ContreIndicattions)
    {
        this.ContreIndicattions = ContreIndicattions;
    }

    public Date getDateDernierDon()
    {
        return dateDernierDon;
    }

    public void setDateDernierDon(Date dateDernierDon)
    {
        this.dateDernierDon = dateDernierDon;
    }

    public StatutDonneur getStatut()
    {
        return statut;
    }

    public void setstatut(StatutDonneur statut)
    {
        this.statut = statut;
    }

}
