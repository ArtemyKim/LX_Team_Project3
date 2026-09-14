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


<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>
    body {
        background-color: #eeeeee;
        font-family: 'Pretendard', sans-serif;
    }

    /* ===== 지하철 뒷 배경 ===== */
    .subway-scene {
        position: relative;
        height: 90vh;
        width: auto;
        max-width: 100%;
        aspect-ratio: 5692 / 3200;
        margin: 60px auto 0;
        background-image: url('image/background.png');
        background-size: cover;
        background-position: center;
        container-type: inline-size;
    }

    /* ===== 로그인 폼 ===== */
    .login-wrapper {
        position: absolute;
        top: 20%;
        left: 31.7%;
        width: 36%;
        height: 40%;
        background-color: #bfe1ee;
        border-radius: 6%;
        text-align: left;
        display: flex;
        flex-direction: column;
        justify-content: center;
        padding: 5% 7%;
        box-sizing: border-box;
        box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
        z-index: 1;
    }

    .login-wrapper h2 {
        margin: 0 0 4%;
        color: #ffffff;
        font-size: clamp(14px, 3.6vw, 30px);
        font-weight: 700;
        text-align: center;
        letter-spacing: 0.05em;
    }

    .input-group {
        margin-bottom: 2%;
    }

    .input-group label {
        display: block;
        margin-bottom: 1%;
        color: #1c1d1f;
        font-weight: 500;
        font-size: clamp(7px, 1.4cqw, 14px);
    }

    .input-group input {
        width: 100%;
        padding: 3%;
        background-color: #ffffff;
        border: none;
        border-radius: 2px;
        color: #1c1d1f;
        box-sizing: border-box;
        font-size: clamp(6px, 1.4cqw, 10px);
    }

    .btn-login {
        width: 100%;
        margin-top: 3%;
        padding: 2% 5%;
        background-color: #4a4e69;
        color: white;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        font-weight: 500;
        font-size: clamp(7px, 1.6cqw, 14px);
    }

    /* ===== 핸들 호버 ===== */
    .handle-row {
        position: absolute;
        top: 10%;
        left: 31.7%;
        width: 36.5%;
        display: flex;
        justify-content: space-between;
        z-index: 2;
    }

    .handle-wrap {
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .handle {
        transform-origin: top center;
        cursor: pointer;
    }

    .strap {
        width: 0.6cqw;
        height: 3cqw;
        background: #a0a0a0;
        margin: 0 auto;
        border-radius: 2px;
    }

    .ring-tri {
        width: 0;
        height: 0;
        border-left: 1.8cqw solid transparent;
        border-right: 1.8cqw solid transparent;
        border-bottom: 3cqw solid #f4a935;
        position: relative;
    }

    .ring-tri:after {
        content: "";
        position: absolute;
        left: -1.2cqw;
        top: 0.75cqw;
        width: 0;
        height: 0;
        border-left: 1.2cqw solid transparent;
        border-right: 1.2cqw solid transparent;
        border-bottom: 1.95cqw solid #eeeeee;
    }

    .handle-wrap:hover .handle {
        animation: sway 0.5s ease-in-out infinite;
    }

    @keyframes sway {
        0% {
            transform: rotate(0deg);
        }
        25% {
            transform: rotate(14deg);
        }
        50% {
            transform: rotate(0deg);
        }
        75% {
            transform: rotate(-14deg);
        }
        100% {
            transform: rotate(0deg);
        }
    }
</style>
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