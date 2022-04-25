<%@page import="kr.or.ddit.kream.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	MemberVO memberVo = (MemberVO)session.getAttribute("memberVo");
	String mem_email = "null";
	String mem_auth = "";
	if(memberVo != null){ //로그인을 했다.
		mem_email = memberVo.getMem_email();
		mem_auth = memberVo.getAuthority();
	}
	
	
%>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
  <script src="../js/boardQnA.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style type="text/css">
#head{
	border: 1px solid;
}
.row{
	border: 0px solid;
}

.card-header {
    padding: 5px;
	background-color: white; 
}
.card{
	border: 0px;
}
.card-body{
	border: 0px solid;
}
.ans{
	border: 1px solid;
	padding: 4px 15px;
}
a {
    color: black;
    font-weight: bold;
}
#insertreply-btn{
	
	float: right;
}
.container{
	width:100%;
/* 	height:555px; */
	margin: 0px;
	margin-left:20px;
	padding: 0px;
}
#pagelist{
	margin-left:500px;
}
.form-inline{
	margin-left: 650px;
}
.form-control{
	width: 50px;
}
.rcode{
	margin-top: 30px;
}
.r1{
	float: right;
}
.r3{
	float: right;
}
#modifyform{
  	display: none;
}
.btns{
	float: right;
}
#nav{
	display: inline-block;
}

</style>

<script type="text/javascript">
currentPage = 1;
temp = 0;
reply={};
board_id="";
board={};
mem_email = "<%= mem_email %>";
mem_auth = "<%=mem_auth%>";

$(function() {
	wordvalue = "";
	typevalue = "";
	boardQnA();	
	
	//upadateBoardQnA
	
	
	
	//search검색  이벤트
	$(document).on('click','#search', function(){ //search 버튼을 눌렀을때
		typevalue= $('#stype option:selected').val().trim();
		wordvalue =$('#sword').val().trim();
		console.log(typevalue +" "+wordvalue);
		currentPage = 1;
		boardQnA();
	})
	 
	//page번호 클릭하는 이벤트
	$('#pagelist').on('click','.pnum',  function(){
		currentPage = $(this).text();
		boardQnA();
	})
	
	//이전버튼 클릭하는 이벤트
	$('#pagelist').on('click', '.prev', function(){
		currentPage = parseInt($('.pager a').first().text()) - 1;
		boardQnA();
	})
	//다음버튼 클릭하는 이벤트
	$('#pagelist').on('click', '.next', function(){
		currentPage = parseInt( $('.pager a').last().text()) + 1;
		boardQnA();
	})
	
	//공지사항 제목을 눌렀을때
	$(document).on('click','.select',function(){
		notice = $(this).attr('idx');
		boardQnANoticeDetail(notice);
	})
	
	//공지사항 detail에서 목록보기 클릭
	$(document).on('click','#boardQnAmain',function(){
		currentPage = 1;
		boardQnA();
	})
	
	
	$(document).on('click','.boardDetail',function(){
		board_id = $(this).attr('idx');
		temp=0;
		qnaDetail(board_id);
	})
	
	$(document).on('click','#upadateBoardQnA',function(){
		board_id = $(this).attr('idx');
		temp=1;
		qnaDetail(board_id);
	})
	
	$(document).on('click','#upadateOK',function(){
		board_id = $(this).attr('idx');
		board.board_id = board_id;
		board.board_title = $('.board_title').val();
		board.board_content = $('.board_content').val();
		upadateBoardQnA(board);
	})
	
	
	$(document).on('click','#deleteBoardQnA',function(){
		board_id = $(this).attr('idx');
		qnaDelete(board_id);
	})
	
	
	$(document).on('click','#insert',function(){
		if(mem_auth == "admin"){
			alert("사용자만 접근 가능합니다.");			
		}else{
			qnaInsertForm();
		}
	})
	
	$(document).on('click','#insertOK',function(){
		board.mem_email = mem_email;
		board.board_title = $('.board_title').val().replace(/"<br>"/g,"\n");
		board.board_content = $('.board_content').val().replace(/"<br>"/g,"\n");
		console.log(board.board_title+" "+board.board_content);
		qnaInsert(board);
	})
	
	
	
})
</script>

</head>
<body>

<div id="modifyform">
  	<textarea style="width: 100%; height: 4.25em; border: 0.5px solid lightgray; border-radius: 5px; resize: none;"></textarea><br>
  	<input class="btn btn-success" type="button" value="확인" id="btnok">
  	<input class="btn btn-danger" type="button" value="취소" id="btnreset">
  </div>
<h3>Q&A</h3><hr id="head">

<nav id="nav" class="navbar navbar-expand-sm  navbar-info">
	
	  
</nav>
  <!--list출력   -->
 <div class="container1">
 
 	
 
 </div>
 
 <!--list출력   -->
 <div class="container2">
 
 	
 
 </div>
 
 <!--page출력   -->
 <div id="pagelist">
 
 </div>
 
 
 
</body>
</html>