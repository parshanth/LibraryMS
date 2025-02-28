<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Return Book</title>
</head>
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
        border-bottom: 0.5px solid white; 
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
    .info:hover {
        background-color: rgba(11, 6, 53, 0.3);
    }
    button {
        background-color: #28a745;
        color: white;
        border: none;
        padding: 10px 20px;
        margin: 5px;
        font-size: 16px;
        border-radius: 30px;
        cursor: pointer;
        height: 80px;
        width: 120px;
        transition: background-color 0.3s ease;
        position: relative;
        left: 100px;
        top: 20px;
        font-size: 18px;
        font-family: "Poppins", sans-serif;
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
        color: #ffff;
        font-size: 14px;
        text-decoration: none;
    }
</style>
<body>
    <header>
        <button onclick="window.location.href='showBooks.jsp'">Show</button>
        <button onclick="window.location.href='borrowBook.jsp?id=<%= session.getAttribute("id") %>'">Borrow</button>
        <button onclick="window.location.href='returnBook.jsp?id=<%= session.getAttribute("id") %>'">Return</button>
        <button class="log"><a href="index.html">Logout</a></button>
        
        <div class="info">
            <div class="user-details">
                <img src="images/user.png" alt="user">
                <p><%= session.getAttribute("name") %></p>
            </div>
            <p id="ult" class="user-type">User: <%= session.getAttribute("type") %></p>
        </div>
    </header>
    
    <h2>Return a Book</h2>
    <form action="" method="post">
        <input type="hidden" name="userId" value="<%= request.getParameter("id") %>">
        <input type="submit" name="return" value="Return">
    </form>

    <%
        if (request.getParameter("return") != null) {
            String userId = request.getParameter("userId");
            String url = "jdbc:mysql://localhost:3306/login";
            String username = "root";
            String password = "Appu@2005";
            Connection conn = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, username, password);

                // Get the borrowed book for the user
                String fetchQuery = "SELECT book_id FROM users WHERE id = ?";
                PreparedStatement fetchStmt = conn.prepareStatement(fetchQuery);
                fetchStmt.setString(1, userId);
                ResultSet rs = fetchStmt.executeQuery();

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
                        deleteStmt.setString(1, userId);
                        deleteStmt.executeUpdate();

                        out.println("<script>alert('Book returned successfully!'); window.location='welcome.jsp';</script>");
                    }
                    else
                        out.println("<script>alert('You Don't Have Any Pending Books!'); window.location='showBooks.jsp';</script>");
                } 
                 
            } catch (Exception e) {
                out.println("<script>alert('Error: " + e.getMessage() + "'); window.location='returnBook.jsp?id=" + userId + "';</script>");
            }
        }
    %>
</body>
</html>



