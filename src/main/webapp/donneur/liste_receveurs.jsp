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
            font-family: 'Poppins', sans-serif;
            background-color: #f8fafc;
            color: #0a2239;
            line-height: 1.6;
        }

        /* HEADER AMÉLIORÉ */
        header {
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 8%;
            background: white;
            box-shadow: 0 2px 15px rgba(0,0,0,0.08);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .logo {
            font-size: 1.8rem;
            font-weight: 700;
            color: #0a2239;
            display: flex;
            align-items: center;
        }

        .logo span {
            color: #c62828;
            margin-left: 5px;
        }

        .logo::before {
            margin-right: 8px;
            font-size: 1.5rem;
        }

        nav ul {
            list-style: none;
            display: flex;
            gap: 30px;
        }

        nav ul li a {
            text-decoration: none;
            color: #0a2239;
            font-weight: 500;
            transition: 0.3s;
            padding: 8px 0;
            position: relative;
        }

        nav ul li a::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: 0;
            left: 0;
            background-color: #c62828;
            transition: width 0.3s;
        }

        nav ul li a.active::after,
        nav ul li a:hover::after {
            width: 100%;
        }

        nav ul li a.active,
        nav ul li a:hover {
            color: #c62828;
        }

        /* BURGER MENU POUR MOBILE */
        .burger-menu {
            display: none;
            flex-direction: column;
            cursor: pointer;
            gap: 5px;
            padding: 5px;
        }

        .burger-menu span {
            width: 25px;
            height: 3px;
            background-color: #0a2239;
            transition: 0.3s;
            border-radius: 2px;
        }

        .burger-menu.active span:nth-child(1) {
            transform: rotate(45deg) translate(6px, 6px);
        }

        .burger-menu.active span:nth-child(2) {
            opacity: 0;
        }

        .burger-menu.active span:nth-child(3) {
            transform: rotate(-45deg) translate(6px, -6px);
        }

        /* CONTENU PRINCIPAL */
        .main-content {
            padding: 2rem 8%;
            max-width: 1400px;
            margin: 0 auto;
        }

        .page-title {
            text-align: center;
            margin-bottom: 3rem;
            animation: fadeIn 1s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .page-title h1 {
            color: #c62828;
            font-size: 2.8rem;
            margin-bottom: 0.5rem;
            font-weight: 700;
        }

        .page-title h1 span {
            position: relative;
        }

        .page-title h1 span::after {
            content: '';
            position: absolute;
            width: 100%;
            height: 8px;
            bottom: 5px;
            left: 0;
            background-color: rgba(198, 40, 40, 0.2);
            z-index: -1;
            border-radius: 4px;
        }

        .page-title p {
            font-size: 1.2rem;
            color: #4a5568;
            max-width: 600px;
            margin: 0 auto;
        }

        /* BOUTON AJOUTER */
        .add-section {
            text-align: center;
            margin-bottom: 3rem;
        }

        .add-btn {
            background: linear-gradient(135deg, #c62828, #b71c1c);
            color: white;
            border: none;
            padding: 14px 32px;
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(198, 40, 40, 0.3);
            text-decoration: none;
            display: inline-block;
        }

        .add-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(198, 40, 40, 0.4);
            background: linear-gradient(135deg, #b71c1c, #a01212);
        }

        /* FILTRES */
        .filter-section {
            background: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            margin-bottom: 3rem;
            text-align: center;
        }

        .filter-form {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 1.5rem;
            flex-wrap: wrap;
        }

        select {
            padding: 12px 20px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 1rem;
            background: white;
            transition: border-color 0.3s;
        }

        select:focus {
            outline: none;
            border-color: #c62828;
        }

        .filter-btn {
            background: linear-gradient(135deg, #0a2239, #1a3c57);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .filter-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(10, 34, 57, 0.3);
        }

        /* CARTES - RÉDUITES */
        .card-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 1.5rem;
        }

        .card {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            border-top: 3px solid #c62828;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.12);
        }

        .blood-group-display {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #fff5f5, #ffeaea);
            border: 2px solid #c62828;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem auto;
        }

        .blood-group-text {
            font-size: 1.5rem;
            font-weight: bold;
            color: #c62828;
        }

        .card h3 {
            text-align: center;
            margin-bottom: 1rem;
            color: #0a2239;
            font-size: 1.2rem;
            font-weight: 600;
        }

        .card-info {
            display: flex;
            flex-direction: column;
            gap: 0.6rem;
            margin-bottom: 1rem;
        }

        .info-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.3rem 0;
            font-size: 0.9rem;
        }

        .info-item strong {
            color: #4a5568;
            font-weight: 600;
        }

        /* BARRE DE PROGRESSION */
        .progress-container {
            margin: 1rem 0;
            background: #f8fafc;
            padding: 0.8rem;
            border-radius: 8px;
        }

        .progress-label {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: #0a2239;
            font-size: 0.85rem;
        }

        .progress-bar {
            width: 100%;
            height: 6px;
            background: #e2e8f0;
            border-radius: 3px;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            background: linear-gradient(90deg, #c62828, #e53e3e);
            border-radius: 3px;
            transition: width 0.5s ease;
        }

        /* BOUTONS D'ACTION */
        .actions {
            display: flex;
            gap: 0.8rem;
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid #f1f5f9;
        }

        .action-btn {
            flex: 1;
            padding: 8px 12px;
            text-decoration: none;
            border-radius: 6px;
            text-align: center;
            font-size: 0.85rem;
            font-weight: 600;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }

        .btn-edit {
            background: linear-gradient(135deg, #0a2239, #1a3c57);
            color: white;
        }

        .btn-edit:hover {
            transform: translateY(-1px);
            box-shadow: 0 2px 8px rgba(10, 34, 57, 0.3);
        }

        .btn-delete {
            background: linear-gradient(135deg, #dc3545, #c53030);
            color: white;
        }

        .btn-delete:hover {
            transform: translateY(-1px);
            box-shadow: 0 2px 8px rgba(220, 53, 69, 0.3);
        }

        /* MESSAGE AUCUNE DONNÉE */
        .no-data {
            text-align: center;
            padding: 3rem 2rem;
            color: #718096;
            font-style: italic;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            grid-column: 1 / -1;
        }

        .no-data::before {
            font-size: 2.5rem;
            display: block;
            margin-bottom: 1rem;
            opacity: 0.5;
        }

        /* MESSAGE DE SUCCÈS */
        .message {
            background: linear-gradient(135deg, #48bb78, #38a169);
            color: white;
            padding: 1rem 1.5rem;
            border-radius: 8px;
            margin-bottom: 2rem;
            text-align: center;
            font-weight: 600;
            box-shadow: 0 4px 12px rgba(72, 187, 120, 0.3);
        }

        /* RESPONSIVE */
        @media (max-width: 768px) {
            header {
                padding: 15px 5%;
            }

            .main-content {
                padding: 1rem 5%;
            }

            nav ul {
                gap: 1.5rem;
            }

            .page-title h1 {
                font-size: 2.2rem;
            }

            .filter-form {
                flex-direction: column;
                width: 100%;
            }

            select, .filter-btn {
                width: 100%;
                max-width: 300px;
            }

            .card-container {
                grid-template-columns: 1fr;
            }

            .card {
                padding: 1.2rem;
            }

            .actions {
                flex-direction: column;
            }

            .burger-menu {
                display: flex;
            }

            nav ul {
                position: absolute;
                top: 100%;
                right: 0;
                background: white;
                flex-direction: column;
                width: 200px;
                padding: 15px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                border-radius: 8px;
                display: none;
                gap: 0;
            }

            nav ul.active {
                display: flex;
            }

            nav ul li {
                margin: 8px 0;
            }

            nav ul li a {
                display: block;
                padding: 8px 0;
                border-bottom: 1px solid #f0f0f0;
            }

            nav ul li:last-child a {
                border-bottom: none;
            }
        }

        @media (max-width: 480px) {
            .logo {
                font-size: 1.5rem;
            }

            .page-title h1 {
                font-size: 1.8rem;
            }

            .blood-group-display {
                width: 70px;
                height: 70px;
            }

            .blood-group-text {
                font-size: 1.3rem;
            }

            .card {
                padding: 1rem;
            }

            nav ul {
                width: 180px;
            }

            .add-btn {
                padding: 12px 24px;
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
<header>
    <div class="logo">Banque<span>Sang</span></div>
    <nav>
        <ul id="nav-menu">
            <li><a href="${pageContext.request.contextPath}/receveur/liste_donneurs">Donneurs</a></li>
            <li><a href="${pageContext.request.contextPath}/donneur/liste_receveurs" class="active">Receveurs</a></li>
            <li><a href="#">Contactez-nous</a></li>
        </ul>
        <div class="burger-menu" id="burger-menu">
            <span></span>
            <span></span>
            <span></span>
        </div>
    </nav>
</header>

<div class="main-content">
    <div class="page-title">
        <h1>Liste des <span>Receveurs</span></h1>
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
                            <form action="${pageContext.request.contextPath}/donneur/supprimerReceveur" method="post" style="flex: 1;">
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
    // Menu burger
    const burgerMenu = document.getElementById('burger-menu');
    const navMenu = document.getElementById('nav-menu');

    burgerMenu.addEventListener('click', () => {
        burgerMenu.classList.toggle('active');
        navMenu.classList.toggle('active');
    });

    // Fermer le menu quand on clique sur un lien
    const navLinks = document.querySelectorAll('#nav-menu a');
    navLinks.forEach(link => {
        link.addEventListener('click', () => {
            burgerMenu.classList.remove('active');
            navMenu.classList.remove('active');
        });
    });

    // Animation des barres de progression
    document.addEventListener('DOMContentLoaded', function() {
        const progressBars = document.querySelectorAll('.progress-fill');
        progressBars.forEach(bar => {
            const width = bar.style.width;
            bar.style.width = '0';
            setTimeout(() => {
                bar.style.width = width;
            }, 100);
        });
    });
</script>
</body>
</html>