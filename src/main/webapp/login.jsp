<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
            max-width: 400px;
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
            <div class="main-title">Bienvenue</div>
            <div class="subtitle">Connectez-vous pour accéder à votre espace</div>
        </div>
    </div>

    <!-- Section Formulaire -->
    <div class="form-section">
        <div class="form-container">
            <h2>Login</h2>

            <c:if test="${not empty error}">
                <div class="error">${error}</div>
            </c:if>

            <form action="<%= request.getContextPath() %>/login" method="post">
                <div class="form-group">
                    <label for="cin">CIN:</label>
                    <input type="text" id="cin" name="cin" placeholder="AA123456" required>
                </div>

                <div class="form-group">
                    <label for="usertype">Type d'utilisateur:</label>
                    <select id="usertype" name="usertype" required>
                        <option value="">--Sélectionner--</option>
                        <option value="donneur">Donneur</option>
                        <option value="receveur">Receveur</option>
                    </select>
                </div>

                <button type="submit">Se Connecter</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>