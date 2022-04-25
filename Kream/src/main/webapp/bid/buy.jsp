
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
  <link rel = "stylesheet" href = "/Kream/css/buybidPrice.css">
  
  <!-- <link rel = "stylesheet" href = "/Kream/css/pagetopline.css">
  <link rel = "stylesheet" href = "/Kream/css/prodSearchModal.css"> -->
 
  <!--  --><!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css"> -->
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>





<% 
 	String prodid = (String) request.getAttribute("prodid"); 
    
MemberVO memberVo = (MemberVO)session.getAttribute("memberVo");
 
 
 
 %> 
 
 <style>
 button{
 width: 200px;
 height: 70px;
 margin: 5px;
 } 
 </style>
 
 
 <script> 
 
//'search' 클릭시 모달 실행
	$('#search_modal').on('click', function(){
			$('#searchmodal').modal('show');
	})
 
 
 
	
 $(function() {
	    $(document).on('click','.btnsize', function() {
	    	$('.btnsize').removeAttr("style");
	    	 $(this).css('border','2px solid black');
	    	  $('#btn_a').css("display","block");
	    });
  });
  
 
 
 $(function(){
	
	//상품정보 가져오기 
	$.ajax({
		url : '/Kream/prodDetail.do',
		type : 'post',
		data : {
			"prodid" : "<%=prodid%>"
		},
		success : function(res){
			str = '  <div class="product" style=background:#ebf0f5;>';
			str += '    <img  width="100px" id = "shoeimg" src = "' + res.photo_path + '" alt = "' + res.prod_name +'">';
			str += '   </div>';
			$('.prod_img').html(str);
			
			
		 	con = '<b class="brand_name">'+ res.brand_name + '</b><br>';
			con += '<p class="prod_name">' + res.prod_name + '</p><br>';
			$('.content').html(con);	  	
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		},
		dataType : 'json'
	})
	 
	
		
	 // 상품 상세페이지의 prod_id 가져와서 사이즈, 가격 가져오기 
	$.ajax({
		url : "/Kream/buyInfo.do",
		type : 'get',
		data : {
			"prodid" : "<%=prodid%>"
			},
		success : function(res){
			str ="";
			
			str += '			<div class="sell_before_select">';
			str += '  			    <div class="select_area mo column_duoble" style="margin: 0 auto;background: white;">';
			
			$.each(res, function(i, v){
			str += '  		 				<input type="radio" hidden id="lblsize' + i + '" name="<%=prodid%>" value="btnsize' + i + '">';
			str += '							<button id="btnsize' + i + '" type="button" class="btnsize btn btn-outline-dark">';
			str += '               				   <div class="link_inner">';
			str += '                				   <span id="sName">' + v.size_name + '</span>';
			str += '                				   <span id="sid" hidden >' + v.size_id + '</span>';
			str += '                				   <br>';   

			console.log(v.bid_price);
			
			if(v.bid_price == 0){
				 str += '                             <span id="bPrice">구매입찰</span>';
				
			}else{
				str += '                              <span id="bPrice">' + v.bid_price + '</span>';
			}   
				str += '			               </div>'; //class="link_inner"
			    str += '		 				</button>';
			
			     });
			str += '  				 </div>'; //class="select_area mo column_duoble"
			str += '			<div class="order_btn_area">'; 
			str += '			<a href = "javascript:bidFormSubmit()" id = "btn_a">';//서블릿 보내서 페이지 이동

			
			str += '					<div class="box">'; 
			str += '						<div class="order_case_info">'; //사이즈 클릭 시 가격 정보가 버튼에 출력
			str += '							<span></span>'; //가격
			str += '							<span id="send">배   송</span>'; 
			str += '						</div>'; //class="order_case_info"
			str += '					</div>'; //class="box"
			str += '				</a>'; 
			str += '			</div>'; //class="order_btn_area"
			str += '		</div>'; //class="sell_before_select"
			str += '      </div>';//class="sell_before_check"
			str += '     </div>';//class="sell_before"
			str += '  </div>';//class="content-area"
			str += '</div>'; //class="container-sm"
			
			
			$('.container').html(str); 
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		},
		dataType : 'json'
	})
	
	
	$(".container").on("click",".btnsize", function(){
		let thisId = $(this).attr("id");
		let num = thisId.substring( "btnsize".length );
		$("#lblsize" + num).prop("checked", true);
	});
	
})
  
function bidFormSubmit(){
	
	var selBid = $("input[name='<%=prodid%>']:checked").val();
	if(selBid==undefined){
		alert("선택 후 사용하세요");
		return;
	}
	
	var sName = $("#" + selBid).find("#sName").text();
	var bPrice = $("#" + selBid).find("#bPrice").text();
	var sid = $("#" + selBid).find("#sid").text();  //추가
	if(bPrice=="구매입찰"){
		bPrice = 0;
	}
	
	$("#bidForm").find("[name=size_name]").val( sName );
	$("#bidForm").find("[name=bid_price]").val( bPrice );
	$("#bidForm").find("[name=size_id]").val( sid );  //추가
	$("#bidForm").get(0).submit();
}  
</script>





<title>Insert title here</title>
</head>
<body>

<div class="all" >
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
		</div><!-- class="top_inner" -->
	</div><!-- class="header_top" -->
	<hr>
	<div class="main_inner">
		
		<a class="black" href = "/Kream/prodview/prodList.jsp">
   		<h1 style=" margin:0px 0px; align-content: center; font-style: oblique; font-weight: 900;">
   		SHOEKREAM
   		</h1>
   </a>
		
		
		<div class="center">
			<h2 class="title"><span class="title_txt">구매하기</span></h2>
		</div><!-- class="center" -->
		<div class="right">
			<button type="button" class="btn btn_standard outlinegrey small"> 검수기준 </button>
		</div><!-- class="right" -->
	</div><!-- class="main_inner" -->
</div><!-- class="header" -->
<div class="end">
 <div class="prod" style="margin: 0  auto; margin-top: 20px;" >
		<div class="prod_img">
		</div>
		<div class="content">
		</div>
  </div><!-- class="prod" -->


<form id="bidForm" action="/Kream/buyAgreeServlet.do">
	<input type="hidden" name="prodid" value="<%=prodid%>">
	<input type="hidden" name="size_name">
	<input type="hidden" name="bid_price">
	<input type="hidden" name="size_id">   <!-- size_id 추가 -->
</form>

 
	<div class="photo"></div>	
	<div class="container"></div> <!-- 가격정보 container 끝 -->
</div><!-- class="end" -->


</body>
</html>