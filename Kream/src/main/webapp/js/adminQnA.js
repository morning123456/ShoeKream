/**
 * 
 */
 
 var replyDelete=function(target){
	
	console.log(actionIdx + "board_reply_id");
	
	$.ajax({
		url : '/Kream/AdminReplyDelete.do',
	    type : 'post',
	    data :{
			"board_reply_id":actionIdx
	    },
	    success : function(res){
			qnaList(target);
		},
		error : function(xhr){
		   alert("상태 : " + xhr.status);
	    },
	    dataType : 'json'
	})
}
 
 
 var replyUpdate=function(target){
	$.ajax({
		url : '/Kream/AdminReplyUpdate.do',
	    type : 'post',
	    data :reply,
	    success : function(res){
			replyList(target);
		},
		error : function(xhr){
		   alert("상태 : " + xhr.status);
	    },
	    dataType : 'json'
	})
}
 
 
 var replyinsert=function(target){
	$.ajax({
		url : '/Kream/AdminReplyInsert.do',
	    type : 'post',
	    data :reply,
	    success : function(res){
			qnaList(target);
		},
		error : function(xhr){
		   alert("상태 : " + xhr.status);
	    },
	    dataType : 'json'
	})
}
 
 
 var replyList=function(target){
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
				rcode += '     <div class="rcode">';
	   			rcode += '       <hr>';
				rcode += '       <p class="r1">';
				rcode += '         날짜 : ' + v.rep_date + '&nbsp;&nbsp;&nbsp;';
				rcode += '       </p><br>';
	   			rcode += '       <p class="r2">';
	   			rcode += v.rep_content;
	   			console.log(v.rep_content);
	   			rcode += '       	<p class="r3">';
	   			rcode += '         		<input idx="' + v.board_reply_id + '" type="button" class="action btn btn-success" name="r_modify" value="댓글수정">';
	   			rcode += '         		<input idx="' + v.board_reply_id + '" type="button" class="action btn btn-danger" name="r_delete" value="댓글삭제">';
	   			rcode += '       	</p>';
	   			rcode += '       </p><br>';
	   			rcode += '     </div>';
	   		
	   			$(target).parents('.card').find('.p5').html(rcode);
	   		
	   		})
		},
	    error : function(xhr){
		   alert("상태 : " + xhr.status);
	    },
	    dataType : 'json'
	})
}
 
 var qnaList=function(){
	$.ajax({
		url : '/Kream/AdminQnA.do',
	    type : 'post',
	    data :{
			'page' : currentPage,
			'stype' : typevalue, //mem_email, board_title
			'sword' : wordvalue
	    },
	    success : function(res){
		   console.log("성공");
		   code = '<div id="accordion">';
		   
		   num=res.datas.length;
		   $.each(res.datas, function(i, v){ 
			
		   code += '<div class="card"><hr>';
		   code += '   <div class="card-header action row" idx="' + v.board_id + '" name="title">';
		   code += '		<div class="col-1">'+ (num-i) +'</div>';
  		   code += '		<div class="col-4"><a class="card-link" data-toggle="collapse" href="#collapse' + v.board_id + '">'+v.board_title +'</a></div>';
		   code += '		<div class="col-3">'+ v.mem_email +'</div>';
		   code += '		<div class="col-2">'+ v.board_date +'</div>';
		   
		   console.log(v.rcount+"----------");
		   
		   if(v.creply > 0){
				code += '		<div class="col-2.5"><span class="ans" style="margin-left:5px; background-color:lightgray;">답변완료</span></div>';
		   }else if(v.creply == 0){
				code += '		<div class="col-2.5"><span class="ans" style="margin-left:5px;">답변예정</span></div>';
		   }
		   code += '   </div>';
		   code += '   <div id="collapse' + v.board_id + '" class="collapse" data-parent="#accordion"><hr>';
		   code += '     <div class="card-body">';
		   code += '       <p class="p1">';
		   code += '         <span class="board_title" style="font-weight:bold;">' + v.board_title + '</span><br>';
		   code += '         작성자 : <span class="mem_email">' + v.mem_email + '</span>&nbsp;&nbsp;&nbsp;';
		   code += '         날짜 : <span class="board_date">' + v.board_date + '</span>';
		   code += '       </p>';
		   code += '       <hr>';
		   code += '       <p class="p3">';
		   code += v.board_content.replace(/\r/g,"").replace(/\n/g,"<br>")+"</div>";
		   code += '       </p><hr>';
		   code += '       <p class="p4">';
		   code += '          <textarea style="width: 100%; height: 4.25em; border: 0.5px solid lightgray; border-radius: 5px; resize: none;" id="insertText"></textarea><br>';
		   code += '          <input idx="' + v.board_id + '" type="button" class="action btn btn-primary" id="insertreply-btn" name="replyinsert" value="등록"><br>';
		   code += '       </p>';
		   code += '       <p class="p5">';
		   code += '       </p>';
		   code += '     </div>';
		   code += '   </div>';
		   code += ' </div>';  
		   
		   })//반복문
		   
		   code += '<hr></div>';
		   
		   
		   $('.container').html(code);
		   
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