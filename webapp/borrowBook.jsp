<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Borrow Book</title>
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
    <div class="borrow_status"></div>
    <h2>Borrow a Book</h2>
    <form action="" method="post">
        <input type="hidden" name="userId" value="<%= request.getParameter("id") %>">
        Enter Book ID: <input type="text" name="bookId"><br>
        <input type="submit" name="borrow" value="Borrow">
    </form>

    <%
        if (request.getParameter("borrow") != null) {
            String userId = request.getParameter("userId");
            String bookId = request.getParameter("bookId");

            String url = "jdbc:mysql://localhost:3306/login";
            String username = "root";
            String password = "Appu@2005";
            Connection conn = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, username, password);

                // Check if the user has already borrowed a book
                String userBookQuery = "SELECT book_id FROM users WHERE id = ?";
                PreparedStatement userBookStmt = conn.prepareStatement(userBookQuery);
                userBookStmt.setString(1, userId);
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
                        assignBookStmt.setString(2, userId);
                        assignBookStmt.executeUpdate();

                        out.println("<script>alert('Book borrowed successfully!'); window.location='showBooks.jsp';</script>");
                    } else {
                        out.println("<script>alert('Book not available!'); window.location='borrowBook.jsp?id=" + userId + "';</script>");
                    }
                }
            } catch (Exception e) {
                out.println("<script>alert('Error: " + e.getMessage() + "'); window.location='borrowBook.jsp?id=" + userId + "';</script>");
            } 
        }
    %>
</body>
</html>
