

$().ready(function() {
	
		$("#loginEmail").keyup( function(){
			$.post("/AdvanceBooking/member/loginSuccess"
			,function(){				
				$("#loginEmailError").slideUp(100);
			})
	})
		
	$("#loginPassword").keyup( function(){
		$.post("/AdvanceBooking/member/loginSuccess"
		,function(){
			$("#loginPasswordError").slideUp(100);
		})
	})
	
	$("#loginBtn").click( function() {
			
		$.ajax({
				url: "/AdvanceBooking/memberlogin"
				, type: "POST"
				, data: $('#loginForm').serialize()
				, dataType: "json"
				, success:function(response) {
					if ( response.isLoginSuccess ) {
						alert("로그인 성공");
						$("#loginModal").modal();
						return;							
					}
					else {
						alert("로그인 실패");
					}
				}
		})
	})
	
	
//	regist javascript 처리
	
	$("#registEmail").keyup( function(){
			$.post("/AdvanceBooking/member/regist"
			,function(){				
				$("#registEmailError").slideUp(100);
			})
			
			$.post("/AdvanceBooking/member/check/duplicate"
					, {
						"email":$(this).val()				
					}
					, function(response) {
						if ( response.duplicated ) {
							$("#email-duplicated").show()
						}
						else {
							$("#email-duplicated").hide()
						}
					}
			)
	})
		
	$("#registPassword").keyup( function(){
		$.post("/AdvanceBooking/member/regist"
		,function(){
			$("#registPasswordError").slideUp(100);
		})
	})
		
	$("#registPasswordConfirm").keyup( function(){
		$.post("/AdvanceBooking/member/regist"
		,function(){				
			$("#registPasswordConfirmError").slideUp(100);
			
			if( $("#registPassword").val() != $("#registPasswordConfirm").val() ) {
				$("#notEqualPassword").show();
			}
			else {					
				$("#notEqualPassword").hide();
			}
			
		})
	})

	$("#name").keyup( function(){
		$.post("/AdvanceBooking/member/regist"
		,function(){
				$("#nameError").slideUp(100);
		})
	})

	$("#registBtn").click( function() {
			
		$.ajax({
				url: "/AdvanceBooking/member/regist"
				, type: "POST"
				, data: $('#registForm').serialize()
				, dataType: "json"
				, success:function(response) {
					if ( response.success ) {
						location.href='/AdvanceBooking/main';
						alert("회원가입 성공");
						$("#loginModal").modal("show");
						return;							
					}
					else {
						alert("회원가입 실패");
					}
				}
		})
	})
	
	$('.dropdown a.test').on("click", function(e){
	    $(this).next('ul').toggle();
	    e.stopPropagation();
	    e.preventDefault();
    });
	
})