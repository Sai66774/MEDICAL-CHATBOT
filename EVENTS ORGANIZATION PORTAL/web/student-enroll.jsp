<%-- 
    Document   : student-enroll
    Created on : 12 May, 2022, 7:30:54 PM
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
td{
    width: 200px;
}
</style>
</head>

<body>
    <header>
    <div class="wrapper">
        
        <p style="font-size:30px; float:left; color:white; padding:20px; font-family: Harrington;font-style: Bold Oblique;"> EVENTECH</p>
        <ul class="nav-area">
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
    <%
        try
        {
         Class.forName("oracle.jdbc.driver.OracleDriver");
         Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","password");
         Statement st=con.createStatement();
         String s=request.getParameter("enroll");
         ResultSet rs=st.executeQuery("select *from event_reg where email='"+s+"'");
         out.println("<table border=2 style=color:white;border-color:white;>");
         out.println("<tr><td>EVENT ID</td><td>EVENT NAME</td><td>UNROLL</td></tr>");
         while(rs.next())
         {
         out.println("<tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td><button id=back name=id style=width:150px; onclick=window.location.href='events-unroll.jsp?email="+s+"&eventid="+rs.getString(1)+"'>UNROLL</button></td></th></tr>");
         }
         
         out.println("</table><center><br><br><br><button onclick=window.location.href='events-students.jsp?email="+s+"' style=width:100px;height:50px;background-color:red;border-radius:30px;>BACK</button>");
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


