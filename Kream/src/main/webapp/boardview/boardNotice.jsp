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
  <script src="../js/boardNotice.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript">
currentPage = 1;
admin={};
temp = 0;
$(function() {
	wordvalue = "";
	noticeList();
	
	//search검색  이벤트
	$(document).on('click','#search', function(){ //search 버튼을 눌렀을때
		wordvalue =$('#sword').val().trim();
		currentPage = 1;
		noticeList();
	})
	
	//page번호 클릭하는 이벤트
	$('#pagelist').on('click','.pnum',  function(){
		currentPage = $(this).text();
		noticeList();
	})
	
	//이전버튼 클릭하는 이벤트
	$('#pagelist').on('click', '.prev', function(){
		currentPage = parseInt($('.pager a').first().text()) - 1;
		noticeList();
	})
	//다음버튼 클릭하는 이벤트
	$('#pagelist').on('click', '.next', function(){
		currentPage = parseInt( $('.pager a').last().text()) + 1;
		noticeList();
	})
	
	//게시글 보기 버튼 또는 제목을 눌렀을때
	$(document).on('click','.select',function(){
		notice = $(this).parents('tr').find('.notice').attr('value');
		temp = 0;
		noticeDetail(notice);
	})
	
	//noticeDetail에서 다시 noticeMain으로 돌아올때
	$(document).on('click','#noticemain',function(){
		noticeList();
	})
	
})
</script>
<style type="text/css">
#head{
	border: 1px solid;
}
/*검색버튼, 게시글 등록 버튼*/
#search{
	margin-left: 0px;
	border: 1px solid lightgray;
}

/*검색창(입력받는 부분)*/
#sword, .select{
	width: 500px;
}
.notice{
	width: 200px;
}
/*테이블 삽입되는 부분*/
.container{
	width:100%;
	height:525px;
	margin: 0px;
	padding: 0px;
}
/*page 리스트*/
#pagelist{
	margin-left:500px;
}

.navbar{
	display: inline;
}
#notice_detail{
	margin: 15px;
}

.modal-content{
	width: 500px;
}
.notice_title{
	width: 100%;
}

.form-inline{
	float: right;
	margin-right: 100px;
}

textarea {
    width: 100%;
    height: 6.25em;
    resize: none;
  }
</style>
</head>
<body>
<h3>공지사항</h3><hr id="head">

<!-- noticeList()에서 추가 된다.  -->
<nav id="nav" class="navbar navbar-expand-sm  navbar-info">
	  
	  
</nav>
  <!--list출력   -->
 <div class="container">
 
 </div>
 
 <!--page출력   -->
 <div id="pagelist">
 
 </div>

</body>
</html>