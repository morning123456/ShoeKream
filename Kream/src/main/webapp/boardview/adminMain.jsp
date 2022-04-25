<%@page import="kr.or.ddit.kream.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%
	MemberVO memberVo = (MemberVO)session.getAttribute("memberVo");
%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel = "stylesheet" href = "/Kream/css/pagetopline.css">
<link rel = "stylesheet" href = "/Kream/css/prodSearchModal.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<style type="text/css">
/*nav, iframe 전체 크기 조정*/
#board{
	width: 1450px;
	height: 100%;
	margin: 0px auto;
}

/*nav*/
#leftnav{
	margin: 10px;
	float: left;
	height: auto;
	width: 13%;
}
#leftnav ul{
	list-style: none;
	padding: 5px;
}

#leftnav ul li:hover{
	background: #f2f4f7;
	font-weight: bold;
}

/*게시판 리스트, iframe*/
#boardList{
	margin-top: 20px;
	float: right;
	width: 85%;
	height: 1000px;
}
#main{
	height: 100%;
}
iframe {
	border: none;
	width: 100%;
	height: 100%;
}

header h1{
	display: flex;
	margin-left: 40px;
}

</style>
<script type="text/javascript">
$(function() {
	$('span').on('click', function() {
		$('iframe').attr('src', $(this).attr('id'))
	})
	
	$('#search_btn').on('click', function(){
      //검색한 값을 가져와 메서드로 보내주기
      input = $('#search_prod').val();
      
      //검색 내역 모달에 출력
      prodSearch(input);
   })
})
</script>
</head>
<body>
<!-- 이후 header추가 -->
<body style="padding-top: 100px;">
<!-- 헤더 -->
<div class="top_line fixed-top border-bottom text-end" style="height: 50px; display: flex; line-height: 50px; padding-right: 20px; background: white;">
	<ul class = "text-end" style="margin-left: auto;">
		<li><a href="<%= request.getContextPath() %>/boardview/adminMain.jsp">관리자</a></li>
<%
	if(memberVo == null){
%>
		<li id="login"><a href="<%= request.getContextPath() %>/member/loginForm.jsp">로그인</a></li>

		
<% }else{ %>
		<li id="logout"><a href="<%= request.getContextPath() %>/Logout.do">로그아웃</a></li>
<%
	}
%>
	</ul>
	
</div>
<div class="top_line fixed-top border-bottom text-end" style="height: 68px; align-items: center; display: flex; padding:0px 40px; background: white; margin-top: 50px;">
    <a href = "/Kream/prodview/prodList.jsp">
   		<h3 style=" margin:0px 0px; align-content: center; font-style: oblique; font-weight: 900;">
   		SHOEKREAM
   		</h3>
   </a>
   <div class="gnb_area">
      <nav class="gnb">
         <ul class="gnb_list">
            <li class="gnb_item">
               <a  class="gnb_link" href="http://localhost/Kream/prodview/prodReviewPage.jsp">STYLE</a>
            </li>
            <li class="gnb_item" style="margin-left: 30px;">
               <a class="gnb_link" href="http://localhost/Kream/prodview/prodList.jsp">SHOP</a>
            </li>
            <li class="gnb_item search" style="margin-left: 30px;">
               <a href = "#" class="gnb_link" id = "search_modal">SEARCH</a>
            </li>
         </ul>
      </nav>
      <div></div>
   </div>
</div>
<hr><br>
<div id="board">
	<div id="leftnav">
		<h1>관리</h1>
		<ul>
			<li><span id="./memberManagement.jsp">회원관리</span></li><hr>
			<li><span id="./noticeList.jsp">공지사항</span></li><hr>
			<li><span id="./qnaList.jsp">Q&A</span></li><hr>
<!-- 			<li><span id="./memberManagement.jsp">물품등록</span></li><hr> -->
		</ul>
	</div>

	<div id="boardList">
		<article id="main">
			<iframe src="./memberManagement.jsp" name="ifr"></iframe>
		</article>
	</div>
</div>


<!--바디 끝나기 전에 넣어주세요-->
<!-- search 클릭시 모달만들기 -->
<div class = "modal" id = "searchmodal" >
	<div class="modal-dialog">
    	<div class="modal-content search_modal_content">
      
	        <!-- Modal Header -->
	        <div class="modal-header">
	          <h4 class="modal-title">상품 검색</h4>
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	        </div>
        
        	<!-- Modal body -->
        	<div class="modal-body">
        		<div class = "modal_select_area_search" showlayer = "true">
        			<input type = "text" id = "search_prod" name = "search_prod">
        			<input type = "button" id = "search_btn" name = "search_btn" value = "검색">
        		</div>
        		<div id = "prod_search_list">
        		</div>
        	</div>
        	        <!-- Modal footer -->
	        <div class="modal-footer">
	          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	        </div>
		</div>
	</div>
</div>
<!-- search 모달 끝-->

</body>
</html>