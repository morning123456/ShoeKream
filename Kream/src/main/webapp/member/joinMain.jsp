<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src = "<%=request.getContextPath()%>/js/searchProd.js"></script>
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel = "stylesheet" href = "/Kream/css/pagetopline.css">
<link rel = "stylesheet" href = "/Kream/css/prodSearchModal.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="../js/jquery.serializejson.min.js"></script>

<style>
html{
	height: 100%;
}
body{
	height: 100%;
}
.content{
	margin: 0 auto;
	padding: 0 40px;
	max-width: 1280px;
}
.login_area{
	margin: 0 auto;
    padding: 118px 0 160px;
    width: 400px;
}
.login_title{
	padding-bottom: 50px;
    text-align: center;
    font-size: 32px;
}
.intput_box{
	position: relative;
    padding: 10px 0 14px;
}
.input_title{
	font-size: 13px;
    letter-spacing: -.07px;
    line-height: 18px;
}
.input_item{
	position: relative;
}
.intput_txt{
	padding-right: 30px;
    height: 38px;
}
a, a:hover{
	text-decoration: none;
	color: black;
	font-size: 12px;
}
li{
	float: left;
	list-style: none;
	margin-left: 20px;
}
</style>
<script type="text/javascript">
$(function(){
	$('#search_modal').on('click', function(){
		$('#searchmodal').modal('show');
	})
	
	//검색 모달의 검색버튼을 누를 시 이벤트
   	$('#search_btn').on('click', function(){
      	//검색한 값을 가져와 메서드로 보내주기
      	input = $('#search_prod').val();
      
      	//검색 내역 모달에 출력
      	prodSearch(input);
   	})
	email = $('#email').val();
	$.ajax({
		url : '<%= request.getContextPath()%>/emailCheck.do',
		type : 'get',
		data : {
			"email" : email
		},
		success : function(res){
			if(res=="중복"){
				$('#check').hide();
				$('#noCheck').show();
				$('#join').attr('disabled','disabled');
			}else{
				$('#check').show();
				$('#noCheck').hide();
				$('#join').removeAttr('disabled');
			}
		},
		error : function(xhr){
			alert("상태 " + xhr.status);
		},
		dataType : 'json'
		
	});
	$('#email').keyup(function(){
		$('#check').hide();
		$('#noCheck').show();
		$('#join').attr('disabled','disabled');
	});
	
	$('.btn.btn-success').on('click',function(){
		email = $('#email').val();
		$.ajax({
			url : '<%= request.getContextPath()%>/emailCheck.do',
			type : 'get',
			data : {
				"email" : email
			},
			success : function(res){
				if(res=="중복"){
					$('#check').hide();
					$('#noCheck').show();
					$('#join').attr('disabled','disabled');
				}else{
					$('#check').show();
					$('#noCheck').hide();
					$('#join').removeAttr('disabled');
				}
			},
			error : function(xhr){
				alert("상태 " + xhr.status);
			},
			dataType : 'json'
			
		});
	})
})

</script>
</head>
<body>
<div class="top_line fixed-top border-bottom text-end" style="height: 50px; display: flex; line-height: 50px; padding-right: 20px; background: white;">
<ul class = "text-end" style="margin-left: auto;">
	<li><a href="<%=request.getContextPath()%>/boardview/boardMain.jsp">고객센터</a></li>
	<li><a href="<%= request.getContextPath() %>/member/loginForm.jsp">마이페이지</a></li>
	<li><a href="<%= request.getContextPath() %>/member/loginForm.jsp">로그인</a></li>
</ul>
</div>

<div class="top_line fixed-top border-bottom text-end" style="height: 68px; align-items: center; display: flex; padding:0px 40px; background: white; margin-top: 50px;">
    <a href = "/Kream/member/main.jsp">
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


<div class="content md">
	<div class="login_area">
		<form class="was-validated" action="<%= request.getContextPath() %>/insertMember.do" method="post">
			<h2 class="login_title">회원 가입</h2>
			<div class="input_box mb-4">
				<h3 class="input_title">이메일 주소</h3>
				<div class="input_item input-group">
					<input type="email" value="tjdtkd1247@naver.com" class="form-control" id="email" placeholder="예)shou123@ddit.or.kr" name="mem_email" required>
					<div id="check" class="input-group-append" style="display: none;">
          				<button class="btn btn-success">중복검사완료</button>  
        			</div>
			        <div id="noCheck" class="input-group-append">
			        	<button class="btn btn-success">중복검사실패</button>  
			        </div>
					<div class="valid-feedback"></div>
					<div class="invalid-feedback">이메일 주소를 정확히 입력해 주세요</div>
				</div>
			</div>
			
			<div class="input_box mb-4">
				<h3 class="input_title">비밀번호</h3>
				<div class="input_item">
					<input type="password" class="form-control w-100" id="pass" placeholder="Enter passward" autocomplete="off" name="mem_pass" required
					pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$">
					<div class="valid-feedback"></div>
					<div class="invalid-feedback">영문, 숫자, 특수문자를 조합해서 입력해주세요. (8자 이상)</div>
				</div>
			</div>
			
			<div class="input_box mb-4">
				<h3 class="input_title">이름</h3>
				<div class="input_item">
					<input type="text" class="form-control w-100" id="name" placeholder="홍길동" name="mem_name" required
					pattern="^[가-힣]{2,4}$">
					<div class="valid-feedback"></div>
					<div class="invalid-feedback">이름을 정확히 입력해 주세요</div>
				</div>
			</div>
			<button type="submit" id="join" class="btn btn-outline-secondary w-100" disabled="disabled">가입 하기</button>
			
		</form>
	</div>
</div>

<div class="jumbotron jumbotron-fluid text-center" id="footerbody">
	<div class="info_list">
		<p>팀이름 : SHOEKREAM</p>
		<p>사업장소재지: 대전광역시 중구 계룡로 846 3층 304호</p>
		<p>호스팅 서비스 : 대덕인재개발원</p>
	
		<table>
			<tr>
				<td>PL</td>
				<td>:강동주&nbsp;</td>
				<td></td>
				<td></td>
			</tr>
			
			<tr>
				<td>TA</td>
				<td class="td_last">:오지현&nbsp;</td>
				<td>AA</td>
				<td>:곽성상</td>
			</tr>
			
			<tr>
				<td>UA</td>
				<td class="td_last">:김민지&nbsp;</td>
				<td>DA</td>
				<td>:노혜지</td>
			</tr>
		</table>
	</div>
	<div class="customer_service">
		<strong>
			고객센터
			<a href="tel:042-939-5559">042-939-5559</a>
		</strong>
		<p>수업시간 평일 09:00 - 17:30</p>
		<p>점심시간 평일 12:50 - 13:40</p>
		<p>자율학습 시간 평일 5:30 - 22:00</p>
		<p>자율학습 시간 주말 9:00 - 18:00</p>
	</div>
</div>

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
        		<div id = "modal_prod_search">
        		</div>
        	</div>
        	        <!-- Modal footer -->
	        <div class="modal-footer">
	          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	        </div>
		</div>
	</div>
</div>
</body>
</html>