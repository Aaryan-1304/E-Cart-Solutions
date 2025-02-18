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

        .header {
            background: #28a745;
            color: white;
            padding: 1rem 0;
        }

        .header .container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 80%;
            margin: auto;
        }

        .header .logo {
            font-size: 2rem;
            font-weight: bolder;
            text-decoration: none;
            color: white;
        }

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

        .header .user-info {
            display: flex;
            align-items: center;
            flex-direction: column;
            justify-content: flex-end;
        }

        .header .user-name {
            color: white;
            font-size: 1rem;
            font-weight: bold;
        }

        .header .sign-out {
            margin-top: 0.5rem;
            color: white;
            text-decoration: none;
            background-color: rgba(255, 255, 255, 0.2);
            padding: 5px 10px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .header .sign-out:hover {
            background-color: rgba(255, 255, 255, 0.4);
        }
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
                    <li><a href="#"><i class="fas fa-search" href="${pageContext.request.contextPath}/"></i></a></li>
                    <li><a href="${pageContext.request.contextPath}/viewCart" class="nav-link">
                    <i class="fas fa-shopping-cart"></i> Cart
                </a></li>

                </ul>
                <div class="user-info">
                    <span class="user-name">Welcome, ${sessionScope.loggedInUser}!</span>
                    <a href="${pageContext.request.contextPath}/logout" class="sign-out">Sign Out</a>
                </div>
            </nav>
        </div>
    </header>
    <script type="text/javascript">
    // Prevent back button after logout
    window.onpageshow = function(event) {
        if (event.persisted) {
            // Page was loaded from cache (back/forward button)
            checkSession();
        }
    };
    
    // Function to check session status
    function checkSession() {
        fetch('${pageContext.request.contextPath}/session/check', {
            method: 'GET',
            credentials: 'same-origin'
        })
        .then(response => response.text())
        .then(data => {
            if (data === "No active session found" || data === "Session is invalid") {
                // Redirect to login page if no valid session
                window.location.href = '${pageContext.request.contextPath}/userLogin';
            }
        })
        .catch(error => {
            console.error('Error checking session:', error);
            // Redirect to login page on error
            window.location.href = '${pageContext.request.contextPath}/userLogin';
        });
    }
    
    // Disable browser back button after logout
    history.pushState(null, null, document.URL);
    window.addEventListener('popstate', function () {
        history.pushState(null, null, document.URL);
        checkSession();
    });
</script>
</body>
</html>
