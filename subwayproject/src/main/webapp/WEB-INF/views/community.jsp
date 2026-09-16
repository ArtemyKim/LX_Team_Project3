<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="addrbook_error.jsp" import="lx.edu.subwayproject.*"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

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
		<c:choose>
			<c:when test="${sessionScope.loginUser != null}">
				<li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/logout.do">Logout</a></li>
			</c:when>
			<c:otherwise>
				<li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/login.do">Login</a></li>
			</c:otherwise>
		</c:choose>
		<li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/schedules.do">Scheduler</a></li>
	</ul>
	<!-- ============ Navi end ============ -->

	<div class="container" style="margin-top: 100px;">

		<!-- 제목 + 글 추가 버튼 -->
		<div class="d-flex justify-content-between align-items-center mb-4" style="max-width: 700px; margin: 0 auto;">
			<h3 class="fw-bold m-0">실시간 지하철 이례상황 🚇</h3>
			<!-- 새 글 쓰기는 페이지 이동 유지 -->
			<button type="button" class="btn btn-secondary" id="newRouteBtn" onclick="location.href='/subwayproject/community/write'">+ 글 추가하기</button>
		</div>

		<!-- 🪗 아코디언 그룹 시작 -->
		<div class="accordion" id="communityAccordion" style="max-width: 700px; margin: 0 auto;">

			<c:forEach var="post" items="${postList}">
			<div class="accordion-item shadow-sm mb-3 border-0 rounded overflow-hidden">

				<h2 class="accordion-header" id="heading-${post.postId}">
					<button class="accordion-button collapsed py-3" type="button" data-bs-toggle="collapse" data-bs-target="#collapse-${post.postId}">
						<span class="badge bg-primary me-3">제목</span> 
						<span class="fw-bold fs-5 me-auto">${post.title}</span> 
						<span class="text-muted small fw-normal me-3 d-none d-md-block">작성자: ${post.userName} | ${post.createdTime}</span>
					</button>
				</h2>

				<!-- [아코디언 바디(내용)] -->
				<div id="collapse-${post.postId}" class="accordion-collapse collapse" data-bs-parent="#communityAccordion">
					<div class="accordion-body bg-white pt-4 pb-2">

						<!-- 게시글 내용 및 수정/삭제 버튼 (제목 수정, 내용 수정 버튼을 각각 분리!) -->
						<div class="d-flex justify-content-between mb-3">
							<p class="card-text fs-6" style="min-height: 100px; white-space: pre-line;">${post.content}</p>
							<div class="text-end text-nowrap ms-3 d-flex flex-column gap-1">
								<button type="button" class="btn btn-sm btn-outline-secondary" onclick="editPostTitle('${post.postId}')">제목 수정</button>
								<button type="button" class="btn btn-sm btn-outline-secondary" onclick="editPostContent('${post.postId}')">내용 수정</button>
								<button type="button" class="btn btn-sm btn-outline-danger" onclick="deletePost('${post.postId}')">삭제</button>
							</div>
						</div>

						<!-- 좋아요 버튼 (비동기 처리) -->
						<div class="text-center mb-4">
							<button class="btn btn-outline-danger rounded-pill px-4" onclick="likePost('${post.postId}', this)">
								❤️ 좋아요 <span class="badge bg-danger ms-1" id="likeCount-${post.postId}">${post.likeCount}</span>
							</button>
						</div>

						<hr class="text-muted">

						<!-- 댓글 영역 -->
						<h6 class="fw-bold mb-3">댓글 <span class="text-primary">${post.commentList != null ? post.commentList.size() : 0}</span></h6>

						<ul class="list-group list-group-flush mb-3">
							<c:forEach var="comment" items="${post.commentList}">
								<li class="list-group-item px-0 py-2 border-bottom-0">
									<div class="d-flex justify-content-between align-items-start">
										<div class="bg-light p-3 rounded w-100 me-2">
											<div class="fw-bold small mb-1">${comment.userName}</div>
											<div class="fs-6">${comment.content}</div>
										</div>
										<div class="text-end mt-1">
											<span class="text-muted" style="font-size: 0.75rem;">${comment.createdTime}</span>
											<div class="mt-1">
												<button type="button" class="btn btn-sm btn-link text-secondary p-0 me-1" style="font-size: 0.8rem;" onclick="editComment('${comment.commentId}', this)">수정</button>
												<button type="button" class="btn btn-sm btn-link text-danger p-0" style="font-size: 0.8rem;" onclick="deleteComment('${comment.commentId}', this)">삭제</button>
											</div>
										</div>
									</div>
								</li>
							</c:forEach>
						</ul>

						<!-- 댓글 작성 폼 (새로고침 없는 Ajax 등록 처리로 변경!) -->
						<form onsubmit="submitComment(event, '${post.postId}')" class="d-flex gap-2 mt-2">
							<input type="text" name="content" class="form-control bg-light" placeholder="댓글을 남겨보세요..." required>
							<button type="submit" class="btn btn-primary text-nowrap px-4">등록</button>
						</form>

					</div>
				</div>
			</div>
			</c:forEach>
		</div>
	</div>

	<!-- 부트스트랩 JS -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

	<!-- 🔥 SPA(Ajax) 스크립트 모음 🔥 -->
	<script>
    // 🗑️ 1. 게시글 삭제
    function deletePost(postId) {
        if(confirm("정말 이 게시글을 삭제하시겠습니까?")) {
            fetch('/subwayproject/community/deletePost?postId=' + postId)
            .then(response => response.text())
            .then(data => {
                if(data === "success") {
                    document.getElementById('heading-' + postId).parentElement.remove();
                } else {
                    alert("삭제에 실패했습니다.");
                }
            })
            .catch(error => console.error('Error:', error));
        }
    }

    // 🗑️ 2. 댓글 삭제
    function deleteComment(commentId, btnElement) {
        if(confirm("댓글을 삭제하시겠습니까?")) {
            fetch('/subwayproject/community/deleteComment?commentId=' + commentId)
            .then(response => response.text())
            .then(data => {
                if(data === "success") {
                    btnElement.closest('li').remove();
                } else {
                    alert("삭제에 실패했습니다.");
                }
            })
            .catch(error => console.error('Error:', error));
        }
    }

    // 💬 3. 댓글 등록 (새로고침 없이 비동기 등록)
   // 💬 3. 댓글 등록 (수정된 코드)
    function submitComment(event, postId) {
        event.preventDefault(); 
        
        let form = event.target;
        let contentInput = form.querySelector('input[name="content"]');
        let content = contentInput.value;
        
        let formData = new URLSearchParams();
        formData.append("postId", postId);
        formData.append("content", content);

        fetch('/subwayproject/community/submitComment', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: formData
        })
        .then(response => {
            if(response.ok) {
                // 🌟 포인트: 새로고침 직전에 열려있던 postId를 세션 스토리지에 백업합니다.
                sessionStorage.setItem("openPostId", postId);
                
                location.reload(); // 기존처럼 새로고침 진행
            } else {
                alert("댓글 등록 실패");
            }
        })
        .catch(error => console.error('Error:', error));
    }

    // ✍️ 4-1. 게시글 제목만 따로 수정
    function editPostTitle(postId) {
        let accordionHeader = document.querySelector('#heading-' + postId);
        let titleSpan = accordionHeader.querySelector('.fw-bold.fs-5.me-auto');
        let oldTitle = titleSpan.innerText.trim();

        let newTitle = prompt("수정할 게시글 제목을 입력하세요:", oldTitle);
        if (newTitle === null || newTitle.trim() === "") return;

        let contentElement = document.querySelector('#collapse-' + postId + ' .card-text');
        let currentContent = contentElement.innerText.trim(); // DB 제약조건 충족을 위해 기존 내용 함께 전송

        let formData = new URLSearchParams();
        formData.append("postId", postId);
        formData.append("title", newTitle);
        formData.append("content", currentContent);

        sendUpdateAjax(formData, function() {
            titleSpan.innerText = newTitle;
            alert("제목 수정 완료!");
        });
    }

    // ✍️ 4-2. 게시글 내용만 따로 수정
    function editPostContent(postId) {
        let contentElement = document.querySelector('#collapse-' + postId + ' .card-text');
        let oldContent = contentElement.innerText.trim();

        let newContent = prompt("수정할 게시글 내용을 입력하세요:", oldContent);
        if (newContent === null || newContent.trim() === "") return;

        let accordionHeader = document.querySelector('#heading-' + postId);
        let titleSpan = accordionHeader.querySelector('.fw-bold.fs-5.me-auto');
        let currentTitle = titleSpan.innerText.trim(); // DB 제약조건 충족을 위해 기존 제목 함께 전송

        let formData = new URLSearchParams();
        formData.append("postId", postId);
        formData.append("title", currentTitle);
        formData.append("content", newContent);

        sendUpdateAjax(formData, function() {
            contentElement.innerText = newContent;
            alert("내용 수정 완료!");
        });
    }

    // 공통 서버 전송 헬퍼 함수 (코드 중복 방지)
    function sendUpdateAjax(formData, successCallback) {
        fetch('/subwayproject/community/editPost', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: formData
        })
        .then(response => response.text())
        .then(data => {
            if (data === "success") {
                successCallback();
            } else {
                alert("수정에 실패했습니다.");
            }
        })
        .catch(error => console.error('Error:', error));
    }

    // ✍️ 5. 댓글 수정
    function editComment(commentId, btnElement) {
        let contentElement = btnElement.closest('.list-group-item').querySelector('.fs-6');
        let oldContent = contentElement.innerText;
        let newContent = prompt("댓글을 수정하세요:", oldContent);
        
        if (newContent !== null && newContent.trim() !== "" && newContent !== oldContent) {
            let formData = new URLSearchParams();
            formData.append("commentId", commentId);
            formData.append("content", newContent);

            fetch('/subwayproject/community/editComment', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: formData
            })
            .then(response => response.text())
            .then(data => {
                if (data === "success") {
                    contentElement.innerText = newContent;
                    alert("댓글 수정 완료!");
                } else {
                    alert("댓글 수정에 실패했습니다.");
                }
            })
            .catch(error => console.error('Error:', error));
        }
    }
    // ❤️ 6. 좋아요 (비동기, 클릭 시 숫자만 바로 +1)
    function likePost(postId, btnElement) {
        btnElement.disabled = true; // 연타 방지

        fetch('/subwayproject/community/likePost', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: new URLSearchParams({ postId: postId })
        })
        .then(response => response.text())
        .then(data => {
            if (data === "success") {
                let countSpan = document.getElementById('likeCount-' + postId);
                countSpan.innerText = parseInt(countSpan.innerText) + 1;
            } else {
                alert("로그인 후 이용해주세요.");
            }
        })
        .catch(error => console.error('Error:', error))
        .finally(() => { btnElement.disabled = false; });
    }
    
 // 🌟 페이지가 완전히 로드된 후 실행 (새로고침 직후 아코디언 복구)
    document.addEventListener("DOMContentLoaded", function() {
        let openPostId = sessionStorage.getItem("openPostId");
        
        if (openPostId) {
            let targetCollapse = document.getElementById('collapse-' + openPostId);
            if (targetCollapse) {
                // 부트스트랩 API를 사용해 해당 아코디언을 강제로 엽니다.
                let bsCollapse = new bootstrap.Collapse(targetCollapse, {
                    toggle: false
                });
                bsCollapse.show();
            }
            // 목적을 달성했으므로 스토리지에서 삭제합니다.
            sessionStorage.removeItem("openPostId"); 
        }
    });
	</script>
</body>
</html>