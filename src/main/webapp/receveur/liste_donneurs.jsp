<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Donneurs</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background-color: #f4f9ff;
            color: #0a2239;
        }

        /* HEADER */
        header {
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 8%;
            background: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .logo {
            font-size: 1.6rem;
            font-weight: 700;
            color: #0a2239;
        }

        .logo span {
            color: #c62828;
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
        }

        nav ul li a.active,
        nav ul li a:hover {
            color: #c62828;
        }

        /* BURGER MENU */
        .burger-menu {
            display: none;
            flex-direction: column;
            cursor: pointer;
            gap: 4px;
        }

        .burger-menu span {
            width: 25px;
            height: 3px;
            background-color: #0a2239;
            transition: 0.3s;
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

        /* MAIN CONTENT */
        .main-content {
            padding: 60px 8%;
        }

        .page-title {
            text-align: center;
            margin-bottom: 40px;
        }

        .page-title h1 {
            font-size: 2.5rem;
            color: #0a2239;
            margin-bottom: 10px;
        }

        .page-title h1 span {
            color: #c62828;
        }

        .page-title p {
            color: #666;
            font-size: 1.1rem;
        }

        /* FILTER SECTION */
        .filter-section {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            margin-bottom: 40px;
            text-align: center;
        }

        .filter-form {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
        }

        .filter-form label {
            font-weight: 600;
            color: #0a2239;
        }

        select, .filter-btn {
            padding: 12px 20px;
            border-radius: 8px;
            border: 1px solid #ddd;
            font-size: 1rem;
            transition: all 0.3s;
        }

        select {
            background: white;
            min-width: 150px;
        }

        select:focus {
            outline: none;
            border-color: #c62828;
            box-shadow: 0 0 0 2px rgba(198, 40, 40, 0.1);
        }

        .filter-btn {
            background: linear-gradient(135deg, #c62828, #d32f2f);
            color: white;
            border: none;
            cursor: pointer;
            font-weight: 600;
            padding: 12px 25px;
        }

        .filter-btn:hover {
            background: linear-gradient(135deg, #b71c1c, #c62828);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(198, 40, 40, 0.3);
        }

        /* CARD CONTAINER */
        .card-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }

        .card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            padding: 25px;
            transition: all 0.3s ease;
            border-top: 4px solid #c62828;
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 35px rgba(0,0,0,0.15);
        }

        /* BLOOD GROUP DISPLAY */
        .blood-group-display {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: white;
            border: 3px solid #c62828;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px auto;
            position: relative;
            box-shadow: 0 5px 15px rgba(198, 40, 40, 0.2);
        }

        .blood-group-display::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            /*background: linear-gradient(135deg, rgba(198, 40, 40, 0.1), rgba(211, 47, 47, 0.05));*/
            border-radius: 12px;
        }

        .blood-group-text {
            font-size: 2.5rem;
            font-weight: bold;
            color: #c62828;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
            z-index: 2;
        }

        .blood-group-label {
            position: absolute;
            bottom: 15px;
            font-size: 0.9rem;
            color: #666;
            font-weight: 600;
            z-index: 2;
        }

        .card h3 {
            color: #0a2239;
            margin-bottom: 15px;
            font-size: 1.3rem;
            text-align: center;
        }

        .card-info {
            display: flex;
            flex-direction: column;
            gap: 8px;
            margin-bottom: 20px;
        }

        .info-item {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 0.95rem;
            color: #555;
        }

        .info-item strong {
            color: #0a2239;
            min-width: 140px;
        }

        .status {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-eligible {
            background: #e8f5e9;
            color: #2e7d32;
        }

        .status-indication {
            background: #ffebee;
            color: #c62828;
        }

        /* ACTIONS */
        .actions {
            display: flex;
            gap: 10px;
            justify-content: space-between;
            flex-wrap: wrap;
            margin-top: auto;
            padding-top: 20px;
            border-top: 1px solid #f0f0f0;
        }

        .action-btn {
            flex: 1;
            min-width: 80px;
            padding: 10px 15px;
            text-decoration: none;
            border-radius: 8px;
            font-size: 0.85rem;
            font-weight: 600;
            text-align: center;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
        }

        .btn-add {
            background: linear-gradient(135deg, #007BFF, #0056b3);
            color: white;
        }

        .btn-edit {
            background: linear-gradient(135deg, #28a745, #1e7e34);
            color: white;
        }

        .btn-delete {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
        }

        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 3px 10px rgba(0,0,0,0.2);
        }

        /* RESPONSIVE */
        @media (max-width: 900px) {
            .main-content {
                padding: 40px 5%;
            }

            .page-title h1 {
                font-size: 2rem;
            }

            .filter-form {
                flex-direction: column;
                align-items: stretch;
            }

            select {
                min-width: auto;
            }
        }

        @media (max-width: 768px) {
            header {
                padding: 15px 5%;
            }

            .logo {
                font-size: 1.4rem;
            }

            nav {
                position: relative;
            }

            nav ul {
                position: absolute;
                top: 100%;
                right: 0;
                background: white;
                flex-direction: column;
                width: 200px;
                padding: 20px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                border-radius: 8px;
                display: none;
                gap: 0;
            }

            nav ul.active {
                display: flex;
            }

            nav ul li {
                margin: 10px 0;
            }

            nav ul li a {
                display: block;
                padding: 10px 0;
                border-bottom: 1px solid #f0f0f0;
            }

            nav ul li:last-child a {
                border-bottom: none;
            }

            .burger-menu {
                display: flex;
            }

            .card-container {
                grid-template-columns: 1fr;
            }

            .actions {
                flex-direction: column;
            }

            .action-btn {
                min-width: auto;
            }
        }

        @media (max-width: 480px) {
            .page-title h1 {
                font-size: 1.8rem;
            }

            .page-title p {
                font-size: 1rem;
            }

            nav ul {
                width: 180px;
            }

            .card {
                padding: 20px;
            }

            .blood-group-display {
                width: 90px;
                height: 90px;
            }

            .blood-group-text {
                font-size: 2rem;
            }

            .card h3 {
                padding-right: 0;
            }
        }
    </style>
</head>
<body>
<header>
    <div class="logo">Sang<span>Donneurs</span></div>
    <nav>
        <ul id="nav-menu">
            <li><a href="#" class="active">Accueil</a></li>
            <li><a href="#">Donneurs</a></li>
            <li><a href="#">Receveurs</a></li>
            <li><a href="#">Statistiques</a></li>
            <li><a href="#">Contact</a></li>
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
        <h1>Liste des <span>Donneurs</span></h1>
        <p>Gérez et consultez tous les donneurs de sang enregistrés</p>
    </div>

    <!-- Section Filtre -->
    <div class="filter-section">
        <form method="get" action="" class="filter-form">
            <label for="groupeSanguin">Filtrer par groupe sanguin :</label>
            <select name="groupeSanguin" id="groupeSanguin">
                <option value="">-- Tous les groupes --</option>
                <option value="O_NEGATIF" <c:if test="${filtreGroupe == 'O_NEGATIF'}">selected</c:if>>O-</option>
                <option value="O_POSITIF" <c:if test="${filtreGroupe == 'O_POSITIF'}">selected</c:if>>O+</option>
                <option value="A_NEGATIF" <c:if test="${filtreGroupe == 'A_NEGATIF'}">selected</c:if>>A-</option>
                <option value="A_POSITIF" <c:if test="${filtreGroupe == 'A_POSITIF'}">selected</c:if>>A+</option>
                <option value="B_NEGATIF" <c:if test="${filtreGroupe == 'B_NEGATIF'}">selected</c:if>>B-</option>
                <option value="B_POSITIF" <c:if test="${filtreGroupe == 'B_POSITIF'}">selected</c:if>>B+</option>
                <option value="AB_NEGATIF" <c:if test="${filtreGroupe == 'AB_NEGATIF'}">selected</c:if>>AB-</option>
                <option value="AB_POSITIF" <c:if test="${filtreGroupe == 'AB_POSITIF'}">selected</c:if>>AB+</option>
            </select>
            <button type="submit" class="filter-btn">Appliquer le filtre</button>
        </form>
    </div>

    <!-- Liste des donneurs -->
    <div class="card-container">
        <c:forEach var="donneur" items="${donneurs}">
            <div class="card">
                <!-- Cadre du groupe sanguin -->
                <div class="blood-group-display">
                    <div class="blood-group-text">
                        <c:choose>
                            <c:when test="${donneur.groupeSanguin == 'O_NEGATIF'}">O-</c:when>
                            <c:when test="${donneur.groupeSanguin == 'O_POSITIF'}">O+</c:when>
                            <c:when test="${donneur.groupeSanguin == 'A_NEGATIF'}">A-</c:when>
                            <c:when test="${donneur.groupeSanguin == 'A_POSITIF'}">A+</c:when>
                            <c:when test="${donneur.groupeSanguin == 'B_NEGATIF'}">B-</c:when>
                            <c:when test="${donneur.groupeSanguin == 'B_POSITIF'}">B+</c:when>
                            <c:when test="${donneur.groupeSanguin == 'AB_NEGATIF'}">AB-</c:when>
                            <c:when test="${donneur.groupeSanguin == 'AB_POSITIF'}">AB+</c:when>
                            <c:otherwise>${donneur.groupeSanguin}</c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <h3>${donneur.nom} ${donneur.prenom}</h3>

                <div class="card-info">
                    <div class="info-item">
                        <strong>CIN:</strong>
                        <span>${donneur.cin}</span>
                    </div>
                    <div class="info-item">
                        <strong>Sexe:</strong>
                        <span>${donneur.sexe}</span>
                    </div>
                    <div class="info-item">
                        <strong>Contre-indications:</strong>
                        <span class="status <c:if test="${donneur.contreIndicattions}">status-indication</c:if>">
                            <c:choose>
                                <c:when test="${donneur.contreIndicattions}">Oui</c:when>
                                <c:otherwise>Non</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <div class="info-item">
                        <strong>Date Dernier Don:</strong>
                        <span><c:out value="${donneur.dateDernierDon}"/></span>
                    </div>
                    <div class="info-item">
                        <strong>Statut:</strong>
                        <span class="status status-eligible">${donneur.statut}</span>
                    </div>
                    <div class="info-item">
                        <strong>Receveurs Associés:</strong>
                        <span>Pas de receveur</span>
                    </div>
                </div>




                <div class="actions">
                    <form action="${pageContext.request.contextPath}/donneur/modifierAssocDonIdRecveur"  method="post">
                        <input type="hidden" name="id" value="${donneur.id}">
                        <c:forEach var="assoc" items="${donneur.associationDonList}">
                            <c:if test="${empty assoc.receveur}">
                                <input type="hidden" name="id_assoc" value="${assoc.id}">
                            </c:if>

                        </c:forEach>

                        <button class="action-btn btn-add">Ajouter Receveur</button>

                    </form>
                    <a class="action-btn btn-edit" href="${pageContext.request.contextPath}/donneur/modifierDono?id=${donneur.id}">Modifier</a>
                    <form action="${pageContext.request.contextPath}/receveur/supprimerDonor" method="post">
                        <input type="hidden" name="userId" value="${donneur.id}">
                        <button class="action-btn btn-delete" type="submit" >Supprimer</button>
                    </form>

                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script>
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
</script>
</body>
</html>