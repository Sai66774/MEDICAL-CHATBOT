<%-- 
    Document   : event-particitants
    Created on : 12 May, 2022, 5:41:04 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">

    <title>Participation List</title>
 
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
<li><a href="events-organizer.jsp">Events</a></li>
<li><a href="create-event.html">CREATE EVENT</a></li>
<li><a href="stafflogin.jsp">Logout</a></li>
</ul>
</div>
<div class="welcome-text">
    <center>
    <hr style="height: 2px;width:1300px;color: black;" color="white">
    <br>
    <%
        try
        {
         Class.forName("oracle.jdbc.driver.OracleDriver");
         Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","password");
         Statement st=con.createStatement();
         String s=request.getParameter("eventid");
         ResultSet rs=st.executeQuery("select *from event_reg where eventid="+s);
         out.println("<table border=2 style=color:white;border-color:white;>");
         out.println("<tr><td>REGISTRATION ID</td><td>NAME</td><td>BRANCH</td><td>EMAIL</td></tr>");
         while(rs.next())
         {
         out.println("<tr><td>"+rs.getString(3)+"</td><td>"+rs.getString(4)+"</td><td>"+rs.getString(5)+"</td><td>"+rs.getString(6)+"</td></th></tr>");
         }
         con.close();
        }
        catch(Exception e)
        {
            out.println(e);
        }
    %>
</center>
</div>
</header>
</body>
</html>

