/**
 * 
 */
//모든사이즈의 그래프 출력
var getFirstGraph = function(prodid){
		//사이즈를 가져온다
//		sizenm = $(this).val();
		xArray = new Array();
		yArray = new Array();
		fdate = "";
		ldate = "";
		maxPrice = 0;
		minPrice = 0;
		
		$.ajax({
			url : '/Kream/AllGraphInfo.do', 
			type : 'get',
			data : {
				"prodid" : prodid
			},
			success : function(res){
				
				if(res.length == 0){
					alert("낙찰된 사례가 없습니다");
				}else{
					var tempDateArr = [];		// 중복되지 않는 날짜가 저장될 배열
//					fdate = res[0].temp_date;
					$.each(res, function(j, v){
						var test = false;
						for(var i=0; i<tempDateArr.length; i++){
							if(tempDateArr[i] == v.temp_date){
								test = true;
								break;
							}
						}
						
						if(test==false){
							tempDateArr.push(v.temp_date)
						}
						
						
//						xArray.push(v.temp_date);
//						yArray.push(parseInt(v.temp_price));
//						ldate = v.temp_date;
					});
					
					var maxTempPriceArr = [];	// 각 날짜별 price중 제일 큰값이 저장될 배열
					for(var i=0; i<tempDateArr.length; i++){
						var maxPrice = 0;
						$.each(res, function(j, v){
							if(tempDateArr[i] == v.temp_date && maxPrice<v.temp_price ){
								maxPrice = v.temp_price 
							}
						});
						
						maxTempPriceArr.push(maxPrice);
					}
					
					console.log("res", res);
					console.log("tempDateArr", tempDateArr);
					console.log("maxTempPriceArr", maxTempPriceArr);
					
					
					fdate = tempDateArr[0];
					for(var i=0; i<tempDateArr.length; i++){
						xArray.push(tempDateArr[i]);
						yArray.push(parseInt(maxTempPriceArr[i]));
						ldate = tempDateArr[i];
					}
					
					
					var graphData = [{
						  x: xArray,
						  y: yArray,
						  mode:"lines"
						}];
					
					maxPrice = Math.max(...yArray);
					minPrice = Math.min(...yArray);
					
						// Define Layout
						var layout = {
						  xaxis: {range: [new Date(fdate), new Date(ldate)]},
						  yaxis: {range: [minPrice, maxPrice]},  
						  title: "시세"
						};
// 						$('.tab_area').empty();
						// Display using Plotly
						Plotly.newPlot("tab_area", graphData, layout);
// 					alert(xArray + "/" + yArray + "/" + fdate + "/" + ldate);
				}
			},
			error : function(xhr){
				alert("상태 : " + xhr.status);
			},
			dataType : 'json'
		})
}

//사이즈를 선택하면 그 사이즈의 그래프 출력
var getSizeGraph = function(prodid, sizenm){
		
		$.ajax({
			url : '/Kream/GraphInfo.do', 
			type : 'get',
			data : {
				"prodid" : prodid,
				"sizename" : sizenm
			},
			success : function(res){
				
				if(res.length == 0){
					alert("낙찰된 사례가 없습니다");
				}else{
					var tempDateArr = [];		// 중복되지 않는 날짜가 저장될 배열
//					fdate = res[0].temp_date;
					$.each(res, function(j, v){
						var test = false;
						for(var i=0; i<tempDateArr.length; i++){
							if(tempDateArr[i] == v.temp_date){
								test = true;
								break;
							}
						}
						
						if(test==false){
							tempDateArr.push(v.temp_date)
						}
						
						
//						xArray.push(v.temp_date);
//						yArray.push(parseInt(v.temp_price));
//						ldate = v.temp_date;
					});
					
					var maxTempPriceArr = [];	// 각 날짜별 price중 제일 큰값이 저장될 배열
					for(var i=0; i<tempDateArr.length; i++){
						var maxPrice = 0;
						$.each(res, function(j, v){
							if(tempDateArr[i] == v.temp_date && maxPrice<v.temp_price ){
								maxPrice = v.temp_price 
							}
						});
						
						maxTempPriceArr.push(maxPrice);
					}
					
					console.log("res", res);
					console.log("tempDateArr", tempDateArr);
					console.log("maxTempPriceArr", maxTempPriceArr);
					
					
					fdate = tempDateArr[0];
					for(var i=0; i<tempDateArr.length; i++){
						xArray.push(tempDateArr[i]);
						yArray.push(parseInt(maxTempPriceArr[i]));
						ldate = tempDateArr[i];
					}
					
					
					var graphData = [{
						  x: xArray,
						  y: yArray,
						  mode:"lines"
						}];
					
					maxPrice = Math.max(...yArray);
					minPrice = Math.min(...yArray);
					
						// Define Layout
						var layout = {
						  xaxis: {range: [new Date(fdate), new Date(ldate)]},
						  yaxis: {range: [minPrice, maxPrice]},  
						  title: "시세"
						};
// 						Plotly.empty();
						// Display using Plotly
						Plotly.newPlot("tab_area", graphData, layout);
// 					alert(xArray + "/" + yArray + "/" + fdate + "/" + ldate);
				}
			},
			error : function(xhr){
				alert("상태 : " + xhr.status);
			},
			dataType : 'json'
		})
}

//체결 거래 내역 출력
var getTranscation1 = function(prodid){
	var tran = "";
	$.ajax({
		url : '/Kream/bidTrans.do',
		type : 'get',
		data : {
			"prodid" : prodid
		},
		success : function(res){
			tran += '<div class = "table_wrap lg">';
			tran += '	<table border = "1">';	
			tran += '		<caption><span class = "blind">데이터 테이블</span></caption>';
			tran += '		<thead>';
			tran += '			<tr>';
			tran += '				<th class = "table_th">사이즈</th>';
			tran += '				<th class = "table_th align-right">거래가</th>';
			tran += '				<th class = "table_th align-right">거래일</th>';
			tran += '			</tr>';
			tran += '		</thead>';
			tran += '		<tbody>';

			$.each(res, function(i,v){
				tran += '			<tr>';
				tran += '				<td class = "table_td">' + v.size_name + '</td>';
				tran += '				<td class = "table_td align-right">' + v.temp_price.toLocaleString("ko-KR") + '</td>';
				tran += '				<td class = "table_td align-right">' + v.temp_date + '</td>';
				tran += '			</tr>';
				
			})
			tran += '		</tbody>';
			tran += '	</table>';
			tran += '</div>';
			
			$('#panel1').empty();
			$('#panel1').html(tran);
			
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		},
		dataType : "json"
	})	
}
//구매입찰, 판매입찰 내역 출력
var getTranscation2 = function(prodid, position){
	var tran = "";
	$.ajax({
		url : '/Kream/bidTrans2.do',
		type : 'get',
		data : {
			"prodid" : prodid,
			"position" : position
		},
		success : function(res){
			tran += '<div class = "table_wrap lg">';
			tran += '	<table border = "1">';	
			tran += '		<caption><span class = "blind">데이터 테이블</span></caption>';
			tran += '		<thead>';
			tran += '			<tr>';
			tran += '				<th class = "table_th">사이즈</th>';
			tran += '				<th class = "table_th align-right">거래가</th>';
			tran += '				<th class = "table_th align-right">거래일</th>';
			tran += '			</tr>';
			tran += '		</thead>';
			tran += '		<tbody>';

			$.each(res, function(i,v){
				tran += '			<tr>';
				tran += '				<td class = "table_td">' + v.size_name + '</td>';
				tran += '				<td class = "table_td align-right">' + v.bid_price.toLocaleString('ko-KR') + '</td>';
				tran += '				<td class = "table_td align-right">' + v.bid_date + '</td>';
				tran += '			</tr>';
				
			})
			tran += '		</tbody>';
			tran += '	</table>';
			tran += '</div>';
			
			$('#panel1').empty();
			$('#panel1').html(tran);
			
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		},
		dataType : "json"
	})	
}

//상품의 최신 거래가
var GetRecentPrice = function(prodid, sizenm){
	
			$.ajax({
			url : '/Kream/GetRecentPrice.do',
			type : 'get',
			data : {
				"prodid" : prodid,
				"sizenm" : sizenm
			},
			success : function(res){
				var temp = "구매입찰";
				if(res==null){
					$('.column_box').find('span[id = "recentPrice"]').empty();
					$('.column_box').find('span[id = "chkwon"]').empty();
					$('.column_box').find('span[id = "recentPrice"]').text(temp);
					
				}else{
					$('.column_box').find('span[id = "chkwon"]').empty();
					$('.column_box').find('span[id = "chkwon"]').text("원");
					$('.column_box').find('span[id = "recentPrice"]').empty();
					$('.column_box').find('span[id = "recentPrice"]').text(res.toLocaleString('ko-KR'));
				}
				$('.modal').modal('hide');
			},
			error : function(xhr){
				alert('상태 : ' + xhr.status);
			},
			dataType : 'json'
		});
}

//관심상품 등록 or 삭제
var prodLikeUpdate = function(prodid, memid){
		$.ajax({
			url : '/Kream/prodLikeUpdate.do',
			type : 'get',
			data : {
				"prodid" : prodid,
				"memid" : memid
			},
			success : function(res){
				if(res == "성공"){
					alert("관심상품에 등록되었습니다!");
				}else if(res == "삭제"){
					alert("관심상품에서 삭제되었습니다!");
				}
			},
			error : function(xhr){
				alert('상태 : ' + xhr.status);
			},
			dataType : 'json'
		})
		
}

//구매가 중 최소값
var getbuyPrice = function(prodid){
		$.ajax({
			url : '/Kream/GetbuyPrice.do',
			type : 'get',
			data : {
				"prodid" : prodid
			},
			success : function(res){
				if(res==null){
					$('#getbuyPrice').text("구매입찰");					
				}else{
					$('#getbuyPrice').text(res.toLocaleString('ko-KR'));
				}
				
			},
			error : function(xhr){
				alert('상태 : ' + xhr.status);
			},
			dataType : 'json'
		})
}
//판매가 중 최대값
var getsellPrice = function(prodid){
		$.ajax({
			url : '/Kream/GetsellPrice.do',
			type : 'get',
			data : {
				"prodid" : prodid
			},
			success : function(res){
				if(res==null){
					$('#getsellPrice').text("판매입찰");					
				}else{
					$('#getsellPrice').text(res.toLocaleString('ko-KR'));
				}
			},
			error : function(xhr){
				alert('상태 : ' + xhr.status);
			},
			dataType : 'json'
		})
}
		
//모든사이즈 클릭시 모달(모든 사이즈 및 가격 출력)
var prodAllSize = function(prodid){
		$.ajax({
			url : '/Kream/prodAllSize.do',
			type : 'get',
			data : {
				"prodid" : prodid
			},
			success : function(res){
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
						str += '				<span class = "bPrice">' + v.bid_price.toLocaleString('ko-KR') + '</span>';
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
	}
	

//화면 하단 상품 리뷰 모음
var reviewList = function(prodid){
	$.ajax({
			url : '/Kream/reviewList.do',
			type : 'get',
			data : {
				"prodid" : prodid
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
}




























