package com.servletPackage;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/RetrieveDetails")
public class RetrieveDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection to database
            String username = "root";
            String pass= "Appu@2005";
            String url = "jdbc:mysql://localhost:3306/login";
            Connection conn = DriverManager.getConnection(url,username,pass);
            // Prepare SQL query to retrieve user details
            String sql = "SELECT id, first_name, last_name, email FROM users";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            // Display data in HTML format
            out.println("<html><body>");
            out.println("<h2>User Details</h2>");
            out.println("<table border='1'><tr><th>ID</th><th>First Name</th><th>Last Name</th><th>Email</th></tr>");

            while (rs.next()) {
                out.println("<tr><td>" + rs.getInt("id") + "</td>");
                out.println("<td>" + rs.getString("first_name") + "</td>");
                out.println("<td>" + rs.getString("last_name") + "</td>");
                out.println("<td>" + rs.getString("email") + "</td></tr>");
            }

            out.println("</table></body></html>");

            // Close resources
            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
            e.printStackTrace(out);
        }
    }
}
