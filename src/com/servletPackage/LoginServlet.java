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
import java.sql.ResultSet;
import java.util.*;
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        String url = "jdbc:mysql://localhost:3306/login";
        String fname = request.getParameter("name");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String username = "root";
            String pass = "Appu@2005";
            Connection conn = DriverManager.getConnection(url, username, pass);

            String query = "SELECT first_name, id, type FROM users WHERE first_name = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, fname);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String name = rs.getString("first_name");
                int id = rs.getInt("id");
                String ty = rs.getString("type");

                request.getSession().setAttribute("name", name);
                request.getSession().setAttribute("id", id);
                request.getSession().setAttribute("type", ty);
                if(ty.charAt(0)=='L') {
                    response.sendRedirect("admin.jsp");
                } else {
                    response.sendRedirect("welcome.jsp");
                }

            } else {
                out.println("<script>");
                out.println("alert('Invalid username or password!');");
                out.println("window.location.href='index.html';");
                out.println("</script>");
            }

            conn.close();
        } catch (Exception e) {
            out.println("<script>");
            out.println("alert('Error: " + e.getMessage() + "');");
            out.println("window.location.href='index.html';");
            out.println("</script>");
        }
    }
}
