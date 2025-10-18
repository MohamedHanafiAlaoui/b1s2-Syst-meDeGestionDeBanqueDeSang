<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
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
            font-family: 'Poppins', sans-serif;
            /*background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);*/
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: 100%;
            max-width: 700px;
        }

        .header {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
            padding: 30px;
            text-align: center;
        }

        .header h2 {
            font-size: 2.2rem;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .header p {
            opacity: 0.9;
            font-size: 1rem;
        }

        .form-content {
            padding: 40px;
        }

        .messages {
            margin-bottom: 25px;
        }

        .message {
            padding: 15px;
            border-radius: 10px;
            text-align: center;
            font-weight: 500;
            margin-bottom: 15px;
            animation: slideIn 0.5s ease-out;
        }

        .erreur {
            background: linear-gradient(135deg, #f8d7da, #f5c6cb);
            color: #721c24;
            border-left: 4px solid #dc3545;
        }

        .success {
            background: linear-gradient(135deg, #d4edda, #c3e6cb);
            color: #155724;
            border-left: 4px solid #28a745;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .full-width {
            grid-column: 1 / -1;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #495057;
            font-size: 0.95rem;
        }

        input, select {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid #e9ecef;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        input:focus, select:focus {
            outline: none;
            border-color: #dc3545;
            background: white;
            box-shadow: 0 0 0 3px rgba(220, 53, 69, 0.1);
            transform: translateY(-2px);
        }

        .checkbox-group {
            display: flex;
            align-items: center;
            background: #f8f9fa;
            padding: 15px;
            border-radius: 10px;
            border: 2px solid #e9ecef;
            margin: 25px 0;
        }

        .checkbox-group input {
            width: auto;
            margin-right: 12px;
            transform: scale(1.2);
        }

        .checkbox-group label {
            margin-bottom: 0;
            font-weight: 500;
            color: #495057;
        }

        .btn-submit {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
            padding: 16px 32px;
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 100%;
            box-shadow: 0 4px 15px rgba(220, 53, 69, 0.3);
        }

        .btn-submit:hover {
            background: linear-gradient(135deg, #c82333, #bd2130);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(220, 53, 69, 0.4);
        }

        .btn-submit:active {
            transform: translateY(0);
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr;
            }

            .form-content {
                padding: 30px 25px;
            }

            .header {
                padding: 25px 20px;
            }

            .header h2 {
                font-size: 1.8rem;
            }
        }

        @media (max-width: 480px) {
            body {
                padding: 10px;
            }

            .form-content {
                padding: 20px 15px;
            }

            .header {
                padding: 20px 15px;
            }

            .header h2 {
                font-size: 1.5rem;
            }

            input, select {
                padding: 12px 14px;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <h2>Modifier le Donneur</h2>
        <p>Mettez à jour les informations du donneur</p>
    </div>

    <div class="form-content">
        <div class="messages">
            <c:if test="${not empty erreur}">
                <div class="message erreur">${erreur}</div>
            </c:if>

            <c:if test="${not empty sessionScope.message}">
                <div class="message success">${sessionScope.message}</div>
                <c:remove var="message" scope="session"/>
            </c:if>
        </div>

        <form action="${pageContext.request.contextPath}/donneur/modifierDono" method="post">
            <input type="hidden" name="id" value="${donneur.id}" />

            <div class="form-grid">
                <div class="form-group">
                    <label for="cin">CIN :</label>
                    <input type="text" id="cin" name="cin" value="${donneur.cin}" required />
                </div>

                <div class="form-group">
                    <label for="telephone">Téléphone :</label>
                    <input type="text" id="telephone" name="telephone" value="${donneur.telephone}" required />
                </div>

                <div class="form-group">
                    <label for="nom">Nom :</label>
                    <input type="text" id="nom" name="nom" value="${donneur.nom}" required />
                </div>

                <div class="form-group">
                    <label for="prenom">Prénom :</label>
                    <input type="text" id="prenom" name="prenom" value="${donneur.prenom}" required />
                </div>

                <div class="form-group">
                    <label for="dateNaissance">Date de naissance :</label>
                    <input type="date" id="dateNaissance" name="dateNaissance" value="${dateNaissanceStr}" required />
                </div>

                <div class="form-group">
                    <label for="poids">Poids (kg) :</label>
                    <input type="number" id="poids" name="poids" min="50" value="${donneur.poids}" required />
                </div>

                <div class="form-group">
                    <label for="sexe">Sexe :</label>
                    <select id="sexe" name="sexe" required>
                        <option value="">-- Sélectionner --</option>
                        <c:forEach var="s" items="${listeSexes}">
                            <option value="${s}" <c:if test="${s.name() == sexeStr}">selected</c:if>>${s}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label for="groupeSanguin">Groupe sanguin :</label>
                    <select id="groupeSanguin" name="groupeSanguin" required>
                        <option value="">-- Sélectionner --</option>
                        <c:forEach var="g" items="${listeGroupes}">
                            <option value="${g}" <c:if test="${g.name() == groupeSanguinStr}">selected</c:if>>${g}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group full-width">
                    <label for="dateDernierDon">Date du dernier don :</label>
                    <input type="date" id="dateDernierDon" name="dateDernierDon" value="${dateDernierDonStr}" />
                </div>

                <div class="checkbox-group full-width">
                    <input type="checkbox" id="contreindicattions" name="contreindicattions"
                           <c:if test="${donneur.contreIndicattions}">checked</c:if> />
                    <label for="contreindicattions">Contre-indications médicales</label>
                </div>
            </div>

            <button type="submit" class="btn-submit">Enregistrer les modifications</button>
        </form>
    </div>
</div>

</body>
</html>