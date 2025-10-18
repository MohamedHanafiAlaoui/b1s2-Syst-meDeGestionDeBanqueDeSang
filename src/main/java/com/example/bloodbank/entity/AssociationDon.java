package com.example.bloodbank.entity;

import com.example.bloodbank.entity.enums.GroupeSanguin;
import jakarta.persistence.*;

import java.util.Date;

@Entity
@Table(name = "AssociationDon")
public class AssociationDon {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;


    @Temporal(TemporalType.DATE)
    private Date dateAssociation;

    @Column(name = "donEffecture")
    private boolean donEffecture;

    @Temporal(TemporalType.DATE)
    private Date dateDonEffecture;

    @ManyToOne
    @JoinColumn(name = "donneur_id", nullable = false)
    private Donor donor;

    @ManyToOne
    @JoinColumn(name = "receveur_id", nullable = true)
    private Receveur receveur;

    public  AssociationDon()
    {
    }

    public  AssociationDon(Date dateAssociation,boolean donEffecture, Date dateDonEffecture, Donor donor, Receveur receveur)
    {
        this.dateAssociation = dateAssociation;
        this.donor = donor;
        this.receveur = receveur;
        this.donEffecture = donEffecture;
        this.dateDonEffecture = dateDonEffecture;

    }



    public long getId() {
        return id;
    }
    public void setId(long id) {
        this.id = id;
    }
    public Date getDateAssociation() {
        return dateAssociation;
    }
    public void setDateAssociation(Date dateAssociation) {
        this.dateAssociation = dateAssociation;
    }
    public boolean isDonEffecture() {
        return donEffecture;
    }
    public void setDonEffecture(boolean donEffecture) {
        this.donEffecture = donEffecture;
    }
    public Date getDateDonEffecture() {
        return dateDonEffecture;
    }
    public void setDateDonEffecture(Date dateDonEffecture) {
        this.dateDonEffecture = dateDonEffecture;
    }
    public Donor getDonor() {
        return donor;
    }
    public void setDonor(Donor donor) {
        this.donor = donor;
    }
    public Receveur getReceveur() {
        return receveur;

    }
    public void setReceveur(Receveur receveur) {

        this.receveur = receveur;
    }


}
