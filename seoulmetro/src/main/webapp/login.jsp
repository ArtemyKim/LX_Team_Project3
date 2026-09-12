<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
	
	
<!-- ============ Google Fonts begin ============ -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap"
	rel="stylesheet">
<!-- ============ Google Fonts end ============ -->
	
		
<!-- <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> -->


<style>
    /* 로그인 전용 스타일 */
    .login-wrapper {
        width: 100%;
        max-width: 400px;
        margin: 100px auto;
        padding: 40px;
        background-color: #1c1d1f;
        border: 1px solid #2b2b2b;
        border-radius: 12px;
        text-align: center;
    }
    .login-wrapper h2 { margin-bottom: 30px; color: #ffffff; }
    .input-group { margin-bottom: 20px; text-align: left; }
    .input-group label { display: block; margin-bottom: 8px; color: #b0b0b0; font-size: 0.9rem; }
    .input-group input {
        width: 100%;
        padding: 12px;
        background-color: #141517;
        border: 1px solid #2b2b2b;
        border-radius: 6px;
        color: white;
        box-sizing: border-box;
    }
    .btn-group { display: flex; gap: 10px; margin-top: 30px; }
    .btn-login { flex: 2; padding: 12px; background-color: #816BFF; color: white; border: none; border-radius: 6px; cursor: pointer; font-weight: bold; }
    .btn-login:hover { background-color: #6a5acd; }
    .btn-back { flex: 1; padding: 12px; background-color: #3a3b3d; color: white; border: none; border-radius: 6px; cursor: pointer; }
    .btn-back:hover { background-color: #505154; }
</style>
</head>
<body style="background-color: #141517; font-family: 'Pretendard', sans-serif;">

    <div class="login-wrapper">
        <h2>로그인</h2>
        <form action="login.do" method="post" id="loginForm">
            <div class="input-group">
                <label>아이디</label>
                <input type="text" name="userId" id="userId" placeholder="아이디를 입력해주세요">
            </div>
            <div class="input-group">
                <label>패스워드</label>
                <input type="password" name="userPassword" id="userPassword" placeholder="비밀번호를 입력해주세요">
            </div>
            <div class="btn-group">
                <button type="submit" class="btn-login">로그인</button>
                <button type="button" id="back" class="btn-back">돌아가기</button>
            </div>		
        </form>
    </div>
	
    <script>
        $('#back').click(function(){
            location.href = 'otthome.do';
        })
        
        $('#loginForm').submit(function(e) {
            let userId = $('#userId').val().trim();
            let userPassword = $('#userPassword').val().trim();
            
            if (userId === '') {
                alert('아이디를 입력해주세요.');
                $('#userId').focus(); 
                e.preventDefault();
                return false;
            }
            if (userPassword === '') {
                alert('비밀번호를 입력해주세요.');
                $('#userPassword').focus(); 
                e.preventDefault();     
            }
        });
    </script>
</body>
</html>