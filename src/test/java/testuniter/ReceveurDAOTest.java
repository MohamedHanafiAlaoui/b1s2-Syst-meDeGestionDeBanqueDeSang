package testuniter;

import com.example.bloodbank.dao.ReceveurDAO;
import com.example.bloodbank.entity.Receveur;
import com.example.bloodbank.entity.enums.GroupeSanguin;
import com.example.bloodbank.entity.enums.Sexe;
import com.example.bloodbank.util.JPAUtil;
import jakarta.persistence.EntityManagerFactory;
import org.junit.jupiter.api.*;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class ReceveurDAOTest {

    private static ReceveurDAO receveurDAO;
    private static long cretedId;

    @BeforeAll
    static void init() {
        EntityManagerFactory emf = JPAUtil.getEntityManagerFactory(true);
        assertNotNull(emf, "EntityManagerFactory ne doit pas être null");
        receveurDAO = new ReceveurDAO();
    }

    @Test
    @Order(1)
    void testCreateReceveur() {
        Receveur r = new Receveur();
        r.setNom("El Amrani");
        r.setPrenom("Youssef");
        r.setSexe(Sexe.MASCULIN);
        r.setCin("AA12345");
        r.setGroupeSanguin(GroupeSanguin.A_POSITIF);
        r.setTelephone("0612345678");
        receveurDAO.ajouterReceveur(r);

        assertNotNull(r.getId(), "L'ID du receveur ne doit pas être nul après persistance !");
        cretedId = r.getId();
        System.out.println("Receveur ajouté avec ID = " + cretedId);
    }

    @Test
    @Order(2)
    void testGetReceveurById() {
        Receveur r = receveurDAO.getReceveurId(cretedId);
        assertNotNull(r, "Receveur doit exister après ajout !");
        assertEquals("El Amrani", r.getNom());
    }

    @Test
    @Order(3)
    void testModifyReceveur() {
        Receveur r = receveurDAO.getReceveurId(cretedId);
        r.setPrenom("El Amrani");
        receveurDAO.modifierReceveur(r);

        Receveur r2 = receveurDAO.getReceveurId(cretedId);
        assertEquals("El Amrani", r2.getPrenom(), "Prenom doit être mis à jour");
    }

    @Test
    @Order(4)
    void testGetAllReceveur() {
        List<Receveur> liste = receveurDAO.getAllReceveur();
        assertFalse(liste.isEmpty(), "La liste des receveurs ne doit pas être vide !");
        System.out.println("Nombre total de receveurs = " + liste.size());
    }

    @Test
    @Order(5)
    void testDeleteReceveur() {
        receveurDAO.supprimerReceveur(cretedId);
        Receveur delete = receveurDAO.getReceveurId(cretedId);

        assertNull(delete, "Receveur doit être supprimé !");
        System.out.println("🗑Receveur supprimé avec succès !");
    }
}
