<%@ page import="app.daos.ProductDao" %>
<%@ page import="app.model.Product" %>
<%@ page import="java.util.List" %>
<%@ include file="/WEB-INF/view/header.jsp" %>
<%@ include file="/WEB-INF/view/navbar.jsp" %>

<html>
<head>
    <title>Product View</title>
    <!-- Add your CSS and other headers here -->
    <style>
        /* Add the CSS styling for the main container */
        .main-container {
            max-width: 2000px; /* Adjust the maximum width as needed */
            margin: 0 auto; /* Center the container horizontally */
            padding: 30px; /* Adjust padding as needed */
            height: 130vh; /* Set the height to viewport height (100% of the viewport height) */
            overflow: auto; /* Add scrollbars when content overflows */
            display: flex; /* Use flexbox to align the category boxes */
            flex-wrap: wrap; /* Allow wrapping to the next row if needed */
            justify-content: space-evenly; /* Distribute the category boxes evenly */
        }

         .category-box {
              width: 400px; /* Set the width of each box */
              height: 300px; /* Set the height of each box */
              background-color: #f1f1f1;
              padding: 20px;
              border-radius: 20px;
              margin: 20px;
              text-align: center; /* Center the content inside the boxes */
              box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2); /* Add a subtle shadow */
              transition: transform 0.3s, box-shadow 0.3s; /* Add transition for smooth effect */
       /* Replace with the path to your wood texture image */
              background-size: cover;
              background-position: center;
              background-repeat: no-repeat;
              color: #fff;
              font-size: 24px; /* Adjust font size as needed */
              font-weight: bold;
              display: flex; /* Use flexbox to align items */
              flex-direction: column; /* Stack text and image vertically */
              justify-content: center; /* Center content vertically */
              align-items: center; /* Center content horizontally */
          }

        .category-box img {
            max-width: 80%; /* Set the maximum width of the image */
            max-height: 60%; /* Set the maximum height of the image */
            margin-bottom: 10px; /* Add spacing between image and text */
        }

        /* Hover styles for the category boxes */
        .category-box:hover {
            transform: scale(1.05); /* Scale up the box on hover */
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }
        .header-image {
            display: flex;
            justify-content: center;
            align-items: center;
/*Image            !*background-image: url("../productImage/Category Image.webp"); !* Replace 'path_to_your_image.jpg' with the path to your image *!*!*/
            background-size: cover;
            background-position: center;
            height: 50px; /* Adjust the height as needed */
            margin-top: 15px; /* Adjust the top margin as needed */
            margin-bottom: 0px; /* Adjust the bottom margin as needed */
            color: #fff;
            font-size: 36px;
            font-weight: bold;
            text-align: center;
        }

    </style>
</head>
<body>
<div class="header-image">
    <p style="color: black;" >Product Categories</p>
</div>
<%
    ProductDao dao=new ProductDao();
    List<Product> products=dao.getAllProducts();
    request.setAttribute("pd",products);
%>

<%--these links are in javascript --%>
<div class="main-container">
    <div class="category-box" id="electronics-container">

        <h2 style="color: black;">Electronics</h2>
        <img src="../productImage/Electronic1.jpeg" alt="Electronics" />

    </div>

    <div class="category-box" id="fashion-container">
        <h2 style="color: black;" >Fashion & Apparel</h2>
        <img src="../productImage/Fashion1.jpg" alt="Fashion & Apparel" />
    </div>

    <div class="category-box" id="home-container">
        <h2 style="color: black;" >Home & Living</h2>
        <img src="../productImage/Home1.jpg.webp" alt="Home and Living" />

    </div>
    <div class="category-box" id="beauty-container">
        <h2 style="color: black;" >Beauty & Personal Care</h2>
        <img src="../productImage/Beauty1.jpg" alt="Beauty and Personal Care" />
    </div>


    <div class="category-box" id="fitness-container">
        <h2 style="color: black;">Health & Fitness</h2>
        <img src="../productImage/Health1.jpg" alt="Health and Fitness" />
    </div>


    <div class="category-box" id="food-container">
        <h2 style="color: black;">Food & Beverages</h2>
        <img src="../productImage/Food1.jpg" alt="Food and Beverage" />
    </div>


    <div class="category-box" id="tech-container">
        <h2 style="color: black;" >Tech Gadgets</h2>
        <img src="../productImage/Tech1.jpg" alt="Tech Gadgets" />
    </div>

    <div class="category-box" id="toys-container">
        <h2 style="color: black;" >Toys & Games</h2>
        <img src="../productImage/Toys1.png.webp" alt="Toys & Games" />
    </div>

    <div class="category-box" id="books-container">
        <h2 style="color: black;" >Books & Stationery</h2>
        <img src="../productImage/Books1.jpg.webp" alt="Books and Stationery" />
    </div>

    <div class="category-box" id="automotive-container">
        <h2  style="color: black;" >Automotive & Accessories</h2>
        <img src="../productImage/Automotive1.jpg" alt="Automotive & Accessories" />
    </div>

    <div class="category-box" id="Electrical-container">
        <h2  style="color: black;" >Electrical Appliances</h2>
        <img src="../productImage/Electrical1.jpg" alt="Electrical Appliances" />
    </div>

    <div class="category-box" id="sports-container">
        <h2 style="color: black;" >Sports</h2>
        <img src="../productImage/Sports1.jpg" alt="Sports" />
    </div>

    <div class="category-box" id="arts-container">
        <h2 style="color: black;" >Arts & Crafts</h2>
        <img src="../productImage/Arts1.jpg.webp" alt="Arts & Crafts" />
    </div>

    <div class="category-box" id="jewelry-container">
        <h2 style="color: black;" >Jewelry & Accessories</h2>
        <img src="../productImage/Jewelry1.jpeg" alt="Jewelry and Accessories" />
    </div>

    <div class="category-box" id="estate-container">
        <h2 style="color: black;" >Real Estates & Apartments</h2>
        <img src="../productImage/RealEstate1.jpg.webp" alt="Real Estate" />
    </div>

    <div class="category-box" id="baby-container">
        <h2 style="color: black;" >Baby & Kid Products</h2>
        <img src="../productImage/Baby1.jpg" alt="Baby and Kid Products" />
    </div>

    <div class="category-box" id="pet-container">
        <h2 style="color: black;" >Pet Supplies</h2>
        <img src="../productImage/Pet1.jpeg" alt="Pet Supplies" />
    </div>

    <div class="category-box" id="gardening-container">
        <h2 style="color: black;" >Gardening & OutDoor</h2>
        <img src="../productImage/Gardening1.jpg" alt="Gardening & OutDoor" />
    </div>

    <div class="category-box" id="collectibles-container">
        <h2 style="color: black;" >Collectibles & Antiques</h2>
        <img src="../productImage/Collectibles1.jpg" alt="Collectibles and Antiques" />
    </div>

    <div class="category-box" id="travel-container">
        <h2 style="color: black;" >Travel & Luggage</h2>
        <img src="../productImage/Travels1.jpg" alt="Travels " />
    </div>

    <div class="category-box" id="others-container">
        <h2 style="color: black;" >Others</h2>
        <img src="../productImage/Others1.png.webp" alt="Others" />
    </div>

</div>
<%--<div class="container">--%>

<%--    <table class="table">--%>
<%--        <thead class="thead-dark">--%>
<%--        <tr>--%>
<%--            <th scope="col">Id</th>--%>
<%--            <th scope="col">Name</th>--%>

<%--        </tr>--%>
<%--        </thead>--%>
<%--        <tbody>--%>
<%--        <c:forEach items="${pd}" var="stu">--%>
<%--            <tr>--%>
<%--                <td>${stu.getProduct_item_id()}</td>--%>
<%--                <td>${stu.getProductName()}</td>--%>


<%--            </tr>--%>
<%--        </c:forEach>--%>
<%--        </tbody>--%>
<%--    </table>--%>
<%--</div>--%>

<script>
    const electronicsContainer = document.getElementById('electronics-container');
    electronicsContainer.addEventListener('click', () => {
        window.location.href = '/categories/electronics';
    });

    const fashionContainer = document.getElementById('fashion-container');
    fashionContainer.addEventListener('click', () => {
        window.location.href = '/categories/fashion';
    });

    const homeContainer = document.getElementById('home-container');
    homeContainer.addEventListener('click', () => {
        window.location.href = '/categories/home';
    });

    const beautyContainer = document.getElementById('beauty-container');
    beautyContainer.addEventListener('click', () => {
        window.location.href = '/categories/beauty';
    });

    const fitnessContainer = document.getElementById('fitness-container');
    fitnessContainer.addEventListener('click', () => {
        window.location.href = '/categories/fitness';
    });

    const foodContainer = document.getElementById('food-container');
    foodContainer.addEventListener('click', () => {
        window.location.href = '/categories/food';
    });

    const techContainer = document.getElementById('tech-container');
    techContainer.addEventListener('click', () => {
        window.location.href = '/categories/tech';
    });

    const toysContainer = document.getElementById('toys-container');
    toysContainer.addEventListener('click', () => {
        window.location.href = '/categories/toys';
    });

    const booksContainer = document.getElementById('books-container');
    booksContainer.addEventListener('click', () => {
        window.location.href = '/categories/books';
    });

    const automotiveContainer = document.getElementById('automotive-container');
    automotiveContainer.addEventListener('click', () => {
        window.location.href = '/categories/automotive';
    });

    const sportsContainer = document.getElementById('sports-container');
    sportsContainer.addEventListener('click', () => {
        window.location.href = '/categories/sports';
    });

    const artsContainer = document.getElementById('arts-container');
    artsContainer.addEventListener('click', () => {
        window.location.href = '/categories/arts';
    });

    const jewelryContainer = document.getElementById('jewelry-container');
    jewelryContainer.addEventListener('click', () => {
        window.location.href = '/categories/jewelry';
    });

    const electricalContainer = document.getElementById('Electrical-container');
    electricalContainer.addEventListener('click', () => {
        window.location.href = '/categories/electrical';
    });
    const estateContainer = document.getElementById('estate-container');
    estateContainer.addEventListener('click', () => {
        window.location.href = '/categories/estate';
    });

    const babyContainer = document.getElementById('baby-container');
    babyContainer.addEventListener('click', () => {
        window.location.href = '/categories/baby';
    });

    const petContainer = document.getElementById('pet-container');
    petContainer.addEventListener('click', () => {
        window.location.href = '/categories/pet';
    });

    const gardeningContainer = document.getElementById('gardening-container');
    gardeningContainer.addEventListener('click', () => {
        window.location.href = '/categories/gardening';
    });

    const collectiblesContainer = document.getElementById('collectibles-container');
    collectiblesContainer.addEventListener('click', () => {
        window.location.href = '/categories/collectibles';
    });

    const travelContainer = document.getElementById('travel-container');
    travelContainer.addEventListener('click', () => {
        window.location.href = '/categories/travel&luggage';
    });

    const othersContainer = document.getElementById('others-container');
    othersContainer.addEventListener('click', () => {
        window.location.href = '/categories/other';
    });
</script>
</body>
</html>
<%@ include file="/WEB-INF/view/footer.jsp" %>



