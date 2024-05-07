<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Welcome</title>
</head>
<body>
<h1>Welcome!</h1>
<%
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/webapp", "root", "1234");

        Statement stmt = conn.createStatement();

        ResultSet rs = stmt.executeQuery("SELECT * FROM user");
        out.println("<h2>Users</h2>");
        out.println("<table border='1'>");
        out.println("<tr><th>ID</th><th>Name</th><th>Password</th><th>Email</th><th>Role</th></tr>");
        while (rs.next()) {
            out.println("<tr><td>" + rs.getInt("id_user") + "</td><td>" + rs.getString("name") + "</td><td>"+ rs.getString("password") + "</td><td>"+ rs.getString("email") + "</td><td>"+ rs.getString("role") +"</td></tr>");
        }
        out.println("</table>");

        conn.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
</body>
</html>