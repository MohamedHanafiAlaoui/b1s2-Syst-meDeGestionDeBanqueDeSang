<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Receveurs</title>
    <style>
        /* RESET BASIQUE */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f9ff;
            color: #333;
            line-height: 1.6;
        }

        /* HEADER SIMPLIFIÉ */
        header {
            background: white;
            padding: 1rem 2rem;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 1.5rem;
            font-weight: bold;
            color: #c62828;
        }

        nav ul {
            list-style: none;
            display: flex;
            gap: 2rem;
        }

        nav a {
            text-decoration: none;
            color: #333;
            font-weight: 500;
        }

        nav a.active {
            color: #c62828;
        }

        /* CONTENU PRINCIPAL */
        .main-content {
            padding: 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .page-title {
            text-align: center;
            margin-bottom: 2rem;
        }

        .page-title h1 {
            color: #c62828;
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
        }

        /* BOUTON AJOUTER */
        .add-section {
            text-align: center;
            margin-bottom: 2rem;
        }

        .add-btn {
            background: #28a745;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 6px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s;
        }

        .add-btn:hover {
            background: #218838;
        }

        /* FILTRES */
        .filter-section {
            background: white;
            padding: 1.5rem;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
            text-align: center;
        }

        .filter-form {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 1rem;
            flex-wrap: wrap;
        }

        select, .filter-btn {
            padding: 8px 16px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1rem;
        }

        .filter-btn {
            background: #c62828;
            color: white;
            border: none;
            cursor: pointer;
        }

        /* CARTES */
        .card-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 1.5rem;
        }

        .card {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            border-top: 4px solid #c62828;
        }

        .blood-group-display {
            width: 100px;
            height: 120px;
            background: white;
            border: 2px solid #c62828;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem auto;
        }

        .blood-group-text {
            font-size: 1.8rem;
            font-weight: bold;
            color: #c62828;
        }

        .card h3 {
            text-align: center;
            margin-bottom: 1rem;
            color: #333;
        }

        .card-info {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
            margin-bottom: 1rem;
        }

        .info-item {
            display: flex;
            justify-content: space-between;
        }

        .info-item strong {
            color: #555;
        }

        /* BARRE DE PROGRESSION */
        .progress-container {
            margin: 1rem 0;
        }

        .progress-label {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
        }

        .progress-bar {
            width: 100%;
            height: 6px;
            background: #f0f0f0;
            border-radius: 3px;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            background: #c62828;
            border-radius: 3px;
        }

        /* BOUTONS D'ACTION */
        .actions {
            display: flex;
            gap: 0.5rem;
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid #eee;
        }

        .action-btn {
            flex: 1;
            padding: 8px 12px;
            text-decoration: none;
            border-radius: 4px;
            text-align: center;
            font-size: 0.9rem;
            font-weight: 500;
        }

        .btn-edit {
            background: #007bff;
            color: white;
        }

        .btn-delete {
            background: #dc3545;
            color: white;
        }

        /* MESSAGE AUCUNE DONNÉE */
        .no-data {
            text-align: center;
            padding: 3rem;
            color: #666;
            font-style: italic;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        /* RESPONSIVE */
        @media (max-width: 768px) {
            .main-content {
                padding: 1rem;
            }

            header {
                flex-direction: column;
                gap: 1rem;
            }

            nav ul {
                gap: 1rem;
            }

            .filter-form {
                flex-direction: column;
            }

            .card-container {
                grid-template-columns: 1fr;
            }

            .actions {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
<header>
    <div class="logo">SangReceveurs</div>
    <nav>
        <ul>
            <li><a href="#">Accueil</a></li>
            <li><a href="#">Donneurs</a></li>
            <li><a href="#" class="active">Receveurs</a></li>
            <li><a href="#">Statistiques</a></li>
        </ul>
    </nav>
</header>

<div class="main-content">
    <div class="page-title">
        <h1>Liste des Receveurs</h1>
        <p>Gérez et suivez tous les receveurs en attente de transfusion</p>
    </div>

    <form action="${pageContext.request.contextPath}/donneur/ajouterAssocDon" method="post">
        <c:if test="${not empty sessionScope.assocMessage}">
            <div class="message">${sessionScope.assocMessage}</div>
            <c:remove var="assocMessage" scope="session"/>
        </c:if>

        <div class="add-section">
            <button class="add-btn" type="submit">Ajouter un Receveur</button>
        </div>
    </form>


    <!-- Filtres -->
    <div class="filter-section">
        <form method="get" action="" class="filter-form">
            <label for="groupeSanguin">Filtrer par groupe sanguin :</label>
            <select name="groupe" id="groupeSanguin">
                <option value="">Tous les groupes</option>
                <option value="O_NEGATIF" <c:if test="${filterGroupe == 'O_NEGATIF'}">selected</c:if>>O-</option>
                <option value="O_POSITIF" <c:if test="${filterGroupe == 'O_POSITIF'}">selected</c:if>>O+</option>
                <option value="A_NEGATIF" <c:if test="${filterGroupe == 'A_NEGATIF'}">selected</c:if>>A-</option>
                <option value="A_POSITIF" <c:if test="${filterGroupe == 'A_POSITIF'}">selected</c:if>>A+</option>
                <option value="B_NEGATIF" <c:if test="${filterGroupe == 'B_NEGATIF'}">selected</c:if>>B-</option>
                <option value="B_POSITIF" <c:if test="${filterGroupe == 'B_POSITIF'}">selected</c:if>>B+</option>
                <option value="AB_NEGATIF" <c:if test="${filterGroupe == 'AB_NEGATIF'}">selected</c:if>>AB-</option>
                <option value="AB_POSITIF" <c:if test="${filterGroupe == 'AB_POSITIF'}">selected</c:if>>AB+</option>
            </select>
            <button type="submit" class="filter-btn">Filtrer</button>
        </form>
    </div>

    <!-- Liste des receveurs -->
    <div class="card-container">
        <c:choose>
            <c:when test="${not empty receveurs}">
                <c:forEach var="receveur" items="${receveurs}">
                    <div class="card">
                        <div class="blood-group-display">
                            <div class="blood-group-text">
                                <c:choose>
                                    <c:when test="${receveur.groupeSanguin == 'O_NEGATIF'}">O-</c:when>
                                    <c:when test="${receveur.groupeSanguin == 'O_POSITIF'}">O+</c:when>
                                    <c:when test="${receveur.groupeSanguin == 'A_NEGATIF'}">A-</c:when>
                                    <c:when test="${receveur.groupeSanguin == 'A_POSITIF'}">A+</c:when>
                                    <c:when test="${receveur.groupeSanguin == 'B_NEGATIF'}">B-</c:when>
                                    <c:when test="${receveur.groupeSanguin == 'B_POSITIF'}">B+</c:when>
                                    <c:when test="${receveur.groupeSanguin == 'AB_NEGATIF'}">AB-</c:when>
                                    <c:when test="${receveur.groupeSanguin == 'AB_POSITIF'}">AB+</c:when>
                                    <c:otherwise>${receveur.groupeSanguin}</c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <h3>${receveur.nom} ${receveur.prenom}</h3>

                        <div class="card-info">
                            <div class="info-item">
                                <strong>CIN:</strong>
                                <span>${receveur.cin}</span>
                            </div>
                            <div class="info-item">
                                <strong>Sexe:</strong>
                                <span>${receveur.sexe}</span>
                            </div>
                            <div class="info-item">
                                <strong>Urgence:</strong>
                                <span>${receveur.urgence}</span>
                            </div>

                            <div class="progress-container">
                                <div class="progress-label">
                                    <span>Poches reçues:</span>
                                    <span>${receveur.nombrePochesRecues}/${receveur.nombrePochesRequises}</span>
                                </div>
                                <div class="progress-bar">
                                    <div class="progress-fill"
                                         style="width: ${(receveur.nombrePochesRecues / receveur.nombrePochesRequises) * 100}%">
                                    </div>
                                </div>
                            </div>

                            <div class="info-item">
                                <strong>Statut:</strong>
                                <span>${receveur.statut}</span>
                            </div>
                        </div>

                        <div class="actions">
                            <a class="action-btn btn-edit" href="${pageContext.request.contextPath}/receveur/modifierReceveur?id=${receveur.id}">Modifier</a>
                            <form action="${pageContext.request.contextPath}/donneur/supprimerReceveur" method="post">
                                <input type="hidden" name="userId" value="${receveur.id}">

                                <button type="submit" class="action-btn btn-delete">Supprimer</button>
                            </form>

                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="no-data">
                    Aucun receveur trouvé.
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script>

</script>
</body>
</html>