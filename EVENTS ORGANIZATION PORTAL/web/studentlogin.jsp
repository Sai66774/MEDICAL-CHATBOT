<%-- 
    Document   : studentlogin
    Created on : 9 May, 2022, 12:17:59 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Login</title>
<link rel="stylesheet" href="style1.css"></head>
<body>
    <header>
        <div class="wrapper">   
            <p style="font-size:30px; float:left; color:white; padding:20px; align:left; font-family: Harrington;font-style: Bold Oblique;"> EVENTECH</p>
            <ul class="nav-area">
                <li><a href="index.html">Home</a></li>
                <li><a href="stafflogin.jsp">Organizer Login</a></li>
                <li><a id="current" href="studentlogin.jsp">Student Login</a></li>
                <li><a href="contact.html">Contact Us</a></li>
                <li><a href="about.html">About</a></li>
            </ul>
        </div>
    <div class="welcome-text">
        <div class="loginbox">
            <h2>Student Login Here</h2>
            <br>
            <form action=""> 
                <p>Mail</p>
                <input type="text" name="user" placeholder="Enter Username" id="a">
                <p>Password</p>
                <input type="password"  name="password" placeholder="Enter Password" id="b">
<%
            try 
           {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","password");
        Statement st=con.createStatement();
        String us=request.getParameter("user");
        String pa=request.getParameter("password");
        ResultSet rs=st.executeQuery("select *from student where email='"+us+"' and password='"+pa+"'"); 
        if(rs.next())
        {
            response.sendRedirect("events-students.jsp?email="+us);
        } 
        else if(!us.equals("null"))
        {
         out.println("<h6 style=color:red><div class=alert alert-danger><strong>WRONG USERNAME OR PASSWORD</strong></div></h6>");
        }
        con.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
            %>
                <input type="submit" value="Login" id="submit">
                <a href="forgotstudent.html">Lost your password?</a><br>
                <a href="studentreg.html">Don't have an account?</a>
            </form>
        </div>
    </div>
</header>

</body>
</html>
