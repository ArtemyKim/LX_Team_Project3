<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티 게시글</title>

<!-- 부트스트랩 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/community.css">
</head>

<body class="bg-light">

	<!-- ============ Navi begin ============ -->
	<ul class="nav">
		<li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/login">Login</a></li>
		<li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/schedule/status">Scheduler</a></li>
	</ul>
	<!-- ============ Navi end ============ -->

	<!-- ❌ 맨 위에 덩그러니 있던 버튼 삭제함! -->

	<div class="container" style="margin-top: 100px;">

		<!-- 제목 + 글 추가 버튼: 아코디언과 같은 700px 폭 안에서 양 끝 정렬 -->
		<div class="d-flex justify-content-between align-items-center mb-4" style="max-width: 700px; margin: 0 auto;">
			<h3 class="fw-bold m-0">실시간 지하철 이례상황 🚇</h3>
			
			<!-- ⭕ 이 버튼이 찐입니다! type="button"으로 바꾸고 location.href 연결! -->
			<button type="button" class="btn btn-secondary" id="newRouteBtn" onclick="location.href='/subwayproject/community/write'">+ 글 추가하기</button>
		</div>

		<!-- 🪗 아코디언 그룹 시작 -->
		<div class="accordion" id="communityAccordion" style="max-width: 700px; margin: 0 auto;">

			<%-- <c:forEach var="post" items="${postList}"> --%>
			<div class="accordion-item shadow-sm mb-3 border-0 rounded overflow-hidden">

				<h2 class="accordion-header" id="heading-${post.POST_ID}">
					<button class="accordion-button collapsed py-3" type="button" data-bs-toggle="collapse" data-bs-target="#collapse-${post.POST_ID}">
						<span class="badge bg-primary me-3">Q</span> 
						<span class="fw-bold fs-5 me-auto">${post.TITLE}</span> 
						<span class="text-muted small fw-normal me-3 d-none d-md-block">작성자: ${post.USER_NAME} | ${post.CREATED_TIME}</span>
					</button>
				</h2>

				<!-- [아코디언 바디(내용)] -->
				<div id="collapse-${post.POST_ID}" class="accordion-collapse collapse" data-bs-parent="#communityAccordion">
					<div class="accordion-body bg-white pt-4 pb-2">

						<!-- 게시글 내용 및 수정/삭제 버튼 -->
						<div class="d-flex justify-content-between mb-3">
							<p class="card-text fs-6" style="min-height: 100px; white-space: pre-line;">${post.CONTENT}</p>
							<div class="text-end text-nowrap ms-3">
								<button type="button" class="btn btn-sm btn-outline-secondary" onclick="location.href='/subwayproject/community/editPost?postId=${post.POST_ID}'">수정</button>
								<button type="button" class="btn btn-sm btn-outline-danger" onclick="deletePost(${post.POST_ID})">삭제</button>
							</div>
						</div>

						<!-- 좋아요 버튼 -->
						<div class="text-center mb-4">
							<button class="btn btn-outline-danger rounded-pill px-4" onclick="alert('좋아요 꾹!')">
								❤️ 좋아요 <span class="badge bg-danger ms-1">${post.LIKE_COUNT}</span>
							</button>
						</div>

						<hr class="text-muted">

						<!-- 댓글 영역 -->
						<h6 class="fw-bold mb-3">댓글 <span class="text-primary">${commentList.size()}</span></h6>

						<ul class="list-group list-group-flush mb-3">
							<c:forEach var="comment" items="${commentList}">
								<li class="list-group-item px-0 py-2 border-bottom-0">
									<div class="d-flex justify-content-between align-items-start">
										<div class="bg-light p-3 rounded w-100 me-2">
											<div class="fw-bold small mb-1">${comment.USER_NAME}</div>
											<div class="fs-6">${comment.CONTENT}</div>
										</div>
										<div class="text-end mt-1">
											<span class="text-muted" style="font-size: 0.75rem;">${comment.CREATED_TIME}</span>
											<div class="mt-1">
												<button type="button" class="btn btn-sm btn-link text-secondary p-0 me-1" style="font-size: 0.8rem;" onclick="editComment()">수정</button>
												<button type="button" class="btn btn-sm btn-link text-danger p-0" style="font-size: 0.8rem;" onclick="deleteComment('${comment.COMMENT_ID}')">삭제</button>
											</div>
										</div>
									</div>
								</li>
							</c:forEach>
						</ul>

						<!-- 댓글 작성 폼 -->
						<form action="/subwayproject/community/submitComment" method="post" class="d-flex gap-2 mt-2">
							<!-- ⭕ name을 정확히 postId (언더바 없음)로 수정! -->
							<input type="hidden" name="postId" value="${post.POST_ID}">
							<!-- ⭕ name="content" 소문자 유지! -->
							<input type="text" name="content" class="form-control bg-light" placeholder="댓글을 남겨보세요..." required>
							<button type="submit" class="btn btn-primary text-nowrap px-4">등록</button>
						</form>

					</div>
				</div>
			</div>
			<!-- 게시글 1개 아이템 끝 -->
		<%-- </c:forEach> --%>
		</div>
	</div>

	<!-- 부트스트랩 JS -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

	<script>
    function deletePost(postId) {
        if(confirm("정말 이 게시글을 삭제하시겠습니까?")) {
            location.href = '/subwayproject/community/deletePost?postId=' + postId;
        }
    }

    function deleteComment(commentId) {
        if(confirm("댓글을 삭제하시겠습니까?")) {
            location.href = '/subwayproject/community/deleteComment?commentId=' + commentId;
        }
    }
    
    function editComment() {
        alert("댓글 수정 기능은 별도의 폼이나 팝업 구현이 필요합니다.");
    }
	</script>
</body>
</html>