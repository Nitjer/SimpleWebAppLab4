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

        ResultSet rs = stmt.executeQuery("SELECT * FROM student");
        out.println("<h2>Students</h2>");
        out.println("<table border='1'>");
        out.println("<tr><th>ID</th><th>Name</th></tr>");
        while (rs.next()) {
            out.println("<tr><td>" + rs.getInt("id_student") + "</td><td>" + rs.getString("name_student") + "</td></tr>");
        }
        out.println("</table>");

        rs = stmt.executeQuery("SELECT * FROM teacher");
        out.println("<h2>Teachers</h2>");
        out.println("<table border='1'>");
        out.println("<tr><th>ID</th><th>First Name</th><th>Last Name</th></tr>");
        while (rs.next()) {
            out.println("<tr><td>" + rs.getInt("id_teacher") + "</td><td>" + rs.getString("first_name") + "</td><td>" + rs.getString("last_name") + "</td></tr>");
        }
        out.println("</table>");

        rs = stmt.executeQuery("SELECT * FROM teacher_student");
        out.println("<h2>Teacher-Student</h2>");
        out.println("<table border='1'>");
        out.println("<tr><th>ID</th><th>Student ID</th><th>Teacher ID</th></tr>");
        while (rs.next()) {
            out.println("<tr><td>" + rs.getInt("id_teacher_student") + "</td><td>" + rs.getInt("id_student") + "</td><td>" + rs.getInt("id_teacher") + "</td></tr>");
        }
        out.println("</table>");

        conn.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
</body>
</html>