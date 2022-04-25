<%@page import="kr.or.ddit.kream.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="<%=request.getContextPath()%>/js/kakao.js"></script>
<script src = "<%=request.getContextPath()%>/js/searchProd.js"></script>
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel = "stylesheet" href = "/Kream/css/pagetopline.css">
<link rel = "stylesheet" href = "/Kream/css/prodSearchModal.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript"
  src="https://cdn.jsdelivr.net/npm/@emailjs/browser@3/dist/email.min.js"></script>
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
    padding: 60px 0 160px;
    width: 400px;
}
.login_title{
	padding-bottom: 50px;
    text-align: center;
    font-size: 0;
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
.modal-footer.email, .modal-footer.pass{
	text-align: center;
	margin: 0px auto;
	border-style: none;
}
.modal-body.email, .modal-body.pass{
	border-bottom: 1px solid #dee2e6;
}
#find_pass_btn{
	border: 1px solid #d3d3d3;
    color: rgba(34,34,34,.8);
	border-radius: 10px;
	background: white;
	padding: 5px 7px;
}
#find_name_btn{
	border: 1px solid #d3d3d3;
    color: rgba(34,34,34,.8);
	border-radius: 10px;
	background: white;
	padding: 5px 7px;
}
</style>

<script type="text/javascript">


$(function() {
	emailjs.init("FsYG2bOayC-ELZ7X3");	
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
	
	$('#find_name_btn').on('click',function(){
		mem_name = $('#find_name').val();
		
		$.ajax({
			url : '<%= request.getContextPath() %>/findEmail.do',
			data : {"mem_name" : mem_name},
			type : 'post',
			success : function(res){
				arr = res.split("@");
				id = arr[0];
				length = id.length
				startchar = id.charAt(0);
				endchar = id.charAt(length - 1);
				addr = arr[1];
				findEmail = startchar;
				for(var i = 0; i < length - 2; i++){
					findEmail += "*";
				}
				findEmail += endchar;
				findEmail += "@" + addr;
				
				code = "";
				code += "이메일 찾기에 성공하였습니다.<br>";
				code += findEmail + "<br>";
				$('.modal-footer.email').html(code);
			},
			error : function(xhr){
				alert("상태 " + xhr.status);
			},
			dataType : 'json'
		});
	})
	
	$('#find_pass_btn').on('click',function(){
		mem_name = $('#find_pass_name').val();
		mem_email = $('#find_pass_email').val();
		
		$.ajax({
			url : '<%= request.getContextPath() %>/findPass.do',
			data : {"mem_name" : mem_name, "mem_email" : mem_email},
			type : 'post',
			success : function(res){
				var templateParams = {	
					      //각 요소는 emailJS에서 설정한 템플릿과 동일한 명으로 작성!
					            name: $('#find_pass_name').val(),
					            phone: $('input[name=phone]').val(), 
					            email : $('#find_pass_email').val(),
					            message : res
    			};
					                
					            	
			     emailjs.send('service_yokcaxm', 'template_vlprvdy', templateParams)
			     //emailjs.send('service ID', 'template ID', 보낼 내용이 담긴 객체)
			     	    .then(function(response) {
			     	       console.log('SUCCESS!', response.status, response.text);
			     	       alert("회원님의 비밀번호를 이메일로 보내드렸습니다.")
			     	    }, function(error) {
			     	       console.log('FAILED...', error);
			     	    });
			 
			},
			error : function(xhr){
				alert("상태 " + xhr.status);
			},
			dataType : 'json'
		});
	})
	
	
})


Kakao.init('ba2c3583e3af2fefe8d5556275e63e32');
console.log(Kakao.isInitialized()); // 초기화 판단여부

login = "";
function loginWithKakao() {
    Kakao.Auth.login({
        success: function (authObj) {
            console.log(authObj); // access토큰 값
            Kakao.Auth.setAccessToken(authObj.access_token); // access토큰값 저장

            getInfo();
        },
        fail: function (err) {
            console.log(err);
        }
    });
}

// 4. 엑세스 토큰을 발급받고, 아래 함수를 호출시켜서 사용자 정보를 받아옴.
function getInfo() {
    Kakao.API.request({
        url: '/v2/user/me',
        success: function (res) {
            console.log(res);
            // 이메일, 성별, 닉네임, 프로필이미지
            var email = res.kakao_account.email;
            var gender = res.kakao_account.gender;
            var nickname = res.kakao_account.profile.nickname;
            var profile_image = res.kakao_account.profile.thumbnail_image_url;
            var birthday = res.kakao_account.birthday;
            var age_range = res.kakao_account.age_range;

            console.log(email, gender, nickname, profile_image, birthday, age_range);
            //location.href = "http://localhost/Kream/member/joinMain.jsp?email=" + email;
            
            
            //window.open("http://localhost/Kream/member/joinMain.jsp");
        	$.ajax({
        		url : '<%= request.getContextPath() %>/KakaoCheck.do',
        		data : {
        			"email" : email,
        			"nickname" : nickname
        		},
        		type : 'post',
        		success : function(result){
        			//alert(result)
        			if(result == "0"){
        				location.href = "http://localhost/Kream/member/joinSns.jsp?email=" + email + "&nickname=" + nickname;
        			}else{
        				//alert("로그인");
        				$.ajax({
        					url : '<%= request.getContextPath() %>/KakaoLogin.do',
        					data : {"sns" : email},
        					type : 'get',
        					success : function(res){
        						
        						location.href = "http://localhost/Kream/Login.do?mem_email=" + res.mem_email + "&mem_pass=" + res.mem_pass;
        					},
        					error : function(xhr){
        						alert("상태 " + xhr.status)
        					},
        					dataType : 'json'
        				});
        			}
        		},
        		error : function(xhr){
        			alert("상태 " + xhr.status)
        		},
        		dataType : 'json'
        	});
		    //location.href = "http://localhost/Kream/member/joinMain.jsp";
        	
        },
        fail: function (error) {
            alert('카카오 로그인에 실패했습니다. 관리자에게 문의하세요.' + JSON.stringify(error));
        }
    });
}

// 5. 로그아웃 기능 - 카카오 서버에 접속하는 엑세스 토큰을 만료, 사용자 어플리케이션의 로그아웃은 따로 진행.
function kakaoLogout() {
    if (!Kakao.Auth.getAccessToken()) {
        alert('Not logged in.');
        return;
    }
    Kakao.Auth.logout(function() {
        alert('logout ok\naccess token -> ' + Kakao.Auth.getAccessToken());
    });
};

// 6. 연동 헤제 기능
function secession() {
	Kakao.API.request({
    	url: '/v1/user/unlink',
    	success: function(response) {
    		console.log(response);
    		//callback(); //연결끊기(탈퇴)성공시 서버에서 처리할 함수
    		//window.location.href='/'
    	},
    	fail: function(error) {
    		console.log('탈퇴 미완료')
    		console.log(error);
    	},
	});
}; 
</script>

</head>
<body>
<div class="top_line fixed-top border-bottom text-end" style="height: 50px; display: flex; line-height: 50px; padding-right: 20px; background: white;">
	<ul class = "text-end" style="margin-left: auto;">
		<li><a href="<%= request.getContextPath() %>/boardview/boardMain.jsp">고객센터</a></li>
		<li><a href="<%=request.getContextPath()%>/member/loginForm.jsp">마이페이지</a></li>
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
   </div>
</div>
<!-- 로그인은 쿠키로 -->

<div class="content md">
	<div class="login_area">
		<form action="<%= request.getContextPath() %>/Login.do" method="post" class="was-validated">
			<h2 class="login_title">로그인 타이틀</h2>
			<div class="input_box mb-4">
				<h3 class="input_title">이메일 주소</h3>
				<div class="input_item">
					<input type="text" class="form-control w-100" id="email" placeholder="예)shou123@ddit.or.kr" name="mem_email" required>
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
			
			<button type="submit" class="btn btn-outline-secondary w-100">로그인</button>
			<div class="d-flex mb-3">
			    <div class="p-2 flex-fill" style="text-align: center;">
			    <a href="<%= request.getContextPath() %>/member/joinMain.jsp" class="info">이메일 가입</a>
			    </div>
			    
			    <div class="p-2 flex-fill" style="text-align: center;">
			    <a data-toggle="modal" data-target="#findEmail" class="info">이메일 찾기</a>
			    </div>
			    
			    <div class="p-2 flex-fill" style="text-align: center;">
			    <a data-toggle="modal" data-target="#findPass" class="info">비밀번호 찾기</a>
			    </div>
  			</div>
		</form>
		<div style="text-align: center;">
			<a id="custom-login-btn" href="javascript:loginWithKakao()">
				<img alt="" src="/Kream/img/icon/kakao_login_medium_wide.png">
	        
	    	</a>
		</div>
<!--     	<button class="api-btn" onclick="secession()">연결 끊기</button> -->
		
	</div>
</div>

<!-- 이메일 찾기 -->
<div class = "modal" id = "findEmail" style="display: none;">
	<div class="modal-dialog">
    	<div class="modal-content">
      
	        <!-- Modal Header -->
	        <div class="modal-header">
	          <h4 class="modal-title">이메일 찾기</h4>
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	        </div>
        
        	<!-- Modal body -->
        	<div class="modal-body email">
        		<div class = "modal_select_area" showlayer = "true">
        			<div class="modify name">
						<h5 class="title2" style="padding: 0; margin: 0; font-size: 15px; color: black;">가입 시 등록한 이름를 입력하면</h5>
						<h5 class="title2" style="padding: 0; margin: 0; font-size: 15px; padding-bottom: 22px; color: black;">이메일 주소의 일부를 알려드립니다.</h5>
						<div class="input_box">
							<input type="text" autocomplete="off" id="find_name" placeholder="회원 이름" class="input_txt name">
							<button id="find_name_btn">이메일 찾기</button>
						</div>
					</div>

					<div id="findEmailResult">
					
					</div>
				</div>
        	</div>
        	        <!-- Modal footer -->
	        <div class="modal-footer email">
	        	
	        </div>
		</div>
	</div>
</div>

<!-- 비밀 번호 찾기 -->
<div class = "modal" id = "findPass" style="display: none;">
	<div class="modal-dialog">
    	<div class="modal-content">
      
	        <!-- Modal Header -->
	        <div class="modal-header">
	          <h4 class="modal-title">비밀번호 찾기</h4>
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	        </div>
        
        	<!-- Modal body -->
        	<div class="modal-body pass">
        		<div class = "modal_select_area" showlayer = "true">
        			<div class="modify name">
						<h5 class="title2" style="padding: 0; margin: 0; font-size: 15px; color: black;">가입 시 등록한 이름과 이메일을 입력하면</h5>
						<h5 class="title2" style="padding: 0; margin: 0; font-size: 15px; padding-bottom: 22px; color: black;">비밀번호 일부를 알려드립니다.</h5>
						<div class="input_box">
							
								<input type="text" autocomplete="off" id="find_pass_name" placeholder="회원 이름" class="input_txt name">
								<input type="email" autocomplete="off" id="find_pass_email" placeholder="회원 이메일" class="input_txt name">
							</div>
					</div>
						
					<div class="modify_btn_box" style="margin-top: 10px; margin-left: 0px;">
						<button id="find_pass_btn">비밀번호 찾기</button>
					</div>
					
					<div id="findPassResult">
					
					</div>
        		</div>
        	</div>
        	        <!-- Modal footer -->
	        <div class="modal-footer pass">
	          
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
