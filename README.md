# Système de Gestion de Banque de Sang (README)


---

## 1. Résumé du projet
Une application web JEE (Java EE / Jakarta EE) pour gérer les donneurs et receveurs de sang, automatiser les associations selon la compatibilité sanguine et l'urgence médicale. Conçue pour être déployée sur Apache Tomcat, avec JSP/JSTL pour les vues, JPA/Hibernate pour l'ORM et MySQL ou PostgreSQL en base.

<img width="1901" height="905" alt="image" src="https://github.com/user-attachments/assets/61f34a21-dba8-4b97-87d4-08d0b0f6a22a" />
---
<img width="1901" height="905" alt="image" src="https://github.com/user-attachments/assets/f37c4d7e-a5e3-4568-bd56-9730d3f1c4ec" />
---
<img width="1886" height="899" alt="image" src="https://github.com/user-attachments/assets/28ac227f-9471-4b38-a95a-e53c6ac8120c" />



---

## 2. Objectifs fonctionnels (rappel succinct)
- Page Création : deux formulaires (Donneur / Receveur) avec validations front & back.
- Page Liste Donneurs : tableau (données perso + receveur associé + actions modifier/supprimer + filtres/tri).
- Page Liste Receveurs : tableau (données perso + donneurs associés + actions modifier/supprimer + filtres/tri). Tri par priorité : `CRITIQUE > URGENT > NORMAL`.
- Matching : respecter la matrice de compatibilité (O- donneur universel, AB+ receveur universel, règles spécifiques pour autres groupes).
- Statuts automatiques :
  - Donneur : `DISPONIBLE`, `NON_DISPONIBLE`, `NON_ELIGIBLE` (déterminé par âge, poids, contre-indications).
  - Receveur : `EN_ATTENTE`, `SATISFAIT` (devenant SATISFAIT quand nombre requis de poches atteint).
- Contraintes : 1 don = 1 poche max par receveur ; un donneur ne peut être associé qu'à 1 receveur à la fois.

---

## 3. Stack technique (obligatoire)
- Langage : Java 8+  
- Build : Maven  
- Vues : JSP + JSTL  
- Serveur : Apache Tomcat (WAR)  
- BD : **MySQL** ou **PostgreSQL** (choix configurable)  
- ORM : JPA / Hibernate (fichier `persistence.xml` dans `src/main/resources/META-INF`)  
- Tests : JUnit (min. 2 tests unitaires requis)  
- UI : CSS natif ou framework (Bootstrap / Tailwind — à choisir)  
- Logging : `java.util.logging` ou `log4j2` (configurable)
- Interdiction : ne PAS utiliser `application.properties` ni annotations de mapping de servlets (`@WebServlet`) — **mapping via `web.xml` obligatoire**.

---

## 4. Architecture & design
Multicouche MVC :
- **Présentation** : JSP/JSTL (views)
- **Contrôleur** : Servlets (mapping via `web.xml`)
- **Service** : services métiers (règles de validation, matching, policies)
- **DAO / Repository** : JPA EntityManager (Repository pattern + Singleton pour EntityManagerFactory)
- **Modèles** : Entités JPA (`Donneur`, `Receveur`, éventuellement `Don`, `HistoriqueDon`)

Principes : SOLID, séparation des responsabilités, tests unitaires, logging, gestion d'erreurs utilisateur.

---

## 5. Modèle de données (entités principales)
> (Exemples d'attributs — mapper avec JPA @Entity)

### Donneur
- id (Long, PK)
- nom, prenom
- telephone
- cin
- dateNaissance (LocalDate)
- poids (double)
- sexe (ENUM: M/F/Autre)
- groupeSanguin (ENUM: `O_NEG`, `O_POS`, `A_NEG`, `A_POS`, `B_NEG`, `B_POS`, `AB_NEG`, `AB_POS`)
- statutDisponibilite (ENUM: `DISPONIBLE`, `NON_DISPONIBLE`, `NON_ELIGIBLE`)
- contreIndications (Set<ENUM>) — ex: HEPATITE_B, VIH, DIABETE_INSULINO_DEPENDANT, GROSSESSE, ALLAITEMENT
- dateDernierDon (LocalDate, nullable)
- receveurAssocie (ManyToOne -> Receveur) — nullable

### Receveur
- id (Long, PK)
- nom, prenom
- telephone
- cin
- dateNaissance (LocalDate)
- sexe (ENUM)
- groupeSanguin (ENUM)
- urgence (ENUM: `CRITIQUE`, `URGENT`, `NORMAL`)
- nbPochesRequises (int) ← déterminé par `urgence` (CRITIQUE=4, URGENT=3, NORMAL=1)
- etat (ENUM: `EN_ATTENTE`, `SATISFAIT`)
- donneursAssocies (OneToMany -> Donneur)

### Optionnel (recommandé)
- Don / Transaction : historique d'un don (id, donneurId, receveurId, dateDon, status)
- Paramétrage de la matrice de compatibilité (pour tests / évolutivité)

---

## 6. Règles métiers (détaillées)
- **Éligibilité donneur** : âge ∈ [18,65], poids ≥ 50 kg, pas de contre-indications listées → sinon `NON_ELIGIBLE`.
- **Disponibilité** :
  - `DISPONIBLE` si éligible & pas associé & pas de don récent (par défaut on n'automatise pas le retour à DISPONIBLE sauf bonus).
  - Après association (don confirmé), `NON_DISPONIBLE`.
- **Association** :
  - Lors de l'acte d'association, afficher uniquement : pour un receveur => donneurs compatibles **et** `DISPONIBLE`; pour un donneur => receveurs compatibles **et** `EN_ATTENTE` (non satisfaits).
  - Un receveur `SATISFAIT` ne doit plus recevoir d'autres donneurs.
  - 1 don = 1 poche max par receveur ; un receveur peut avoir plusieurs donneurs selon `nbPochesRequises`.
- **Tri** :
  - Liste receveurs triée par urgence (CRITIQUE → URGENT → NORMAL), puis par date d'entrée.
- **Matching sanguin** : appliquer la matrice fournie (O- donneur universel, AB+ receveur universel, etc.). Implémenter la matrice sous forme de service ou table de lookup.

---

## 7. Validation & UX
- Front-end : validations JS (JSP + optionally Bootstrap forms) + messages d'erreur clairs.
- Back-end : validation côté serveur (Service layer) et renvoi d'erreurs JSP.
- Messages d'erreur : afficher en haut des formulaires, mettre en surbrillance les champs invalides.

---

## 8. Fichiers de configuration importants
- `src/main/resources/META-INF/persistence.xml` — configuration unité de persistance Hibernate (JDBC URL, driver, dialect, user, password).
- `src/main/webapp/WEB-INF/web.xml` — mapping des servlets, filtres, listeners.
- `pom.xml` — dépendances (javax.servlet, jsp, jstl, hibernate-core, hibernate-entitymanager, mysql/postgresql driver, junit, log4j2).

---

## 9. Déploiement & exécution (local)
1. Configurer la base (MySQL/Postgres) et créer BD (script SQL fourni dans `/database/init.sql`).
2. Modifier `persistence.xml` pour renseigner JDBC URL / user / password.
3. Build : `mvn clean package` → génère `target/sang-bank.war`.
4. Déployer WAR sur Tomcat (copier dans `TOMCAT_HOME/webapps/`).
5. Accéder : `http://localhost:8080/sang-bank/`

---

## 10. Scripts utiles
- `/database/init.sql` : création tables (entités Donneur, Receveur, Don)
- `/database/sample-data.sql` : quelques donneurs/receveurs pour tests

---

## 11. Tests
- JUnit : Minimum 2 tests unitaires fournis (exemples) :
  - `DonneurEligibilityServiceTest` : cas âge/poids/contre-indications.
  - `MatchingServiceTest` : test matrice de compatibilité (ex : receveur AB+ accepte O-, A+, etc).
- (Bonus recommandé) : Tests d'intégration sur couche DAO (EntityManager in-memory H2) — optionnel.

---

## 12. Sécurité & gestion des erreurs
- Gestion des erreurs utilisateurs : messages clairs dans JSP.
- Validation des entrées côté serveur (pas de confiance au front).
- Logging des erreurs et des actions importantes (association, création, suppression).
- (Optionnel) Filtres pour authentification si besoin (non exigé par le sujet).

---

## 13. Livrables (ce que vous devez fournir)

- Diagramme de classe (UML) — image ou fichier <img width="798" height="697" alt="image" src="https://github.com/user-attachments/assets/5b8687d2-6742-405d-8b41-b78a090f3bfd" />


 .


---

## 14. Suggestions d'implémentation techniques (bonnes pratiques)
- Utiliser DTO pour échanges servlets ↔ services (éviter d'exposer entités JPA directement).
- Service `MatchingService` stateless : implémente la logique de compatibilité.
- Repository pattern : `DonneurRepository`, `ReceveurRepository` (utiliser `EntityManager`).
- Singleton `EntityManagerFactoryProvider` qui crée et fournit `EntityManagerFactory`.
- Pagination côté DAO (LIMIT/OFFSET) pour listes (bonus).
- Internationalisation des messages d'erreur (folder `i18n/messages_fr.properties`).

---

## 15. Bonus (fonctionnalités optionnelles — cocher celles à inclure)
- 2 tests d’intégration (DAO + Service)  
- Rendre un donneur DISPONIBLE 1 mois après dernier don (scheduler ou calcul date)  
- Pagination pour listes (donneurs/receveurs)  
- Recherche dynamique / filtrage (JS + endpoints Ajax)  
- Dockerfile pour conteneuriser l'app  
- Déploiement manuel WAR (instructions incluses)  
- Dashboard analytics (Chart.js) : taux par groupe sanguin, répartition urgences, etc.

---

## 16. Checklist d'évaluation (pour la soutenance)
- [ ] Respect règles métiers (éligibilité, 1 poche, etc.)
- [ ] Matching correct (matrice)
- [ ] Vues JSP fonctionnelles + validations
- [ ] `persistence.xml` présent et fonctionnel
- [ ] `web.xml` contient tous les mappings
- [ ] JUnit tests (≥2) + logs
- [ ] WAR généré et déployable
- [ ] JIRA lien + diagramme de classe + README

---

## 17. Structure de projet (suggestion)

<img width="665" height="516" alt="image" src="https://github.com/user-attachments/assets/c56c2fa7-991e-4938-84dc-72492bcc54f3" />

