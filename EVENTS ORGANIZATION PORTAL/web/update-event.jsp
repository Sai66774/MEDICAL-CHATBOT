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
   </style>
</head>

<body>
    <header>
        <div class="wrapper">

            <p style="font-size:30px; float:left; color:white; padding:20px; align:left; font-family: Harrington;font-style: Bold Oblique;"> EVENTECH</p>
            <ul class="nav-area">
                <li><a href="events-organizer.jsp">Events</a></li>
                <li><a href="create-event.html">CREATE EVENT</a></li>
                <li><a href="stafflogin.jsp">Logout</a></li>
            </ul>
        </div>
<div class="welcome-text">
<fieldset style="margin: 50px; border-radius: 20px;padding: 10px;border: none; height: 600px; width: 200px;height:450px;">
    <h2>UPDATE EVENT HERE</h2>
    <form action="update-events.jsp">
        
        <%
            try
            {
                
                String s=request.getParameter("eventid");
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
                            <tr> <td>Event Name</td><td>:</td><td><input type="text" id="name" name="eventname" placeholder="Enter event name" value=<%=rs.getString(1)%>></td></tr>
		<tr><td>Registration Starting Date</td><td>:</td><td><input type="date" id="regdate" name="regdate" value=<%=rs.getString(2)%>></td></tr>
		<tr><td>Registration End Date</td><td>:</td><td><input type="date" id="enddate" name="enddate" value=<%=rs.getString(3)%>></td></tr>
		<tr><td>Eligibility</td><td>:</td><td><input type="text" id="eligibility" name="eligibility" value=<%=rs.getString(4)%>></td></tr>
		<tr><td>Type</td><td>:</td><td><input type="text" id="type" name="type" value=<%=rs.getString(5)%>></td></tr>
		<tr><td>No. of Students</td><td>:</td><td><input type="text" id="number" name="number" value=<%=rs.getString(6)%>></td></tr>
		<tr><td>Event Date</td><td>:</td><td><input type="date" id="date" name="date" value=<%=rs.getString(7)%>></td></tr>
		<tr><td>Department</td><td>:</td><td><input type="text" id="dept" name="dept" value=<%=rs.getString(8)%>></td></tr>
		<input type="hidden" id="eventid" name="eventid" value=<%=rs.getString(9)%>>
		
                          <tr><td><input type="submit" value="UPDATE" style="margin-left:70px;height: 30px; width: 100px; background-color: red;border-radius:20px; "></td><td></td><td><button onclick="window.location.href='/events-organizer.jsp'" style="height: 30px; width: 100px;color:white; background-color: red; border-radius:20px;font-size:17px;">BACK</button></td></tr>
	</table>
             <%
                 }
                 con.close();
                 }catch(Exception e)
                    {
                        out.println(e.getMessage());
                    }
                 
             %>
                    </form> 
</div>
</header>
</body>
</html>
