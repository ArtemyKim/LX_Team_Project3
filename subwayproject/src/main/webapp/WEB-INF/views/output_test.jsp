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

<style>

    body {
        font-family: sans-serif;
        padding: 30px;
    }

    .schedule {
        border: 1px solid #ccc;
        border-radius: 10px;
        padding: 20px;
        margin-bottom: 25px;
    }

    table {
        border-collapse: collapse;
        width: 100%;
        margin-top: 10px;
    }

    th,
    td {
        border: 1px solid #ccc;
        padding: 10px;
        text-align: center;
    }

    .status-area {
        margin-top: 20px;
    }

    .status-badge {
        display: inline-block;
        padding: 8px 15px;
        border-radius: 20px;
        font-weight: bold;
        text-decoration: none;
    }

    .problem {
        background-color: #f8d7da;
        color: #842029;
        cursor: pointer;
    }

    .problem:hover {
        background-color: #f1aeb5;
    }

    .safe {
        background-color: #d1e7dd;
        color: #0f5132;
    }

</style>

</head>


<body>


<h1>내 스케줄</h1>


<!-- 등록된 Schedule이 없는 경우 -->
<c:if test="${empty scheduleList}">

    <p>
        등록된 스케줄이 없습니다.
    </p>

</c:if>



<!-- Schedule 목록 -->
<c:forEach var="schedule"
           items="${scheduleList}">


    <div class="schedule">


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



        <h3>이동 경로</h3>


        <!-- Route 존재 여부 -->
        <c:choose>

            <c:when test="${empty schedule.routes}">

                <p>
                    등록된 경로가 없습니다.
                </p>

            </c:when>


            <c:otherwise>

                <table>

                    <thead>

                        <tr>

                            <th>순서</th>

                            <th>출발역</th>

                            <th>도착역</th>

                        </tr>

                    </thead>


                    <tbody>

                        <c:forEach var="route"
                                   items="${schedule.routes}">

                            <tr>

                                <td>
                                    ${route.routeSeq}
                                </td>

                                <td>
                                    ${route.departureStationName}
                                </td>

                                <td>
                                    ${route.arrivalStationName}
                                </td>

                            </tr>

                        </c:forEach>

                    </tbody>

                </table>

            </c:otherwise>

        </c:choose>



        <div class="status-area">

            <strong>
                이례상황 :
            </strong>


            <!-- 문제 여부 표시 -->
            <c:choose>

                <c:when test="${schedule.problem}">

                    <a class="status-badge problem"
                       href="${pageContext.request.contextPath}/schedule/status/${schedule.scheduleId}/notices">

                        문제 있음

                    </a>

                </c:when>


                <c:otherwise>

                    <span class="status-badge safe">

                        문제 없음

                    </span>

                </c:otherwise>

            </c:choose>

        </div>


    </div>


</c:forEach>


</body>

</html>