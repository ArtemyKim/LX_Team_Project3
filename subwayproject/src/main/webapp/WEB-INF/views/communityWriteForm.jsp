<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>새 글 쓰기</title>
</head>
<body>
    <h2>새로운 이례상황 알리기</h2>
    <!-- action 주소는 POST /write 입니다! -->
    <form action="/subwayproject/community/write" method="post">
        <!-- 반드시 name을 DTO와 똑같이 소문자로! -->
        제목: <input type="text" name="title" required><br><br>
        내용:<br>
        <textarea name="content" rows="10" cols="50" required></textarea><br><br>
        <button type="submit">글 등록</button>
        <button type="button" onclick="history.back()">취소</button>
    </form>
</body>
</html>