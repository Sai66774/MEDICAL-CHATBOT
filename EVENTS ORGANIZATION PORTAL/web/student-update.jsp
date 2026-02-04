<%-- 
    Document   : student-update
    Created on : 7 Apr, 2022, 9:59:46 PM
    Author     : SAI PRAKASH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">

    <title>Anits College Events</title>
 
   <link rel="stylesheet" href="style1.css">    
   <style>
   td{
   color:white;
   }
   input[type="text"],input[type="date"]{
   border: none;
    border-bottom: 1px solid #fff;
   background: transparent;
    outline: none;
    height: 40px;
    color: #fff;
    font-size: 16px;
   }
  </style>
</head>

<body>
    <header>
    <div class="wrapper">
<p style="font-size:30px; float:left; color:white; padding:20px; font-family: Harrington;font-style: Bold Oblique;"> EVENTECH</p>
<ul class="nav-area">
<li><a href="index.html">Home</a></li>
<li><a href="stafflogin.jsp">Organizer Login</a></li>
<li><a href="studentlogin.jsp">Student Login</a></li>
<li><a href="contact.html">Contact Us</a></li>
<li><a href="about.html">About</a></li>
</ul>
</div>
<div class="center">
            <fieldset style="margin: 50px; border-radius: 20px;padding: 50px; border:none;">
                <%
                    
              try{
                  String p1=request.getParameter("password");
            String p2=request.getParameter("repassword");
            if(!p1.equals(p2))
            {
                response.sendRedirect("student-forgot.jsp");
            }
            else
            {
                                Class.forName("oracle.jdbc.driver.OracleDriver");
                                Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","password");
                                String roll=request.getParameter("id");
                                String password=request.getParameter("password");
                                PreparedStatement pre=con.prepareStatement("update student set password='"+password+"' where id='"+roll+"'");
                                int i=pre.executeUpdate();
                                out.println("updated");
                                if(i==1)
                                    response.sendRedirect("studentlogin.jsp");
            
                                con.close();
            }
                                }catch(Exception e)
                                {
                                    out.println(e.getMessage());
                                }
            
            %>
</header>
</body>
</html>