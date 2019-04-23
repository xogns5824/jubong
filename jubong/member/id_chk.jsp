<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
int idCnt = -1;

if (id != null) {
// 아이디 중복 검사를 실시 하였으면(처음 열린 상태가 아니면)
	Connection conn = null;
	String driver = "com.mysql.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/xogns3692";
	Statement stmt = null;
	ResultSet rs = null;
	String sql = "select count(*) from member_list where ml_id = '" + id + "'";
	// 사용자가 검색한 아이디와 동일한 아이디가 있는 지를 검사할 쿼리

	try {
		Class.forName(driver);
		conn = DriverManager.getConnection(url, "xogns3692", "skansmfqh29");
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		if (rs.next())	idCnt = rs.getInt(1);

	} catch(Exception e) {
		out.println("일시적인 장애가 생겼습니다. 잠시 후 [새로 고침]을 누르거나 첫화면으로 이동하세요.");
		e.printStackTrace();
	} finally {
		try {
			rs.close();
			stmt.close();
			conn.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
} else {
	id = "";
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>아이디 중복 체크</title>
<script>
<% if (idCnt == 0) { %>
// 사용할 수 있는 아이디일 경우에만 존재하는 함수
function useID() {
	opener.document.frm.id.value = document.frm_id.id.value;
	opener.document.frm.id.readOnly = true;
	self.close();
}
<% } %>
</script>
</head>
<body onload="window.resizeTo(280,200);">
<form name="frm_id" action="" method="get">
<table width="100%" cellpadding="5">
<tr><td align="center">
	<input type="text" name="id" size="15" value="<%=id %>" />
	<input type="submit" value="검색" />
<%
if (idCnt == 0) {		// 사용할 수 있는 아이디이면
	out.println("<br />사용할 수 있는 아이디 입니다.");
} else if (idCnt == 1) {	// 사용할 수 없는 아이디이면
	out.println("<br />사용할 수 없는 아이디 입니다.");
}
%>
</td></tr>
<tr><td align="center">
<%
if (idCnt == 0) {		// 사용할 수 있는 아이디이면
	out.println("<input type='button' value='아이디 사용' onclick='useID();' />");
}
%>
	<input type="reset" value="재입력" />&nbsp;&nbsp;
	<input type="button" value="닫 기" onclick="self.close();" />
</td></tr>
</table>
</form>
</body>
</html>





