//package testuniter;
//
//
//import com.example.bloodbank.dao.DonorDAO;
//import com.example.bloodbank.entity.Donor;
//import com.example.bloodbank.entity.enums.GroupeSanguin;
//import com.example.bloodbank.entity.enums.Sexe;
//import com.example.bloodbank.entity.enums.StatutDonneur;
//import jakarta.persistence.EntityManagerFactory;
//import org.junit.jupiter.api.BeforeAll;
//import org.junit.jupiter.api.*;
//import static org.junit.jupiter.api.Assertions.assertNotNull;
//import static org.junit.jupiter.api.Assertions.assertEquals;
//
//
//public class DonorTest {
//    private static DonorDAO donorDAO;
//    private static EntityManagerFactory emf;
//
//    @BeforeAll
//     static void init()
//    {
//        donorDAO = new DonorDAO();
//    }
//    @Test
//    public void createDonor()
//    {
//        Donor donor = new Donor();
//        donor.setNom("Mohamed");
//        donor.setPrenom("Yatim");
//        donor.setCin("vc123456");
//        donor.setSexe(Sexe.MASCULIN);
//        donor.setGroupeSanguin(GroupeSanguin.O_POSITIF);
//        donor.setstatut(StatutDonneur.DISPONIBLE);
//        donor.setTelephone("0612345678");
//
//        donorDAO.ajouterDonor(donor);
//
//        Donor found = donorDAO.getDonorByid(donor.getId());
//        assertNotNull(found, "Donor should be persisted and found in DB");
//        assertEquals("Mohamed", found.getNom());
//        assertEquals("Yatim", found.getPrenom());
//
//        System.out.println(" Donor created successfully: " + found.getNom() + " " + found.getPrenom());
//
//    }
//
//}
