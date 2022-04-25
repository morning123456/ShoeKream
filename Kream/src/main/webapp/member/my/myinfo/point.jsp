<%@page import="kr.or.ddit.kream.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	MemberVO memberVo = (MemberVO)session.getAttribute("memberVo");
	
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="<%=request.getContextPath()%>/js/kakao.js"></script>
<script src = "<%=request.getContextPath()%>/js/searchProd.js"></script>
<link rel = "stylesheet" href = "/Kream/css/pagetopline.css">
<link rel = "stylesheet" href = "/Kream/css/prodSearchModal.css">
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
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
	height: 100%;
	margin: 0 auto;
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
.point-detail{
    padding: 30px;
    margin-top: 12px;
    border-radius: 10px;
    background-color: #fafafa;
    border: 1px solid #ebebeb;
}
p{
	margin: 0px 0px;
}
#point{
	font-size: 24px;
	font-weight: bold;
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
});
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
			
			<li class="meun item"><a href="/Kream/member/my/myinfo/profile.jsp">프로필 정보</a></li>
			<li class="meun item"><a href="/Kream/member/my/myinfo/payment.jsp">결제 정보</a></li>
			<li class="meun item"><a href="/Kream/member/my/myinfo/point.jsp" style="color: black; font-weight: 700;">포인트</a></li> 	
	    </ul>
	</div>
	
	<div class="my-home-area" style="overflow: hidden;">
		<div class="my-home">
			
			<div style="border-bottom : 3px solid; align-items: center;">
				<div class="buying-title" style=" margin-left: auto; margin-right:50px;">
					<h3>포인트 정보</h3>
				</div>
			</div>
			
			<div style="border-bottom: 1px solid #ebebeb; padding: 50px 0 38px;">
				<div class="point-detail" style="display: flex;">
					
					<div class="prod_brand" style="margin: auto 0px;">
						<p>사용가능한 포인트</p>
						<p id="point"><%= memberVo.getMem_point() %>P</p>
					</div>
								
				</div>
			</div>
			
		</div>	
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