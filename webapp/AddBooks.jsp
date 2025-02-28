<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Add Book</title>
    <script>
        function showSuccess() {
            alert("Book added successfully!");
            window.location.href = "admin.jsp";
        }
    </script>
    <style>
        body {
            font-family: "Poppins", sans-serif;
            background-image: url("images/bg.jpg");
            background-size: cover;
            background-repeat: no-repeat;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            overflow: hidden;
        }
        header {
            color: white;
            width: 100%;
            height: 17%;
            padding: 10px;
            position: fixed; 
            top: 0;
            background-color: rgba(0, 0, 0, 0.3); 
            border-bottom: 0.5px solid white; 
        }
        header h1 {
            position: relative;
            left: 20px;
            bottom:20px;
            font-size: 50px;

        }
        button {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 12px 20px;
            font-size: 16px;
            border-radius: 30px;
            cursor: pointer;
            height: 60px;
            width: 150px;
            transition: background-color 0.3s ease;
            font-weight: bold;
        }
        button:hover {
            background-color: #196a29;
        }
        .log {
            position: absolute;
            height: 40px;
            width: 100px;
            top: 50px;
            left: 78%;
        }
        header a {
            color: #fff;
            font-size: 14px;
            text-decoration: none;
        }
        .container {
            background-color: rgba(255, 255, 255, 0.2);
            padding: 25px;
            border-radius: 12px;
            width: 450px;
            text-align: center;
            position: absolute;
            top: 55%;
            transform: translateY(-50%);
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
        }
        .container h2 {
            color: white;
            font-size: 26px;
            margin-bottom: 20px;
        }
        .form-group {
            width: 100%;
            margin-bottom: 20px;
            text-align: left;
        }
        .form-group label {
            color: white;
            font-size: 18px;
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }
        .form-group input {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            border-radius: 5px;
            border: 1px solid #ccc;
            background-color: rgba(255, 255, 255, 0.8);
            outline: none;
        }
        .form-group input:focus {
            border-color: #196a29;
        }
        .submit-btn {
            background-color: #28a745;
            color: white;
            border-radius: 50px;
            padding: 12px;
            font-size: 18px;
            border: none;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.3s ease;
            font-weight: bold;
        }
        .submit-btn:hover {
            background-color: #196a29;
        }
        .info {
            width: 150px;
            border: 1px solid white;
            border-radius: 40px;
            background-color: rgba(71, 55, 212, 0.3); 
            padding: 10px;
            margin-right: 15px;
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            text-align: left;
        }
        .user-details {
            display: flex;
            align-items: center;
            margin: 9px;
            gap: 10px;
        }
        .user-details img {
            width: 30px;
            height: 30px;
        }
        .user-details p {
            margin-left: 4px;
        }
        .user-type {
            margin-top: 1px;
        }
        #ult {
            margin-left: 11px;
            font-size: 15px;
        }
        .back{
            background-color: #d9534f;
        	position:relative;
        	bottom:45px;
        	left:20px;
        	height:40px;
        	width:80px;
        }
    </style>
</head>
<body>
    <header>
        <h1>Admin Side</h1>
        <button class="back" onclick="window.location.href='admin.jsp'">back</button>
        
        <button class="log"><a href="index.html">Logout</a></button>
        <div class="info">
            <div class="user-details">
                <img src="images/user.png" alt="user">
                <p><%= session.getAttribute("name") %></p>
            </div>
            <p id="ult" class="user-type">User : <%= session.getAttribute("type") %></p>
        </div>
    </header>

    <div class="container">
        <h2>Add a New Book</h2>
        <form method="POST">
            <div class="form-group">
                <label>Book Name:</label>
                <input type="text" name="book_name" required>
            </div>
            <div class="form-group">
                <label>Author Name:</label>
                <input type="text" name="author_name" required>
            </div>
            <div class="form-group">
                <label>Availability:</label>
                <input type="number" name="avail" required>
            </div>
            <button type="submit" class="submit-btn">Add Book</button>
        </form>
    </div>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String bookName = request.getParameter("book_name");
            String authorName = request.getParameter("author_name");
            int avail = Integer.parseInt(request.getParameter("avail"));

            Connection conn = null;
            PreparedStatement stmt = null;

            try {
                String url = "jdbc:mysql://localhost:3306/login";
                String username = "root";
                String password = "Appu@2005";

                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, username, password);

                String query = "INSERT INTO books (book_name, author_name, avail) VALUES (?, ?, ?)";
                stmt = conn.prepareStatement(query);
                stmt.setString(1, bookName);
                stmt.setString(2, authorName);
                stmt.setInt(3, avail);

                int rows = stmt.executeUpdate();
                if (rows > 0) {
    %>
                    <script>showSuccess();</script>
    <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        }
    %>
</body>
</html>
