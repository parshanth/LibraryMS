<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Check Borrowed Books</title>
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
            width: 600px;
            text-align: center;
            position: absolute;
            top: 55%;
            transform: translateY(-50%);
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
            overflow-y: auto;
            max-height: 400px;
        }
        .container h2 {
            color: white;
            font-size: 26px;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        th, td {
            border: 1px solid white;
            padding: 10px;
            text-align: left;
            color: white;
        }
        th {
            background-color: rgba(0, 0, 0, 0.5);
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
        <h2>Borrowed Books</h2>
        <table>
            <tr>
                <th>User Name</th>
                <th>Book Name</th>
                <th>Author</th>
            </tr>

            <%
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

                try {
                    String url = "jdbc:mysql://localhost:3306/login";
                    String username = "root";
                    String password = "Appu@2005";

                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, username, password);

                    // SQL Query: Get books borrowed by users
                    String query = "SELECT u.first_name, b.book_name, b.author_name " +
                                   "FROM users u " +
                                   "JOIN books b ON u.book_id = b.book_id " +
                                   "WHERE u.book_id IS NOT NULL";

                    stmt = conn.prepareStatement(query);
                    rs = stmt.executeQuery();

                    while (rs.next()) {
            %>
                        <tr>
                            <td><%= rs.getString("first_name") %></td>
                            <td><%= rs.getString("book_name") %></td>
                            <td><%= rs.getString("author_name") %></td>
                        </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </table>
    </div>
</body>
</html>
