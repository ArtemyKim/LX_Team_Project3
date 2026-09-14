<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>

<!-- ============ Google Fonts begin ============ -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap"
	rel="stylesheet">
<!-- ============ Google Fonts end ============ -->

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body>
    <div class="subway-scene">
        <div class="handle-row">
            <div class="handle-wrap">
                <div class="handle">
                    <div class="strap"></div>
                    <div class="ring-tri"></div>
                </div>
            </div>
            <div class="handle-wrap">
                <div class="handle">
                    <div class="strap"></div>
                    <div class="ring-tri"></div>
                </div>
            </div>
            <div class="handle-wrap">
                <div class="handle">
                    <div class="strap"></div>
                    <div class="ring-tri"></div>
                </div>
            </div>
        </div>

        <div class="login-wrapper">
            <h2>SEOUL SUBWAY SCHEDULER</h2>
            <form action="login.do" method="post" id="loginForm">
                <div class="input-group">
                    <label>아이디</label>
                    <input type="text" name="userId" id="userId" placeholder="아이디를 입력해주세요">
                </div>
                <div class="input-group">
                    <label>비밀번호</label>
                    <input type="password" name="userPassword" id="userPassword" placeholder="비밀번호를 입력해주세요">
                </div>
                <button type="submit" class="btn-login">로그인 하기</button>
            </form>
        </div>
    </div>

    <script>
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
                return false;
            }
        });
    </script>
</body>
</html>