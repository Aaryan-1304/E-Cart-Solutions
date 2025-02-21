<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Cart Header</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        /* HEADER CONTAINER */
        .header {
            background: #28a745;
            color: white;
            padding: 1rem 0;
            width: 100%;
        }

        .header .container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 90%;
            margin: auto;
        }

        /* LOGO */
        .header .logo {
            font-size: 2rem;
            font-weight: bold;
            text-decoration: none;
            color: white;
        }

        /* NAVIGATION BAR */
        .header .navbar {
            display: flex;
            align-items: center;
            gap: 2rem;
        }

        .header .nav {
            list-style: none;
            margin: 0;
            padding: 0;
            display: flex;
            gap: 1.5rem;
        }

        .header .nav li {
            margin: 0;
        }

        .header .nav a {
            color: white;
            text-decoration: none;
            font-size: 1rem;
            padding: 5px 10px;
            border-radius: 5px;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .header .nav a:hover {
            background-color: rgba(255, 255, 255, 0.2);
            transform: scale(1.05);
        }

        /* CART & USER INFO SECTION */
        .user-section {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }

        .user-name {
            color: white;
            font-size: 1rem;
            font-weight: bold;
        }

        .sign-out {
            color: white;
            text-decoration: none;
            background-color: rgba(255, 255, 255, 0.2);
            padding: 5px 10px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .sign-out:hover {
            background-color: rgba(255, 255, 255, 0.4);
        }

        /* FIX FOR NAVBAR BACKGROUND */
        .navbar {
            background-color: #28a745;
        }
    </style>
</head>
<body>
    <header class="header">
        <div class="container">
            <a href="/eCart/homepage" class="logo">E-Cart Solutions</a>
            
            <nav class="navbar">
                <ul class="nav">
                    <li><a href="/eCart/homepage">Home</a></li>
                    <li><a href="/eCart/allProducts">Shop</a></li>
                    <li><a href="/eCart/about">About</a></li>
                    <li><a href="/eCart/contact">Contact</a></li>
                    <li><a href="#"><i class="fas fa-search"></i></a></li>
                    <li><a href="${pageContext.request.contextPath}/viewCart">
                        <i class="fas fa-shopping-cart"></i> Cart
                    </a></li>
                </ul>
            </nav>

            <div class="user-section">
                <span class="user-name">Welcome, ${sessionScope.loggedInUser}!</span>
                <a href="${pageContext.request.contextPath}/logout" class="sign-out">Sign Out</a>
            </div>
        </div>
    </header>

    <script type="text/javascript">
        window.onpageshow = function(event) {
            if (event.persisted) {
                checkSession();
            }
        };

        function checkSession() {
            fetch('${pageContext.request.contextPath}/session/check', {
                method: 'GET',
                credentials: 'same-origin'
            })
            .then(response => response.text())
            .then(data => {
                if (data === "No active session found" || data === "Session is invalid") {
                    window.location.href = '${pageContext.request.contextPath}/userLogin';
                }
            })
            .catch(error => {
                console.error('Error checking session:', error);
                window.location.href = '${pageContext.request.contextPath}/userLogin';
            });
        }

//        history.pushState(null, null, document.URL);
//        window.addEventListener('popstate', function () {
//            history.pushState(null, null, document.URL);
//            checkSession();
//        });
    </script>
</body>
</html>
