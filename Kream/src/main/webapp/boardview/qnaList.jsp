<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
  <script src="../js/adminQnA.js"></script>
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
	margin-left: 700px;
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
</style>

<script type="text/javascript">
currentPage = 1;
admin={};
temp = 0;
reply={};
board_id="";
creply=12;
$(function() {
	wordvalue = "";
	typevalue = "";
	qnaList();
	
	//search검색  이벤트
	$('#search').on('click', function(){
		typevalue= $('#stype option:selected').val().trim();
		wordvalue =$('#sword').val().trim();
		console.log(typevalue);
		console.log(wordvalue);
		currentPage = 1;
		qnaList();
		
	})
	
	//page번호 클릭하는 이벤트
	$('#pagelist').on('click','.pnum',  function(){
		//alert( $(this).text());
		
		currentPage = $(this).text();
		qnaList();
	})
	
	//이전버튼 클릭하는 이벤트
	$('#pagelist').on('click', '.prev', function(){
		currentPage = parseInt($('.pager a').first().text()) - 1;
		
		alert(currentPage);
		
		qnaList();
	})
	//다음버튼 클릭하는 이벤트
	$('#pagelist').on('click', '.next', function(){
		currentPage = parseInt( $('.pager a').last().text()) + 1;
		
		alert(currentPage)
		
		qnaList();
	})
	
	//acordion 클릭시 (글 내용 출력, 댓글 출력)
	$('.container').on('click', '.action', function(){
		actionName =  $(this).attr('name');
		actionIdx  = $(this).attr('idx');
		
		if(actionName=="title"){
			//alert(actionIdx + "번의 댓글을 출력합니다 ");
			//댓글 리스트 출력
			board_id = actionIdx;
			replyList(this);
		}
		if(actionName=="replyinsert"){
			//댓글 달기 버튼을 눌렀을 때
			reply.board_id = actionIdx;
			reply.rep_content = $('#insertText').val().replace(/"<br>"/g,"\n");
			
			console.log(reply.board_id);
			console.log(reply.rep_content);
			//board_id, rep_content 가져오기
			
			replyinsert(this);
			$('#insertText').val("");
		}
		if(actionName=="r_modify"){
			//댓글 수정 버튼을 눌렀을때
			
			//댓글 수정폼의 css속성 값을 가져온다.
			if($('#modifyform').css('display')!="none"){
				//다른곳에 수정폼이 이미 열려있다.
				//수정폼을 body로 다시 append 
				//원래내용을 원래위치로 환원
				replyReset();
				
			}
			//alert(aa);
			
			
			//원래내용(수정할 내용)가져오기 - <br>태그 포함
			
			r2cont = $(this).parents('.rcode').find('.r2').html();
			console.log(r2cont);
			//\n으로 변경
			r2temp = r2cont.replace(/<br>/g,"\n");
			
			$('#modifyform textarea').val(r2temp);
			
			$(this).parents('.rcode').find('.r2').empty().append($('#modifyform'));
			$('#modifyform').show();
		}
		if(actionName=="r_delete"){
			replyDelete(this)
			$(this).parents('.rcode').remove();
		}
		
	})
	
	function replyReset(){
		//p3찾기
		vr2 = $('#modifyform').parent();
		
		//수정폼을 body로 이동, 감추기
		$('body').append($('#modifyform'));
		$('#modifyform').hide();
		
		//원래데이터 환원
		$(vr2).html(r2cont);
	}
	
	//댓글수정창에서 취소버튼 클릭
	$('#btnreset').on('click',function(){
		replyReset();
	})
	
	//댓글수정창에서 확인버튼 클릭
	$('#btnok').on('click',function(){
		//수정입력내용 가져오기 \r \n이 포함되어 있다.
		modicont = $('#modifyform textarea').val();
		
		//환원할 위치 = r2
		vr2 = $('#modifyform').parent();
		
		//수정폼을 body로 이동, 감추기
		$('body').append($('#modifyform'));
		$('#modifyform').hide();
		
		//mobicont 내용을 <br>태그로 바꿔서 r2위치에 출력표시
		modishow = modicont.replace(/\r/g,"").replace(/\n/g,"<br>");
		vr2.html(modishow);
		//db에서 수정 - <cont>, redate
		reply.board_reply_id = actionIdx;
		reply.rep_content = modicont;
		replyUpdate();
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
	
	<form class='form-inline' >
		<select class="form-control" id="stype">
	   		<option value="board_title">제목</option>
	   		<option value="mem_email">작성자</option>
	 	</select>
		<input id='sword' class='form-control mr-sm-2 ' type='text' placeholder='Search'>
		<button id='search' class='btn btn-primary' type='button'>Search</button>
	</form>
	  
</nav>
  <!--list출력   -->
 <div class="container">
 
 	
 
 </div>
 
 <!--page출력   -->
 <div id="pagelist">
 
 </div>
</body>
</html>