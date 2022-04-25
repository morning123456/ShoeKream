<%@page import="kr.or.ddit.kream.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel = "stylesheet" href = "/Kream/css/pagetopline.css">
<link rel = "stylesheet" href = "/Kream/css/order.css">
<script src = "<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<style>
#gohistory{
	cursor: pointer;
}
</style>
<%

	MemberVO memberVo = (MemberVO)session.getAttribute("memberVo");
	
	if (session.getAttribute("memberVo") == null) {
	    response.sendRedirect("logout.jsp");
	}
	
	String prod_id = (String)request.getAttribute("prod_id");
	String sizeId = (String)request.getAttribute("size_id");
	String bid_position = (String)request.getAttribute("bid_position");
 	int bid_price = (int)request.getAttribute("bid_price");
 	int point = (int)request.getAttribute("point");
	int price = bid_price + 3000 - point;
%>
<script>
$(function(){
	//상품정보 가져오기 
	$.ajax({
		url : '/Kream/OrderController.do',
		type : 'post',
		data : {
			"sizeId" : "<%=sizeId%>"
		},
		success : function(res){
			str = '<img id = "big_img" src = "' + res.photo_path + '" alt = "' + res.prod_name +'">';
			$('#prod_img_big').html(str);
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		},
		dataType : 'json'
	})
	
	$('#gohistory').on('click', function(){
		history.go(-6);
		
	})
})
</script>
</head>
<body style="padding : 0px;">
<div class="header">
<!-- 헤더 -->
<div class="top_line fixed-top border-bottom text-end" style="height: 50px; display: flex; line-height: 50px; padding-right: 20px; background: white; border-bottom: 1px solid #dee2e6!important;">
	<ul class = "text-end" style="margin-left: auto;">
		<li><a href="#">고객센터</a></li>
		<li><a href="<%= request.getContextPath() %>/MyPage.do">마이페이지</a></li>
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

	<div class="main_inner">
		<a class="black" href="/Kream/prodview/prodList.jsp">
			<h2
				style="margin: 0px 0px; align-content: center; font-style: oblique; font-weight: 900;">
				<img src="/Kream/img/main/로고.PNG" class="margin_top">
			</h2>
		</a>
		<div class="center">
			
		</div>
		<div class="right">
			<button type="button" class="btn btn_standard outlinegrey small margin_top">
				검수기준
			</button>
		</div>
	</div>
</div>



<div class="main_com">
	<div id="prod_img_big"></div>
	<div>
		<div class="con_center">
			<h2><% String result = ((bid_position.equals("buyer")) ? "구매" : "판매" );  %> <%=result%> 입찰이 완료되었습니다.</h2>
			 <p>결제는 거래가 성사되는 시점에<p>
			 <p>등록하신 결제 정보로 자동 처리 됩니다.</p>
			<div class="inline_btn">
			 	 <a href="/Kream/buyingList.do" class="com_btn" >내역 상세보기</a>	
			 	 <a  class="com_btn" id="gohistory" >SHOP 상세보기</a>	
			</div>
			<p>구매내역 > 입찰 중’ 상태일 때는 입찰 지우기가 가능합니다.</p>
		</div>
	</div>
	<div class="orderInfo">
		<h3 class="point_top">최종 주문 정보</h3>
			<p><% String result2 = ((bid_position.equals("buyer")) ? "결제" : "정산" );  %> 총 <%=result2%> 금액</p>
			<% if(result.equals("구매")){ %> 
			<p class="right" id="pay_money"><%=price%>원</p>
			 <% }else{ %>	
			 <p class="right" id="pay_money"><%=bid_price%>원</p>
			 <% } %>	
			<hr>
			<table class="order_tb">
				<tr>
				<% if(result.equals("구매")){ %> 
					<td><b>구매 희망가</b></td>
				 <% }else{ %>	
				 	<td><b>판매 희망가</b></td>
				 <% } %>	
					<td id="bid_price"><b><%=bid_price%>원</b></td>
				</tr>
				 <% if(result.equals("구매")){ %> 
				<tr>
					<td>사용 포인트</td>
					<td><%=point%></td>
				</tr>
			  <% } %>	
				<tr>
					<td>검수비</td>
					<td>무료</td>
				</tr>
				<tr>
					<td>수수료</td>
					<td>무료</td>
				</tr>
				 <% if(result.equals("구매")){ %> 
				<tr>
					<td>배송비</td>
					<td>3000원</td>
				</tr>
			  <% } %>	
			</table>
			
	</div>
</div>

<div class="jumbotron jumbotron-fluid text-center" id="footerbody" style="background : white;">
   
   <div class="info_list">
      <p>팀이름 : SHOEKREAM</p><br>
      <p>사업장소재지: 대전광역시 중구 계룡로 846 3층 304호</p><br>
      <p>호스팅 서비스 : 대덕인재개발원</p><br><br>
      
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
</body>
</html>