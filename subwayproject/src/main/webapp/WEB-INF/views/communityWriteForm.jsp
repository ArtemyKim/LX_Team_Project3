<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="addrbook_error.jsp" import="lx.edu.subwayproject.*"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>새 글 쓰기</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/communitywrite.css">
</head>
<body>

	<!-- ============ Navi begin ============ -->
	<ul class="nav">
		<c:choose>
			<c:when test="${sessionScope.loginUser != null}">
				<li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/logout.do">Logout</a></li>
			</c:when>
			<c:otherwise>
				<li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/login.do">Login</a></li>
			</c:otherwise>
		</c:choose>
		<li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/community">Community</a></li>
	</ul>
	<!-- ============ Navi end ============ -->

	<div class="write-wrap">
		<div class="write-card">
			<h2>새 글 작성</h2>

			<form action="${pageContext.request.contextPath}/community/write" method="post">
				<div class="write-field">
					<label>제목</label>
					<!-- 반드시 name을 DTO와 똑같이 소문자로! -->
					<input type="text" name="title" required>
				</div>
				<div class="write-field">
					<label>내용</label>
					<textarea name="content" rows="10" required></textarea>
				</div>
				<div class="write-actions">
					<button type="submit" class="btn-submit">글 등록</button>
					<button type="button" class="btn-cancel" onclick="history.back()">취소</button>
				</div>
			</form>
		</div>
	</div>

</body>
</html>
