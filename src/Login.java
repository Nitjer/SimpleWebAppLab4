import model.UserEntity;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

@WebServlet(name = "/Login", urlPatterns = "/Login")
public class Login extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String pass = request.getParameter("pass");
        UserEntity user = new UserEntity();
        user.setName(name);
        user.setPassword(pass);
        Connection conn;
        try {
             conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/webapp", "root", "1234");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        if (validate(name, pass,conn)) {
            String role = getRoleFromDB(name, pass);
            if ("admin".equals(role)) {
                response.sendRedirect("admin.jsp");
            } else {
                response.sendRedirect("department.jsp");
            }
        } else {
            response.sendRedirect("index.jsp");
        }
    }

    private boolean validate(String username, String password, Connection conn) {

            try (PreparedStatement statement = conn.prepareStatement("SELECT * FROM user WHERE name = ? AND password = ?")) {
                statement.setString(1, username);
                statement.setString(2, password);
                ResultSet result = statement.executeQuery();
                return result.next();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

    }

    private String getRoleFromDB(String username, String password) {
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/webapp", "root", "1234")) {
            try (PreparedStatement statement = conn.prepareStatement("SELECT role FROM user WHERE name = ? AND password = ?")) {
                statement.setString(1, username);
                statement.setString(2, password);
                ResultSet result = statement.executeQuery();
                if (result.next()) {
                    return result.getString("role");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}