<%@page import="kr.or.ddit.kream.vo.MemberVO"%>
<%@page import="kr.or.ddit.kream.vo.BidVo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel = "stylesheet" href = "/Kream/css/prodDetail.css">
<title>Insert title here</title>
<script src = "<%=request.getContextPath()%>/js/prodBoard.js"></script>
<script src = "<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<%
	//prodid 받기
	String prodid = (String) request.getAttribute("prodid");
	
%>
<script type="text/javascript">

window.addEventListener('scroll', function () {
	  //부모 div의 top값
	    const top =  $('.column_bind').offset().top;
// 	  	console.log("top : " + top);
	    //부모 div의 bottom값
	    const bottom = top + $('.column_bind').height();
// 	  	console.log("bottom : " + bottom);
		
	    const inner = $('.prodimg');
// 	  	console.log("inner : " + inner);
	    
	    //스크롤바 top값 구하기
	    const scrollLocation = document.querySelector('html').scrollTop;
	    console.log(scrollLocation);
	    
	    if(top < scrollLocation && scrollLocation < bottom) {
	    	inner.offset({top:scrollLocation});
	    }
});

$(function(){
	
	str = "";//이미지 출력
	code = "";//상품정보 출력
	
	$.ajax({
		url : '/Kream/prodDetail.do',
		type : 'get',
		data : {
			"prodid" : "<%=prodid%>"
		},
		success : function(res){
			//res.키값
			//이미지 출력
			str += '<img id = "shoeimg" src = "' + res.photo_path + '" alt = "' + res.prod_name +'">';
			$('.prodimg').html(str);
			
			//정보 출력
			code += '<div class = "column_top">';
			code += '	<div class = "detail_main_title">';
			code += '		<h3 class = "brand">' + res.brand_name + '</h3><br>';
			code += '		<p class = "title">' + res.prod_name + '</p>';	
			code += '	</div>';//detail_main_title끝
			code += '	<div class = "product_figure_wrap lg">';//클래스 두개임
			code += '		<div class = "detail_size">';
			code += '			<div class = "title">';
			code += '				<span class = "title_txt">사이즈</span>';
			code += '			</div>';
			code += '			<div class = "size">';
									//클릭이벤트 모달 줘야함
			code += '				<button type = "button" data-toggle="modal" data-target="#sizemodal" class = "btn_size">';
			code += '				<span class = "btn_text">모든 사이즈</span>';
			code += '			</div>';
			code += '		</div>';//detail_size 끝
			code += '		<div class = "detail_price">';
			code += '			<div class = "title">';
			code += '				<span class = "title_txt">최근 거래가</span>';
			code += '			</div>';
			code += '			<div class = "price">';
			code += '				<div class = "amount">';
			code += '					<span class = "num" id = "recentPrice">' + res.prod_resell + '</span>'
			code += '					<span id = "chkwon" class = "won">원</span>'
			code += '				</div>';
			code += '			</div>';
			code += '		</div>';//detail_price 끝
			code += '	</div>';//product_figure_wrap lg 끝
			
			code += '	<div class = "btn_wrap">';
			code += '		<div class = division_btn_box>';
			code += '			<a href = "/Kream/tempId.do?gubun=2&prodid=' + res.prod_id + '" class = "btn_division buy">';//서블릿 보내서 페이지 이동
			code += '				<strong class = "buytitle">구매</strong>';
			code += '				<div class = "price">';
			code += '					<span class = "amount">';
			code += '						<em class = "num">' + res.prod_resell + '</em>';
			code += '						<span class = "won">&nbsp;원</span>';
			code += '					<span>';
			code += '					<span class = "desc">즉시 구매가</span>';
			code += '				</div>';
			code += '			</a>';
			code += '			<a href = "/Kream/tempId.do?gubun=3&prodid=' + res.prod_id + '" class = "btn_division sell">';//서블릿 보내서 페이지 이동
			code += '				<strong class = "seltitle">판매</strong>';
			code += '				<div class = "price">';
			code += '					<span class = "amount">';
			code += '						<em class = "num">' + res.prod_resell + '</em>';
			code += '						<span class = "won">&nbsp;원</span>';
			code += '					<span>';
			code += '					<span class = "desc">즉시 판매가</span>';
			code += '				</div>';
			code += '			</a>';
			code += '		</div>';//division_btn_box 끝
			code += '		<button type = "button" class = "btn_like">';//클릭시 관심상품에 prod_id를 저장
			code += '			<span class = "btn_text">관심상품 담기</span>';//클릭하면 alert로 관심상품 담겼다고 알려주기
			code += '		</button>';
			code += '	</div>';//btn_wrap 끝
			code += '</div>';//column_top 끝
			
			code += '<div class = "product_info_wrap">';
			code += '	<h4>상품 정보</h4>';
			code += '	<div class = "detail_product_wrap">';
			code += '		<dl class = "detail_product">';
			code += '			<div class = "detail_box model_num">';
			code += '				<dt class = "product_title">모델번호</dt>';
			code += '				<dd class = "product_info">' + res.prod_id + '</dd>';
			code += '			</div>';//detail_box model_num 끝
			code += '			<div class = "detail_box">';
			code += '				<dt class = "product_title">출시일</dt>';
			code += '				<dd class = "product_info">' + res.prod_launch + '</dd>';
			code += '			</div>';//detail_box 끝
			code += '			<div class = "detail_box">';
			code += '				<dt class = "product_title">발매가</dt>';
			code += '				<dd class = "product_info">' + res.org_price + '<span>원</span></dd>';
			code += '			</div>';//detail_box 끝
			code += '		</dl>';//detail_product 끝
			code += '	</div>';//detail_product_wrap 끝
			code += '</div>';//product_info_wrap 끝
			
			//그래프 출력
			code += '<div class = "detail_wrap">';
			code += '	<div class = "product_sales_graph"';
			code += '		<div class = "title">';
			code += '			<h3 class = "detail_title md">시세</h3>';
			code += '			<div class = "sales_filter md">';
			code += '				<div class = "filter_unit">';
			code += '					<select class = "btn btn_select" id = "graphSize">';
			code += '						<option value = "230">230</option>';
			code += '						<option value = "235">235</option>';
			code += '						<option value = "240">240</option>';
			code += '						<option value = "245">245</option>';
			code += '						<option value = "250">250</option>';
			code += '						<option value = "255">255</option>';
			code += '						<option value = "260">260</option>';
			code += '						<option value = "265">265</option>';
			code += '						<option value = "270">270</option>';
			code += '						<option value = "275">275</option>';
			code += '						<option value = "280">280</option>';
			code += '						<option value = "285">285</option>';
			code += '						<option value = "290">290</option>';
			code += '						<option value = "295">295</option>';
			code += '						<option value = "300">300</option>';
			code += '						<option value = "305">305</option>';
			code += '	 					<option value = "310">310</option>';
			code += '					</select>';
			code += '				</div>';//filter_unit 끝
			code += '			</div>';//sales_filter md 끝
			code += '		</div>';//title 끝
			
			code += '	</div>';//product_sales_graph 끝
			code += '</div>';//detail_wrap 끝
			
			//그래프를 출력하는 .tab_area div.
			code += '		<div class = "tab_area" id = "tab_area">';
			code += '		</div>';
			
			code += '<div class = "wrap_bids">';
			code += '	<div class = "tab_area">';
			code += '		<ul role = "tab_list" class = "tab_list">';
			code += '			<li class = "item" role = "tab" aria-selected = "true" aria-controls = "panel1">';
			code += '				<button type = "button" class = "item_link itlink1 btn_size">체결 거래</button>';
			code += '			</li>';
			code += '			<li class = "item" role = "tab" aria-selected = "false" aria-controls = "panel2">';
			code += '				<button type = "button" class = "item_link itlink2 btn_size">판매 입찰</button>';
			code += '			</li>';
			code += '			<li class = "item" role = "tab" aria-selected = "false" aria-controls = "panel3">';
			code += '				<button type = "button" class = "item_link itlink3 btn_size">구매 입찰</button>';
			code += '			</li>';
			code += '		</ul>';
			code += '	</div>';
			code += '</div>';
			
			//거래내역 출력(display:none 추가 생각하기)
			code += '<div id = "panel1" role = "tabpanel" span = "sales" class = "tab_content"></div>';
			
			$('.column_box').html(code);
			
			//그래프 출력
			getFirstGraph("<%=prodid%>");
			//체결 거래 내역 출력
			getTranscation1("<%=prodid%>");
// 			//리뷰 리스트 출력
<%-- 			reviewList("<%=prodid%>"); --%>
// 			//모든사이즈 출력(모달)
<%-- 			prodAllSize("<%=prodid%>"); --%>
			
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		},
		dataType : 'json'
	})
	//---------------그래프-------------
		xArray = new Array();
		yArray = new Array();
		fdate = "";
		ldate = "";
		maxPrice = 0;
		minPrice = 0;
	
	//그래프의 콤보박스 이벤트가 변경되었을때
	$('.column_box').on('change', '.btn_select', function(){
		//사이즈를 가져온다
		sizenm = $(this).val();
		getSizeGraph('<%=prodid%>', sizenm);
	})
//-------------------------------------그래프끝	

//--------------거래 내역---------------
$('.column_box').on('click', '.itlink1', function(){
	getTranscation1("<%=prodid%>");
})
$('.column_box').on('click', '.itlink2', function(){
	var position = "seller";
	getTranscation2("<%=prodid%>", position);
})
$('.column_box').on('click', '.itlink3', function(){
	var position = "buyer";
	getTranscation2("<%=prodid%>", position);
})

//-----------------------
	//모달 실행
	$('.column_box').on('click', 'btn_size', function(){
			$('.modal').modal('show');
	})
	
	//사이즈를 선택시 최근거래가를 불러와 최근거래가 span에 출력
	$('.modal_select_area').on('click', '.btnsize', function(){
		var sizenm = $(this).find('span[class="size"]').text();
		GetRecentPrice('<%=prodid%>', sizenm);
	})
	
	//관심상품 담기 and 삭제
	$('.column_box').on('click', '.btn_like', function(){
		location.href = "/Kream/member/loginForm.jsp";
	})
	
	//모달에 출력할 사이즈정보들
	$.ajax({
			url : '/Kream/prodAllSize.do',
			type : 'get',
			data : {
				"prodid" : "<%=prodid%>"
			},
			success : function(res){
				console.log(res.length)
				var str = "";
				$.each(res, function(i, v){
					
					str += '<div class = "sell_before_select">';
					str += '	<div class = "select_area mo column_duoble">'
					var temp = "구매입찰";
					if(v.bid_price == 0){
						str += '				<button type = "button" id = "btnsize" class = "btnsize btn btn-outline-dark">';
						str += '					<div class = "link_inner">';
						str += '						<span class = "size">' + v.size_name + '</span><br>';
						str += '						<span class = "bPrice">' + temp + '</span>';
						str += '					</div>';
						str += '				</button>';
					}else {
						str += '				<button type = "button" id = "btnsize" class = "btnsize btn btn-outline-dark">';
						str += '			<div class = "link_inner">';
						str += '				<span class = "size">' + v.size_name + '</span><br>';
						str += '				<span class = "bPrice">' + v.bid_price + '</span>';
						str += '			</div>';
						str += '		</button>';
					}
				});
					str += '	</div>';
					str += '</div>';
				$('.modal_select_area').html(str);
				
			},
			error : function(xhr){
				alert("상태 : " + xhr.status);
			},
			dataType : "json"
		})
	
		//리뷰 출력
		$.ajax({
			url : '/Kream/reviewList.do',
			type : 'get',
			data : {
				"prodid" : "<%=prodid%>"
			},
			success : function(res){
				var str = "";
				$.each(res, function(i, v){
					str += '<div class = "feed_card item" style = "left : 0px; top:0px;">';
					str += '	<div class = "social_img_box sqare">';
					str += '		<img class = "prod_img_feed" alt = "소셜이미지" src = "' + v.review_photopath + '">';
					str += '	</div>';
					str += '	<div class = "card_detail">';
					str += '		<div class = "user_box">';
					str += '			<img alt = "" src = "' + v.mem_photo + ' " class = "img_profile">';
					str += '			<p class = "user_name">' + v.mem_email + '</p>';
					str += '		</div>';
					str += '		<p>' + v.review_content + '</p>';
					str += '	</div>';
					str += '</div>';
				});
				$('.masonry_posts').html(str);
			},
			error : function(xhr){
				alert("상태 : " + xhr.status);
			},
			dataType : "json"
	})
	
	//리뷰의 더보기란 눌렀을 때 리뷰 페이지로 이동
	$('.btn_outlinegrey').on('click', function(){
		lacation.href = "http://localhost/Kream/prodview/prodReviewPage.jsp";
	})
})




</script>
<style type="text/css">

</style>

</head>
<body>
<h2>ShoeKream</h2>
<hr>

<!-- 부모 div -->
<div class = "content">
	
	<!-- 상품 사진 -->
	<div class = "column_bind">
		<div class = "prodimg">
		</div>
	</div>
	
	<!-- 상품 정보 -->
	<div class = "column">
		<div class = "column_box">
		
		</div>
	</div>
</div>
<!-- content 끝 -->
<hr>
<!-- 리뷰 게시판 시작 -->
<div class = "feed_area">
	<h3 class = "feed_title">
		<span>스타일 리뷰</span>
	</h3>
	<div class = "social_feeds">
		<div class = "masonry_posts" style = "position:relative; height:772px;">
		</div>
		<div class = "more_btn_box">
			<button type = "button" class = "btn_outlinegrey medium">더보기</button>
		</div>
	</div>
</div>


<!-- 모달 만들기 -->
<div class = "modal" id = "sizemodal" display = "none">
	<div class="modal-dialog">
    	<div class="modal-content">
      
	        <!-- Modal Header -->
	        <div class="modal-header">
	          <h4 class="modal-title">사이즈</h4>
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	        </div>
        
        	<!-- Modal body -->
        	<div class="modal-body">
        		<div class = "modal_select_area" showlayer = "true">
        		
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














