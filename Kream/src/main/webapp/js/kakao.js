/**
 * 
 */

// 3. 데모버전으로 들어가서 카카오로그인 코드를 확인.
function loginWithKakao() {
    Kakao.Auth.login({
        success: function (authObj) {
            console.log(authObj); // access토큰 값
            Kakao.Auth.setAccessToken(authObj.access_token); // access토큰값 저장

            getInfo();
        },
        fail: function (err) {
            console.log(err);
        }
    });
}

// 4. 엑세스 토큰을 발급받고, 아래 함수를 호출시켜서 사용자 정보를 받아옴.
function getInfo() {
    Kakao.API.request({
        url: '/v2/user/me',
        success: function (res) {
            console.log(res);
            // 이메일, 성별, 닉네임, 프로필이미지
            var email = res.kakao_account.email;
            var gender = res.kakao_account.gender;
            var nickname = res.kakao_account.profile.nickname;
            var profile_image = res.kakao_account.profile.thumbnail_image_url;
            var birthday = res.kakao_account.birthday;
            var age_range = res.kakao_account.age_range;

            console.log(email, gender, nickname, profile_image, birthday, age_range);
            //location.href = "http://localhost/Kream/member/joinMain.jsp?email=" + email;
            
            
            //window.open("http://localhost/Kream/member/joinMain.jsp");
        	$.ajax({
        		url : '<%= request.getContextPath() %>/KakaoCheck.do',
        		data : {
        			"email" : email,
        			"nickname" : nickname
        		},
        		type : 'post',
        		success : function(result){
        			alert(result)
        			if(result == "0"){
        				location.href = "http://localhost/Kream/member/joinSns.jsp?email=" + email + "&nickname=" + nickname;
        			}else{
        				alert("로그인");
        				$.ajax({
        					url : '<%= request.getContextPath() %>/KakaoLogin.do',
        					data : {"sns" : email},
        					type : 'get',
        					success : function(res){
        						
        						location.href = "http://localhost/Kream/Login.do?mem_email=" + res.mem_email + "&mem_pass=" + res.mem_pass;
        					},
        					error : function(xhr){
        						alert("상태 " + xhr.status)
        					},
        					dataType : 'json'
        				});
        			}
        		},
        		error : function(xhr){
        			alert("상태 " + xhr.status)
        		},
        		dataType : 'json'
        	});
		    //location.href = "http://localhost/Kream/member/joinMain.jsp";
        	
        },
        fail: function (error) {
            alert('카카오 로그인에 실패했습니다. 관리자에게 문의하세요.' + JSON.stringify(error));
        }
    });
}

// 5. 로그아웃 기능 - 카카오 서버에 접속하는 엑세스 토큰을 만료, 사용자 어플리케이션의 로그아웃은 따로 진행.
function kakaoLogout() {
    if (!Kakao.Auth.getAccessToken()) {
        alert('Not logged in.');
        return;
    }
    Kakao.Auth.logout(function() {
        alert('logout ok\naccess token -> ' + Kakao.Auth.getAccessToken());
    });
};

// 6. 연동 헤제 기능
function secession() {
	Kakao.API.request({
    	url: '/v1/user/unlink',
    	success: function(response) {
    		console.log(response);
    		//callback(); //연결끊기(탈퇴)성공시 서버에서 처리할 함수
    		//window.location.href='/'
    	},
    	fail: function(error) {
    		console.log('탈퇴 미완료')
    		console.log(error);
    	},
	});
}; 