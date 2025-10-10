package com.example.bloodbank.entity;

import com.example.bloodbank.entity.enums.GroupeSanguin;
import com.example.bloodbank.entity.enums.Sexe;
import com.example.bloodbank.entity.enums.StatutDonneur;
import jakarta.persistence.*;

import java.util.Date;

@Entity
@Table(name = "donneur")
public class Donor extends  Utilisateur
{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private  Long id;
    private Double poids;
    private boolean contreindicattions;
    @Temporal(TemporalType.DATE)
    private Date datedernierdon;
    @Enumerated(EnumType.STRING)
    private StatutDonneur statut;

    public  Donor()
    {
        super();
    }

    public Donor( String cin, String nom , String prenom , Date dateNaissance,
                 String telephone, Sexe sexe, GroupeSanguin groupesanguin, double poids,
                 boolean contreindicattions, Date datedernierdon, StatutDonneur statut )
    {
        super(  cin, nom , prenom , dateNaissance, telephone, sexe,  groupesanguin);

        this.poids = poids;
        this.contreindicattions = contreindicattions;
        this.datedernierdon = datedernierdon;
        this.statut = statut ;
    }

    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
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
        return contreindicattions;
    }

    public void setContreIndicattions(boolean contreindicattions)
    {
        this.contreindicattions = contreindicattions;
    }

    public Date getDateDernierDon()
    {
        return datedernierdon;
    }

    public void setDateDernierDon(Date dateDernierDon)
    {
        this.datedernierdon = dateDernierDon;
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
