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
  <script src="../js/adminBoard.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript">
currentPage = 1;
admin={};
$(function() {
	typevalue = "";
	wordvalue = "";
	
	memberList();
	//search검색  이벤트
	$('#search').on('click', function(){ //search 버튼을 눌렀을때
		typevalue= $('#stype option:selected').val().trim(); //체크한 옵션 가져오기
		wordvalue =$('#sword').val().trim();
		
		currentPage = 1;
		memberList();
	})
	
	//page번호 클릭하는 이벤트
	$('#pagelist').on('click','.pnum',  function(){
		//alert( $(this).text());
		
		currentPage = $(this).text();
		memberList();
	})
	
	//이전버튼 클릭하는 이벤트
	$('#pagelist').on('click', '.prev', function(){
		currentPage = 
			parseInt($('.pager a').first().text()) - 1;
		
		memberList();
	})
	//다음버튼 클릭하는 이벤트
	$('#pagelist').on('click', '.next', function(){
		currentPage =
			parseInt( $('.pager a').last().text()) + 1;
		
		memberList();
	})
	
	$(document).on('click','#insert',function(){
		$('#insertModal').modal({backdrop: false});
	})
	
	$(document).on('click','#update',function(){
		$('#updateModal').modal({backdrop: false});
	})
	
	$('.modal-footer').on('click', '.action', function(){
		actionName =  $(this).attr('name');
		actionIdx  = $(this).attr('idx');
		
		
		//관리자 계정 추가
		if(actionName == "insert"){
			//mem_mail, mem_pass, mem_name
			
			mem_email = $('#imem_email').val(); //관리자 아이디
			mem_pass = $('#imem_pass').val(); //관리자 비밀번호
			mem_name = $('#imem_name').val(); //관리자 이름
			
			admin.mem_email = mem_email;
			admin.mem_pass = mem_pass;
			admin.mem_name = mem_name;
			
			adminInsert(this);
			
		}else if(actionName=="update"){
			
			//mem_email = $('#mem_email').val(); 
			mem_pass = $('#umem_pass').val(); //관리자 비밀번호
			mem_name = $('#umem_name').val(); //관리자 이름
			
			admin.mem_email = mem_email;
			admin.mem_pass = mem_pass;
			admin.mem_name = mem_name;
			
			adminUpdate(this);
		}
		
		
	})
	
	
	$('#update').on('click', function(){
		console.log($("input:radio[name='member']:checked"));
		if(!$("input:radio[name='member']:checked").length>0){
			alert("계정을 선택해 주세요");
			return false;
			//$('#updateModal').modal('hide');
		}else {
			mem_email = $("input:radio[name='member']:checked").parents('tr').find('.dmem_email').attr('name');//관리자 아이디
			$('#umem_email').val(mem_email);
		}
	})
	
	$('#delete').on('click', function(){
		
 		if(!$("input:radio[name='member']:checked").length>0){
 			alert("계정을 선택해 주세요");
 			return false;
 			//$('#updatemodal').modal('hide');
 		}else {
			
 			mem_email = $("input:radio[name='member']:checked").parents('tr').find('.dmem_email').attr('name');//관리자 아이디
			
 			alert(mem_email+" 삭제되었습니다.");
 			adminDelete(mem_email);
 		} 
	})
	
})
</script>
<style type="text/css">
#head{
	border: 1px solid;
}
div{
	margin: 0px;
	display: inline-block;
}
/*검색창 (search, optionList)*/
.navbar{
	float: left;
	width: 100%;
}
#sword{
	width: 400px;
}
.form-inline{
	margin-left:5px;
}

#stype{
	width: 150px;
}
/* 관리자 계정 추가, 수정, 삭제*/
#btns{
	margin-left:210px;
	float: right;
	display: inline-block;
}
/*table ui*/
.container{
	width:100%;
	height:555px;
	margin: 0px;
	padding: 0px;
}
table{
	width: 100%;
	margin-left: 10px;
	margin-right: 5px;
}

/* page 리스트*/
#pagelist{
	margin-left:500px;
}

/*moadal*/
.modal{
	padding-left: 450px;
	
}
.lsize{
	/*글씨 맞춤 style*/
	display: inline-block;
	width: 100px;
}


#btnsearch{
	border-radius:20%;
}

</style>
</head>
<body>
<h3>회원관리</h3><hr id="head">
  <nav class="navbar navbar-expand-sm  navbar-info">
  
	 <select class="form-control" id="stype">
	   <option value="">전체</option>
	   <option value="user">일반사용자</option>
	   <option value="admin">관리자</option>
	 </select>
	 
	  <form class="form-inline" >
	     <input id="sword" class="form-control mr-sm-2" type="text" placeholder="Search">
	     <button id="search" class="btn btn-primary" type="button">Search</button>
	  </form>
	  
	  <form id="btns">
	  	<button id="insert" name="insert" type="button" class="action btn btn-outline-dark">계정추가</button>
	  	<button id="update" name="update" type="button" class="action btn btn-outline-dark">계정수정</button>
	  	<button id="delete" name="delete" type="button" class="btn btn-outline-dark">계정삭제</button>
	  </form>
  </nav>
  <br><br>
  <!--list출력   -->
 <div class="container">
 
 </div>
 
 <br><br>
 <!--page출력   -->
 <div id="pagelist">
 
 </div>
 
 
 <!-- The Modal //관리자 계정 추가-->
<div class="modal fade" id="insertModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">관리자 계정 추가</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        <form id="imodiForm">
        <!-- vo와 name이 동일해야한다. -->
        	<label class="lsize">아이디</label>
        	<input type="text" id="imem_email" name="mem_email"><br>
        	
        	<label class="lsize">비밀번호</label>
        	<input type="text" id="imem_pass" name="mem_pass"><br>
        	
        	<label class="lsize">이름</label>
        	<input type="text" id="imem_name" name="mem_name"><br>
        </form>
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
      <input type="button" name="insert" class="btn btn-primary action"  value="확인" data-dismiss="modal"> <!-- class="action" name="modisend" idx="" -->
        <button type="button" name="close" class="btn btn-danger action" data-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>

<!-- The Modal //관리자 계정 수정-->
<div class="modal" id="updateModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">관리자 계정 수정</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        <form id="umodiForm">
        <!-- vo와 name이 동일해야한다. -->
        	<label class="lsize">아이디</label>
        	<input disabled type="text" id="umem_email" name="mem_email"><br>
        	
        	<label class="lsize">비밀번호</label>
        	<input type="text" id="umem_pass" name="mem_pass"><br>
        	
        	<label class="lsize">이름</label>
        	<input type="text" id="umem_name" name="mem_name"><br>
        </form>
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
      <input type="button" name="update" class="btn btn-primary action"  id="umodisend"value="확인" data-dismiss="modal"> <!-- class="action" name="modisend" idx="" -->
        <button type="button" name="close" class="btn btn-danger action" data-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>

