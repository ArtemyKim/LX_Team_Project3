<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="jakarta.tags.core"
           prefix="c"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>내 스케줄</title>

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

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/output.css">

</head>


<body>


<div class="schedule-nav-wrap">

    <ul class="schedule-nav">
        <li><a class="schedule-nav-link" href="${pageContext.request.contextPath}/login">Logout</a></li>
        <li><a class="schedule-nav-link" href="${pageContext.request.contextPath}/community">Community</a></li>
    </ul>

    <a class="add-route-btn"
       href="${pageContext.request.contextPath}/schedule/inputTest">
        + 새 경로 추가하기
    </a>

</div>


<div class="subway-scene">

    <div class="card-wrap">

        <!-- 등록된 Schedule이 없는 경우 -->
        <c:if test="${empty scheduleList}">

            <p class="empty-msg">
                등록된 스케줄이 없습니다.
            </p>

        </c:if>


        <!-- Schedule 목록 -->
        <c:forEach var="schedule"
                   items="${scheduleList}">


            <div class="route-card">


                <div class="route-card-header">

                    <h2 class="route-name">
                        ${schedule.scheduleName}
                    </h2>


                    <c:choose>

                        <c:when test="${schedule.problem}">

                            <a class="status-badge status-yellow"
                               href="${pageContext.request.contextPath}/schedule/status/${schedule.scheduleId}/notices">

                                문제 있음

                            </a>

                        </c:when>


                        <c:otherwise>

                            <span class="status-badge status-green">

                                정상

                            </span>

                        </c:otherwise>

                    </c:choose>

                </div>


                <p class="route-meta">
                    ${schedule.travelDate}

                    <c:if test="${not empty schedule.travelTime}">
                        · ${schedule.travelTime}
                    </c:if>
                </p>



                <!-- Route 존재 여부 -->
                <c:choose>

                    <c:when test="${empty schedule.routes}">

                        <p>
                            등록된 경로가 없습니다.
                        </p>

                    </c:when>


                    <c:otherwise>

                        <c:forEach var="route"
                                   items="${schedule.routes}">

                            <div class="station-block">
                                <span class="dot"></span>
                                <span>
                                    ${route.departureStationName}
                                    →
                                    ${route.arrivalStationName}
                                </span>
                            </div>

                        </c:forEach>

                    </c:otherwise>

                </c:choose>



                <!-- 문제 있을 때 안내 문구 -->
                <c:if test="${schedule.problem}">

                    <p class="notice-text">
                        이례상황이 등록되어 있습니다. 클릭하여 확인하세요.
                    </p>

                </c:if>


				<!-- 스케쥴 삭제 -->
               <div class="card-actions">

			    <form action="${pageContext.request.contextPath}/schedules/delete"
			          method="post">
			
			        <input type="hidden"
			               name="scheduleId"
			               value="${schedule.scheduleId}">
			
			        <button type="submit" class="btn-delete">
			            삭제
			        </button>

				    </form>
				
				</div>

            </div>


        </c:forEach>

    </div>

</div>


</body>

</html>