<%@page import="kr.or.ddit.kream.vo.MemberVO"%>
<%@page import="kr.or.ddit.kream.vo.SizeVo"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.kream.vo.PhotoVo"%>
<%@page import="kr.or.ddit.kream.vo.BidVo"%>
<%@page import="java.util.Map"%>

<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ page import="java.text.*" %>
    
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src = "<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
  
   <link rel = "stylesheet" href = "/Kream/css/buyLast.css">
 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


<%



	String prodid = (String) request.getAttribute("prodid");
	String size_name = (String) request.getAttribute("size_name");
	String bid_price = (String) request.getAttribute("bid_price");
	String sizeId = (String) request.getParameter("size_id"); // 추가
	
	MemberVO memberVo = (MemberVO)session.getAttribute("memberVo");
	
	
 	DecimalFormat df = new DecimalFormat("###,###");
	
 	int price = Integer.parseInt(bid_price);
 	String dfMoney = df.format(price);
	
%>
 

 

 <script>
  
 //'판매 입찰 계속'버튼을 누르면 css가 바뀌는 메서드
 $(document).on('click','.deadline_tab', function() {
	 
		  $('.btn_full').css("opacity","1");
		  $('.btn_full').attr("check","checked");
  })
  //
//  $(document).on('click','.btn_full', function() {
	 

		  
	  
//  });
 
 
  
  
 $(document).ready(function(){
	 
	 $('.item_link').on('click',function(){
		 $('.item_link').css('background','#41b979');
		 $('.item_link').css('color','#fff');
		 
		 $('.item_link2').css('background','#f4f4f4');
		 $('.item_link2').css('color','rgba(34,34,34,.8)');
	 })
	 	 
	  $('.item_link2').on('click',function(){
		
		  $('.item_link2').css('background','#41b979');
		  $('.item_link2').css('color','#fff');
		  
		  $('.item_link').css('background','#f4f4f4');
		  $('.item_link').css('color','rgba(34,34,34,.8)');	
	 })
	 
	<%--   console.log("bprice : <%=bid_price%>"); --%>
	 
	 temp_bid = ("<%=bid_price%>").replace(",", "").trim();
	 
	  if(temp_bid != 0 ){
		 $('.item_link2').trigger('click');  //가격있으면 즉시 판매
	 } else {
		 $('.item_link2').unbind('click').css('pointer-events','none');
		 $('.item_link').trigger('click');   //판매입찰
	 }  
	 
 });
 
  
  
 
 $(function() { 
	 
	//판매입찰가격이 즉시판매보다 작을 경우 자동으로 즉시판매로 이동
	   $(document).on('click','.deadline_tab', function() {
	    	var amout = $('.input_amount').val();
	    	//var unit = $('.input_amount').val();
	    	 
	    	if(amout < <%=bid_price%>){
		    	
	    		$('.item_link2').trigger('click');
	    	}
	    	 
	    	//판매희망가 가격을 정산금액에 넣음
	    	else{
	    		$('.amount').html(amout);
	    		$('.launit').html('원');
	    	}
	    		
	    });
	   
	    
	    
	    
         // 판매입찰계속 버튼 클릭시 이벤트 (판매입찰 가격) 
	    $(document).on("click", ".btn_full", function(e){
	    	e.preventDefault();
	    	
	  	  if($('.btn_full').attr("check") != "checked"){
				  alert("입찰 마감기한을 선택하세요.");
		  }else{
		    	var amout = $('.input_amount').val();
		    	location.href = '/Kream/SellOrder.do?amout=' + amout + '&sizeId=<%=sizeId%>&prod_id=<%=prodid%>';
		  }//if문 끝
	    });//판매입찰계속 버튼 클릭시 이벤트 끝
         
	    
	});
 

 function proc1(){  //판매입찰 
	 
		 
out="	 <div  class='price_now active_input'>                                                            ";
out+="     <dl class='price_now_box'>                                                                     ";                                                                                     
out+="           <dt class='price_now_title'> 판매 희망가 </dt>                                               ";                                                                                     
out+="           <dd class='price7'>                                                                       ";                                                                                   
out+="<input type='text' pattern='([0-9]+.{0,1}[0-9]*,{0,1})*[0-9]' required='required' placeholder='희망가 입력' autocomplete='off' class='input_amount'>";
out+="                <span class='unit'>원</span>                                                        ";                                                                                   
out+="           </dd>                                                                                    ";                                                                                                        
out+="     </dl>                                                                                          ";                                                                                                        
out+="<div class='price_warning' style='display: none;'>                                                  ";                                                                                   
out+="</div>                                                                                              ";                                                                                                        
out+="</div>                                                                                              ";                                                                                                        
out+="<div class='price_bind'>                                                                            ";                                                                                    
out+="   <dl class='price_addition'>                                                                      ";                                                                  
//out+="        <dt class='price_title'>                                                                    ";                                                                                     
out+="              <span>검수비</span>                                                                     ";                                                                                                        
out+="              <span class='endfree'>-</span>                                                                     ";                                                                                                        
//out+="        </dt>                                                                                       ";                                                                                                        
//out+="        <dd class='price_text'>-                                                                    ";                                                                                     
//out+="         </dd>                                                                                      ";                                                                                                        
out+="   </dl>                                                                                            ";                                                                                                        
//out+="    <dl class='price_addition'>                                                                     ";                                                                 
//out+="           <dt class='price_title'>                                                                 ";                                                                                     
out+="                 <span>수수료</span>                                                                  ";                                                                                    
//out+="                   </button>                                                                       ";                                                                                                        
//out+="           </dt>                                                                                    ";                                                                                                        
out+="           <span class='endfree'>-                                                                 ";                                                                                     
out+="            </span>                                                                                   ";                                                                                                        
out+="     </dl>                                                                                          ";                                                                                                        
out+="      <dl class='price_addition'>                                                                   ";                                                                  
//out+="          <dt class='price_title'>                                                                  ";                                                                                    
out+="                 <span>배송비</span>                                                                  ";                                                                                     
//out+="          </dt>                                                                                     ";                                                                                                        
out+="          <span class='price_text'>선불 ・ 판매자 부담                                                      ";                                                                                    
out+="          </span>                                                                                     ";                                                                                                        
out+="     </dl>                                                                                          ";                                                                                                        
out+="</div>                                                                                              ";                                                                                                        
out+="<div class='deadline_info_area'>                                                                    ";                                                                  
out+="    <div class='section_title'>                                                                     ";                                                                                     
out+="          <h3 class='title_txt'>입찰 마감기한</h3>                                                      ";                                                                                     
out+="    </div>                                                                                          ";                                                                                                        
out+="    <div class='section_content'>                                                                   ";                                                                                     
out+="          <div class='bid_deadline'>                                                                ";                                                                                     
//out+="                  <p class='deadline_txt'> 30일 (2022/05/18 마감) </p>                              ";                                                                                     
out+="                <div class='deadline_tab'>                                                          ";                                                                                     
out+="                      <a href='#' class='btn outlinegrey medium'> 1일 </a>                          ";                                                                  
out+="                      <a href='#' class='btn outlinegrey medium'> 3일 </a>                          ";                                                                 
out+="                       <a href='#' class='btn outlinegrey medium'> 7일 </a>                         ";                                                                 
out+="                        <a href='#' class='btn outlinegrey medium is_active'> 30일 </a>             ";                                                                  
out+="                        <a href='#' class='btn outlinegrey medium'> 60일 </a>                       ";                                                                                                              
out+="                 </div>                                                                             ";                                                                                                              
out+="           </div>                                                                                   ";                                                                                                              
out+="     </div>                                                                                         ";                                                                                                              
out+="</div>                                                                                              ";                                                                                                              
out+="<div class='buy_total_price'>                                                                       ";                                                                                                              
out+="     <div class='price_total'>                                                                      ";                                                                                                              
out+="           <dl class='empty_price'>                                                                   ";                                                                                                              
out+="                   <span class='price_title'> 정산금액 </span>                                             ";                                                                                                              
//out+="                   <span class='empty_price'>                                                         ";                                                                                                              
out+="                            <span class='amount'></span>                                           ";                                                                                                              
out+="                             <span class='launit'></span>                                             ";                                                                                                              
//out+="                    </span>                                                                           ";                                                                                                              
out+="             </dl>                                                                                  ";                                                                                                              
out+="            <span class='price_warning' style='display: none;'><em>주의! </em>                       ";                                                                                                            
out+="             </span>                                                                                ";                                                                                                              
out+="      </div>                                                                                        ";                                                                                                              
out+="<a  href='#' class='btn_full'> 판매 입찰 계속 </a>";
out+="</div>                                                                                              ";                                                                                                              
                                                                                                                                                                                                                        
 document.getElementById('result').innerHTML = out;	 
 }
 
 
 
 
 function proc2(){ //즉시 판매
	
	 out="	 <div class='price_now'>                                     "     ;
	 out+="	   <dl class='price_now_box'>                                "     ;
	 out+="	     <dt class='price_now_title'>즉시판매가</dt>                 "    ;
	 out+="	       <dd class='price2'>                                    "     ;
	 out+="	         <span class='amount'><%=dfMoney %></span>     "     ;
	 out+="	         <span class='unit'>원</span>                        "     ;
	 out+="	        </dd>                                                "     ;
	 out+="	   </dl>                                                     "     ;
	 out+="   <div class='price_warning' style='display:none;'></div>     "    ;
	 out+="	 </div>                                                       "     ; //<!-- price_now끝 -->
	 out+="	 <div class='price_bind'>                                    "     ;
	 out+="	   <dl class='price_addition'>                               "     ;
	 //out+="	      <dt class='price_title'>                               "     ;
	 out+="	        <span>검수비<span>                                    "     ;
	// out+="	       </dt>                                                 "     ;
	// out+="	       <dd class='price_text'>                               "     ;
	 out+="	          <span class='free'>무료<span>                                             "     ;
	// out+="	       </dd>                                                 "     ;
	 out+="	   </dl>                                                     "     ;
	 out+="	   <dl class='price_addition'>                               "     ;
	// out+="	      <dt class='price_title'>                               "     ;
	 out+="	        <span>수수료</span>                                    "     ;
	 //ut+="	       </dt>                                                 "     ;
	 out+="	       <span class='free'>무료</span>                             "     ;
	 //out+="	       </dd>                                                 "     ;
	 out+="	   </dl>                                                     "     ;
	 out+="	   <dl class='price_addition'>                               "     ;
	 //out+="	      <dt class='price_title'>                               "     ;
	 out+="	        <span>배송비</span>                                    "     ;
	 //out+="	       </dt>                                                 "     ;
	 out+="	       <span class='txfree'>선불 ・ 판매자 부담</span>                   "     ;
	 //out+="	       </dd>                                                 "     ;
	 out+="	   </dl>                                                     "     ;
	 out+="	<div class='buy_total_price'>                                "     ;
	 out+="	  <div class='price_total'>                                  "     ;
	 out+="	    <dl class='price_box'>                                   "     ;
	 out+="	      <span class='price_title'>정산금액</span>                     "    ;
	 out+="	      <dd class='lastprice2'>                                     "     ;
	 out+="	        <span class='amount lastpr'><%=dfMoney %></span>               "     ;   
	 out+="	        <span class='launit'> 원</span>                         "      ;
	 out+="	       </dd>                                                 "     ;
	 out+="	    </dl>                                                    "     ;
	 out+="	  </div>                                                     "     ;//<!-- class="price_total" -->
	 out+="<a  href='/Kream/DrSellOrder.do?prod_id=<%=prodid%>&bid_price=" + temp_bid + "&sizeId=<%=sizeId%>' class='solid'>즉시 판매 계속</a>";
	 out+="	 </div>                                                      "     ;//<!-- class="buy_total_price" -->
	
     document.getElementById('result').innerHTML = out;	 
 
     }
 
 $(function(){
	
	$.ajax({ //상품정보 가져오기 
		url : '/Kream/SellLastPhoto.do',
		type : 'get',
		data : {
			"prodid" : "<%=prodid%>"
		},
		success : function(res){
			str = '  <div class="product" style=background:#ebf0f5>';
			str += '    <img  width="100px" id = "shoeimg" src = "' + res.photo_path + '" alt = "' + res.prod_name +'">';
			str += '   </div>';
			$('.prod_img').html(str);
			
			
		 	con = '<b class="brand_name">'+ res.brand_name + '</b><br>';
			con += '<p class="title">' + res.prod_name + '</p>';
			con += '<p class="title">' + <%=size_name%> + '</p>';
			$('.content').html(con);	  	
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		},
		dataType : 'json'
	})
 
 
	
	 $.ajax({  //즉시 판매가 가져오기 
		url : '/Kream/sellNowCallCont.do',
		type : 'get',
		data : {
			"size_name" : "<%=size_name%>", 
			"prodid" : "<%=prodid%>"
		},
		success : function(res){
			str='';
		 	
		 	if(res == 0){
		 	    str+='  -  ' ;
		 	} else{
		 	//	str+= ''+ res +'' ;
		 		str+= ''+ res.toLocaleString('ko-KR') +'' ;
		 	}  
		 	
			$('.price').html(str);	  	
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		},
		dataType : 'json'
	 }) 
 
 })
 
 
 </script>


<style>
.price_text{
	 text-indent:100px; 
	margin-left: 50px;
}

</style>


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
	
		<!-- <h1><a href="#" aria-label="홈" class="logo">SHOE KREAM</a></h1> -->
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

<div class="big">
 <div class="prod">
		<div class="prod_img">
		</div>
		<div class="content">
		</div>
</div>


<div class="price_descision">
 <ul class="price_list">
   <li class="list_item">
     <p class="Toptitle">즉시 구매가</p>
     <span class="price"></span>
     <span class="Topunit">원</span>
   </li>
   <li class="list_item2">
     <p class="Toptitle">즉시 판매가</p>
     <span class="price1"><%=dfMoney %></span>
     <span class="Topunit">원</span>
   </li>
 </ul>
<div class="instant_group">
  <div class="tab_area">
    <ul class="tab_list">
       <li class="item">
          <a class="item_link" onclick="proc1()"><span class="bidname">판매입찰</span></a>
        </li>
        <li class="item on">
          <a class="item_link2" onclick="proc2()"><span class="bidname">즉시 판매</span></a>
        </li>
    </ul>
  </div><!-- class="tab_area buy_tab" -->
  
<div id="result"></div>

   </div> <!-- class="instant_group" -->
  </div><!-- class="price_descision_box" -->
 </div><!-- class="price_descision" -->
</div><!-- class=big -->
</body>
</html>