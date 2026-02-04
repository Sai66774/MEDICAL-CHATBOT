<%-- 
    Document   : student-registration-DB
    Created on : 7 Apr, 2022, 9:21:29 PM
    Author     : SAI PRAKASH
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
            String p1=request.getParameter("password");
            String p2=request.getParameter("re-password");
            if(!p1.equals(p2))
            {
                response.sendRedirect("studentreg.html");
            }
                else{
         Class.forName("oracle.jdbc.driver.OracleDriver");
         Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","password");
          PreparedStatement pre=con.prepareStatement("insert into student values(?,?,?,?,?,?,?)" );
          String id=request.getParameter("no");
          String name=request.getParameter("name");
          String branch=request.getParameter("branch");
          String email=request.getParameter("email");
          String quest=request.getParameter("question");
          String ans=request.getParameter("answer");
          String password=request.getParameter("password");
          pre.setString(1,id);
          pre.setString(2,name);
          pre.setString(3,branch);
          pre.setString(4,email);
          pre.setString(5,password);
          pre.setString(6,quest);
          pre.setString(7,ans);
          int l=pre.executeUpdate();
          con.close();
          if(l==1)
          response.sendRedirect("studentlogin.jsp");
        }
        }
            catch(Exception e)
            {
                  out.println("<center>You already registered");
                  out.println("<br><br><br><button onclick=history.back() style=width:100px;height:50px;background-color:red;border-radius:30px;>BACK</button>");
            }
             
            %>
    </div>
</div>
</header>

</body>
</html>