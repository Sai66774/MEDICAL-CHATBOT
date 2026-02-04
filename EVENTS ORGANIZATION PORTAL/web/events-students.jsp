<%-- 
    Document   : events-students
    Created on : 11 May, 2022, 10:39:48 PM
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
    margin-top: 18px;
    height: 50px;
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
a
{
    
}
</style>
</head>
<body style="overflow-x:auto;">
    <header>
    <div class="wrapper">
<p style="font-size:30px; float:left; color:white; padding:20px; font-family: Harrington;font-style: Bold Oblique;"> EVENTECH</p>
<ul class="nav-area">
    
    <li><a href="events-students.jsp" style="color:red;">Events</a></li>
    <% 
         String us=request.getParameter("email");
         out.println("<li><a href=student-enroll.jsp?enroll="+us+">events Enroll</a></li>");
    %>

<li><a href="studentlogin.jsp">Logout</a></li>
</ul>
</div>
<div class="welcome-text">
    <center>
    <hr style="height: 2px;width:1300px;color: black;" color="white">
    <br>
    <table border="0" >
    <%
        try
        {
         Class.forName("oracle.jdbc.driver.OracleDriver");
         Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE","system","password");
         Statement st=con.createStatement();
         ResultSet rs=st.executeQuery("select *from event");
         while(rs.next())
         {
             out.println("<tr><td style=padding_right:100px;><a href='studentevent_details.jsp?eventid="+rs.getString(9)+"&email="+us+"'><img src=event.jpeg style=width:60px;height:30px;float:left;/>Title:"+rs.getString(1)+" Date:"+rs.getString(7)+" End Date:"+rs.getString(3)+" NO.Of Students:"+rs.getString(6)+" </a></pre></td><td><button id=back height=50 onclick=window.location.href='event-reg.jsp?eventid="+rs.getString(9)+"&eventname="+rs.getString(1)+"&email="+us+"'>register</button></td></tr>");
         }
         con.close();
        }
        catch(Exception e)
        {
            out.println(e);
        }
    %>
    </table>
</center>
</div>
</header>
</body>
</html>