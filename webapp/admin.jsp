<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Available Books</title>
   
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
        header h1{
        	position:relative;
        	left:20px;
			font-size:50px;
        	top:0px;
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
            left: 330px;
            bottom: 110px;
            font-size: 18px;
            font-family: "Poppins", sans-serif;
            font-weight: bold;
        }
        button:hover {
            background-color: #196a29;
        }
        .show{
        color:#ffff;
        }
        .show th,td{
        color:#ffff;
        }
        .show a{
        	text-decoration:none;
        }
        .log{
        	position:absolute;
        	height:40px;
        	width:100px;
        	top:50px;
        	left:78%;
        	
        }
        header a{
        	color:#ffff;
        	font-size:14px;
        	text-decoration:none;
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
        .place{
            
        	position:relative;
        	left:140px;
        	top:60px;
        	
        }
.place button {
    color: white;
    background-color: black;
    font-size: 25px;
    height: 100px;
    width: 180px;
    border: 2px solid #2C3E50;
    border-radius: 30px;
    cursor: pointer;
    font-weight: bold;
    transition: all 0.3s ease;
    box-shadow: 3px 3px 8px rgba(0, 0, 0, 0.2);
}

.place button:hover {
    background-color: #DEE2E6;
    color: #1A252F;
}

        </style>
<body>
    <header>
		<h1>Admin Side</h1>

	    <button class="log"><a href="index.html">Logout</a></button>
	
        <div class="info">
            <div class="user-details">
                <img src="images/user.png" alt="user">
                <p><%= session.getAttribute("name") %></p>
            </div>
            <p id="ult" class="user-type">User : <%= session.getAttribute("type") %></p>
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
		<div class="place">
				        <button onclick="window.location.href='AddBooks.jsp'">Add</button>
        <button onclick="window.location.href='Delete.jsp?id=<%= session.getAttribute("name") %>'">Delete</button>
        <button onclick="window.location.href='check.jsp?id=<%= session.getAttribute("name") %>'">Check</button>
        
		</div>
    
    
    
    
  
</body>
</html>
