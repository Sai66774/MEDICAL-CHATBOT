<%-- 
    Document   : events-unroll
    Created on : 16 May, 2022, 8:10:54 PM
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

<body>
    <header>
    <div class="wrapper">
<p style="font-size:30px; float:left; color:white; padding:20px; font-family: Harrington;font-style: Bold Oblique;"> EVENTECH</p>
<ul class="nav-area">
<li><a href="events-organizer.jsp">Home</a></li>
<li><a href="create-event.html">CREATE EVENT</a></li>
<li><a href="contact.html">Contact Us</a></li>
<li><a href="about.html">About</a></li>
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
            String mail=request.getParameter("email");
            String id=request.getParameter("eventid");
            int w=st.executeUpdate("delete from event_reg where email='"+mail+"' and eventid='"+id+"'");
            if(w!=0)
            {
                response.sendRedirect("student-enroll.jsp?enroll="+mail);
            }
            else
                out.println("<h2 style='color:red'>NOT DONE</h2>");
            out.println("<center><button onclick='history.back()' id=back style='width:100px;border-radius:  5px 15px 5px 15px; margin-top: 5px; padding:5px;'>BACK</button></a></center>");
            con.close();
            }
            catch(Exception e)
                    {
                        out.println(e.getMessage());
                    }
            %>
    </body>
</html>
