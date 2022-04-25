/**
 * 
 */

 
 
 var replyList=function(board_id){
	console.log(board_id+"board_id");
	
	$.ajax({
		url : '/Kream/AdminReply.do',
	    type : 'post',
	    data :{
			"board_id":board_id
	    },
	    success : function(res){
			rcode= "";
		  	$.each(res,function(i,v){
				rcode += '     <div class="rcode" style="width: 1100px; margin-left:40px; ">';
	   			rcode += '       <hr>';
				rcode += '       <p class="r1">';
				rcode += '         날짜 : ' + v.rep_date + '&nbsp;&nbsp;&nbsp;';
				rcode += '       </p><br><br>';
	   			rcode += '       <p class="r2" style = "background: #fafafa; padding:40px; ">';
	   			rcode += v.rep_content.replace(/\r/g,"").replace(/\n/g,"<br>");
	   			rcode += '       </p><br>';
	   			rcode += '     </div>';
	   		
	   			$('.container2').html(rcode);
	   		
	   		})
		},
	    error : function(xhr){
		   alert("상태 : " + xhr.status);
	    },
	    dataType : 'json'
	})
}
 
 
 var qnaDelete=function(board_id){
	$.ajax({
		url : '/Kream/BoardQnADelete.do',
	    type : 'get',
	    data :{
			'board_id'  :  board_id
	    },
	    success : function(res){
			boardQnA();
		},
		error : function(xhr){
		   alert("상태 : " + xhr.status);
	    },
	    dataType : 'json'
	})
}
 
 var qnaInsert=function(){
	$.ajax({
		url : '/Kream/BoardQnAInsert.do',
	    type : 'get',
	    data :board,
	    success : function(res){
			boardQnA();
		},
		error : function(xhr){
		   alert("상태 : " + xhr.status);
	    },
	    dataType : 'json'
	})
}

 var qnaInsertForm=function(){
	console.log("o");
	
	scode="<span style='margin-left:30px;'>제목 : </span><input type='text' class='board_title' style='margin-left:15px; width:800px;'><br>";
	scode+="<span style='padding-left:15px; float : right;'>작성자 : "+mem_email+"</span><br>";
	scode+="<hr style='width:1100px; padding:0px;  margin:0px; margin-top:20px; margin-left:20px;'>";
	$('#nav').html(scode);
	
	code="<textarea id='board_update' class='board_content' style='width:1100px; height: 6.25em; resize: none; margin-left: 40px;'></textarea><br>";
	code+="<button id='insertOK' class='btn btn-success' style='margin-left:500px;'>확인</button>";
	code+="<button id='boardQnAmain' class='btn btn-danger' style='margin-left:10px;'>취소</button>";
				
	$('.container1').html(code);
	$('.container2').html("");
	$('#pagelist').html("");
				
	$('.board_title').val("");
	$('.board_content').val("");
}
 
 var upadateBoardQnA=function(board_id){
	$.ajax({
		url : '/Kream/BoardQnAUpdate.do',
	    type : 'get',
	    data :board,
	    success : function(res){
			boardQnA();
		},
		error : function(xhr){
		   alert("상태 : " + xhr.status);
	    },
	    dataType : 'json'
	})
}
 
 var qnaDetail=function(board_id){
	$.ajax({
		url : '/Kream/BoardQnADetail.do',
	    type : 'get',
	    data :{
			'board_id'  :  board_id
	    },
	    success : function(res){
		
			if(temp == 0){
				scode="<h5 style='padding-left:15px;'>"+res.board_title+"</h5>";
				scode+="<span style='padding-left:15px; float : right;'>작성자 : "+res.mem_email+"</span><br>";
				scode+="<hr style='width:1100px; padding:0px;  margin:0px; margin-top:20px; margin-left:20px;'>";
				$('#nav').html(scode);
	
				code="<div id='notice_detail' style='background:#fafafa;margin-left: 40px; margin-right:90px; padding:40px;'>";
				code+=res.board_content.replace(/\r/g,"").replace(/\n/g,"<br>")+"</div><br>";
				code+="<span style='float:right; margin-right :100px;'>"+res.board_date+"</span><br>";
				code+="<button id='boardQnAmain' class='btn btn-outline-light text-dark' style='margin-left:450px;'>돌아가기</button>";
				if(res.mem_email == mem_email){
					code+="<button id='upadateBoardQnA' class='btn btn-success' style='margin-left:10px;' idx='"+res.board_id+"'>수정</button>";
					code+="<button id='deleteBoardQnA' class='btn btn-danger' style='margin-left:10px;' idx='"+res.board_id+"'>삭제</button>";
				}
				
				$('.container1').html(code);
				$('.container2').html("");
				$('#pagelist').html("");
				
				replyList(board_id);
			}else if(temp==1){
				
				console.log("o");
				board.board_id = res.board_id;
				board.board_title = res.board_title;
				board.board_content = res.board_content;
				
				scode="<span style='margin-left:30px;'>제목 : </span><input type='text' class='board_title' style='margin-left:15px; width:800px;'><br>";
				scode+="<span style='padding-left:15px; float : right;'>작성자 : "+res.mem_email+"</span><br>";
				scode+="<hr style='width:1100px; padding:0px;  margin:0px; margin-top:20px; margin-left:20px;'>";
				$('#nav').html(scode);
				
				code="<textarea id='board_update' class='board_content' style='width:1100px; height: 6.25em; resize: none; margin-left: 40px;'></textarea><br>";
				code+="<span style='float:right; margin-right :100px;'>"+res.board_date+"</span><br>";
				code+="<button id='upadateOK' class='btn btn-success' style='margin-left:500px;' idx='"+res.board_id+"'>확인</button>";
				code+="<button id='boardQnAmain' class='btn btn-danger' style='margin-left:10px;' idx='"+res.board_id+"'>취소</button>";
				
				$('.container1').html(code);
				$('.container2').html("");
				$('#pagelist').html("");
				
				$('.board_title').val(board.board_title);
				$('.board_content').val(board.board_content);
			}
			
		},
		error : function(xhr){
		   alert("상태 : " + xhr.status);
	    },
	    dataType : 'json'
	})
		
}
	
	
 
 var boardQnANoticeDetail=function(notice){
	console.log(temp)
	
	$.ajax({
		url : '/Kream/AdminNoticeDetail.do',
	    type : 'get',
	    data :{
			'notice'  :  notice
	    },
	    success : function(res){
		
				scode=res.notice_date+"<br><br>";
				scode+="<h5 style='padding-left:15px;'>"+res.notice_title+"</h5>";
				scode+="<hr style='width:1100px; padding:0px;  margin:0px; margin-top:20px; margin-left:20px;'>";
				$('#nav').html(scode);
		
				code="<div id='notice_detail' style='background:#fafafa; margin-left: 40px; margin-right:90px; padding:40px;'>";
				code+=res.notice_content.replace(/\r/g,"").replace(/\n/g,"<br>")+"</div><br>";
				code+="<button id='boardQnAmain' class='btn btn-outline-light text-dark' style='margin-left:500px;'>목록보기</button>";
				$('.container1').html(code);
				$('.container2').html("");
				$('#pagelist').html("");
			
			
			
			
		},
		error : function(xhr){
		   alert("상태 : " + xhr.status);
	    },
	    dataType : 'json'
	})
	
}
 
 
 var boardQnA=function(){
	$.ajax({
		url : '/Kream/BoardQnA.do',
	    type : 'post',
	    data :{
			'page' : currentPage,
			'stype' : typevalue, //mem_email, board_title
			'sword' : wordvalue
	    },
	    success : function(res){
		   console.log("성공");

			hcode ="";
			
			hcode += "<form class='form-inline' >";
			hcode += '	<select class="form-control" id="stype">';
	   		hcode += '		<option value="board_title">제목</option>';
	   		hcode += '		<option value="mem_email">작성자</option>';
	 		hcode += '	</select>';
			hcode += "	<input id='sword' class='form-control mr-sm-2 ' type='text' placeholder='Search'>";
			hcode += "	<button id='search' class='btn btn-primary' type='button'>Search</button>";
			hcode += "	<button id='insert' name='insert' type='button' class='btn btn-outline-dark' style=' margin-left:10px;'>Q&A 등록</button>";
			hcode += "</form><br>";
			
			$('.navbar').html(hcode);

			ncode ="<div class='row'>";
			ncode +="	<div class='col-1'>NO.</div>";
			ncode +="	<div class='col-4'>Title</div>";
			ncode +="	<div class='col-2'>Writer</div>";
			ncode +="	<div class='col-2'>WriteDate</div>";
			ncode +="	<div class='col-3'>답변</div>";
			ncode +="</div><hr>";

			$.each(res.notice,function(i,v){
				ncode +="<div class='row' idx='" + v.notice + "' name='board_id'>";
				ncode +="	<div class='col-1 ' >공지</div>";
				ncode +="	<div class='col-4 select' idx='"+v.notice+"'>"+v.notice_title+"</div>";
				ncode +="	<div class='col-2'>관리자</div>";
				ncode +="	<div class='col-2'>"+v.notice_date+"</div>";
				ncode +="	<div class='col-3'></div>";
				ncode +="</div><hr>";
			})
			
			$('.container1').html(ncode);
			
			code="";
			num = res.board.length;
			$.each(res.board, function(i, v){
				code +="<div class='row' idx='" + v.board_id + "' name='board_id'>";
				code +="	<div class='col-1'>"+(num-i)+"</div>";
				code +="	<div class='col-4 boardDetail' idx="+v.board_id+">"+v.board_title+"</div>";
				code +="	<div class='col-2'>"+v.mem_email+"</div>";
				code +="	<div class='col-2'>"+v.board_date+"</div>";
				if(v.creply > 0){
					code +="<div class='col-3'><span class='ans' style='margin-left:5px; background-color:lightgray; border:none;'>답변완료</span></div>";
				}else if(v.creply == 0){
					code +="<div class='col-3'><span class='ans' style='margin-left:5px; '>답변예정</span></div>";
				}
				code +="</div><hr>";
			})

		   $('.container2').html(code);
		   
		   pcode = "";
		   
		   //이전버튼 출력
		   if(res.startp > 1) {
			pcode = '<ul class="pagination">';
			pcode +='<li class="page-item">';
			pcode +='<a class="page-link prev" href="#">Previous</a>';
			pcode += '</li>';
			pcode += '</ul>';
		  }
		   
		   pcode += '<ul  class="pagination pager">'
		   //페이지 목록 출력 
		   for(i= res.startp ; i<= res.endp; i++){
			  if(currentPage == i){
				pcode +='<li class="page-item active">';
		     	pcode +='<a class="page-link pnum" href="#">' + i + '</a>'
		     	pcode += '</li>';
			  }else{
				pcode +='<li class="page-item">';
		     	pcode +='<a class="page-link pnum" href="#">' + i + '</a>'
		     	pcode += '</li>';
			  }
		   }
		   pcode += '</ul>'
		   
		   
		   //다음 버튼 출력 
		   if(res.endp < res.totalp){
			pcode += '<ul class="pagination">';
			pcode +='<li class="page-item">';
			pcode +='<a class="page-link next" href="#">Next</a>';
			pcode += '</li>';
			pcode += '</ul>';
		   }
		   
		   
		   $('#pagelist').html(pcode);
	    },
	    error : function(xhr){
		   alert("상태 : " + xhr.status);
	    },
	    dataType : 'json'
	})
}