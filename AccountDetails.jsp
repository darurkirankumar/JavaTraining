<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.mphasis.jsp.ConnectionHelper"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style>
table {
  width:90%;
}
th {
  text-align: center;
}
table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
}
th, td {
  padding: 15px;
  text-align: center;
}

#t01 th {
  background-color: black;
  color: white;
}

</style>
</head>
<body>
<jsp:include page="menu.jsp"/>
	<%
		String user=(String)session.getAttribute("user");
	
		Connection con = ConnectionHelper.getConnection();
		PreparedStatement pst;
		String cmd1 = "select count(*) cnt from TranBook where Username = ?"; 			
		pst = con.prepareStatement(cmd1);
		pst.setString(1,user);			
		ResultSet rs = pst.executeQuery();
		rs.next();
		int count = rs.getInt("cnt");
		if(count>0)
		{
		%>
		<br/>
		<h2>
		<% out.write("Issued books to "+user+"<br/><br/>");%>
		</h2>
		<hr>
		<%
		//	out.write("Issued books to "+user+"<br/><br/>");
			String cmd = "select * from TranBook where Username = ?"; 			
			pst = con.prepareStatement(cmd);
			pst.setString(1,user);			
			rs = pst.executeQuery();
		%>	
			
			
			<table border='3' align="center">
			<tr>
			<th>Book ID</th>
			<th>From Date</th>
			</tr>
		<%
			while(rs.next()){
		%>
				<tr>
				
				<td><%=rs.getInt("BookId") %></td>
				<td><%=rs.getDate("FromDate") %></td>
		<%	
			}
		%>
			</table>
		<%
		}
		else if(count==0){
		%>
		<br/><br/><br/>
		<%
			out.println("No books are issued to "+user);
		}
	%>
</body>
</html>