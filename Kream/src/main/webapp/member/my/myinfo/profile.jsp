<%@page import="java.util.Map"%>
<%@page import="kr.or.ddit.kream.vo.MyBuyingListVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.kream.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	MemberVO memberVo = (MemberVO)session.getAttribute("memberVo");
	String mem_pass = memberVo.getMem_pass();
	String replacePass = "";
	for(int i = 0; i < mem_pass.length(); i++){
		replacePass += "●";
	}
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="<%=request.getContextPath()%>/js/kakao.js"></script>
<script src = "<%=request.getContextPath()%>/js/searchProd.js"></script>
<link rel = "stylesheet" href = "/Kream/css/pagetopline.css">
<link rel = "stylesheet" href = "/Kream/css/prodSearchModal.css">
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>




<style>
html{
	height: 100%;
}
body{
	height: 100%;
}
div{
	display: block;
	box-sizing: border-box;
}
a, a:hover{
	text-decoration: none;
	color: black;
}
.container.my{
	margin: 0 auto;
/* 	height: 100%; */
	padding: 40px 40px 0px;
	max-width: 1280px;
}
.meun{
	list-style: none;
}
.left_meun{
	width: 180px;
	margin-left: 50px;
	float: left;
}
.mytitle{
	font-size: 24px;
}
.meun.title{
	font-size: 18px;
	padding-top: 30px;
}
.meun.item{
	font-size: 15px;
	padding-top: 12px;
}
.meun.item a{

	color: rgba(34,34,34,0.5);
}

.title{
	font-weight: 700;
}
img {
	width: 100px;
	height: 100px;
}
.modify.email, .modify.pass, .modify.name, .modify.addr{
	padding-top: 25px;
}
.modify .title2{
	padding-bottom: 22px;
}
.title2{
	font-size: 13px;
	color: rgba(34,34,34,.5);
}
.input_box{
	position: relative;
	padding: 10px 0 14px;
}
.intput_title{
	font-size: 13px;
	line-height: 18px;
	outline: 0;
    border-style: none;
}
.modify .input_txt{
	padding: 7px 0;
	font-size: 15px;
}
.container.my input{
	border: 0;
	width: 100%;
	 border-bottom: 1px solid #ebebeb;
}
.modify_btn_box{
	padding-top: 28px;
	text-align: center;
	font-size: 0px;
}

.medium{
	height: 42px;
	line-height: 40px;
	border-radius: 12px;
	font-size: 14px;
}

.small{
	font-size: 12px;
	padding: 0px 5px;
	height: 34px;
	line-height: 32px;
	border-radius: 10px;
}

.container.my .btn {
	display: inline-block;
	vertical-align: middle;
	text-align: center;
	cursor: pointer;
	padding: 0 38px;
}

.outlinegrey{
	border: 1px solid #d3d3d3;
    color: rgba(34,34,34,.8);
}

.util{
	padding: 25px 60px 18px 0;
    position: relative;
    border-bottom: 1px solid #ebebeb;
}
.btn.btn_modify{
	position: absolute;
    right: 0;
    bottom: 15px;
    padding-top: 1px;
    padding-left: 11px;
    padding-right: 12px;
}
.desc{
	padding-top: 6px;
    font-size: 16px;
    letter-spacing: -.16px;
}
.container.my input:focus {
	outline: none;
	border-bottom: 2px solid black; 
}
.input_error{
	color: red;
	position: absolute;
	display: block;
	line-height: 16px;
	font-size: 11px;
}
#deleteImg, #changeProfile{
	border: 1px solid #d3d3d3;
    color: rgba(34,34,34,.8);
	border-radius: 10px;
	background: white;
    font-size: 12px;
	padding: 0px 10px;
	height: 34px;
	line-height: 32px;
	margin-top: 5px;
}



</style>
<script type="text/javascript">
$(function(){
	$('#search_modal').on('click', function(){
		$('#searchmodal').modal('show');
	});
	//검색 모달의 검색버튼을 누를 시 이벤트
   	$('#search_btn').on('click', function(){
      	//검색한 값을 가져와 메서드로 보내주기
      	input = $('#search_prod').val();
      
      	//검색 내역 모달에 출력
      	prodSearch(input);
   	});
// 	sort = $('#asc').attr('id');
// 	$('#asc').on('click',function(){
// 		$(this).toggle();
// 		$('#desc').toggle();
// 		sort = $('#desc').attr('id');
// 	});
	
// 	$('#desc').on('click',function(){
// 		$(this).toggle();
// 		$('#asc').toggle();
// 		sort = $('#asc').attr('id');
// 	});	

	$('.btn.btn_modify.outlinegrey.small').on('click',function(){
		$(this).parent().toggle();
		$(this).parent().next().toggle();
	});
	
	$('.btn.outlinegrey.medium').on('click',function(){
		$(this).parents('.modify').toggle();
		$(this).parents('.modify').prev().toggle();
	});
	
	$('.savename').on('click',function(){
		name = $('.input_txt.name').val();
		id = $('.input_txt.name').attr('id');
// 		alert(name);
// 		alert(id);
		$.ajax({
			url : '<%= request.getContextPath()%>/memberUpdate.do',
			type : 'get',
			data : {"value" : name,
				    "para" : id
			},
			success : function(res){
// 				alert(res);
			},
			error : function(xhr){
				alert("상태 " + xhr.status);
			},
			dataType : 'json'
		});
	});
	
	$('.savepass').on('click',function(){
		name = $('.input_txt.pass').val();
		id = $('.input_txt.pass').attr('id');
// 		alert(name);
// 		alert(id);
		$.ajax({
			url : '<%= request.getContextPath()%>/memberUpdate.do',
			type : 'get',
			data : {"value" : name,
				    "para" : id
			},
			success : function(res){
// 				alert(res);
			},
			error : function(xhr){
				alert("상태 " + xhr.status);
			},
			dataType : 'json'
		});
	});
	
	$('.saveaddr').on('click',function(){
		name = $(this).parents('.modify.addr').find('input[name="name"]').val();
		addr1 = $(this).parents('.modify.addr').find('input[name="addr1"]').val();
		addr2 = $(this).parents('.modify.addr').find('input[name="addr2"]').val();
		zip_code = $(this).parents('.modify.addr').find('input[name="zip_code"]').val();
		phone_num = $(this).parents('.modify.addr').find('input[name="phone_num"]').val();
		
// 		alert(name);
		
		$.ajax({
			url : '<%= request.getContextPath()%>/addrUpdate.do',
			type : 'get',
			data : {"name" : name,
				    "addr1" : addr1,
				    "addr2" : addr2,
				    "zip_code" : zip_code,
				    "phone_num" : phone_num},
			success : function(res){
				//alert(res);
			},
			error : function(xhr){
				alert("상태 " + xhr.status);
			},
			dataType : 'json'
		});
		
	});
	
	$('.input_txt.email').keyup(function(){
		var regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
		var email = $(this).val();
		
		if(!regEmail.test(email)){
			$(this).next().show();
			$('.saveemail').attr('disabled','disabled');
		}else{
			$(this).next().hide();
			$('.saveemail').removeAttr('disabled');
		}
	});
	
	$('.input_txt.pass').keyup(function(){
		var regPass = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
		var pass = $(this).val();
		
		if(!regPass.test(pass)){
			$(this).next().show();
		}else{
			$(this).next().hide();
		}
	})
	
	$('.input_txt.name').keyup(function(){
		var regName = /^[가-힣]{2,4}$/;
		var name = $(this).val();
		
		if(!regName.test(name)){
			$(this).next().show();
		}else{
			$(this).next().hide();
		}
	})
	
	$('#deleteImg').on('click',function(){
		$.ajax({
			url : '<%= request.getContextPath()%>/ProfileDelete.do',
			type : 'get',
			success : function(res){
// 				alert(res);
			},
			error : function(xhr){
				alert("상태 " + xhr.status);
			},
			dataType : 'json'
		});
	});
	
	$('#check').on('click',function(){
		data = $('#files').val();
// 		alert(data);
	})
	
	if("<%= memberVo.getMem_photo()%>" == "mem_profile_icon.png"){
		$('#deleteImg').hide();
	}
	
	$('#files').change(function(){
		if($('#files').val() != ""){
			$('#changeProfile').show();
		}
	})
	
	$('#changeProfile').on('click',function(){
		
		location.href = "http://localhost/Kream/member/loginForm.jsp";
	})
	


 
})

</script>



</head>
<body>
<div class="top_line fixed-top border-bottom text-end" id="topline1">
	<ul class = "text-end" style="margin-left: auto;">
		<li><a class="top_line" href="<%=request.getContextPath()%>/boardview/boardMain.jsp">고객센터</a></li>
		<li><a class="top_line" href="<%= request.getContextPath() %>/MyPage.do">마이페이지</a></li>
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

<div class="top_line fixed-top border-bottom text-end" id="topline2">
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


<div class="container my">
	<div class="left_meun">
	    <a class="mytitle" href="<%= request.getContextPath() %>/MyPage.do">마이 페이지</a>
	    <ul class="meun" style="padding-left: 0px;">	
			<li class="meun title">쇼핑 정보</li>
			
			<li class="meun item"><a href="<%= request.getContextPath() %>/buyingList.do">구매 내역</a></li>
			<li class="meun item"><a href="<%= request.getContextPath() %>/member/my/shopinfo/selling.jsp">판매 내역</a></li>
			<li class="meun item"><a href="<%= request.getContextPath() %>/member/my/shopinfo/wish.jsp">관심 상품</a></li>
			
			<li class="meun title">내 정보</li>
			
			<li class="meun item"><a href="/Kream/member/my/myinfo/profile.jsp" style="color: black; font-weight: 700;">프로필 정보</a></li>
			<li class="meun item"><a href="/Kream/member/my/myinfo/payment.jsp">결제 정보</a></li>
			<li class="meun item"><a href="/Kream/member/my/myinfo/point.jsp">포인트</a></li> 	
	    </ul>
	</div>
	
	<div class="my-home-area" style="overflow: hidden;">
		<div class="my-home">
			
			<div style="border-bottom : 3px solid; align-items: center; ">
				<div class="buying-title" style=" margin-left: auto; margin-right:50px;">
					<h3>프로필 정보</h3>
				</div>
			</div>
			
			<div style="border-bottom: 1px solid #ebebeb; padding: 50px 0 38px;">
				<div class="wish-detail" style="display: flex;">
					<div class="profile_thumb" style="width: 100px; height: 100px; margin-right: 20px;">
						<img style="width: 100%; height: 100%;" alt="" src="<%= request.getContextPath() %>/memberPhotoView.do?filename=<%= memberVo.getMem_photo() %>">
					</div>
					
					<div class="prod_brand" style="margin: auto 0px;">
						<strong><%= memberVo.getMem_email() %></strong><br>
						<form id="profile" action="<%= request.getContextPath() %>/ProfileUpload.do" method="post" enctype="multipart/form-data">
							<input id="files" type="file" name="fileUpload" multiple>
							<button id="deleteImg" type="button">삭제</button>
							<button id="changeProfile" type="submit" style="display: none;">이미지 변경</button>
						</form>
					</div>
				</div>
			</div>
			
			
			
			
			<div class="profile_info" style="max-width: 480px;">
			
				<div style="border-bottom : 3px solid; align-items: center; margin-top: 20px;">
					<div class="buying-title" style=" margin-left: auto; margin-right:50px;">
						<h4>로그인 정보</h4>
					</div>
				</div>
				
				<!--////////////////////////////////// 이메일 변경 ///////////////////////////// -->
				<div class="util email">
					<h5 class="title2" style="margin: 0;">이메일</h5>
					<p class="desc" style="margin: 0; font-weight:600;"><%= memberVo.getMem_email() %></p>
					<button type="button" class="btn btn_modify outlinegrey small" style="padding: 0 10px;">
					 변경
					</button>
				</div>
				
				<div class="modify email" style="display: none;">
					<h5 class="title2" style="padding: 0; margin: 0; padding-bottom: 22px; color: black;">이메일</h5>
					<div class="input_box">
						<h6 class="intput_title" style="padding: 0; margin: 0;">새로운 이메일</h6>
						<div class="input_item">
							<input type="email" autocomplete="off" id="mem_email" placeholder="고객님의 이름" class="input_txt email">
							<span class="input_error" style="display: none;">이메일주소를 정확히 입력해 주세요.</span>
						</div>
					</div>
					
					<div class="modify_btn_box">
						<button class="btn outlinegrey medium">취소</button>
						<button class="btn outlinegrey medium saveemail" disabled="disabled" style="margin-left: 8px;">저장</button>
					</div>
				</div>
				
				<!--////////////////////////////////// 비밀번호 변경 ///////////////////////////// -->
				<div class="util pass">
					<h5 class="title2" style="margin: 0;">비밀번호</h5>
					<p class="desc" style="margin: 0; font-weight:600;"><%= replacePass %></p>
					<button type="button" class="btn btn_modify outlinegrey small" style="padding: 0 10px;">
					 변경
					</button>
				</div>
				
				<div class="modify pass" style="display: none;">
					<h5 class="title2" style="padding: 0; margin: 0; padding-bottom: 22px; color: black;">비밀번호</h5>
					<div class="input_box">
						<h6 class="intput_title" style="padding: 0; margin: 0;">새로운 비밀번호</h6>
						<div class="input_item">
							<input type="password" autocomplete="off" id="mem_pass" placeholder="고객님의 이름" class="input_txt pass">
							<span class="input_error" style="display: none;">영문,숫자,특수분자를 포함하여 입력하세요.(8자 이상)</span>
						</div>
					</div>
					
					<div class="modify_btn_box">
						<button class="btn outlinegrey medium">취소</button>
						<button class="btn outlinegrey medium savepass" style="margin-left: 8px;">저장</button>
					</div>
				</div>
				
				
				
				
				
				<div style="border-bottom : 3px solid; align-items: center; margin-top: 20px;">
					<div class="buying-title" style=" margin-left: auto; margin-right:50px;">
						<h4>개인 정보</h4>
					</div>
				</div>
				
				<!--////////////////////////////////// 이름 변경 ///////////////////////////// -->
				<div class="util">
					<h5 class="title2" style="margin: 0;">이름</h5>
					<p class="desc" style="margin: 0; font-weight:600;"><%= memberVo.getMem_name() %></p>
					<button type="button" class="btn btn_modify outlinegrey small" style="padding: 0 10px;">
					 변경
					</button>
				</div>
				
				<div class="modify name" style="display: none;">
					<h5 class="title2" style="padding: 0; margin: 0; padding-bottom: 22px; color: black;">이름</h5>
					<div class="input_box">
						<h6 class="intput_title" style="padding: 0; margin: 0;">새로운 이름</h6>
						<div class="input_item">
							<input type="text" autocomplete="off" id="mem_name" placeholder="고객님의 이름" class="input_txt name">
							<span class="input_error" style="display: none;">이름을 정확히 입력하세요</span>
						</div>
					</div>
					
					<div class="modify_btn_box">
						<button class="btn outlinegrey medium">취소</button>
						<button class="btn outlinegrey medium savename" style="margin-left: 8px;">저장</button>
					</div>
				</div>
				
				<!--////////////////////////////////// 주소 변경 ///////////////////////////// -->
				<div class="util">
					<h5 class="title2" style="margin: 0;">배송지</h5>
					<p class="desc" style="margin: 0; font-weight:600;">배송지 변경</p>
					<button type="button" class="btn btn_modify outlinegrey small" style="padding: 0 10px;">
					 변경
					</button>
				</div>
				
				<div class="modify addr" style="display: none;">
					<h5 class="title2" style="padding: 0; margin: 0; padding-bottom: 22px; color: black;">배송지</h5>
					<div class="input_box">
						<h6 class="intput_title" style="padding: 0; margin: 0;">수령인 이름</h6>
						<div class="input_item">
							<input type="text" name="name" autocomplete="off" placeholder="수령인의 이름을 적어주세요" class="input_txt">
						</div>
					</div>
					<div class="input_box">
						<h6 class="intput_title" style="padding: 0; margin: 0;">전화번호</h6>
						<div class="input_item">
							<input type="text" name="phone_num" autocomplete="off" placeholder="전화번호" class="input_txt">
						</div>
					</div>
					<div class="input_box">
						<h6 class="intput_title" style="padding: 0; margin: 0;">우편번호</h6>
						<div class="input_item">
							<input type="text" name="zip_code" autocomplete="off" placeholder="우편 번호" class="input_txt">
						</div>
					</div>
					
					<div class="input_box">
						<h6 class="intput_title" style="padding: 0; margin: 0;">주소</h6>
						<div class="input_item">
							<input type="text" name="addr1" autocomplete="off" placeholder="주소" class="input_txt">
						</div>
					</div>
					
					<div class="input_box">
						<h6 class="intput_title" style="padding: 0; margin: 0;">상세주소</h6>
						<div class="input_item">
							<input type="text" name="addr2" autocomplete="off" placeholder="상세 주소" class="input_txt">
						</div>
					</div>
					
					<div class="modify_btn_box">
						<button class="btn outlinegrey medium">취소</button>
						<button class="btn outlinegrey medium saveaddr" style="margin-left: 8px;">저장</button>
					</div>
				</div>
			</div>
			
			
		</div>	
	</div>
</div>

<footer>

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
</footer>

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