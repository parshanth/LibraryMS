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
            position: absolute;
            height: 50px;
            width: 110px;
            top: 50px;
            left: 48%;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .log button {
            background-color: #28a745;
        }
        .log a {
            color: #fff;
            font-size: 16px;
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
        	allign-items:center;
        	justify-items:center;
            position: absolute;
            left: 1000px;
            width: 459px;
            height: 460px;
            top: 25%;
            background-color: rgba(0, 0, 0, 0.5);
            padding: 15px;
            border-radius: 10px;
            color: white;
            font-size: 20px;
            font-weight: bold;
        }
        .borrow-status button {
            position: relative;
            top: 40px;
            left:0px;
        }
        .borrow-status h1 {
            position: relative;
            top: 0px;
            left:9px;
           
            font-size: 35px;
        }
        .bookname {
   			 font-family: 'Poppins', Arial, sans-serif;
   			 font-size: 18px;
    		 font-weight: bold;
   			 text-decoration: underline;
    		 color: #ffff;
    		 position:absolute;
    		 right:10px;
    		 letter-spacing: 0.5px;
     		 text-transform: capitalize;
		}

        .borrow-status input[name="return"] {
        	position:absolute;
        	top:200px;
        	left : 160px;
            background: linear-gradient(45deg, #28a745, #007b19);
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 18px;
            border-radius: 30px;
            cursor: pointer;
            margin-top: 15px;
            width: 30%;
            height:60px;
            font-size:30px;
        }
        .borrow-status input[type="submit"]:hover {
            background: linear-gradient(45deg, #196a29, #28a745);
        }
        .get{
        	position:absolute;
        	top:10px;
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
                PreparedStatement stmt = null, st = null;
                ResultSet rs = null, r = null;
                String borrowedStatus = "no";
                String book_name = "";
                String bk_name="";

                try {
                    String url = "jdbc:mysql://localhost:3306/login";
                    String username = "root";
                    String password = "Appu@2005";
                    
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, username, password);

                    Object userId = session.getAttribute("id");
                    if (userId != null) {
                        int id = Integer.parseInt(userId.toString());

                        String q = "SELECT book_id FROM users WHERE id=?";
                        st = conn.prepareStatement(q);
                        st.setInt(1, id);
                        r = st.executeQuery();

                        if (r.next()) {
                            bk_name = r.getString("book_id");
                            if (bk_name != null) {
                                borrowedStatus = "yes";
                            }
                        }

                        String newq = "SELECT book_name FROM books WHERE book_id=?";
                        st = conn.prepareStatement(newq);
                        st.setString(1, bk_name);
                        r = st.executeQuery();

                        if (r.next()) {
                            book_name = r.getString("book_name");
                        }
                    }

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
        <% if (borrowedStatus.equals("no")) { %>
            <h1 class="OnlyBorrow">You Can Borrow </h1><h2> Only One Book</h2>
            <button onclick="window.location.href='borrow.jsp'" class="get">Get a Book</button>
        <% } else { %>
        
            <h1>You Have Borrowed</h1>
            <h1 class="bookname"><%=bk_name +" - "+ book_name %></h1>
            <form action="" method="post">
        <input type="submit" name="return" value="Return">
    </form>

    <%	
   		 Object userId = session.getAttribute("id");

        if (request.getParameter("return") != null) {

            try {
                // Get the borrowed book for the user
                String fetchQuery = "SELECT book_id FROM users WHERE id = ?";
                PreparedStatement fetchStmt = conn.prepareStatement(fetchQuery);
                fetchStmt.setObject(1, userId);
                rs = fetchStmt.executeQuery();

                if (rs.next()) {
                    String bookId = rs.getString("book_id");

                    if (bookId != null) {
                        // Increase book availability
                        String updateQuery = "UPDATE books SET avail = avail + 1 WHERE book_id = ?";
                        PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
                        updateStmt.setString(1, bookId);
                        updateStmt.executeUpdate();

                        // Remove book reference from user
                        String deleteQuery = "UPDATE users SET book_id = NULL WHERE id = ?";
                        PreparedStatement deleteStmt = conn.prepareStatement(deleteQuery);
                        deleteStmt.setObject(1, userId);
                        deleteStmt.executeUpdate();

                        out.println("<script>alert('Book returned successfully!'); window.location='welcome.jsp';</script>");
                    }
                    else
                        out.println("<script>alert('You Don't Have Any Pending Books!'); window.location='welcome.jsp';</script>");
                } 
                 
            } catch (Exception e) {
                out.println("<script>alert('Error: " + e.getMessage() + "'); window.location='welcome.jsp?id=" + userId + "';</script>");
            }
        }
    %>
        <% } %>
    </div>
</body>
</html>
