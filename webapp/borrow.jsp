<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
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
            border-bottom: 0.5px solid blue;
        }
        header h1 {
            font-size: 50px;
            margin-left: 40px;
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
        .info:hover {
            background-color: rgba(11, 6, 53, 0.3);
        }
        button {
            background: linear-gradient(45deg, #28a745, #007b19);
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 30px;
            cursor: pointer;
            height: 100px;
            width: 180px;
            transition: background-color 0.3s ease;
            position: relative;
            top: 12px;
            left: 70px;
            font-size: 23px;
            font-family: "Poppins", sans-serif;
            font-weight: bold;
        }
        button:hover {
            background: linear-gradient(45deg, #196a29, #28a745);
        }
        .log {
            background: #136d25;
            position: absolute;
            height: 40px;
            width: 100px;
            top: 50px;
            left: 78%;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .log a {
            color: #fff;
            font-size: 14px;
            text-decoration: none;
            text-align: center;
            width: 100%;
        }
        .show {
            color: #fff;
            width: 900px;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.1);
            position: absolute;
            left: 0;
            top: 20%;
            height: 570px;
            max-height: 100vh;
            overflow-y: auto;
        }
        .show table {
            width: 100%;
            border-collapse: collapse;
            background-color: rgba(0, 0, 0, 0.5);
        }
        .show th, .show td {
            border: 2px solid #4CAF50;
            padding: 10px;
            text-align: center;
        }
        .show th {
            background-color: #28a745;
            color: white;
        }
        .show tr:nth-child(even) {
            background-color: rgba(255, 255, 255, 0.2);
        }
        .show tr:hover {
            background-color: rgba(255, 255, 255, 0.4);
        }
        .borrow-status {
            position: absolute;
            left: 80%;
            
            transform: translateX(-50%);
            width: 450px;
            height:250px;
            background-color: rgba(0, 0, 0, 0.5);
            padding: 20px;
            padding-bottom:20px;
            border-radius: 10px;
            color: white;
            font-size: 20px;
            font-weight: bold;
            text-align: center;
        }
        .borrow-status input[type="text"] {
            width: 50%;
            padding: 10px;
            border-radius: 20px;
            border: none;
            outline: none;
            text-align: center;
        }
        .borrow-status input[type="submit"] {
            background: linear-gradient(45deg, #28a745, #007b19);
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 18px;
            border-radius: 30px;
            cursor: pointer;
            margin-top: 15px;
            width: 40%;
        }
        .borrow-status input[type="submit"]:hover {
            background: linear-gradient(45deg, #196a29, #28a745);
        }
        .back{
        	height:50px;
        	width:120px;
        	position:absolute;
        	top:550px;
        	left:1170px; 
        }
    </style>
</head>
<body>
    <header>
        <h1>Library Management System</h1>
        <button class="log"><a href="index.html">Logout</a></button>
        <div class="info">
            <div class="user-details">
                <img src="images/user.png" alt="user">
                <p><%= session.getAttribute("name") %></p>
            </div>
            <p id="ult" class="user-type">User: <%= session.getAttribute("type") %></p>
        </div>
    </header>

    <div class="show">
        <h2>Available Books</h2>
        <table>
            <tr>
                <th>Book ID</th>
                <th>Book Name</th>
                <th>Author</th>
                <th>Availability</th>
            </tr>
            <%
                Connection conn = null;
                PreparedStatement stmt = null;
                PreparedStatement st = null;
                ResultSet rs = null;
                ResultSet r = null;
                String borrowedStatus = ""; // Variable to store status message

                try {
                    String url = "jdbc:mysql://localhost:3306/login";
                    String username = "root";
                    String password = "Appu@2005";
                    int id = Integer.parseInt(session.getAttribute("id").toString());
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, username, password);
                    
                    String query = "SELECT * FROM books";
                    stmt = conn.prepareStatement(query);
                    rs = stmt.executeQuery();

                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("book_id") %></td>
                <td><%= rs.getString("book_name") %></td>
                <td><%= rs.getString("author_name") %></td>
                <td><%= rs.getInt("avail") %></td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </table>
		</div>
        <div class="borrow-status">
            <h1>Enter Book Id</h1>
            
    <form action="" method="post">
        <input type="hidden" name="userId" value="<%= request.getParameter("id") %>">
       <input type="text" name="bookId"><br>
       <input type="submit" name="borrow" value="Borrow">
    </form>

    <%
		 Object userId = session.getAttribute("id");

        if (request.getParameter("borrow") != null) {
            String bookId = request.getParameter("bookId");
            

            try {
                String userBookQuery = "SELECT book_id FROM users WHERE id = ?";
                PreparedStatement userBookStmt = conn.prepareStatement(userBookQuery);
                userBookStmt.setObject(1, userId);
                ResultSet userBookRs = userBookStmt.executeQuery();

                if (userBookRs.next() && userBookRs.getString("book_id") != null) {
                    out.println("<script>alert('Maximum borrow limit reached!'); window.location='borrowBook.jsp?id=" + userId + "';</script>");
                } else {
                    // Check if the book is available
                    String checkBookQuery = "SELECT avail FROM books WHERE book_id = ?";
                    PreparedStatement checkBookStmt = conn.prepareStatement(checkBookQuery);
                    checkBookStmt.setString(1, bookId);
                    ResultSet checkBookRs = checkBookStmt.executeQuery();

                    if (checkBookRs.next() && checkBookRs.getInt("avail") > 0) {
                        // Update book availability (decrease count)
                        String updateBookQuery = "UPDATE books SET avail = avail - 1 WHERE book_id = ?";
                        PreparedStatement updateBookStmt = conn.prepareStatement(updateBookQuery);
                        updateBookStmt.setString(1, bookId);
                        updateBookStmt.executeUpdate();

                        // Assign the book to the user
                        String assignBookQuery = "UPDATE users SET book_id = ? WHERE id = ?";
                        PreparedStatement assignBookStmt = conn.prepareStatement(assignBookQuery);
                        assignBookStmt.setString(1, bookId);
                        assignBookStmt.setObject(2, userId);
                        assignBookStmt.executeUpdate();

                        out.println("<script>alert('Book borrowed successfully!'); window.location='welcome.jsp';</script>");
                    } else {
                        out.println("<script>alert('Book not available!'); window.location='welcome.jsp?id=" + userId + "';</script>");
                    }
                }
            } catch (Exception e) {
                out.println("<script>alert('Error: " + e.getMessage() + "'); window.location='welcome.jsp?id=" + userId + "';</script>");
            } 
        }
    %>
        </div>
        <button class="back" onclick="window.location.href='welcome.jsp'">Back</button>
    
</body>
</html>
