<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier Receveur</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            /*background: linear-gradient(135deg, #ff6b6b 0%, #ee5a52 100%);*/
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
            overflow: hidden;
            width: 100%;
            max-width: 800px;
        }

        .header {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
            padding: 30px;
            text-align: center;
            position: relative;
        }

        .header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" preserveAspectRatio="none"><path d="M0,0 L100,0 L100,100 Z" fill="rgba(255,255,255,0.1)"/></svg>');
            background-size: cover;
        }

        .header h2 {
            font-size: 2.2rem;
            font-weight: 600;
            margin-bottom: 8px;
            position: relative;
        }

        .header p {
            opacity: 0.9;
            font-size: 1rem;
            position: relative;
        }

        .header i {
            margin-right: 10px;
        }

        .form-content {
            padding: 40px;
        }

        .messages {
            margin-bottom: 25px;
        }

        .message {
            padding: 15px 20px;
            border-radius: 10px;
            text-align: center;
            font-weight: 500;
            margin-bottom: 15px;
            animation: slideIn 0.5s ease-out;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
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

        label i {
            margin-right: 8px;
            color: #dc3545;
            width: 16px;
        }

        input, select {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid #e9ecef;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: #f8f9fa;
            font-family: 'Poppins', sans-serif;
        }

        input:focus, select:focus {
            outline: none;
            border-color: #dc3545;
            background: white;
            box-shadow: 0 0 0 3px rgba(220, 53, 69, 0.1);
            transform: translateY(-2px);
        }

        .poches-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            background: linear-gradient(135deg, #fff5f5, #ffe6e6);
            padding: 25px;
            border-radius: 15px;
            border: 2px solid #f8d7da;
            margin: 20px 0;
            position: relative;
        }

        .poches-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(135deg, #dc3545, #c82333);
            border-radius: 15px 15px 0 0;
        }

        .poche-item {
            text-align: center;
            padding: 15px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(220, 53, 69, 0.1);
            transition: transform 0.3s ease;
        }

        .poche-item:hover {
            transform: translateY(-3px);
        }

        .poche-number {
            font-size: 2rem;
            font-weight: 700;
            color: #dc3545;
            margin-bottom: 5px;
        }

        .poche-label {
            font-size: 0.9rem;
            color: #6c757d;
            font-weight: 500;
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
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            position: relative;
            overflow: hidden;
        }

        .btn-submit::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }

        .btn-submit:hover {
            background: linear-gradient(135deg, #c82333, #bd2130);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(220, 53, 69, 0.4);
        }

        .btn-submit:hover::before {
            left: 100%;
        }

        .btn-submit:active {
            transform: translateY(0);
        }

        .blood-drop {
            position: absolute;
            width: 100px;
            height: 100px;
            background: radial-gradient(circle, rgba(220,53,69,0.1) 0%, transparent 70%);
            border-radius: 50%;
            animation: float 6s ease-in-out infinite;
        }

        .blood-drop-1 {
            top: 10%;
            left: 5%;
            animation-delay: 0s;
        }

        .blood-drop-2 {
            top: 60%;
            right: 8%;
            animation-delay: 2s;
        }

        .blood-drop-3 {
            bottom: 20%;
            left: 10%;
            animation-delay: 4s;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) scale(1); }
            50% { transform: translateY(-20px) scale(1.05); }
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

            .poches-container {
                grid-template-columns: 1fr;
                gap: 15px;
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

            .poche-number {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
<!-- Effets de gouttes de sang décoratives -->
<div class="blood-drop blood-drop-1"></div>
<div class="blood-drop blood-drop-2"></div>
<div class="blood-drop blood-drop-3"></div>

<div class="container">
    <div class="header">
        <h2><i class="fas fa-user-injured"></i>Modifier le Receveur</h2>
        <p>Mettez à jour les informations médicales du patient</p>
    </div>

    <div class="form-content">
        <div class="messages">
            <c:if test="${not empty erreur}">
                <div class="message erreur">
                    <i class="fas fa-exclamation-triangle"></i>
                        ${erreur}
                </div>
            </c:if>

            <c:if test="${not empty sessionScope.message}">
                <div class="message success">
                    <i class="fas fa-check-circle"></i>
                        ${sessionScope.message}
                </div>
                <c:remove var="message" scope="session"/>
            </c:if>
        </div>

        <form action="${pageContext.request.contextPath}/receveur/modifierReceveur" method="post">
            <input type="hidden" name="id" value="${receveur.id}" />

            <div class="form-grid">
                <div class="form-group">
                    <label><i class="fas fa-id-card"></i>CIN :</label>
                    <input type="text" name="cin" value="${receveur.cin}" required />
                </div>

                <div class="form-group">
                    <label><i class="fas fa-phone"></i>Téléphone :</label>
                    <input type="text" name="telephone" value="${receveur.telephone}" required />
                </div>

                <div class="form-group">
                    <label><i class="fas fa-user"></i>Nom :</label>
                    <input type="text" name="nom" value="${receveur.nom}" required />
                </div>

                <div class="form-group">
                    <label><i class="fas fa-user"></i>Prénom :</label>
                    <input type="text" name="prenom" value="${receveur.prenom}" required />
                </div>

                <div class="form-group">
                    <label><i class="fas fa-birthday-cake"></i>Date de naissance :</label>
                    <input type="date" name="dateNaissance" value="${dateNaissanceStr}" required />
                </div>

                <div class="form-group">
                    <label><i class="fas fa-venus-mars"></i>Sexe :</label>
                    <select name="sexe" required>
                        <c:forEach var="s" items="${listeSexes}">
                            <option value="${s}" <c:if test="${s.name() == sexeStr}">selected</c:if>>${s}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label><i class="fas fa-tint"></i>Groupe Sanguin :</label>
                    <select name="groupeSanguin" required>
                        <c:forEach var="g" items="${listeGroupes}">
                            <option value="${g}" <c:if test="${g.name() == groupeSanguinStr}">selected</c:if>>${g}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label><i class="fas fa-heartbeat"></i>Statut :</label>
                    <select name="statut" required>
                        <c:forEach var="status" items="${StatutReceveurValues}">
                            <option value="${status}" <c:if test="${status.name() == statutStr}">selected</c:if>>${status}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label><i class="fas fa-exclamation-triangle"></i>Urgence :</label>
                    <select name="urgence" required>
                        <c:forEach var="urg" items="${UrgenceReceveurValues}">
                            <option value="${urg}" <c:if test="${urg.name() == urgenceStr}">selected</c:if>>${urg}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="poches-container">
                <div class="poche-item">
                    <div class="poche-number">${receveur.nombrePochesRequises}</div>
                    <div class="poche-label">Poches Requises</div>
                </div>
                <div class="poche-item">
                    <div class="poche-number">${receveur.nombrePochesRecues}</div>
                    <div class="poche-label">Poches Reçues</div>
                </div>
            </div>

            <div class="form-grid">
                <div class="form-group">
                    <label><i class="fas fa-syringe"></i>Nombre de poches requises :</label>
                    <input type="number" name="nombrePochesRequises" value="${receveur.nombrePochesRequises}" min="1" required />
                </div>

                <div class="form-group">
                    <label><i class="fas fa-check-circle"></i>Nombre de poches reçues :</label>
                    <input type="number" name="nombrePochesRecues" value="${receveur.nombrePochesRecues}" min="0" required />
                </div>
            </div>

            <button type="submit" class="btn-submit">
                <i class="fas fa-save"></i>
                Enregistrer les modifications
            </button>
        </form>
    </div>
</div>
</body>
</html>