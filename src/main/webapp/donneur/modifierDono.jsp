<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier un Donneur</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: "Poppins", sans-serif;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .container {
            display: flex;
            max-width: 1200px;
            width: 100%;
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            min-height: 700px;
        }

        .image-section {
            flex: 1;
            background: linear-gradient(135deg, rgba(220, 53, 69, 0.9), rgba(178, 42, 58, 0.9)),
            url('https://images.unsplash.com/photo-1579154204601-015dbf4a937f?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80');
            background-size: cover;
            background-position: center;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 40px;
            color: white;
            text-align: center;
        }

        .image-content h1 {
            font-size: 2.8rem;
            font-weight: 700;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }

        .image-content p {
            font-size: 1.2rem;
            opacity: 0.95;
            line-height: 1.6;
            max-width: 400px;
        }

        .form-section {
            flex: 1;
            padding: 50px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .form-container {
            width: 100%;
            max-width: 500px;
            margin: 0 auto;
        }

        h2 {
            color: #dc3545;
            text-align: center;
            margin-bottom: 10px;
            font-size: 2rem;
            font-weight: 600;
        }

        .subtitle {
            text-align: center;
            color: #6c757d;
            margin-bottom: 30px;
            font-size: 1rem;
        }

        .message {
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: 500;
            text-align: center;
        }

        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .full-width {
            grid-column: 1 / -1;
        }

        label {
            display: block;
            font-weight: 500;
            margin-bottom: 6px;
            color: #495057;
            font-size: 0.9rem;
        }

        input, select {
            width: 100%;
            padding: 12px 15px;
            border: 1.5px solid #e1e5e9;
            border-radius: 8px;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            background-color: #fff;
        }

        input:focus, select:focus {
            outline: none;
            border-color: #dc3545;
            box-shadow: 0 0 0 3px rgba(220, 53, 69, 0.1);
        }

        .checkbox-group {
            display: flex;
            align-items: center;
            margin: 20px 0;
        }

        .checkbox-group input {
            width: auto;
            margin-right: 10px;
        }

        .checkbox-group label {
            margin-bottom: 0;
            font-weight: 500;
        }

        .btn {
            display: block;
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(220, 53, 69, 0.3);
        }

        .btn:hover {
            background: linear-gradient(135deg, #c82333, #bd2130);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(220, 53, 69, 0.4);
        }

        .btn:active {
            transform: translateY(0);
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #6c757d;
            text-decoration: none;
            font-size: 0.9rem;
            transition: color 0.3s;
        }

        .back-link:hover {
            color: #dc3545;
        }

        @media (max-width: 992px) {
            .container {
                flex-direction: column;
                max-width: 600px;
            }

            .image-section {
                padding: 30px 20px;
                min-height: 200px;
            }

            .image-content h1 {
                font-size: 2.2rem;
            }

            .form-section {
                padding: 30px 25px;
            }
        }

        @media (max-width: 576px) {
            .form-grid {
                grid-template-columns: 1fr;
            }

            .image-content h1 {
                font-size: 1.8rem;
            }

            .image-content p {
                font-size: 1rem;
            }

            body {
                padding: 10px;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <!-- Section Image -->
    <div class="image-section">
        <div class="image-content">
            <h1>Modifier un Donneur</h1>
            <p>Mettez à jour les informations du donneur pour maintenir notre base de données à jour</p>
        </div>
    </div>

    <!-- Section Formulaire -->
    <div class="form-section">
        <div class="form-container">
            <h2>Modifier le Donneur</h2>
            <p class="subtitle">Veuillez modifier les informations nécessaires</p>

            <!-- Messages -->
            <c:if test="${not empty erreur}">
                <div class="message error">${erreur}</div>
            </c:if>
            <c:if test="${not empty message}">
                <div class="message success">${message}</div>
            </c:if>

            <form action="<c:url value='/donneur/modifier'/>" method="post">
                <input type="hidden" name="id" value="${donneur.id}" />

                <div class="form-grid">
                    <div class="form-group">
                        <label for="cin">CIN</label>
                        <input type="text" id="cin" name="cin" value="${donneur.cin}" required />
                    </div>

                    <div class="form-group">
                        <label for="telephone">Téléphone</label>
                        <input type="text" id="telephone" name="telephone" value="${donneur.telephone}" required />
                    </div>

                    <div class="form-group">
                        <label for="nom">Nom</label>
                        <input type="text" id="nom" name="nom" value="${donneur.nom}" required />
                    </div>

                    <div class="form-group">
                        <label for="prenom">Prénom</label>
                        <input type="text" id="prenom" name="prenom" value="${donneur.prenom}" required />
                    </div>

                    <div class="form-group">
                        <label for="dateNaissance">Date de Naissance</label>
                        <input type="date" id="dateNaissance" name="dateNaissance"
                               value="<fmt:formatDate value='${donneur.dateNaissance}' pattern='yyyy-MM-dd'/>" required />
                    </div>

                    <div class="form-group">
                        <label for="dateDernierDon">Date du Dernier Don</label>
                        <input type="date" id="dateDernierDon" name="dateDernierDon"
                               value="<fmt:formatDate value='${donneur.dateDernierDon}' pattern='yyyy-MM-dd'/>" />
                    </div>

                    <div class="form-group">
                        <label for="sexe">Sexe</label>
                        <select id="sexe" name="sexe" required>
                            <option value="">-- Choisir --</option>
                            <option value="HOMME" ${donneur.sexe == 'HOMME' ? 'selected' : ''}>Homme</option>
                            <option value="FEMME" ${donneur.sexe == 'FEMME' ? 'selected' : ''}>Femme</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="groupeSanguin">Groupe Sanguin</label>
                        <select id="groupeSanguin" name="groupeSanguin" required>
                            <option value="">-- Sélectionner --</option>
                            <c:forEach var="groupe" items="${['O_NEGATIF','O_POSITIF','A_NEGATIF','A_POSITIF','B_NEGATIF','B_POSITIF','AB_NEGATIF','AB_POSITIF']}">
                                <option value="${groupe}" ${donneur.groupeSanguin == groupe ? 'selected' : ''}>
                                    <c:choose>
                                        <c:when test="${groupe == 'O_NEGATIF'}">O-</c:when>
                                        <c:when test="${groupe == 'O_POSITIF'}">O+</c:when>
                                        <c:when test="${groupe == 'A_NEGATIF'}">A-</c:when>
                                        <c:when test="${groupe == 'A_POSITIF'}">A+</c:when>
                                        <c:when test="${groupe == 'B_NEGATIF'}">B-</c:when>
                                        <c:when test="${groupe == 'B_POSITIF'}">B+</c:when>
                                        <c:when test="${groupe == 'AB_NEGATIF'}">AB-</c:when>
                                        <c:when test="${groupe == 'AB_POSITIF'}">AB+</c:when>
                                        <c:otherwise>${groupe}</c:otherwise>
                                    </c:choose>
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group full-width">
                        <label for="poids">Poids (kg)</label>
                        <input type="number" step="0.1" id="poids" name="poids" value="${donneur.poids}" required />
                    </div>

                    <div class="checkbox-group full-width">
                        <input type="checkbox" id="contreindicattions" name="contreindicattions"
                        ${donneur.contreIndicattions ? 'checked' : ''} />
                        <label for="contreindicattions">Contre-indications</label>
                    </div>
                </div>

                <button type="submit" class="btn">Enregistrer les modifications</button>
<%--                <a href="<c:url value='/donneur/liste'/>" class="back-link">← Retour à la liste des donneurs</a>--%>
            </form>
        </div>
    </div>
</div>

</body>
</html>