<%@page import="kr.or.ddit.kream.vo.LprodVo"%>
<%@page import="kr.or.ddit.kream.vo.MemberVO"%>
<%@page import="kr.or.ddit.kream.vo.MainPageProdVo"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
<html>
<head>
<meta charset="UTF-8">
<link rel = "stylesheet" href = "/Kream/css/prodMain.css">
<link rel = "stylesheet" href = "/Kream/css/pagetopline.css">
<link rel = "stylesheet" href = "/Kream/css/prodSearchModal.css">


<meta name="viewport" content="width=device-width, initial-scale=1">

<script src = "<%=request.getContextPath()%>/js/searchProd.js"></script>
<script src = "<%=request.getContextPath()%>/js/prodBoard.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<%-- <script src = "<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script> --%>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<title>ShoeKream</title>

<script type="text/javascript">
	var categoryChk1 = [];//카테고리가 저장될 배열
	var categoryChk2 = [];//카테고리가 저장될 배열
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
   	
	//체크박스를 클릭하면
	$('.filter_menu').on('click', 'input[class="cat"]', function(){
// 		alert($(this).val());
		//체크하면 checked 속성 추가 체크 없으면 checked 속성삭제
		if($(this).attr('checked') != 'checked'){
			if($(this).attr('name') == "aaa"){
				$(this).attr('checked', true);
				categoryChk1.push($(this).val());
			}else{
				$(this).attr('checked', true);
				categoryChk2.push($(this).val());
			}
		}else{
			if($(this).attr('name') == "aaa"){
				$(this).removeAttr('checked');
				idx = categoryChk1.indexOf($(this).val());
				categoryChk1.splice(idx, 1);
			}else{
				$(this).removeAttr('checked');
				idx = categoryChk2.indexOf($(this).val());
				categoryChk2.splice(idx, 1);
			}
		}
		console.log($(this).attr('checked'))
		console.log("카테고리 : " + categoryChk1);
		console.log("브랜드 : " + categoryChk2);
		
		//카테고리 별 출력
		$.ajax({
			url : '/Kream/CategoryProdlist.do',
			type : 'get',
			data : { 
				"categoryChk1" : categoryChk1,
				"categoryChk2" : categoryChk2
				},
			traditional : true,//배열을 서블릿에 보낼때 필요함
			success : function(res){
				//상품리스트가 있는 자리를 비운다
				$('.search_result_item').remove();
				
				//카테고리에 맞는 정보를 다시 가져와 상품리스트 자리에 출력한다
				var newlist = "";
				$.each(res, function(i, v){
					//상품 정보 출력
					newlist  += '<div class = "search_result_item">';
					newlist  += '	<a href = "/Kream/tempId.do?gubun=1&prodid=' + v.prod_id + '" class = "item_inner">';
					//href->상품상세페이지
					newlist  += '		<div class = "product" style = "background-color:#ebf0f5">';
					newlist  += '			<img alt="' + v.prod_name + '"	src="' + v.photo_path + '" class="image">';
					newlist  += '		</div>';
					newlist  += '		<div class = "product_info">';
					newlist  += '			<div class = "title">';
					newlist  += '				<p class="brand">' + v.brand_name + '</p>';
					newlist  += '				<p class="name">' + v.prod_name +'</p>';
					newlist  += '			</div>';
					newlist  += '			<div class = "price">';
					newlist  += '				<div class="amount">' + v.prod_resell.toLocaleString('ko-KR') +'<span>원</span></div>';
					newlist  += '				<div class = "desc"><p>즉시 구매가</p></div>';
					newlist  += '			</div>';
					newlist  += '		</div>';
					newlist  += '	</a>';
					newlist  += '</div>';
				})
					$('.search_result_list').html(newlist);
			},
			error : function(xhr){
				alert('상태 : ' + xhr.status);
			},
			dataType : 'json'
		})
		
	})
	
	//상품 리스트 정보 요청
	$.ajax({
		url : '/Kream/prodList.do',
		type : 'get',
		success : function(res){
			
			str = "";
			$.each(res, function(i, v){
				//상품 정보 출력
				str += '<div class = "search_result_item">';
				str += '	<a href = "/Kream/tempId.do?gubun=1&prodid=' + v.prod_id + '" class = "item_inner">';
				//href->상품상세페이지
				str += '		<div class = "product" style = "background-color:#ebf0f5">';
				str += '			<img alt="' + v.prod_name + '"	src="' + v.photo_path + '" class="image">';
				str += '		</div>';
				str += '		<div class = "product_info">';
				str += '			<div class = "title">';
				str += '				<p class="brand">' + v.brand_name + '</p>';
				str += '				<p class="name">' + v.prod_name +'</p>';
				str += '			</div>';
				str += '			<div class = "price">';
				str += '				<div class="amount">' + v.prod_resell.toLocaleString('ko-KR') +'<span>원</span></div>';
				str += '				<div class = "desc"><p>최근 거래가</p></div>';
				str += '			</div>';
				str += '		</div>';
				str += '	</a>';
				str += '</div>';
			
				$('.search_result_list').html(str);
				
				console.log(v.prod_id);
			})
// 			location.href('prodDetail.jsp?')
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		},
		dataType : 'json'
	})
	
	
	
	$('.catecory1').on('click', function(){
			// 다시 누르면 들어가야함
			$('.filter_menu.lprod').toggle(); 
		
		$.ajax({
			url : '/Kream/prodCategory.do',
			type : 'get',
			success : function(res){
					str = "<ul class = 'menu_link'>";
					
					$.each(res, function(i, v){
						str += "<li class = 'menu'><input class = 'cat' value=  '" + v.lprod_nm + "'name = 'aaa' type = 'checkbox' id = 'chk'>" + v.lprod_nm + "</li>";
					})
					str += "</ul>";
					
					$('.filter_menu.lprod').html(str);
			},
			error : function(xhr){
				alert('상태 : ' + xhr.status);
			},
			dataType : 'json'
		})
		
	})
	
	$('.catecory2').on('click', function(){
		
		$('.filter_menu.brand').toggle();
		$.ajax({
			url : '/Kream/prodCategory2.do',
			type : 'get',
			success : function(res){
					str = "<ul class = 'menu_link'>";
					
					$.each(res, function(i, v){
						str += "<li class = 'menu'><input class = 'cat' value=  '" + v.brand_name + "' name = 'bbb' type = 'checkbox' id = 'chk'>" + v.brand_name + "</li>";
					})
					str += "</ul>";
					
					$('.filter_menu.brand').html(str);
			},
			error : function(xhr){
				alert('상태 : ' + xhr.status);
			},
			dataType : 'json'
		})
	
	})
	
	//'search' 클릭시 모달 실행
	$('#search_modal').on('click', function(){
			$('#searchmodal').modal('show');
	})

	//검색 모달의 검색버튼을 누를 시 이벤트
		$('#search_btn').on('click', function() {
			//검색한 값을 가져와 메서드로 보내주기
			input = $('#search_prod').val();
			//검색 내역 모달에 출력
			prodSearch(input);
		})

})//onload끝
</script>

</head>
<body style="padding-top: 100px;">
<!-- 헤더 -->
<div class="top_line fixed-top border-bottom text-end" style="height: 50px; display: flex; line-height: 50px; padding-right: 20px; background: white;">
	<ul class = "text-end" style="margin-left: auto;">
		<li><a href="<%=request.getContextPath()%>/boardview/boardMain.jsp">고객센터</a></li>
		<li><a id="member" href="<%= request.getContextPath() %>/MyPage.do" style="display: none;">마이페이지</a></li>
		<li><a id="nomember" href="<%= request.getContextPath() %>/member/loginForm.jsp">마이페이지</a></li>
		<li><a id="admin" href="<%= request.getContextPath() %>/boardview/adminMain.jsp" style="display: none;">관리자</a></li>
		
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
<hr>
<!-- 헤더 끝 -->

<div class = "content">

	<!-- 카테고리 필터 부분 -->
	<div class = "search_filter">
		<div class = "filter_status">
			<div class = "status_box">
				<span class = "status_txt">필터</span>
			</div>
		</div>
		<!-- 상품분류코드로 나누는 카테고리 -->
		<div class = "filter_list">
			<div class = "filter_title catecory1">
				<div class = "title_box">
					<span class = "main_title">카테고리</span><br>
					<span class = "placeholder">모든 카테고리</span>
				</div>
			</div>
			<div class = "filter_menu lprod" style = "display : none;">
			</div>
		</div>
		<!-- 상품 브랜드로 나누는 카테고리 -->
		<div class = "filter_list">
			<div class = "filter_title catecory2">
				<div class = "title_box">
					<span class = "main_title">브랜드</span><br>
					<span class = "placeholder">모든 브랜드</span>
				</div>
			</div>
			<div class = "filter_menu brand" style = "display : none;">
			</div>
		</div>
	</div>
	<!-- 상품 리스트 출력 -->
	<div class = "search_result_list"> <!-- 상품들이 출력될 div -->
	</div>
</div><!-- content끝 -->

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

<!-- search 클릭시 모달만들기 -->
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
<!-- search 모달 끝-->



</body>
</html>