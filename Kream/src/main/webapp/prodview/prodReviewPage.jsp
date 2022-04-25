<%@page import="kr.or.ddit.kream.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel = "stylesheet" href = "/Kream/css/prodReviewPage.css">
<link rel = "stylesheet" href = "/Kream/css/pagetopline.css">
<script src = "<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<style>

</style>
<%
	MemberVO memberVo = (MemberVO)session.getAttribute("memberVo");
	String mem_email = null;
	String mem_auth = null;
	
	if(memberVo != null){
		mem_email = memberVo.getMem_email();
		if(memberVo.getAuthority() != null){
			mem_auth = memberVo.getAuthority();
		}
	}else{
		mem_email = "비회원";
	}

%>
<script>
$(function(){
	
	mem_email = "<%=mem_email%>";
	mem_auth = "<%=mem_auth%>";	
	if(mem_email == "비회원"){
		$('#member').hide();
		$('#admin').hide();
		$('#nomember').show();
	}else{
		if(mem_auth=="admin"){
			$('#member').hide();
			$('#admin').show();
			$('#nomember').hide();
		}else{
			$('#member').show();
			$('#admin').hide();
			$('#nomember').hide();
		}
	}
	
	$.ajax({
		url : '/Kream/ReviewPage.do',
		type : 'get',
		success : function(res){
			var str = "";
			
			$.each(res, function(i, v){
				str += '<div class = "feed_card item" style = "left : 0px; top:0px;">';
				str += '	<div class = "card_box">';
				str += '		<div class = "social_img_box">';
				str += '			<img class = "social_img" alt = "소셜이미지" src = "' + v.review_photopath + '">';
				str += '		</div>';
				str += '	<div class = "card_detail">';
				str += '		<div class = "user_box">';
				str += '			<img alt = "" src = "' + v.mem_photo + ' " class = "img_profile">';
				str += '			<p class = "user_name">' + v.mem_email + '</p>';
				str += '		</div>';
				str += '		<p>' + v.review_content + '</p>';
				
				str += '		<div>';
				str += '			<div class = "product_list">';
				
				str += '				<a class = "product_link" href = "/Kream/tempId.do?gubun=1&prodid=' + v.prod_id + '">';
				str += '					<div class = "product" style = "background-color : rgb(246, 238, 237)">';
				str += '						<picture class = "picture product_img">';
				str += '							<img class = "image" alt = "상품사진" src = "' + v.photo_path + '">';
				str += '						</picture>';
				str += '					</div>';
				str += '					<div class = "product_desc">';
				str += '						<p class = "product_name">' + v.prod_name + '</p>';
				str += '						<div class = "price_box">';
				str += '							<span class = "amount">' + v.prod_resell + '</span>';
				str += '							<span class = "unit">원</span>';
				str += '						</div>';
				str += '					</div>';
				str += '				</a>';
				str += '			</div>';
				str += '		</div>';
				
				str += '		</div>';
				str += '	</div>';//card-box끝
				str += '</div>';
			})
			$('.masonry_posts').html(str);
		},
		error : function(xhr){
			alert("상태 :  " + xhr.status);	
		},
		dataType : 'json'
	});
	
	
	
})


</script>
</head>
<body>
<!-- 헤더 -->
<div class="top_line fixed-top border-bottom text-end" style="height: 50px; display: flex; line-height: 50px; padding-right: 20px; background: white;">
	<ul class = "text-end" style="margin-left: auto;">
		<li><a href="<%=request.getContextPath()%>/boardview/boardMain.jsp">고객센터</a></li>
		<li><a id="member" href="<%= request.getContextPath() %>/MyPage.do" style="display: none;">마이페이지</a></li>
		<li><a id="nomember" href="<%= request.getContextPath() %>/member/loginForm.jsp">마이페이지</a></li>
		<li><a id="admin" href="<%= request.getContextPath() %>/boardview/adminMain" style="display: none;">관리자</a></li>
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
<div class="top_line fixed-top border-bottom text-end" style="height: 68px; align-items: center; display: flex; padding:0px 40px; background: white; margin-top: 50px;">
   <a href = "/Kream/prodview/prodList.jsp">
   		<h1 style=" margin:0px 0px; align-content: center; font-style: oblique; font-weight: 900;">SHOEKREAM</h1>
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
            <li class="gnb_item" style="margin-left: 30px;">
               <a class="gnb_link">SEARCH</a>
            </li>
         </ul>
      </nav>
      <div></div>
   </div>
</div>
<hr>
<div class = "container social md">
	<div class = "social_feed_header">
		<h2>스타일 리뷰</h2>
	</div>
	<div class = "content">
		<div class = "social_feeds">
			<div class = "masonry_posts" style = "position:relative; height:1500px;">
			<!-- 리뷰 리스트 출력 -->
			</div>
		</div>
	</div>
</div>

<div class="jumbotron jumbotron-fluid text-center" id="footerbody">
   
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