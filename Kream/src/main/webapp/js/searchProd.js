/**
 * 
 */
 //검색창 클릭시 모달
var prodSearch = function(input){
		$.ajax({
			url : '/Kream/GetSearchProd.do',
			type : 'post',
			data : {
				"input" : input
			},
			success : function(res){
				var str = "";
				$.each(res, function(i, v){
				//상품 정보 출력
				str += '<div class = "modal_search_prod">';
				str += '	<a href = "/Kream/tempId.do?gubun=1&prodid=' + v.prod_id + '" class = "item_inner">';
				//href->상품상세페이지
				str += '		<div class = "product" style = "background-color:#ebf0f5">';
				str += '			<img alt="' + v.prod_name + '"	src="' + v.photo_path + '" class="image">';
				str += '		</div>';
				str += '		<div class = "modal_product_info>"';
				str += '			<div class = "title">';
				str += '				<p class="brand">' + v.brand_name + '</p>';
				str += '				<p class="name">' + v.prod_name +'</p>';
				str += '			</div>';
				str += '			<div class = "modal_price">';
				str += '				<div class="modal_amount">' + v.prod_resell +'<span>원</span></div>';
				str += '				<div class = "modal_desc"><p>즉시 구매가</p></div>';
				str += '			</div>';
				str += '		</div>';
				str += '	</a>';
				str += '</div>';
				});

				$('#modal_prod_search').html(str);
				
			},
			error : function(xhr){
				alert("상태 : " + xhr.status);
			},
			dataType : "json"
		})
	}