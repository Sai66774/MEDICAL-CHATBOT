<%-- 
    Document   : update-events
    Created on : 12 May, 2022, 5:16:59 PM
    Author     : HP
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
       input{
           border: none;
    border-bottom: 1px solid #fff;
   background: transparent;
    outline: none;
    height: 40px;
    color: #fff;
    font-size: 16px;
       }
       form{
           margin-left: 30px;
           margin-right: 30px;
           font-size: 20px;
       }
   </style>
</head>

<body>
    <header>
        <div class="wrapper">
            <p style="font-size:30px; float:left; color:white; padding:20px; align:left;font-family: Harrington;font-style: Bold Oblique;"> EVENTECH</p>
            <ul class="nav-area">
                <li><a href="index.html">Home</a></li>
                <li><a href="stafflogin.jsp">Organizer Login</a></li>
                <li><a href="studentlogin.jsp">Student Login</a></li>
                <li><a href="contact.html">Contact Us</a></li>
                <li><a href="about.html">About</a></li>
            </ul>
        </div>
<div class="welcome-text">
<fieldset style="margin: 50px; border-radius: 20px;padding: 10px;border: none; height: 600px; width: 200px;">
    <h2>UPDATE EVENT HERE</h2>
    <form action="events-updates.jsp">
        
        <%
          try
          {
                
          String s=request.getParameter("eventid");
          Class.forName("oracle.jdbc.driver.OracleDriver");
          Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","password");
          PreparedStatement pre=con.prepareStatement("update event set eventname=?, regdate=?, enddate=?, eligibility=?, type=?, stu_number=?, event_date=?, brach=?, eventid=? where eventid='"+s+"'");
          String eventid=request.getParameter("eventid");
          String eventname=request.getParameter("eventname");
          String branch=request.getParameter("dept");
          String regdate=request.getParameter("regdate");
          String enddate=request.getParameter("enddate");
          String eligibility=request.getParameter("eligibility");
          String type=request.getParameter("type");
          String number=request.getParameter("number");
          String date=request.getParameter("date");
          pre.setString(1,eventname);
          pre.setString(2,regdate);
          pre.setString(3,enddate);
          pre.setString(4,eligibility);
          pre.setString(5,type);
          pre.setString(6,number);
          pre.setString(7,date);
          pre.setString(8,branch);
          pre.setString(9,eventid);
          int l=pre.executeUpdate();
          con.close();
          if(l==1)
          response.sendRedirect("events-organizer.jsp");
        }
            catch(Exception e)
            {
                out.println(e);
                  out.println("<br><br><br><button onclick=history.back() style=width:100px;height:50px;background-color:red;border-radius:30px;>BACK</button>");
            }
            %>
    </div>
</div>
</header>

</body>
</html>