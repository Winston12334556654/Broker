<%@ page import="app.model.Product" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/view/header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>

    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.7.0/main.min.css">
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <style>


        .navigation-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;

            z-index: 1000; /* Ensure the navigation is on top of other content */
            /* ... (other styles) ... */
        }
        /* CSS styling for the navbar page */
        body {
            background: linear-gradient(to bottom, #c6d2e1, #C4C1A0);

        }
        .container-fluid {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-family: 'EB Garamond', Arial, sans-serif;
            padding: 8px;
        }


        .navbar {
            width: 100%;
            padding: 20px;
            margin-left: auto;
            margin-right: auto;
            /* Replace 'path_to_your_image.jpg' with the path to your photo */
            background-size: cover;
            background-position: center;
            border-radius: 30px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s, background-color 0.3s, transform-origin 0.3s, scale 0.3s;
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            transform-origin: center;
        }

        .navbar:hover {
            background-color: #eef2f5;
            transform: scale(1.02);
        }

        .navbar-brand {
            color: #555;
            font-weight: bold;
            font-family: 'EB Garamond', Arial, sans-serif;
            margin-right: 20px;
            font-size: 26px; /* Adjust the value as per your requirement */
            text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.3); /* Add shadow effect */
            border: 2px solid #555; /* Add border */
            border-radius: 8px; /* Adjust the value as per your requirement */
            padding: 5px 10px; /* Adjust the value as per your requirement */
        }

        .search-form {
            display: flex;
            align-items: center;
            flex-grow: 1;
            margin-left: 20px; /* Adjust the value as per your requirement */
            margin-top: 20px; /* Adjust the value as per your requirement */
            margin-bottom: 10px; /* Adjust the value as per your requirement */
        }

        .search-input {
            padding: 5px;
            border: none;
            border-radius: 20px; /* Make it more circular */
            background-color: #ddd;
            flex-grow: 1;
            text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.3); /* Add shadow effect */
        }

        .search-button {
            padding: 5px 10px;
            background-color: #555;
            color: #fff;
            border: none;
            border-radius: 20px; /* Adjust the value as per your requirement */
            cursor: pointer;
            margin-left: 10px; /* Adjust the value as per your requirement */
        }

        .search-button:hover {
            background-color: #333;
        }

        .navbar-secondary {
            font-weight: bold;
            text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.3); /* Add shadow effect */
        }

        .shopping-cart-icon {
            font-size: 24px;
            color: #555;
            margin-right: 10px;
            text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.3); /* Add shadow effect */
        }

        /* Styles for the warning container */
        #warning-container-wrapper {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            backdrop-filter: blur(8px); /* Apply background blur effect */
            z-index: 9999;
        }

        #warning-container {
            background-color: white;
            padding: 60px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            position: relative;
            width: 80%;
            max-width: 800px;
            text-align: center;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        #warning-container::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(255, 255, 255, 0.5);
            z-index: -1;
        }

        .dialog-buttons {
            display: flex;
            justify-content: center;
            margin-top: 30px;
        }

        .dialog-button {
            margin: 0 10px;
            padding: 10px 20px;
            border: none;
            border-radius: 20px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease-in-out;
        }

        #dialog-yes {
            background-color: green;
            color: white;
        }

        #dialog-no {
            background-color: red;
            color: white;
        }

        .dialog-button:hover {
            background-color: #333;
        }

        /* Styles for the dropdown menu */
        .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropdown:hover .dropdown-content {
            display: block;
            opacity: 1;
            transform: translateY(0);
        }

        .dropdown-content {
            opacity: 0;
            transform: translateY(-10px);
            transition: opacity 0.3s ease-in-out, transform 0.3s ease-in-out;
            transition-delay: 0.2s;
            position: absolute;
            background-color: #f9f9f9;
            min-width: 120px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
        }

        .dropdown-content a {
            color: black;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
        }

        .dropdown-content a:hover {
            background-color: #f1f1f1;
        }

        .dropdown:hover .dropdown-content a {
            opacity: 1;
            transform: translateY(0);
        }

        .dropdown-content.fixed {
            position: fixed;
            left: 1300px;
            top: 80px;
        }



        * {box-sizing: border-box;}
        ul {list-style-type: none;}
        body {font-family: Verdana, sans-serif;}




        body {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;

        }



        .wrapper header {
            display: flex;
            align-items: center;
            padding: 25px 30px 10px;
            justify-content: space-between;

        }

        header .current-date {
            font-size: 1.45rem;
            font-weight: 500;

        }

        header .icons span {
            height: 38px;
            width: 38px;
            color: #C4C1A0;
            font-size: 1.9rem;
            margin: 0 1px;
            cursor: pointer;
            text-align: center;
            line-height: 38px;
            border-radius: 50%;
            background: #f2f2f2;

        }

        header .icons span:hover {
            background: #555555 ;
        }

        header .icons span:last-child {
            margin-right: -10px;
        }



        /*Sah mallll*/

        .calendar {
            position: fixed;
            top: 450px;
            right: 50px;
            width: 250px;
            border: 1px solid #ccc;

            font-family: Arial, sans-serif;
            box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.2);
            border-radius: 20px; /* Adjust border-radius value for curvy corners */
            transition: transform 0.3s, background-color 0.3s;
            background-color: #ffffff;
            margin-bottom: 200px;
        }

        .calendar:hover {
            transform: scale(1.07);
            background-color: white; /* Background color on hover */
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            background-color: #f0f0f0;
            border-top-left-radius: 20px; /* Apply border-radius to the top left and top right corners */
            border-top-right-radius: 20px;
        }

        .cells {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 2px;
            padding: 10px; /* Adjust padding as needed */
            background-color: #fff;
            border-bottom-left-radius: 20px; /* Apply border-radius to the bottom left and bottom right corners */
            border-bottom-right-radius: 20px;
        }

        .days {
            display: flex;
            justify-content: space-between;
            padding: 5px 0;

            font-weight: bold;
        }

        .day {
            flex: 1;
            text-align: center;
            padding: 5px 0;
        }




        footer {
            display: none;
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
            background-color: #f0f0f0;
            padding: 20px;
            box-sizing: border-box;
            z-index: 1002; /* Ensure the footer is above the video container */
        }


        /*Weather Widgets*/

        #weather-widget {
            position: fixed;
            top: 145px; /* Adjust vertical placement as needed */
            right: 5px; /* Adjust horizontal placement as needed */
            width: 200px; /* Adjust width as needed */
            padding: 10px;

            border-radius: 20px; /* Adjust border radius for rounded corners */
            transition: transform 0.3s, background-color 0.3s, border-radius 0.3s; /* Add transition effect */
        }

        #weather-widget:hover {

            border-radius: 30px; /* Slightly rounder corners on hover */
            transform: scale(1.07); /* Slightly scale up on hover */

        }



        body {
            margin: 0;
            padding: 0;

        }

        #video-container {
            position: absolute;
            top: 150px;
            left: 40px;
            width: 700px; /* Initial width */
            height: 270px; /* Initial height */
            background-color: black;
            overflow: hidden;
            border-radius: 20px; /* Curvy corners */
            transition: width 0.5s, height 0.5s, border-radius 0.5s; /* Transition effects */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5); /* Shadow */
        }

        #video-container:hover {
            width: 800px; /* Expanded width on hover */
            height: 350px; /* Expanded height on hover */
            border-radius: 50px; /* Adjust for a rounder corner effect */
        }

        #video-container video {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        @media only screen and (max-width: 768px) {
            /* Styles for screens with a maximum width of 768px */
            .navbar-brand {
                font-size: 20px;
                padding: 3px 8px;
            }

            .search-form {
                margin: 10px 0;
            }

            .search-input {
                padding: 3px;
            }

            .search-button {
                padding: 3px 8px;
                font-size: 12px;
            }
        }




        .product-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            margin: 20px auto;
        }

        .product {
            width: 30%; /* Adjust the width as needed */
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        .product-image {
            max-width: 100%;
            height: auto;
            border-radius: 5px;
        }

        h3 {
            margin-top: 10px;
            font-size: 1.2rem;
        }

        p {
            margin-top: 5px;
            font-weight: bold;
        }
        .product-container {
            margin-left: 60px;
            display: flex;
            flex-wrap: wrap;
            margin-top: 500px;
            max-width: 50%;
            transition: margin-left 0.3s ease, transform 0.3s ease; /* Add transition for both properties */
            background-color: #f5f5f5;
            border: 1px solid #ddd;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        /* Change the background color on hover and scale up */
        .product-container:hover {
            background-color: #e0e0e0;
            transform: scale(1.07);
        }

        .product {
            width: calc(50% - 10px); /* Set the width to 50% minus margin */
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.2);
            text-align: center;
        }
        .image-container {
            width: 100%; /* Ensure the container takes full width */
            height: 200px; /* Set the desired height for the image */
            overflow: hidden; /* Hide any overflowing content */
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* Style for the images */
        .product-image {
            max-width: 100%; /* Ensure the image doesn't exceed its container */
            max-height: 100%; /* Ensure the image doesn't exceed its container */
            object-fit: cover; /* Maintain aspect ratio and cover the container */
        }
    </style>
</head>
<body>
<div class="navigation-container">
    <div class="container-fluid">
        <nav class="navbar navbar-expand-lg navbar-light">
            <span class="navbar-brand"><b>Shal<i>Chate</i></b></span>
            <span class="navbar-secondary">Online Market Place</span>
            <form class="search-form">
                <input class="search-input" type="text" placeholder="Search......">
                <button class="search-button" type="submit">Search</button>
            </form>
            <button class="navbar-toggler" type="button" data-toggle="collapse"
                    data-target="#navbarSupportedContent"
                    aria-controls="navbarSupportedContent" aria-expanded="false"
                    aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#" style="text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.3);" id="shopping-cart-link">
                            <i class="fas fa-dollar-sign shopping-cart-icon"></i>

                        </a>
                    </li>

                    <li class="nav-item"><a class="nav-link" href="#"><b>About</b></a></li>
                    <li class="nav-item"><a class="nav-link" href="#"><b>Services</b></a></li>
                    <li class="nav-item"><a class="nav-link" href="#"><b>Contact</b></a></li>
                </ul>
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="/login">
                            Login
                        </a>
                    </li>
                </ul>
            </div>
        </nav>
    </div>
</div>

<div id="video-container">
    <video autoplay loop muted>
        <source src="../productImage/Ecommerce.mp4" type="video/mp4">
    </video>
</div>

<%--Help from backend --%>
<%@ page import="app.daos.ProductDao" %>
<% ProductDao dao = new ProductDao(); %>
<div class="product-container">
    <%-- Retrieve random products from your method --%>
    <%
        List<Product> randomProducts = dao.getRandomProducts(10); // Replace 'dao' with your actual DAO instance
        for (Product product : randomProducts) {
    %>
    <div class="product">
        <div class="image-container">
            <img src="../productImage/<%= product.getProduct_image_path() %>" alt="${product.getProductName()}" class="product-image">
        </div>
        <h3><%= product.getProductName() %></h3>
        <p><%= product.getPrice() %></p>
    </div>
    <%
        }
    %>
</div>

<div id="weather-widget">
    <div id="ww_bde42e5bd6608" v='1.3' loc='id' a='{"t":"horizontal","lang":"en","sl_lpl":1,"ids":["wl1812"],"font":"Arial","sl_ics":"one_a","sl_sot":"celsius","cl_bkg":"image","cl_font":"#FFFFFF","cl_cloud":"#FFFFFF","cl_persp":"#81D4FA","cl_sun":"#FFC107","cl_moon":"#FFC107","cl_thund":"#FF5722","el_nme":3}'>Weather Data Source: <a href="https://wetterlang.de/bangkok_wetter_30_tage/" id="ww_bde42e5bd6608_u" target="_blank">Wetter 30 tage Bangkok</a></div>
    <script async src="https://app2.weatherwidget.org/js/?id=ww_bde42e5bd6608"></script>
</div>





<!-- Replace this part with the dynamically generated calendar -->
<div class="calendar">
    <div class="header">
        <button id="prevMonth">&lt;</button>
        <h2 id="currentMonth">Month Year</h2>
        <button id="nextMonth">&gt;</button>
    </div>
    <div class="days">
        <div class="day">Sun</div>
        <div class="day">Mon</div>
        <div class="day">Tue</div>
        <div class="day">Wed</div>
        <div class="day">Thu</div>
        <div class="day">Fri</div>
        <div class="day">Sat</div>
    </div>
    <div class="cells" id="calendarCells"></div>
</div>

<!-- Your existing code for footer inclusion -->

<div id="warning-container-wrapper" style="display: none;">
    <div id="warning-container">
        <h2>Create An Account</h2>
        <p>If you want to sell, please create an account.</p>
        <div class="dialog-buttons">
            <button class="dialog-button" id="dialog-yes">Yes</button>
            <button class="dialog-button" id="dialog-no">No</button>
        </div>
    </div>
</div>
<script>
    // Add an event listener to ensure that the script runs after the DOM is fully loaded.
    document.addEventListener("DOMContentLoaded", function () {
        // JavaScript code to handle the shopping cart icon click event
        document.getElementById("shopping-cart-link").addEventListener("click", function(e) {
            e.preventDefault(); // Prevent the default link behavior

            // Show the warning container and blur the background
            document.getElementById("warning-container-wrapper").style.display = "flex";
            document.body.style.overflow = "hidden";
        });

        // Handle the "yes" button click event
        document.getElementById("dialog-yes").addEventListener("click", function() {
            // Redirect to the specified page
            window.location.href = "/customer/customerCreate";
        });

        // Handle the "no" button click event
        document.getElementById("dialog-no").addEventListener("click", function() {
            // Hide the warning container and remove the background blur
            document.getElementById("warning-container-wrapper").style.display = "none";
            document.body.style.overflow = "auto";
        });

        // JavaScript code for fetching and displaying weather information
        const apiKey = "5fc841b91f1262ca882e58e4e3052243"; // Replace with your actual API key
        const weatherUrl = `https://cors-anywhere.herokuapp.com/https://api.openweathermap.org/data/2.5/weather?q=Yangon&appid=${apiKey}`;

        fetch(weatherUrl, {
            headers: {
                'Origin': 'http://localhost:8081' // Replace with your actual localhost URL
            }
        })
            .then(response => response.json())
            .then(data => {
                document.getElementById('location').textContent = data.name;
                document.getElementById('temperature').textContent = (data.main.temp - 273.15).toFixed(2);
                document.getElementById('condition').textContent = data.weather[0].description;
            })
            .catch(error => console.error('Error fetching weather data:', error));
    });

    // Function definitions, fetch calls, and other JavaScript code...

    // Your existing code for the calendar starts here
    const prevMonthButton = document.getElementById("prevMonth");
    const nextMonthButton = document.getElementById("nextMonth");
    const currentMonthLabel = document.getElementById("currentMonth");
    const calendarCells = document.getElementById("calendarCells");

    let currentDate = new Date();
    let activeDate = null; // Store the active date

    function setActiveDate(year, month, day) {
        activeDate = new Date(year, month, day);
    }

    function renderCalendar(year, month) {
        const firstDay = new Date(year, month, 1);
        const lastDay = new Date(year, month + 1, 0);
        const daysInMonth = lastDay.getDate();

        currentMonthLabel.textContent = firstDay.toLocaleString("default", {
            month: "long",
        }) + " " + year;

        const startDate = new Date(year, month, 1 - firstDay.getDay());

        calendarCells.innerHTML = "";

        for (let i = 0; i < daysInMonth + startDate.getDay(); i++) {
            const cell = document.createElement("div");
            cell.classList.add("cell");
            if (i >= startDate.getDay()) {
                cell.textContent = startDate.getDate();
                if (
                    startDate.getDate() === currentDate.getDate() &&
                    startDate.getMonth() === currentDate.getMonth() &&
                    startDate.getFullYear() === currentDate.getFullYear()
                ) {
                    cell.classList.add("today");
                }
                if (activeDate &&
                    startDate.getDate() === activeDate.getDate() &&
                    startDate.getMonth() === activeDate.getMonth() &&
                    startDate.getFullYear() === activeDate.getFullYear()
                ) {
                    cell.classList.add("active-date");
                }
                startDate.setDate(startDate.getDate() + 1);
            }
            calendarCells.appendChild(cell);
        }
    }

    // Set the active date
    setActiveDate(2023, 7, 28); // Year, month (0-based), day

    // Render the initial calendar
    renderCalendar(currentDate.getFullYear(), currentDate.getMonth());

    prevMonthButton.addEventListener("click", () => {
        currentDate.setMonth(currentDate.getMonth() - 1);
        renderCalendar(currentDate.getFullYear(), currentDate.getMonth());
    });

    nextMonthButton.addEventListener("click", () => {
        currentDate.setMonth(currentDate.getMonth() + 1);
        renderCalendar(currentDate.getFullYear(), currentDate.getMonth());
    });

    window.addEventListener("scroll", function () {
        // Calculate how far the user has scrolled from the top
        let scrollDistance = window.scrollY;

        // Define a threshold for when to show the footer (adjust as needed)
        let showFooterThreshold = 300; // for example, show footer when user scrolls 300 pixels down

        // Get a reference to the footer element
        let footer = document.querySelector(".footer");

        // Check if the user has scrolled beyond the threshold
        if (scrollDistance > showFooterThreshold) {
            footer.style.display = "block"; // Show the footer
        } else {
            footer.style.display = "none"; // Hide the footer
        }
    });

    // Your existing code for the calendar ends here
</script>

</body>
</html>

<!-- Your footer content -->
<%@ include file="footer.jsp" %>








