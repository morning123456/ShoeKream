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
	//��ǰ���� �������� 
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
			alert("���� : " + xhr.status);
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
<!-- ��� -->
<div class="top_line fixed-top border-bottom text-end" style="height: 50px; display: flex; line-height: 50px; padding-right: 20px; background: white; border-bottom: 1px solid #dee2e6!important;">
	<ul class = "text-end" style="margin-left: auto;">
		<li><a href="#">������</a></li>
		<li><a href="<%= request.getContextPath() %>/MyPage.do">����������</a></li>
<%
	if(memberVo == null){
%>
		<li id="login"><a href="<%= request.getContextPath() %>/member/loginForm.jsp">�α���</a></li>

		
<% }else{ %>
		<li id="logout"><a href="<%= request.getContextPath() %>/Logout.do">�α׾ƿ�</a></li>
<%
	}
%>
	</ul>
	
</div>

	<div class="main_inner">
		<a class="black" href="/Kream/prodview/prodList.jsp">
			<h2
				style="margin: 0px 0px; align-content: center; font-style: oblique; font-weight: 900;">
				<img src="/Kream/img/main/�ΰ�.PNG" class="margin_top">
			</h2>
		</a>
		<div class="center">
			
		</div>
		<div class="right">
			<button type="button" class="btn btn_standard outlinegrey small margin_top">
				�˼�����
			</button>
		</div>
	</div>
</div>



<div class="main_com">
	<div id="prod_img_big"></div>
	<div>
		<div class="con_center">
			<h2><% String result = ((bid_position.equals("buyer")) ? "����" : "�Ǹ�" );  %> <%=result%> ������ �Ϸ�Ǿ����ϴ�.</h2>
			 <p>������ �ŷ��� ����Ǵ� ������<p>
			 <p>����Ͻ� ���� ������ �ڵ� ó�� �˴ϴ�.</p>
			<div class="inline_btn">
			 	 <a href="/Kream/buyingList.do" class="com_btn" >���� �󼼺���</a>	
			 	 <a  class="com_btn" id="gohistory" >SHOP �󼼺���</a>	
			</div>
			<p>���ų��� > ���� �ߡ� ������ ���� ���� ����Ⱑ �����մϴ�.</p>
		</div>
	</div>
	<div class="orderInfo">
		<h3 class="point_top">���� �ֹ� ����</h3>
			<p><% String result2 = ((bid_position.equals("buyer")) ? "����" : "����" );  %> �� <%=result2%> �ݾ�</p>
			<% if(result.equals("����")){ %> 
			<p class="right" id="pay_money"><%=price%>��</p>
			 <% }else{ %>	
			 <p class="right" id="pay_money"><%=bid_price%>��</p>
			 <% } %>	
			<hr>
			<table class="order_tb">
				<tr>
				<% if(result.equals("����")){ %> 
					<td><b>���� �����</b></td>
				 <% }else{ %>	
				 	<td><b>�Ǹ� �����</b></td>
				 <% } %>	
					<td id="bid_price"><b><%=bid_price%>��</b></td>
				</tr>
				 <% if(result.equals("����")){ %> 
				<tr>
					<td>��� ����Ʈ</td>
					<td><%=point%></td>
				</tr>
			  <% } %>	
				<tr>
					<td>�˼���</td>
					<td>����</td>
				</tr>
				<tr>
					<td>������</td>
					<td>����</td>
				</tr>
				 <% if(result.equals("����")){ %> 
				<tr>
					<td>��ۺ�</td>
					<td>3000��</td>
				</tr>
			  <% } %>	
			</table>
			
	</div>
</div>

<div class="jumbotron jumbotron-fluid text-center" id="footerbody" style="background : white;">
   
   <div class="info_list">
      <p>���̸� : SHOEKREAM</p><br>
      <p>����������: ���������� �߱� ���� 846 3�� 304ȣ</p><br>
      <p>ȣ���� ���� : ������簳�߿�</p><br><br>
      
      <table>
         <tr>
            <td>PL</td>
            <td>:������&nbsp;</td>
            <td></td>
            <td></td>
         </tr>
         
         <tr>
            <td>TA</td>
            <td class="td_last">:������&nbsp;</td>
            <td>AA</td>
            <td>:������</td>
         </tr>
         
         <tr>
            <td>UA</td>
            <td class="td_last">:�����&nbsp;</td>
            <td>DA</td>
            <td>:������</td>
         </tr>
      </table>
   </div>
   
   <div class="customer_service">
      <strong>
         ������
         <a href="tel:042-939-5559">042-939-5559</a>
      </strong>
      <p>�����ð� ���� 09:00 - 17:30</p>
      <p>���ɽð� ���� 12:50 - 13:40</p>
      <p>�����н� �ð� ���� 5:30 - 22:00</p>
      <p>�����н� �ð� �ָ� 9:00 - 18:00</p>
   </div>
</div>
</body>
</html>