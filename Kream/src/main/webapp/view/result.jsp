<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 서블릿에서 공유데이터 꺼내기
	int res = (Integer)request.getAttribute("res");
	if(res>0){
		%>
		{
			"sw": "성공"
		}
		<%
	}else{
		%>
		{
			"sw": "실패"
		}
		<%
	}

%>
