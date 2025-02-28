package com.servletPackage;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String firstName = request.getParameter("firstName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String username = "root";
            String pass= "Appu@2005";
            String url = "jdbc:mysql://localhost:3306/login";
            Connection conn = DriverManager.getConnection(url,username,pass);
            String query = "INSERT INTO users (first_name, email, password) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, firstName);
            stmt.setString(2, email);
            stmt.setString(3, password);

            int result = stmt.executeUpdate();
            
            if (result > 0) {
                out.println("<script>alert('Registration Successful! Please login.'); window.location='index.html';</script>");
            }

            conn.close();
        } catch (Exception e) {
            out.println("<script>alert('Error: " + e.getMessage() + "'); window.location='register.html';</script>");
        }
        out.close();
    }
}
