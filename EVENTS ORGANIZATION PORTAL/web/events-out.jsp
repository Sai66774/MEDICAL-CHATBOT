<%-- 
    Document   : events-out.jsp
    Created on : 11 May, 2022, 5:08:38 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">

    <title>Anits College Events</title>
 
   <link rel="stylesheet" href="events-css.css">  
<style>
#back{
width:100px;
padding:7px;
font-size:16px;
font-width:600px;
border:none;
border-radius:10px;
background-color:#ff0000;
color:#fff;
cursor:pointer;
border:1px solid rgba(255,255,255,0.3);
box-shadow: 1px 1px 5px rgba(0,0,0,0.3);
text-align: center;   
}
</style>
</head>

<body style="overflow-x:auto;">
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
<div class="welcome-text">
    <center>
    <hr style="height: 2px;width:1300px;color: black;" color="white">
    <%
        try
        {
         Class.forName("oracle.jdbc.driver.OracleDriver");
         Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","password");
         Statement st=con.createStatement();
         ResultSet rs=st.executeQuery("select *from event");
         while(rs.next())
         {
         out.println("<a href=studentlogin.jsp onclick=login() class=btn btn-info role=button style=border:1;color: white; title='login to view the details'><img src=event.jpeg style=width:60px;height:30px;float:left;/><pre>Title:"+rs.getString(1)+" Date:"+rs.getString(7)+" End Date:"+rs.getString(3)+" NO.Of performance:"+rs.getString(6)+"            </pre>  </a>");
         }
         con.close();
        }
        catch(Exception e)
        {
            out.println(e);
        }
    %>
    </center></div>
</header>
</body>
</html>

