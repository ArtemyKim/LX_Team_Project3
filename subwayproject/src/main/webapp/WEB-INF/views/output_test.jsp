<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="addrbook_error.jsp" import="lx.edu.subwayproject.*"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ page session="false"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">

<title>스케줄 출력</title>

<body>


<h1>내 스케줄</h1>


<!-- 스케줄이 하나도 없는 경우 -->
<c:if test="${empty scheduleList}">

    <p>등록된 스케줄이 없습니다.</p>

</c:if>


<!-- 스케줄 목록 -->
<c:forEach var="schedule" items="${scheduleList}">

    <hr>

    <div class="schedule">

        <!-- 스케줄 기본 정보 -->
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



        <!-- ======================
             Route 목록
             ====================== -->

        <h3>이동 경로</h3>


        <c:choose>


            <c:when test="${empty schedule.routes}">

                <p>
                    등록된 경로가 없습니다.
                </p>

            </c:when>


            <c:otherwise>

                <table border="1">

                    <thead>

                        <tr>

                            <th>순서</th>

                            <th>출발역</th>

                            <th>도착역</th>

                        </tr>

                    </thead>


                    <tbody>


                        <c:forEach
                            var="route"
                            items="${schedule.routes}"
                            varStatus="status">


                            <tr>

                                <td>
                                    ${status.count}
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


    </div>


</c:forEach>


</body>


</html>