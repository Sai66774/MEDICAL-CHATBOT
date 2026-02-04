<%-- 
    Document   : student-forgot
    Created on : 7 Apr, 2022, 9:51:31 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
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
            <fieldset style="margin: 50px; border-radius: 20px;padding: 50px; border:none;height:270px; width:500px;">
        <%
              try{
          Class.forName("oracle.jdbc.driver.OracleDriver");
          Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","password");
          String name=request.getParameter("name");
          String roll=request.getParameter("id");
          String quest=request.getParameter("question");
          String ans=request.getParameter("answer");
          Statement st=con.createStatement();
          ResultSet rs=st.executeQuery("select *from student where email='"+name+"' and id='"+roll+"' and question='"+quest+"' and answer='"+ans+"'");
          if(rs.next())
          {
             
              out.println("<center><h3>PASSWORD-CHANGE</h3><table><form action='student-update.jsp'>");
              out.println("<tr><td>Password</td><td>:</td><td><input type=password name=password></td></tr>");
              out.println("<tr><td>Re-Password</td><td>:</td><td><input type=password name=repassword></td></tr>");
              out.println("<tr><td colspan=3><input type=hidden value='"+roll+"' name=id></td></tr><tr></tr>");
              out.println("<tr><td><input type=submit onclick='corr()' value=UPDATE id=back style=width:100px;height:50px;background-color:red;border-radius:30px;></td></form><td><button onclick=history.back() style=width:100px;height:50px;background-color:red;border-radius:30px;>BACK</button></td></tr>");
              out.println("</table>");
          }
          else
          {
              out.println("<h2>DATA IS WRONG PLEASE CHECK IT AGAIN</h2><br>");
              out.println("<button onclick=history.back() style=width:100px;height:50px;background-color:red;border-radius:30px;>BACK</button>");
          }
          con.close();
          }catch(Exception e)
           {
                out.println(e.getMessage());
           }
        %>
            </fieldset>
</header>
</body>
</html>