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
  <script src="../js/adminNotice.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript">
currentPage = 1;
admin={};
notice={};
temp = 0;
$(function() {
	wordvalue = "";
	noticeList();
	$('.modal-backdrop').css("z-index", "9999");
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
	
	//수정 버튼을 눌렀을때
	$(document).on('click','.update',function(){
		notice = $(this).parents('tr').find('.notice').attr('value');
		temp=1;
		noticeDetail(notice);
	})
	
	//수정완료후 확인 버튼을 눌렀을때
	$(document).on('click','#updatesend',function(){
		
		admin.notice = notice;
		admin.notice_title = $('.notice_title', "#updateForm").val();
		admin.notice_content = $('.notice_content', "#updateForm").val();
		
		admin.notice_cat = $('.notice_cat', "#updateForm").val();
		admin.notice_sta = $('.notice_sta', "#updateForm").val();
		console.log(admin);
		alert(admin);
		noticeUpdate(admin);
	})
	
	//삭제버튼을 눌렀을때
	$(document).on('click','.delete',function(){
		notice = $(this).parents('tr').find('.notice').attr('value');
		noticeDelete(notice);
	})
	
	//등록버튼을 눌렀을때 초기화
	$(document).on('click','#insert',function(){
		$('#insertModal').modal({backdrop: false});
		$('.notice_title').val("");
		$('.notice_content').val("");
	})
	
	//등록버튼을 눌러 입력후 확인 버튼을 눌렀을 경우
	$(document).on('click','#insertsend',function(){
		notice.notice_title = $('.notice_title').val();
		notice.notice_content = $('.notice_content').val();
		notice.notice_cat = $('.notice_cat option:selected').val();
		console.log(notice.notice_cat);
		notice.notice_sta = $('.notice_sta option:selected').val();
		console.log(notice);
		
		noticeInsert(notice);
	})
	
	
	
	$(document).on('click','#updateNoticeform',function(){
		$('#updateModal').modal({backdrop: false});
	})
	
})
</script>
<style type="text/css">
#head{
	border: 1px solid;
}
/*검색버튼, 게시글 등록 버튼*/
#insert, #search{
	margin-left: 0px;
	border: 1px solid lightgray;
}
/*게시글 등록 버튼*/
#insert{
	color: blue;
	margin-left: 10px;
}
/*검색창(입력받는 부분)*/
#sword{
	width: 700px;
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
/*테이블 내에 들어가는 보기, 수정, 삭제 버튼*/
.select, .update, .delete{
	margin: 5px;
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
 
 <!-- The insertModal -->
<div class="modal" id="insertModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">공지사항 등록</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        <form id="insertForm">
        <!-- vo와 name이 동일해야한다. -->
        	<label>제목</label><br>
        	<input type="text" class="notice_title" name="notice_title"><br>
        	<br>
        	<label>내용</label><br>
        	<textarea type="text" class="notice_content" name="notice_content"></textarea><br>
        	<br><br>
        	
        	<label>카테고리</label>
        	<select class="notice_cat">
        	<option name="notice_cat" value = "notice">Notice
        	<option name="notice_cat" value = "qna" style="margin-left:10px;">Q&A<br>
        	</select>
        	
        	<label style="margin-left:10px;">노출여부</label>
        	<select class="notice_sta">
        	<option name="notice_sta" value = "on">on
        	<option name="notice_sta" value = "off" >off<br>
        	</select>
        	
        </form>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <input type="button" class="btn btn-primary" id="insertsend" value="확인" data-dismiss="modal"> <!-- class="action" name="modisend" idx="" -->
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>

 
 <!-- The updateModal -->
<div class="modal" id="updateModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">공지사항 수정</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        <form id="updateForm">
        <!-- vo와 name이 동일해야한다. -->
        	<label>제목</label><br>
        	<input type="text" class="notice_title" name="notice_title"><br>
        	<br>
        	<label>내용</label><br>
        	<textarea type="text" class="notice_content" name="notice_content"></textarea><br>
        	<br><br>
        	
        	<label>카테고리</label>
        	<select class="notice_cat">
        	<option name="notice_cat" value = "notice">Notice
        	<option name="notice_cat" value = "qna" style="margin-left:10px;">Q&A<br>
        	</select>
        	
        	<label style="margin-left:10px;">노출여부</label>
        	<select class="notice_sta">
        	<option name="notice_sta" value = "on">on
        	<option name="notice_sta" value = "off" >off<br>
        	</select>
        	
        </form>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <input type="button" class="btn btn-primary" id="updatesend" value="수정" data-dismiss="modal"> <!-- class="action" name="modisend" idx="" -->
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>
 
 
</body>
</html>