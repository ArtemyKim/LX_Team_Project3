<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="jakarta.tags.core"
           prefix="c"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>이례상황 상세</title>

<style>

    body {
        font-family: sans-serif;
        padding: 30px;
    }

    .schedule-info {
        border: 1px solid #ccc;
        border-radius: 10px;
        padding: 20px;
        margin-bottom: 30px;
    }

    .notice {
        border: 1px solid #ddd;
        border-radius: 10px;
        padding: 20px;
        margin-bottom: 20px;
    }

    .notice-title {
        font-size: 20px;
        font-weight: bold;
        margin-bottom: 15px;
    }

    .notice-content {
        margin-top: 15px;
        padding: 15px;
        background-color: #f5f5f5;
        border-radius: 6px;
    }

    .back-button {
        display: inline-block;
        margin-top: 20px;
        padding: 10px 18px;
        border-radius: 6px;
        text-decoration: none;
        background-color: #333;
        color: white;
    }

    .back-button:hover {
        background-color: #555;
    }

</style>

</head>


<body>


<h1>이례상황 상세</h1>



<div class="schedule-info">

    <h2>
        ${schedule.scheduleName}
    </h2>

    <p>
        날짜 :
        ${schedule.travelDate}
    </p>

    <c:if test="${not empty schedule.travelTime}">

        <p>
            시간 :
            ${schedule.travelTime}
        </p>

    </c:if>

</div>



<h2>영향을 주는 이례상황</h2>


<!-- 영향을 주는 Notice가 없는 경우 -->
<c:choose>

    <c:when test="${empty schedule.affectedNotices}">

        <p>
            현재 이 스케줄에 영향을 주는
            이례상황이 없습니다.
        </p>

    </c:when>


    <c:otherwise>

        <c:forEach var="notice"
                   items="${schedule.affectedNotices}">


            <div class="notice">


                <div class="notice-title">

                    ${notice.noticeTitle}

                </div>


                <p>
                    <strong>Notice 번호 :</strong>
                    ${notice.noticeId}
                </p>


                <p>
                    <strong>이례상황 종류 :</strong>
                    ${notice.noticeTypeCode}
                </p>


                <p>
                    <strong>대상 노선 :</strong>
                    ${notice.lineNameList}
                </p>


                <p>
                    <strong>영향 구간 :</strong>
                    ${notice.stationSectionCodeList}
                </p>


                <p>
                    <strong>발생 시각 :</strong>
                    ${notice.noticeTime}
                </p>


                <c:if test="${not empty notice.abnormalStartTime}">

                    <p>
                        <strong>이례상황 시작 :</strong>
                        ${notice.abnormalStartTime}
                    </p>

                </c:if>


                <c:if test="${not empty notice.abnormalEndTime}">

                    <p>
                        <strong>이례상황 종료 :</strong>
                        ${notice.abnormalEndTime}
                    </p>

                </c:if>


                <div class="notice-content">

                    ${notice.noticeContent}

                </div>


            </div>


        </c:forEach>

    </c:otherwise>

</c:choose>



<a class="back-button"
   href="${pageContext.request.contextPath}/schedules.do">

    스케줄 목록으로 돌아가기

</a>


</body>

</html>