<%@page import="kr.or.ddit.kream.vo.MemberVO"%>
<%@page import="kr.or.ddit.kream.vo.SizeVo"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.kream.vo.PhotoVo"%>
<%@page import="kr.or.ddit.kream.vo.BidVo"%>
<%@page import="java.util.Map"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1">
<script src = "<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>

<link rel = "stylesheet" href = "/Kream/css/agree.css">

<%
	String prodid = (String) request.getAttribute("prodid");
	String size_name = (String) request.getAttribute("size_name");
	String bid_price = (String) request.getAttribute("bid_price");
	
	String size_id = (String) request.getAttribute("size_id"); // 추가
	
	MemberVO memberVo = (MemberVO)session.getAttribute("memberVo");
%>


 
<script>


	
	



$(function(){
		
	// 상품 사진, prod_id,prod_name
	$.ajax({
		url : "/Kream/SellPhoto.do",
		type : 'get',
		data : {
			"prodid" : "<%=prodid%>"
		},
		success : function(res){
			str = '    <div class="product" style=background:#ebf0f5>';
			str += '		<img width="100px" id = "shoeimg" src = "' + res.photo_path + '" alt = "' + res.prod_name +'">';
			str +='    </div>';
			$('.prod_img').html(str);
			
			con = '					<h4 class = "brand">' + res.brand_name + '</h4>';
			con += '					<p class = "title">' + res.prod_name + '</p>';	
			con += '					<p class = "title">' + <%=size_name%> + '</p>';	
			
			$('.content').html(con);
           // str+='    </div>'
			//$('.photo').html(str);
			
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		},
		dataType : 'json'
	})
	
	
	 cnt = 0;
	 $(document).on('click','.ckBox', function() {
		 cnt++;
		 //console.log(cnt);
		 if(cnt >= 5){
			  $('.btn_division').css("opacity","1");
		 } 
	  }); 
  
		
	
  })
</script>







<title>Insert title here</title>




</head>
<body>

<div class="header">
	<div class="header_top">
		<div  class="top_inner">
			<ul class="top_list">
				<li><a class="black"  href="#">고객센터</a></li>
				<li><a class="black" href="<%= request.getContextPath() %>/MyPage.do">마이페이지</a></li>
				
	<%
	if(memberVo == null){
%>
		<li id="login"><a class="black" href="<%= request.getContextPath() %>/member/loginForm.jsp">로그인</a></li>

		
<% }else{ %>
		<li id="logout"><a class="black" href="<%= request.getContextPath() %>/Logout.do">로그아웃</a></li>
<%
	}
%>
				
				
			</ul>
		</div>
	</div>
	<hr>
	<div class="main_inner">
	<a class="black" href = "/Kream/prodview/prodList.jsp">
   		<h1 style=" margin:0px 0px; align-content: center; font-style: oblique; font-weight: 900;">
   		SHOEKREAM
   		</h1>
   </a>
	
	
	<div class="center">
			<h2 class="title"><span class="title_txt">판매하기</span></h2>
		</div><!-- class="center" -->
		<div class="right">
			<button type="button" class="btn btn_standard outlinegrey small"> 검수기준 </button>
		</div><!-- class="right" -->
	</div><!-- class="main_inner" -->
</div><!-- class="header" -->
	
	
		<!-- <h1><a href="#" aria-label="홈" class="logo">SHOEKREAM</a></h1>
		<div class="center">
			<h2 class="title"><span class="title_txt">구매동의</span></h2>
		</div>
		<div class="right">
			<button type="button" class="btn btn_standard outlinegrey small"> 검수기준 </button>
		</div>
	</div>
</div> -->








      <div class="allbig">
           <div class="bigtitle"> 

           	  <div data-v-3b9b7196="" class="title_area">
                <h2 data-v-3b9b7196="" class="check_title">
                 <span data-v-3b9b7196="" class="accent_text">판매</span>하시기 전에 
                   <br data-v-3b9b7196="" class="br_mo">꼭 확인하세요. </h2>
              </div>
           
					<div class="prod">
							<div class="prod_img">
							</div>
							<div class="content">
							</div>
					</div>
          </div><!-- <class="bigtitle"> -->



<div class="bigbottom">
       <ul data-v-5e593dfe="" data-v-1fa826c8="" class="check_list md">
          <li data-v-5e593dfe="" class="check_item">
              <a data-v-5e593dfe="" href="#" class="check_area">
                 <div data-v-5e593dfe="" class="notice_group">
                   <p data-v-5e593dfe="" class="notice_maintext">판매하려는 상품이 맞습니다.</p>
                      <p data-v-5e593dfe="" class="notice_subtext">상품 이미지, 모델번호, 출시일, 상품명, 사이즈를 한 번 더 확인했습니다.</p>
                      </div>
   <div data-v-4c714e9f="" data-v-5e593dfe="" class="checkbox_item">
  <input type="checkbox" class="ckBox">
      <label data-v-4c714e9f="" for="undefined" class="check_label">

	  </div>
         </a>
       </li>
      <li data-v-5e593dfe="" class="check_item">
          <a data-v-5e593dfe="" href="#" class="check_area">
                 <div data-v-5e593dfe="" class="notice_group">
                      <p data-v-5e593dfe="" class="notice_maintext">국내/해외에서 발매한 정품 · 새상품입니다.</p>
                             <p data-v-5e593dfe="" class="notice_subtext">모든 구성품이 그대로이며, 한 번도 착용하지 않은 정품・새상품입니다. 중고품 판매는 불가능합니다.</p>
                </div>
               <div data-v-4c714e9f="" data-v-5e593dfe="" class="checkbox_item">
                  <input type="checkbox" class="ckBox">
                         <label data-v-4c714e9f="" for="undefined" class="check_label">
	  </div>
        </a>
     </li>
      <li data-v-5e593dfe="" class="check_item">
          <a data-v-5e593dfe="" href="#" class="check_area">
                 <div data-v-5e593dfe="" class="notice_group">
                      <p data-v-5e593dfe="" class="notice_maintext">박스/패키지의 상태를 확인합니다</p>
                             <p data-v-5e593dfe="" class="notice_subtext">박스/패키지 상태에 따른 검수 기준을 확인했습니다.</p>
                </div>
               <div data-v-4c714e9f="" data-v-5e593dfe="" class="checkbox_item">
                  <input type="checkbox" class="ckBox">
                         <label data-v-4c714e9f="" for="undefined" class="check_label">
	  </div>
        </a>
     </li>
     
<li data-v-5e593dfe="" class="check_item">
      <a data-v-5e593dfe="" href="#" class="check_area">
            <div data-v-5e593dfe="" class="notice_group">
                 <p data-v-5e593dfe="" class="notice_maintext">이중 포장하여 선불 발송합니다.</p>
                  <p data-v-5e593dfe="" class="notice_subtext">반드시 이중 포장하여 택배 상자에 담아 선불 발송합니다. 합배송은 권장하지 않으며 이로 인한 박스/패키지 훼손은 판매자의 책임입니다.</p>
           </div>
          <div data-v-4c714e9f="" data-v-5e593dfe="" class="checkbox_item">
     		<input type="checkbox" class="ckBox">
		<label data-v-4c714e9f="" for="undefined" class="check_label">
		</label>
		</div>
	 </a>
</li>

<li data-v-5e593dfe="" class="check_item">
      <a data-v-5e593dfe="" href="#" class="check_area">
            <div data-v-5e593dfe="" class="notice_group">
                 <p data-v-5e593dfe="" class="notice_maintext">KREAM의 최신 이용정책을 모두 확인하였으며, 판매를 계속합니다.</p>
                  <p data-v-5e593dfe="" class="notice_subtext">건전하고 안전한 거래를 위해 반드시 숙지해야 할 미입고, 페널티, 부정거래 등의 이용정책을 확인했습니다.</p>
           </div>
          <div data-v-4c714e9f="" data-v-5e593dfe="" class="checkbox_item">
     		<input type="checkbox" class="ckBox">
		<label data-v-4c714e9f="" for="undefined" class="check_label">
		</label>
		</div>
	 </a>
</li>
<br>
<a href = "/Kream/SellLastController.do?size_name=<%=size_name %>&bid_price=<%=bid_price %>&prodid=<%=prodid %>&size_id=<%=size_id %> " class = "btn_division sell">판매계속</a>

 </div>
</div><!-- <div class="allbig"> -->






</body>
</html>