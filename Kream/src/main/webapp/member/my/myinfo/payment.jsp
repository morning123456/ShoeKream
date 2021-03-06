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
	margin: 0 auto;
	padding: 40px 40px 0px;
	max-width: 1280px;
	height: 100%;
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
.gobuying{
	padding: 0px 0px;
	border-style: none;
	background: #ef6253;
	border-radius: 10px;
    color: #fff;
}




</style>

<script type="text/javascript">
Kakao.init('ba2c3583e3af2fefe8d5556275e63e32');
console.log(Kakao.isInitialized()); // ????????? ????????????

login = "";

$(function(){
	$('#search_modal').on('click', function(){
		$('#searchmodal').modal('show');
	})
	
	//?????? ????????? ??????????????? ?????? ??? ?????????
   	$('#search_btn').on('click', function(){
      	//????????? ?????? ????????? ???????????? ????????????
      	input = $('#search_prod').val();
      
      	//?????? ?????? ????????? ??????
      	prodSearch(input);
   	})
	
	$('.gobuying.acc').on('click', function(){
		$('#add_Acc').toggle();
	});
	
	$('.gobuying.save').on('click',function(){
		mem_bank = $('#mem_bank option:selected').val();
		mem_acc = $('#mem_acc').val();
		
		$.ajax({
			url : '<%= request.getContextPath() %>/updateAcc.do',
			type : 'get',
			data : { "mem_bank" : mem_bank,
				"mem_acc" : mem_acc,
				"mem_email" : "<%= memberVo.getMem_email()%>"
			},
			success : function(res){
				if(res == 1){
					alert("??????????????? ??????(??????)???????????????.");
				}else{
					alert("???????????? ??????(??????)??? ?????????????????????.");
				}
			},
			error : function(xhr){
				alert("?????? " + xhr.status);
			},
			dataType : 'json'
		});
	})
	
});
</script>



</head>
<body>
<div class="top_line fixed-top border-bottom text-end" id="topline1">
	<ul class = "text-end" style="margin-left: auto;">
		<li><a class="top_line" href="<%=request.getContextPath()%>/boardview/boardMain.jsp">????????????</a></li>
		<li><a class="top_line" href="<%= request.getContextPath() %>/MyPage.do">???????????????</a></li>
<%
	if(memberVo == null){
%>
		<li id="login"><a href="<%= request.getContextPath() %>/member/loginForm.jsp">?????????</a></li>

		
<% }else{ %>
		<li id="logout"><a href="<%= request.getContextPath() %>/Logout.do">????????????</a></li>
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
	    <a class="mytitle" href="<%= request.getContextPath() %>/MyPage.do">?????? ?????????</a>
	    <ul class="meun" style="padding-left: 0px;">	
			<li class="meun title">?????? ??????</li>
			
			<li class="meun item"><a href="<%= request.getContextPath() %>/buyingList.do">?????? ??????</a></li>
			<li class="meun item"><a href="<%= request.getContextPath() %>/member/my/shopinfo/selling.jsp">?????? ??????</a></li>
			<li class="meun item"><a href="<%= request.getContextPath() %>/member/my/shopinfo/wish.jsp">?????? ??????</a></li>
			
			<li class="meun title">??? ??????</li>
			
			<li class="meun item"><a href="/Kream/member/my/myinfo/profile.jsp">????????? ??????</a></li>
			<li class="meun item"><a href="/Kream/member/my/myinfo/payment.jsp" style="color: black; font-weight: 700;">?????? ??????</a></li>
			<li class="meun item"><a href="/Kream/member/my/myinfo/point.jsp">?????????</a></li> 	
	    </ul>
	</div>
	
	<div class="my-home-area" style="overflow: hidden;">
		<div class="my-home">
			<div style="border-bottom : 3px solid; align-items: center;">
				<div class="buying-title" style=" margin-left: auto; margin-right:50px;">
					<h3>?????? ??????</h3>
				</div>
			</div>
			
			<div style="border-bottom: 1px solid #ebebeb; padding: 50px 0 38px;">
				<div class="point-detail" style="display: flex;">
					
<%
	if(memberVo.getMem_acc() == null){
%>
					<div class="prod_brand" style="margin: auto 0px;">
						<p>????????? ????????? ????????? ????????? ?????????</p>
					</div>
					
					<div class="delete" style="margin: auto 0px; margin-left: auto">
						<div class="gobuying acc" style="padding: 5px 10px; margin-right: 20px; text-align: center;">
							<p>?????? ??????</p>
							<p>??????</p>
						</div>
					</div>
	
<%
	}else{
%>
					<div class="prod_brand" style="margin: auto 0px; margin-right: 50px;">
						<p>??????</p>
						<p id="point"><%= memberVo.getMem_bank() %></p>
					</div>
					
					<div class="prod_brand" style="margin: auto 0px;">
						<p>????????????</p>
						<p id="point"><%= memberVo.getMem_acc() %></p>
					</div>
					
					
					<div class="delete" style="margin: auto 0px; margin-left: auto">
						<div class="gobuying acc" style="padding: 5px 10px; margin-right: 20px; text-align: center;">
							<p>?????? ??????</p>
							<p>??????</p>
						</div>
					</div>

<%
	}
%>

								
				</div>
			</div>
			
			<div id="add_Acc" style="border-bottom: 1px solid #ebebeb; padding: 50px 0 38px; display: none;">
				<div class="point-detail" style="display: flex;">
					<div class="form-group">
				   		<label for="sel1">??????:</label>
				  		<select class="form-control" id="mem_bank">
					    	<option>??????</option>
					    	<option>KB????????????</option>
							<option>????????????</option>
							<option>????????????</option>
							<option>????????????</option>
							<option>SC????????????</option>
							<option>??????????????????</option>
							<option>????????????</option>
							<option>???????????????</option>
							<option>????????????</option>
							<option>BNK????????????</option>
							<option>BNK????????????</option>
							<option>????????????</option>
							<option>DGB????????????</option>
							<option>????????????</option>
							<option>????????????</option>
				  		</select>
					</div>
					
					<div class="form-group" style="margin-left: 50px">
					  <label for="usr">????????????:</label>
					  <input type="text" class="form-control" id="mem_acc">
					</div>
					
					<div class="delete" style="margin: auto 0px; margin-left: auto">
						<div class="gobuying save" id="updateAcc" style="padding: 5px 10px; margin-right: 20px; text-align: center;">
							<p>??????</p>
						</div>
					</div>
				</div>
			</div>
			
		</div>	
	</div>
</div>

<div class="jumbotron jumbotron-fluid text-center" id="footerbody">
	<div class="info_list">
		<p>????????? : SHOEKREAM</p>
		<p>??????????????????: ??????????????? ?????? ????????? 846 3??? 304???</p>
		<p>????????? ????????? : ?????????????????????</p>
	
		<table>
			<tr>
				<td>PL</td>
				<td>:?????????&nbsp;</td>
				<td></td>
				<td></td>
			</tr>
			
			<tr>
				<td>TA</td>
				<td class="td_last">:?????????&nbsp;</td>
				<td>AA</td>
				<td>:?????????</td>
			</tr>
			
			<tr>
				<td>UA</td>
				<td class="td_last">:?????????&nbsp;</td>
				<td>DA</td>
				<td>:?????????</td>
			</tr>
		</table>
	</div>
	<div class="customer_service">
		<strong>
			????????????
			<a href="tel:042-939-5559">042-939-5559</a>
		</strong>
		<p>???????????? ?????? 09:00 - 17:30</p>
		<p>???????????? ?????? 12:50 - 13:40</p>
		<p>???????????? ?????? ?????? 5:30 - 22:00</p>
		<p>???????????? ?????? ?????? 9:00 - 18:00</p>
	</div>
</div>

<div class = "modal" id = "searchmodal" >
	<div class="modal-dialog">
    	<div class="modal-content search_modal_content">
      
	        <!-- Modal Header -->
	        <div class="modal-header">
	          <h4 class="modal-title">?????? ??????</h4>
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	        </div>
        
        	<!-- Modal body -->
        	<div class="modal-body">
        		<div class = "modal_select_area_search" showlayer = "true">
        			<input type = "text" id = "search_prod" name = "search_prod">
        			<input type = "button" id = "search_btn" name = "search_btn" value = "??????">
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