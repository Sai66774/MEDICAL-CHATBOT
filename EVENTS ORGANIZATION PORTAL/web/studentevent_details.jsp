<%-- 
    Document   : studentevent_details
    Created on : May 18, 2022, 2:47:50 PM
    Author     : DELL
--%>

<%-- 
    Document   : update-event
    Created on : 12 May, 2022, 4:32:31 PM
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
   </style>
</head>

<body>
    <header>
        <div class="wrapper">

            <p style="font-size:30px; float:left; color:white; padding:20px; align:left; font-family: Harrington;font-style: Bold Oblique;"> EVENTECH</p>
            <ul class="nav-area">
                <li><a href="events-students.jsp">Events</a></li>
                <li><a href="student-enroll.jsp">EVENTS ENROLL</a></li>
                <li><a href="studentlogin.jsp">Logout</a></li>
            </ul>
        </div>
<div class="welcome-text">
<fieldset style="margin: 50px; border-radius: 20px;padding: 10px;border: none; height: 400px; width: 400px;">
    <h2 style="padding:20px;">EVENT DETAILS </h2>
    <pre>
        
        <%
            try
            {
                
                String s=request.getParameter("eventid");
                String us=request.getParameter("email");
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","password");
            Statement st=con.createStatement();
            ResultSet rs=st.executeQuery("select *from event where eventid='"+s+"'");
            out.println("<center>");
            out.println("<table border=1>");
            while(rs.next())
            {
            %>
                        <table>
                            <tr> <td>Event Name</td><td>:</td><td><%=rs.getString(1)%></td></tr>
		<tr><td>Registration Starting Date</td><td>:</td><td><%=rs.getString(2)%></td></tr>
		<tr><td>Registration End Date</td><td>:</td><td><%=rs.getString(3)%></td></tr>
		<tr><td>Eligibility</td><td>:</td><td><%=rs.getString(4)%></td></tr>
		<tr><td>Type</td><td>:</td><td><%=rs.getString(5)%></td></tr>
		<tr><td>No. of Students</td><td>:</td><td><%=rs.getString(6)%></td></tr>
		<tr><td>Event Date</td><td>:</td><td><%=rs.getString(7)%></td></tr>
		<tr><td>Department</td><td>:</td><td><%=rs.getString(8)%></td></tr>
		<input type="hidden" id="eventid" name="eventid" value=<%=rs.getString(9)%>
		
                          <tr><td><%out.println("<button id=back style=margin-left:40px;height:30px;width:100px;background-color:red; height=50 onclick=window.location.href='event-reg.jsp?eventid="+rs.getString(9)+"&eventname="+rs.getString(1)+"&email="+us+"'>register</button>");%></td><td><button id="back" onclick="history.back()" style="height: 30px; width: 100px; background-color: red; ">back</button></td></tr>
	</table>
                            
             <%
                
                 }
                 con.close();
                 }catch(Exception e)
                    {
                        out.println(e.getMessage());
                    }
                 
             %>
    </pre>
</div>
</header>
</body>
</html>