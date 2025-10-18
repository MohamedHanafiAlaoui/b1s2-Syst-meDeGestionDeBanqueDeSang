<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
            background-color: #f8fafc;
            color: #0a2239;
            line-height: 1.6;
        }

        /* HEADER */
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

        /* BURGER MENU */
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

        /* HERO SECTION */
        .hero {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 80px 8%;
            flex-wrap: wrap;
            min-height: 90vh;
            background: linear-gradient(135deg, #f8fafc 0%, #e8f0fe 100%);
        }

        .text-content {
            max-width: 550px;
            animation: fadeIn 1s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .text-content h1 {
            font-size: 3.2rem;
            line-height: 1.2;
            margin-bottom: 20px;
            font-weight: 700;
        }

        .text-content h1 span {
            color: #c62828;
            position: relative;
        }

        .text-content h1 span::after {
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

        .text-content p {
            font-size: 1.15rem;
            color: #4a5568;
            margin-bottom: 35px;
            line-height: 1.7;
        }

        .buttons {
            display: flex;
            gap: 15px;
        }

        .btn-dark, .btn-light {
            display: inline-block;
            border: none;
            cursor: pointer;
            font-size: 1rem;
            border-radius: 8px;
            padding: 14px 32px;
            transition: all 0.3s ease;
            font-weight: 600;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-decoration: none;
            text-align: center;
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
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(10, 34, 57, 0.2);
        }

        .btn-light:hover {
            background-color: #b71c1c;
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(198, 40, 40, 0.3);
        }

        /* SCHEMA CONTENT */
        .schema-content {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            animation: float 6s ease-in-out infinite;
        }

        @keyframes float {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-15px); }
            100% { transform: translateY(0px); }
        }

        /* SCHEMA STYLES */
        .schema {
            position: relative;
            background: white;
            width: 500px;
            height: 500px;
            border-radius: 20px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            overflow: hidden;
            transition: transform 0.3s ease;
        }

        .schema:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }

        .schema h2 {
            position: absolute;
            top: 20px;
            color: #c82333;
            font-size: 22px;
            letter-spacing: 0.5px;
            font-weight: 600;
            text-align: center;
            width: 100%;
        }

        .schema svg {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
        }

        .schema line {
            stroke: rgba(200, 35, 51, 0.3);
            stroke-width: 3;
            stroke-linecap: round;
            transition: all 0.3s ease;
        }

        .schema line.active {
            stroke: #c82333;
            stroke-width: 4;
            filter: drop-shadow(0 0 6px rgba(255, 0, 0, 0.5));
        }

        .schema-center {
            width: 100px;
            height: 100px;
            background: radial-gradient(circle, #d82323 20%, #a01212 90%);
            color: white;
            font-weight: bold;
            font-size: 26px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 0 25px rgba(220, 20, 60, 0.5);
            cursor: pointer;
            position: relative;
            z-index: 2;
            transition: all 0.3s ease;
        }

        .schema-center:hover {
            transform: scale(1.05);
            box-shadow: 0 0 35px rgba(220, 20, 60, 0.7);
        }

        .schema-node {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background-color: #f7fafc;
            color: #444;
            font-weight: 600;
            font-size: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            position: absolute;
            transition: all 0.4s ease;
            cursor: pointer;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border: 2px solid transparent;
        }

        .schema-node:hover {
            transform: scale(1.1);
            background-color: #ffebee;
            border-color: #ffcdd2;
        }

        .schema-node.active {
            background: linear-gradient(145deg, #ff1e1e, #a31212);
            color: white;
            box-shadow: 0 0 20px rgba(255, 0, 0, 0.5);
            transform: scale(1.15);
            border-color: #ff1e1e;
        }

        /* Positions circulaires pour le schéma */
        .schema-node[data-id="O+"] { top: 30px; left: 50%; transform: translate(-50%, 0); }
        .schema-node[data-id="O-"] { top: 100px; left: 390px; }
        .schema-node[data-id="A+"] { top: 50%; left: 450px; transform: translateY(-50%); }
        .schema-node[data-id="A-"] { bottom: 100px; left: 390px; }
        .schema-node[data-id="B+"] { bottom: 30px; left: 50%; transform: translate(-50%, 0); }
        .schema-node[data-id="B-"] { bottom: 100px; left: 60px; }
        .schema-node[data-id="AB+"] { top: 50%; left: 0; transform: translateY(-50%); }
        .schema-node[data-id="AB-"] { top: 100px; left: 60px; }

        /* RESPONSIVE */
        @media (max-width: 1100px) {
            .hero {
                padding: 60px 5%;
            }
        }

        @media (max-width: 900px) {
            .hero {
                flex-direction: column;
                text-align: center;
                padding: 60px 5%;
            }

            .text-content {
                margin-bottom: 40px;
                max-width: 100%;
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
                font-size: 1.5rem;
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
                width: 220px;
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
                font-size: 2.4rem;
            }

            .buttons {
                flex-direction: column;
                align-items: center;
            }

            .btn-dark, .btn-light {
                width: 220px;
            }

            .schema {
                width: 400px;
                height: 400px;
            }

            .schema-center {
                width: 80px;
                height: 80px;
                font-size: 22px;
            }

            .schema-node {
                width: 50px;
                height: 50px;
                font-size: 16px;
            }

            .schema-node[data-id="O-"] { top: 80px; left: 310px; }
            .schema-node[data-id="A+"] { top: 50%; left: 350px; transform: translateY(-50%); }
            .schema-node[data-id="A-"] { bottom: 80px; left: 310px; }
            .schema-node[data-id="B-"] { bottom: 80px; left: 50px; }
            .schema-node[data-id="AB+"] { top: 50%; left: 0; transform: translateY(-50%); }
            .schema-node[data-id="AB-"] { top: 80px; left: 50px; }
        }

        @media (max-width: 600px) {
            .schema {
                width: 350px;
                height: 350px;
            }

            .schema-center {
                width: 70px;
                height: 70px;
                font-size: 20px;
            }

            .schema-node {
                width: 45px;
                height: 45px;
                font-size: 14px;
            }

            .schema-node[data-id="O-"] { top: 70px; left: 270px; }
            .schema-node[data-id="A+"] { top: 50%; left: 310px; transform: translateY(-50%); }
            .schema-node[data-id="A-"] { bottom: 70px; left: 270px; }
            .schema-node[data-id="B-"] { bottom: 70px; left: 40px; }
            .schema-node[data-id="AB+"] { top: 50%; left: 0; transform: translateY(-50%); }
            .schema-node[data-id="AB-"] { top: 70px; left: 40px; }
        }

        @media (max-width: 480px) {
            .text-content h1 {
                font-size: 1.8rem;
            }

            .text-content p {
                font-size: 1rem;
            }

            nav ul {
                width: 200px;
            }

            .schema {
                width: 300px;
                height: 300px;
            }

            .schema-center {
                width: 60px;
                height: 60px;
                font-size: 18px;
            }

            .schema-node {
                width: 40px;
                height: 40px;
                font-size: 12px;
            }

            .schema-node[data-id="O-"] { top: 60px; left: 230px; }
            .schema-node[data-id="A+"] { top: 50%; left: 260px; transform: translateY(-50%); }
            .schema-node[data-id="A-"] { bottom: 60px; left: 230px; }
            .schema-node[data-id="B-"] { bottom: 60px; left: 40px; }
            .schema-node[data-id="AB+"] { top: 50%; left: 0; transform: translateY(-50%); }
            .schema-node[data-id="AB-"] { top: 60px; left: 40px; }
        }
    </style>
</head>
<body>
<header>
    <div class="logo">Banque<span>Sang</span></div>
    <nav>
        <ul id="nav-menu">
            <li><a href="${pageContext.request.contextPath}/receveur/liste_donneurs">Donneurs</a></li>
            <li><a href="${pageContext.request.contextPath}/donneur/liste_receveurs" >Receveurs</a></li>
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
        <h1><span>Banque</span> de Sang</h1>
        <p>
            Rejoignez notre communauté de donneurs de sang et sauvez des vies. Chaque don compte et peut faire la différence pour ceux qui en ont besoin.
        </p>
        <div class="buttons">
            <a class="btn-dark" href="${pageContext.request.contextPath}/donneur/ajouterDonneur.jsp">Devenir Donneur</a>
            <a class="btn-light" href="${pageContext.request.contextPath}/receveur/ajouterReceveur.jsp">Receveur</a>
        </div>
    </div>

    <div class="schema-content">
        <div class="schema">
            <svg id="schema-lines"></svg>

            <div class="schema-center" id="schema-center">A+</div>

            <div class="schema-node" data-id="O+">O+</div>
            <div class="schema-node" data-id="O-">O-</div>
            <div class="schema-node" data-id="A+">A+</div>
            <div class="schema-node" data-id="A-">A-</div>
            <div class="schema-node" data-id="B+">B+</div>
            <div class="schema-node" data-id="B-">B-</div>
            <div class="schema-node" data-id="AB+">AB+</div>
            <div class="schema-node" data-id="AB-">AB-</div>
        </div>
    </div>
</section>

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

    // Système de compatibilité sanguine
    const compatibilite = {
        "A+": ["A+", "A-", "O+", "O-"],
        "A-": ["A-", "O-"],
        "B+": ["B+", "B-", "O+", "O-"],
        "B-": ["B-", "O-"],
        "AB+": ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"],
        "AB-": ["A-", "B-", "AB-", "O-"],
        "O+": ["O+", "O-"],
        "O-": ["O-"]
    };

    const center = document.getElementById("schema-center");
    const nodes = document.querySelectorAll(".schema-node");
    const svg = document.getElementById("schema-lines");

    // Création des lignes reliant le centre aux noeuds
    const lines = {};
    nodes.forEach(node => {
        const line = document.createElementNS("http://www.w3.org/2000/svg", "line");
        line.classList.add("link");
        svg.appendChild(line);
        lines[node.dataset.id] = line;
    });

    function updateLines() {
        const centerRect = center.getBoundingClientRect();
        const cadreRect = svg.getBoundingClientRect();
        const cx = centerRect.left + centerRect.width / 2 - cadreRect.left;
        const cy = centerRect.top + centerRect.height / 2 - cadreRect.top;

        nodes.forEach(node => {
            const rect = node.getBoundingClientRect();
            const x = rect.left + rect.width / 2 - cadreRect.left;
            const y = rect.top + rect.height / 2 - cadreRect.top;
            const line = lines[node.dataset.id];
            line.setAttribute("x1", cx);
            line.setAttribute("y1", cy);
            line.setAttribute("x2", x);
            line.setAttribute("y2", y);
        });
    }

    window.addEventListener("resize", updateLines);
    updateLines();

    // Interaction
    nodes.forEach(node => {
        node.addEventListener("click", () => {
            const type = node.dataset.id;
            center.textContent = type;

            nodes.forEach(n => n.classList.remove("active"));
            document.querySelectorAll("line").forEach(l => l.classList.remove("active"));

            const compatibles = compatibilite[type];
            nodes.forEach(n => {
                if (compatibles.includes(n.dataset.id)) {
                    n.classList.add("active");
                    lines[n.dataset.id].classList.add("active");
                }
            });
        });
    });
</script>
</body>
</html>