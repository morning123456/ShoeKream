/**
 * 
 */
 
 var noticeDetail=function(notice){
	console.log(temp)
	
	$.ajax({
		url : '/Kream/AdminNoticeDetail.do',
	    type : 'get',
	    data :{
			'notice'  :  notice
	    },
	    success : function(res){
		
			if(!(temp==1)){
				scode=res.notice_date+"<br>";
				scode+="<h5 style='padding-left:15px;'>"+res.notice_title+"</h5>";
				scode+="<hr style='width:1100px; padding:0px;  margin:0px; margin-top:20px; margin-left:20px;'>";
				$('#nav').html(scode);
		
				code="<div id='notice_detail' style='background:#fafafa; padding: 20px;'>";
				code+=res.notice_content.replace(/\r/g,"").replace(/\n/g,"<br>")+"</div>";
				code+="<button id='noticemain' class='btn btn-outline-light text-dark' style='margin-left:500px;'>목록보기</button>";
				$('.container').html(code);
			
				$('#pagelist').html("");
			}
			if(temp==1){
				console.log("o");
				console.log(res.notice_title);
				$('.notice_title').val(res.notice_title);
				$('.notice_content').val(res.notice_content);
				$('.notice_cat').val(res.notice_cat);
				$('.notice_sta').val(res.notice_sta);
				
			}
			
			
			
		},
		error : function(xhr){
		   alert("상태 : " + xhr.status);
	    },
	    dataType : 'json'
	})
	
}
 
 
 var noticeList=function(){
	$.ajax({
		url : '/Kream/BoardNotice.do',
	    type : 'post',
	    data :{
			'page'  :  currentPage,
			'sword' : wordvalue
	    },
	    success : function(res){
			scode="<form class='form-inline' >";
			scode+="<input id='sword' class='form-control mr-sm-2' type='text' placeholder='Search'>";
			scode+="<button id='search' class='btn btn-outline-light text-dark' type='button'>Search</button>";
			scode+="</form><br><br>";
			
			$('#nav').html(scode);
			
//			NOTICE 글번호
//			MEM_EMAIL 작성자아이디
//			NOTICE_TITLE 글 제목
//			NOTICE_CONTENT 글 내용
//			NOTICE_DATE 작성일
//			NOTICE_CAT 공지사항 카테고리
// 			NOTICE_STA 공지사항 보이기 상태
			
			code = "<table class='table table-hover'>";
			code += "<tr><th>NO.</th>";
			code += "<th>Title</th>";
			code += "<th>WriteDate</th></tr>";
			
			num=res.datas.length
			$.each(res.datas,function(i,v){
				code+="<tr><td class='notice' value='"+v.notice+"'>"+(num-i)+"</td>"; //글번호
				code+="<td class='select'>"+v.notice_title+"</td>"; //글제목
				code+="<td>"+v.notice_date+"</td>"; //작성일
			})
			code+="</table>";
			
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