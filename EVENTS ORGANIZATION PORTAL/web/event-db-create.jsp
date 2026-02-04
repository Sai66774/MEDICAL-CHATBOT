<%-- 
    Document   : event-db-create
    Created on : 9 May, 2022, 11:00:47 PM
    Author     : HP
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
           <title>Anits College Events</title>

<link rel="stylesheet" href="style1.css"></head>

<body>
  
  <header>
    <div class="wrapper">
       
<p style="font-size:30px; float:left; color:white; padding:20px; font-family: Harrington;font-style: Bold Oblique;"> EVENTECH</p>
<ul class="nav-area">
<li><a href="events-organizer">Events</a></li>
<li><a href="stafflogin.jsp">Lgout</a></li>
</ul>
</div>
<div class="welcome-text">
  
          <div class="loginbox">
        <%
            try
        {
         Class.forName("oracle.jdbc.driver.OracleDriver");
         Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE","system","password");
          PreparedStatement pre=con.prepareStatement("insert into event values(?,?,?,?,?,?,?,?,?)" );
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
                  out.println("<h2>Event id already taken</h2>");
                  out.println("<br><br><br><button onclick=history.back() style=width:100px;height:50px;background-color:red;border-radius:30px;>BACK</button>");
            }
            %>
    </div>
</div>
</header>

</body>
</html>
