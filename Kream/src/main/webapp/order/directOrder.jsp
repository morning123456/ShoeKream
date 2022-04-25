<%@page import="kr.or.ddit.kream.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel = "stylesheet" href = "/Kream/css/order.css">
<script src = "<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel = "stylesheet" href = "/Kream/css/pagetopline.css">

<%

MemberVO memberVo = (MemberVO)session.getAttribute("memberVo");

if (session.getAttribute("memberVo") == null) {
    response.sendRedirect("logout.jsp");
}

	String prod_id = (String)request.getAttribute("prod_id");
	String sizeId = (String)request.getAttribute("size_id");
    String bid_price = (String)request.getAttribute("bid_price");
	int price = Integer.parseInt(bid_price) + 3000;
%>
<script>
$(function(){
	bp = <%=price%>;
	bplen = bp.toString();
	console.log(bplen.length);
	//상품정보 가져오기 
	$.ajax({
		url : '/Kream/OrderController.do',
		type : 'post',
		data : {
			"sizeId" : "<%=sizeId%>"
		},
		success : function(res){
			str = '<img id = "small_img" src = "' + res.photo_path + '" alt = "' + res.prod_name +'">';
			$('.prod_img').html(str);
			
			con = '<b class="brand_name">'+ res.brand_name + '</b><br>';
			con += '<p class="prod_name">' + res.prod_name + '</p><br>';
			con += '<b class="size_name">' + res.size_name + '</b>';
			$('.content').html(con);		
			$('#prod_name').val(res.prod_name);
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		},
		dataType : 'json'
	})
	//배송정보 가져오기 
	$.ajax({
		url : '/Kream/AddressController.do',
		type : 'post',
		data : {
			"memId" : "<%=memberVo.getMem_email()%>"
		},
		success : function(res){
			console.log(res);
			str="";
			if(res.name==null || res.name=="undefined"){				
				str+='<br><p>저장된 주소가 없습니다.</p><br>';
				str+='<button type="button" class="btn btn_standard outlinegrey small ad_modi">주소 등록</button>';
				$('#add').html(str);
				$('#addr').val("N");
			}else{
				str+='<table class="add_tb"><tr><td>받는분</td>';
				str+='<td id="res_name">'+ res.name +'</td></tr>';
				str+='<tr><td>연락처</td>';
				str+='<td id="res_phone_num">'+ res.phone_num+'</td></tr>';
				str+='<tr><td>반송 주소</td>';
				str+='<td id="res_addr">'+ res.addr1 + ' ' + res.addr2 +'</td></tr></table>';
				str+='<button type="button" class="btn btn_standard outlinegrey small ad_modi">주소 변경</button>';
				$('#add').html(str);
				$('#addr').val("Y");
				
			}
			
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		},
		dataType : 'json'
	})
	
	//주소등록 모달

	const modal = document.querySelector('#add_modi');

	$('#add').on('click', '.ad_modi' ,function(){
		modal.style.display = 'block'; 
		if($('#addr').val()=="Y"){
	          $('.modal_body h3').html("주소 변경");
	          $('.modal_body #addsubmit').html("변경");
		   }else{
			   $('.modal_body h3').html("주소 등록");
			   $('.modal_body #addsubmit').html("등록");
		   }
	})
	
	
	$('#close').on('click',function(){
		$('#modal_tb').find('#user_name').val("");
		$('#modal_tb').find('#address_kakao').val("");
		$('#modal_tb').find('#address_detail').val("");
		$('#modal_tb').find('#address_zipcode').val("");
		$('#modal_tb').find('#user_tel').val("");
		
		modal.style.display = 'none'; 
	})
	
	
	$('#addsubmit').on('click',function(){
		name = $('#modal_tb').find('#user_name').val();
		addr1 = $('#modal_tb').find('#address_kakao').val();
		addr2 = $('#modal_tb').find('#address_detail').val();
		zip_code = $('#modal_tb').find('#address_zipcode').val();
		phone_num = $('#modal_tb').find('#user_tel').val();
		
		if(name=="null"|| name==""){
			alert("이름을 입력해주세요");
			return false;
		}else if(phone_num=="null"|| phone_num==""){
			alert("전화번호를 입력해주세요");
			return false;
		}else if(zip_code=="null"|| zip_code==""){
			alert("주소를 입력해주세요");
			return false;
		}else if(addr2=="null"|| addr2==""){
			alert("상세주소를 입력해주세요");
			return false;
		}
		
		
		$.ajax({
			url : '<%= request.getContextPath()%>/addrUpdate.do',
			type : 'get',
			data : {"name" : name,
				    "addr1" : addr1,
				    "addr2" : addr2,
				    "zip_code" : zip_code,
				    "phone_num" : phone_num},
			success : function(res){
				str="";
				if($('#addr').val()=="Y"){
						$('#add').find('#res_name').text(res.name);
						$('#add').find('#res_phone_num').text(res.phone_num);
						$('#add').find('#res_addr').text(res.addr1 +" "+res.addr2);
			     }else{
			    	 str+='<table class="add_tb"><tr><td>받는분</td>';
						str+='<td id="res_name">'+ res.name +'</td></tr>';
						str+='<tr><td>연락처</td>';
						str+='<td id="res_phone_num">'+ res.phone_num+'</td></tr>';
						str+='<tr><td>반송 주소</td>';
						str+='<td id="res_addr">'+ res.addr1 + ' ' + res.addr2 +'</td></tr></table>';
						str+='<button type="button" class="btn btn_standard outlinegrey small ad_modi">주소 변경</button>';
						$('#add').html(str);
						$('#addr').val("Y");
				 }
// 				console.log(res);
// 				console.log(res.name);
// 				console.log(res.phone_num);
// 				console.log(res.addr1 + " " +res.addr2);
			},
			error : function(xhr){
				alert("상태 " + xhr.status);
			},
			dataType : 'json'
		});
		

		$('#modal_tb').find('#user_name').val("");
		$('#modal_tb').find('#address_kakao').val("");
		$('#modal_tb').find('#address_detail').val("");
		$('#modal_tb').find('#address_zipcode').val("");
		$('#modal_tb').find('#user_tel').val("");
		
		modal.style.display = 'none'; 
		
	});
	
	
	//주소api
	 document.getElementById("search_zip").addEventListener("click", function(){ //주소입력칸을 클릭하면
        //카카오 지도 발생
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
                document.getElementById("address_zipcode").value = data.zonecode; // 주소 넣기
                document.getElementById("address_kakao").value = data.address; // 주소 넣기
                document.querySelector("input[name=address_detail]").focus(); //상세입력 포커싱
            }
        }).open();
    });
	
	
	
	
	
	
	
	//포인트정보 가져오기 
	$.ajax({
		url : '/Kream/PointController.do',
		type : 'post',
		data : {
			"memId" : "<%=memberVo.getMem_email()%>" 
		},
		success : function(res){
			str='<table class="add_tb"><tr><td>보유 포인트</td>';
			str+='<td id="mem_point">'+ res +'</td></tr></table>';
			$('#my_point').html(str);
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		},
		dataType : 'json'
	})
	
	//카드정보 가져오기 
	$.ajax({
		url : '/Kream/CardController.do',
		type : 'post',
		data : {
			"memId" : "<%=memberVo.getMem_email()%>" 
		},
		success : function(res){
			if(res==null){
				$('.card_modi_btn').html("카드 등록+");
				$('#card_num').html("등록된 카드 없음");
				$('#auto_card').val("카드없음");
			}else{
				$('.card_modi_btn').html("카드 변경");
				$('#card_num').html(res);
			}
			
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		},
		dataType : 'json'
	})
	
	
		//카드등록/변경
	const cardmodal = document.querySelector('#card_modi');
  	$('.card_modi_btn').on('click', function(){
  		cardmodal.style.display = 'block'; 
  		if($(this).val()=="카드없음"){
  			//insert card
  		 	$('.modal_body h3').html("카드 등록");
	        $('.modal_body #addsubmit2').html("등록");
  			
  		}else{
  			//update card
  			$('.modal_body h3').html("카드 변경");
	        $('.modal_body #addsubmit2').html("변경");
  		}
  	})
	
	$('#addsubmit2').on('click',function(){
		cardyn = $('#auto_card').val();
		console.log(cardyn);
		cardnum = $('#modal_tb2').find('#cardnum').val();
		expiry = $('#modal_tb2').find('#expiry').val();
		birth = $('#modal_tb2').find('#birth').val();
		secret = $('#modal_tb2').find('#secret').val();
		console.log(cardnum);
		
		if(cardnum=="null"|| cardnum==""){
			alert("카드번호를 입력해주세요");
			return false;
		}else if(expiry=="null"|| expiry==""){
			alert("유효기간을 입력해주세요");
			return false;
		}else if(birth=="null"|| birth==""){
			alert("생년월일을 입력해주세요");
			return false;
		}else if(secret=="null"|| secret==""){
			alert("비밀번호를 입력해주세요");
			return false;
		}

		$.ajax({
			url : '<%= request.getContextPath()%>/InsertCardController.do',
			type : 'post',
			data : {
				 "cardyn" : cardyn,
				 "cardnum" : cardnum,
				 "expiry" : expiry,
				 "birth" : birth,
				 "secret" : secret
			},
			success : function(res){
				console.log(res);
				$('#card_num').html(res);
				$('#auto_card').val("");
				$('.card_modi_btn').html("카드 변경");
			},
			error : function(xhr){
				alert("상태 " + xhr.status);
			},
			dataType : 'json'
		});
  			
  		
  		
		
		$('#modal_tb2').find('#cardnum').val("");
		$('#modal_tb2').find('#expiry').val("");
		$('#modal_tb2').find('#birth').val("");
		$('#modal_tb2').find('#secret').val("");
			
		cardmodal.style.display = 'none'; 
		
	});
  	
  	
	
	$('#close2').on('click',function(){
		
		$('#modal_tb').find('#cardnum').val("");
		$('#modal_tb').find('#expiry').val("");
		$('#modal_tb').find('#birth').val("");
		$('#modal_tb').find('#secret').val("");
		cardmodal.style.display = 'none'; 
	})
	
	
	
	

	//포인트가 0일때 포인트 입력불가
	point = parseInt($('#mem_point').html());
	if(point==0){
		 $(".input_point").attr("readonly",true);
		 $(".point_btn").prop("disabled", true);
	}
	
	
	
	//포인트 입력창 문자방지
	 var replaceNotInt = /[^0-9]/gi;
	 $(".input_point").on("focusout", function() {
           var x = $(this).val();
           if (x.length > 0) {
               if (x.match(replaceNotInt)) {
                  x = x.replace(replaceNotInt, "");
               }

	            $(this).val(x);
           }
       }).on("keyup", function() {
       	var x = $(this).val();
        inP = parseInt(x);
   		console.log(inP);
   		point = parseInt($('#mem_point').html());
   		bp = <%=price%>;
   		if(inP > bp){
   			if(inP > point){
   				x = x.substring(0, x.length-1);
   				console.log("xz", x)
   			}else{
       			console.log("xz", x)
       			x = x.substring(0, x.length-1);
   			}

   		}
   		if(inP > point){
				x = x.substring(0, x.length-1);
				console.log("xz", x)
			}
	   	 if(x.length >bplen.length){
	         if(x.length > po.length){
	            x = x.substring(0, x.length-1);
	         }else{
	            x = x.substring(0, x.length-1);
	         }
	      }
	   	if(x.length > po.length){
	        x = x.substring(0, x.length-1);
	     }	
   	 
   	   $(this).val(x);
   	   $(this).val($(this).val().replace(replaceNotInt, "")); 
           if(x==0||x==""){
           	$('#use_point').html("-");
           	$('#pay_money').html(bp + "원");
           }else{
           	 $('#use_point').html($(this).val().replace(replaceNotInt, ""));
           	 $('#pay_money').html((bp - x) + "원");
           } 
           
       }).on("keydown", function(){
          var x = $(this).val();
          inP = parseInt(x);
         console.log(inP);
         po =$('#mem_point').html();
         point = parseInt($('#mem_point').html());
         bp = <%=price%>;
         if(inP > bp){
            if(inP > point){
               x = x.substring(0, x.length-1);
            }else{
                console.log("xz", x)
                x = x.substring(0, x.length-1);
            }

         }
         if(x.length >bplen.length){
            if(x.length > po.length){
               x = x.substring(0, x.length-1);
            }else{
               x = x.substring(0, x.length-1);
            }
         }
          $(this).val(x);
          $(this).val($(this).val().replace(replaceNotInt, ""));
          $(this).val($(this).val().replace(/(^0+)/, ""));
          
           if(x==0||x==""){
              $('#use_point').html("-");
              $('#pay_money').html(<%=price%> + "원");
           }else{
              $('#use_point').html($(this).val().replace(replaceNotInt, ""));
               $('#pay_money').html((bp - x) + "원");
           } 
          
          
       }) ;

	
	

	
	 //포인트 최대사용 버튼
	$('.point_btn').on('click', function(){
	    point = parseInt($('#mem_point').html());
		bp = <%=price%>;
		if(point < bp){
			$('.input_point').val(point);
			$('#use_point').html(point);
			$('#pay_money').html(bp-point);
		}else{
			$('.input_point').val(bp);
			$('#use_point').html(bp);
			$('#pay_money').html("0");
		}
		
	})
	
	
    $('.card_btn').on('click', function(){
    	$('.card_btn').removeAttr("style");
    	$(this).css('border','1px solid black');
    	console.log($(this).val());
    })
    
  //전송
	$('.main').on('submit',function(){
		radiochk=$("input[name='pay']:checked").val();
		addrchk=$("input[name='addr']").val();
		payamount = parseInt($('#pay_money').html());
		prodname = 	$('.content').find('p').html();
		
		console.log(radiochk);
		console.log(addrchk);
		console.log(payamount);
		console.log(prodname);
		if(addrchk=="N"){
			alert("주소가 등록되지 않았습니다.");
			return false;	
		}
		if(radiochk=="카드없음"){
			alert("카드가 등록되지 않았습니다.");
			return false;	
		}
		
		if(radiochk=="api"){
		$("#check_module").trigger('click');
			return false;	
			 
		}
	})
	payamount = parseInt($('#pay_money').html());
	prodname = 	$('.content').find('p').html();
	  $("#check_module").click(function(){
          var IMP = window.IMP;
          IMP.init('imp64880425');
          IMP.request_pay({
	            pg: 'inicis', 
	            pay_method: 'card',
	            merchant_uid: 'merchant_11' + new Date().getTime(),
	            name: prodname,
	            //결제창에서 보여질 이름
	            amount: payamount,
	            //가격
	            buyer_email: '<%=memberVo.getMem_email()%>',
	            buyer_name: '${login.member_name}',
	            buyer_tel: '010-9279-6456',
	            buyer_addr: '${pay_address}',
	            buyer_postcode: '123-456',
          }, 
          function (rsp) {
	            console.log(rsp);
	            if (rsp.success) {
		            var msg = '결제가 완료되었습니다.';
		            alert(msg);
		            $("input[name='pay']:checked").val("success");
	            	$(".submit_btn").trigger('click');
	            }
	            else {
		            var msg = '결제에 실패하였습니다.';
		            msg += '에러내용 : ' + rsp.error_msg;
	            	alert(msg);
		            
	            }
	            	
	            
          });
      });
	
	
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
			<h2 class="title">
				<span class="title_txt">배송/결제</span>
			</h2>
		</div>
		<div class="right">
			<button type="button" class="btn btn_standard outlinegrey small margin_top">
				검수기준
			</button>
		</div>
	</div>
</div>
<form class="main" action="/Kream/DirectPayController.do" method="post">
	
	<div class="prod">
		<div class="prod_img">
		</div>
		<div class="content">
		</div>
	</div>
	
	<div class="address">
		<h3>배송주소</h3>
		<div id="add"></div>
		<input type="hidden" name="addr" id="addr">
		<hr>
		<h3 class="address_bt">배송방법</h3>
		 <div>
			<img class="box" src="/Kream/img/Other/택배상자.png">
			<div class="box_con">
				<p><b>배송료</b> 3000원</p>
				<p class="grey">검수후 배송 ㆍ 5-7일 내 도착 예정</p>
			</div>
		 </div>		
	</div>
	<div class="point">
		<h3 class="point_top">포인트</h3>
		<input class="input_point" type="text"  name="point" value="0">
		<button class="point_btn" type="button" >모두사용</button>
		<span id="joinspan"></span>
		<div id="my_point"></div>
	</div>
	
	<div class="orderInfo">
		<h3 class="point_top">최종 주문 정보</h3>
			<p>총 결제 금액</p>
			<p class="right" id="pay_money"><%=price%>원</p>
			<hr>
			<table class="order_tb">
				<tr>
					<td><b>즉시 구매가</b></td>
					<td id="bid_price"><b><%=bid_price%>원</b></td>
				</tr>
				<tr>
					<td>포인트</td>
					<td id="use_point">-</td>
				</tr>
				<tr>
					<td>검수비</td>
					<td>무료</td>
				</tr>
				<tr>
					<td>수수료</td>
					<td>무료</td>
				</tr>
				<tr>
					<td>배송비</td>
					<td>3000원</td>
				</tr>
			</table>
			
	</div>
	<div class="card" >
		<h3 class="point_top">결제방법</h3>
		<p class="margin_top">간편 결제</p>
			<label class="test_obj"> 
				<input id="auto_card" type="radio" name="pay" value="auto" checked> 
				<span class="margin_top" id="card_num">1111-1111-1111-1111</span>
			</label> 
			<button type="button" class="card_modi_btn">카드</button>
		<p class="margin_top">일반 결제</p>
			<label class="test_obj"> 
				<input type="radio" name="pay" value="api"> 
				<span class="margin_top">신용카드</span>
			</label> 
	 <input type="hidden" id="prod_name" value="">
	 <input type="hidden" name="prod_id" value="<%=prod_id%>">
	 <input type="hidden" name="bid_price" value="<%=bid_price%>">
	 <input type="hidden" name="mem_email" value="<%=memberVo.getMem_email()%>">
	 <input type="hidden" name="size_id" value="<%=sizeId%>">
	 <input type="hidden" name="bid_position" value="buyer">
	
	<input id="check_module" type="hidden" class="popup btn btn-style btn-primary" style="float: right;">
	<input type="submit" class="submit_btn" id="paybtn" value="결제하기">
	</div>
	

</form>
<div class="modal" id="add_modi"> 
	<div class="modal_body">
	<h3>주소 등록</h3>
	 <table id="modal_tb">
        <tr>
            <th>이름</th>
            <td><input type="text" name="user_name" id="user_name"></td>
        </tr>
        <tr>
            <th>전화번호</th>
            <td><input type="text" name="user_tel" id="user_tel"></td>
        </tr>
        <tr>
            <th>우편번호 </th>
            <td>
	            <input type="text" id="address_zipcode" name="zipcode" readonly />
	            <button id="search_zip">우편번호 찾기</button>
            </td>
        </tr>
        <tr>
            <th>주소</th>
            <td><input type="text" id="address_kakao" name="address" readonly /></td>
        </tr>
        <tr>
            <th>상세 주소</th>
            <td><input type="text" name="address_detail" id="address_detail" /></td>
        </tr>
    </table>
	    <div class="margin_top">
		    <button type="button" id="addsubmit" class="btn btn_standard outlinegrey small" ></button>
			<button type="button" id="close" class="btn btn_standard outlinegrey small" >close</button>
	    </div>
	</div> 
	
</div>

<div class="modal" id="card_modi"> 
	<div class="modal_body">
	<h3></h3>
	 <table id="modal_tb2">
        <tr>
            <th>카드번호</th>
            <td><input type="text"  id="cardnum"></td>
        </tr>
        <tr>
            <th>유효기간</th>
            <td><input type="text"  id="expiry"></td>
        </tr>
        <tr>
            <th>생년월일</th>
            <td>
	            <input type="text" id="birth" />
            </td>
        </tr>
        <tr>
            <th>카드 비밀번호</th>
            <td><input type="text" id="secret" /></td>
        </tr>
    </table>
	    <div class="margin_top">
		    <button type="button" id="addsubmit2" class="btn btn_standard outlinegrey small" ></button>
			<button type="button" id="close2" class="btn btn_standard outlinegrey small" >close</button>
	    </div>
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