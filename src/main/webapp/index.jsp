<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Système de Gestion de Donneurs de Sang</title>
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

        /* HERO SECTION */
        .hero {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 60px 8%;
            flex-wrap: wrap;
            min-height: 90vh;
        }

        .text-content {
            max-width: 500px;
        }

        .text-content h1 {
            font-size: 3rem;
            line-height: 1.2;
            margin-bottom: 20px;
        }

        .text-content h1 span {
            color: #c62828;
        }

        .text-content p {
            font-size: 1.1rem;
            color: #555;
            margin-bottom: 30px;
        }

        .buttons {
            display: flex;
            gap: 15px;
        }

        button {
            border: none;
            cursor: pointer;
            font-size: 1rem;
            border-radius: 6px;
            padding: 12px 28px;
            transition: 0.3s;
        }

        .btn-dark {
            background-color: #0a2239;
            color: white;
        }

        .btn-light {
            background-color: #c62828;
            color: white;
        }

        .btn-dark:hover {
            background-color: #1a3c57;
        }

        .btn-light:hover {
            background-color: #b71c1c;
        }

        /* IMAGE CONTENT */
        .image-content {
            flex: 1;
            display: flex;
            justify-content: center;
        }

        .image-content img {
            max-width: 500px;
            width: 100%;
        }

        /* RESPONSIVE */
        @media (max-width: 900px) {
            .hero {
                flex-direction: column-reverse;
                text-align: center;
            }

            .text-content {
                margin-top: 40px;
            }

            nav ul {
                gap: 15px;
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

            .hero {
                padding: 40px 5%;
                min-height: auto;
            }

            .text-content h1 {
                font-size: 2.2rem;
            }

            .buttons {
                flex-direction: column;
                align-items: center;
            }

            button {
                width: 200px;
            }
        }

        @media (max-width: 480px) {
            .text-content h1 {
                font-size: 1.8rem;
            }

            .text-content p {
                font-size: 1rem;
            }

            nav ul {
                width: 180px;
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
            <li><a href="#">Fonctionnement</a></li>
            <li><a href="#">Portfolio</a></li>
            <li><a href="#">Tutoriel</a></li>
            <li><a href="#">Contactez-nous</a></li>
        </ul>
        <div class="burger-menu" id="burger-menu">
            <span></span>
            <span></span>
            <span></span>
        </div>
    </nav>
</header>

<section class="hero">
    <div class="text-content">
        <h1><span>Donneurs</span> de Sang</h1>
        <p>
            Une personne qui donne son sang pour transfusion. Il n'est pas permis de vendre son sang ou de payer le donneur de sang.
        </p>
        <div class="buttons">
            <button class="btn-dark">Soumettre</button>
            <button class="btn-light">Essayer maintenant</button>
        </div>
    </div>

    <div class="image-content">
        <img src="img.png" alt="Illustration de don de sang">
    </div>
</section>

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