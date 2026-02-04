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
           <title>Event Registration</title>

<link rel="stylesheet" href="style1.css"></head>

<body>
  
  <header>
    <div class="wrapper">
       
        <p style="font-size:30px; float:left; color:white; padding:20px;align:left; font-family: Harrington;font-style: Bold Oblique;"> EVENTECH</p>
        <ul class="nav-area">
            <li><a href="index.html">Home</a></li>
            <li><a href="stafflogin.jsp">Organizer Login</a></li>
            <li><a href="studentlogin.jsp">Student Login</a></li>
            <li><a href="contact.html">Contact Us</a></li>
            <li><a href="about.html">About</a></li>
        </ul>
    </div>
    <div class="welcome-text">
  
        <div class="loginbox">
        <%
            try
        {
         Class.forName("oracle.jdbc.driver.OracleDriver");
         Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE","system","password");
          PreparedStatement pre=con.prepareStatement("insert into event_reg values(?,?,?,?,?,?)" );
          Statement st=con.createStatement();
          Statement stt=con.createStatement();
          String id=request.getParameter("eventid");
          String name=request.getParameter("eventname");
          String us=request.getParameter("email");
          ResultSet rs=st.executeQuery("select *from student where email='"+us+"'");
          ResultSet r=stt.executeQuery("select *from event_reg where email='"+us+"' and eventid='"+id+"'");
         
          if(r.next())
          {
                  out.println("<center>you have already registered");
                  out.println("<br><br><br><button onclick=history.back() style=width:100px;height:50px;background-color:red;border-radius:30px;>BACK</button>");
          }else 
          if(rs.next())
          {
                    
                    pre.setString(1,id);
                    pre.setString(2,name);
                    pre.setString(3,rs.getString(1));
                    pre.setString(4,rs.getString(2));
                    pre.setString(5,rs.getString(3));
                    pre.setString(6,us);
                    int p=pre.executeUpdate();
                    if(p==1)
                    
                        response.sendRedirect("events-students.jsp?email="+us);
          }
        con.close();
        }catch(Exception e)
            {
                  out.println("<center>you have already registered");
                  out.println("<br><br><br><button onclick=history.back() style=width:100px;height:50px;background-color:red;border-radius:30px;>BACK</button>");
            }
            %>
        </div>
    </div>
</header>

</body>
</html>
