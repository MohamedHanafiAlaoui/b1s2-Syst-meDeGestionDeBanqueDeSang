<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Ajouter un Donneur</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }

        .container {
            display: flex;
            min-height: 100vh;
        }

        .image-section {
            background-image: url("https://www.mcen.fr/uploads/2025/04/Image-don-de-sang-format-blog-scaled.jpg");
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
            position: relative;
            overflow: hidden;
        }

        .image-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(198, 40, 40, 0.7), rgba(211, 47, 47, 0.8));
        }

        .image-content {
            text-align: center;
            color: white;
            z-index: 2;
            position: relative;
            width: 100%;
            max-width: 500px;
        }

        .main-title {
            font-size: 3.5rem;
            font-weight: bold;
            margin-bottom: 30px;
            text-shadow: 3px 3px 6px rgba(0,0,0,0.5);
            line-height: 1.2;
        }

        .subtitle {
            font-size: 1.4rem;
            margin-bottom: 40px;
            opacity: 0.95;
            line-height: 1.5;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
        }

        .form-section {
            flex: 1;
            padding: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: white;
        }

        .form-container {
            max-width: 500px;
            width: 100%;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        h2 {
            color: #c62828;
            text-align: center;
            margin-bottom: 25px;
            font-size: 1.8rem;
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 10px;
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
            color: #333;
            font-size: 0.95rem;
        }

        input, select {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 1rem;
            transition: all 0.3s;
        }

        input:focus, select:focus {
            outline: none;
            border-color: #c62828;
            box-shadow: 0 0 0 2px rgba(198, 40, 40, 0.1);
            transform: translateY(-1px);
        }

        button {
            margin-top: 20px;
            padding: 12px 20px;
            background: linear-gradient(135deg, #c62828, #d32f2f);
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-size: 1.1rem;
            font-weight: bold;
            transition: all 0.3s;
        }

        button:hover {
            background: linear-gradient(135deg, #b71c1c, #c62828);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(198, 40, 40, 0.3);
        }

        .error {
            color: #d32f2f;
            font-weight: bold;
            margin-bottom: 15px;
            padding: 12px;
            background-color: #ffebee;
            border-radius: 5px;
            text-align: center;
            border-left: 4px solid #d32f2f;
        }

        .success {
            color: #2e7d32;
            font-weight: bold;
            margin-bottom: 15px;
            padding: 12px;
            background-color: #e8f5e9;
            border-radius: 5px;
            text-align: center;
            border-left: 4px solid #2e7d32;
        }

        .form-row {
            display: flex;
            gap: 15px;
        }

        .form-row .form-group {
            flex: 1;
        }

        @media (max-width: 768px) {
            .container {
                flex-direction: column;
            }

            .image-section {
                padding: 30px 20px;
                min-height: 300px;
            }

            .form-section {
                padding: 20px;
            }

            .form-row {
                flex-direction: column;
                gap: 0;
            }

            .main-title {
                font-size: 2.5rem;
            }

            .subtitle {
                font-size: 1.2rem;
            }
        }

        @media (max-width: 480px) {
            .main-title {
                font-size: 2rem;
            }

            .subtitle {
                font-size: 1.1rem;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Section Image -->
    <div class="image-section">
        <div class="image-content">
            <div class="main-title">Votre don fait la différence</div>
            <div class="subtitle">Rejoignez notre communauté de donneurs et participez à sauver des vies</div>
        </div>
    </div>

    <!-- Section Formulaire -->
    <div class="form-section">
        <div class="form-container">
            <h2>Ajouter un Donneur</h2>

            <%-- Affichage des erreurs ou message de succès --%>
            <% if (request.getAttribute("error") != null) { %>
            <div class="error"><%= request.getAttribute("error") %></div>
            <% } %>

            <% if (request.getAttribute("message") != null) { %>
            <div class="success"><%= request.getAttribute("message") %></div>
            <% } %>

            <form method="post" action="<%= request.getContextPath() %>/donneur/ajouterDonneur">
                <div class="form-row">
                    <div class="form-group">
                        <label>CIN:</label>
                        <input type="text" name="cin" required>
                    </div>
                    <div class="form-group">
                        <label>Téléphone:</label>
                        <input type="text" name="telephone" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Nom:</label>
                        <input type="text" name="nom" required>
                    </div>
                    <div class="form-group">
                        <label>Prénom:</label>
                        <input type="text" name="prenom" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Date de naissance:</label>
                        <input type="date" name="dateNaissance" required>
                    </div>
                    <div class="form-group">
                        <label>Date dernier don:</label>
                        <input type="date" name="dateDernierDon">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Sexe:</label>
                        <select name="sexe" required>
                            <option value="">--Sélectionner--</option>
                            <option value="MASCULIN">Masculin</option>
                            <option value="FEMININ">Féminin</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Groupe sanguin:</label>
                        <select name="groupeSanguin" required>
                            <option value="">--Sélectionner--</option>
                            <option value="O_NEGATIF">O-</option>
                            <option value="O_POSITIF">O+</option>
                            <option value="A_NEGATIF">A-</option>
                            <option value="A_POSITIF">A+</option>
                            <option value="B_NEGATIF">B-</option>
                            <option value="B_POSITIF">B+</option>
                            <option value="AB_NEGATIF">AB-</option>
                            <option value="AB_POSITIF">AB+</option>
                        </select>
                    </div>
                </div>

                <label>Poids (kg):</label>
                <input type="number" name="poids" step="0.1" required>

                <div style="margin-top: 15px;">
                    <input type="checkbox" name="contreindicattions" id="contreindicattions">
                    <label for="contreindicattions" style="display: inline-block; margin-top: 0; margin-left: 8px;">Contre-indications</label>
                </div>

                <button type="submit">Ajouter le donneur</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>