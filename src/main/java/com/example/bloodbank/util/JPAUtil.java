package com.example.bloodbank.util;
import io.github.cdimascio.dotenv.Dotenv;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.util.HashMap;
import java.util.Map;

public class JPAUtil {

    private static EntityManagerFactory emf;

    static{
        try {
            Dotenv dotenv = Dotenv.load();
            Map<String,String> props = new HashMap<>();
            props.put("jakarta.persistence.jdbc.driver", dotenv.get("DB_DRIVER"));
            props.put("jakarta.persistence.jdbc.url", dotenv.get("DB_URL"));
            props.put("jakarta.persistence.jdbc.user", dotenv.get("DB_USERNAME"));
            props.put("jakarta.persistence.jdbc.password", dotenv.get("DB_PASSWORD"));
            props.put("hibernate.dialect", dotenv.get("DB_DIALECT"));
            props.put("hibernate.hbm2ddl.auto", "update");
            props.put("hibernate.show_sql", "true");
            props.put("hibernate.format_sql", "true");

            emf = Persistence.createEntityManagerFactory("BloodBankPU", props);

        }
        catch (Exception e){
            e.printStackTrace();
        }
    }

    public static  EntityManagerFactory getEntityManagerFactory(){
        return emf;
    }

    public  static  void  close()
    {
        if (emf != null && emf.isOpen())
        {
            emf.close();
        }
    }
}
