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

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/notice.css">

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
				
				    <strong>이례상황 종류 :</strong>
				
				    <c:choose>
				
				        <c:when test="${notice.noticeTypeCode == 1}">
				            화재
				        </c:when>
				
				        <c:when test="${notice.noticeTypeCode == 2}">
				            차량고장
				        </c:when>
				
				        <c:when test="${notice.noticeTypeCode == 3}">
				            열차사고
				        </c:when>
				
				        <c:when test="${notice.noticeTypeCode == 4}">
				            시설장애
				        </c:when>
				
				        <c:when test="${notice.noticeTypeCode == 5}">
				            단순지연
				        </c:when>
				
				        <c:when test="${notice.noticeTypeCode == 6}">
				            기타사유
				        </c:when>
				
				        <c:otherwise>
				            기타사유
				        </c:otherwise>
				
				    </c:choose>
				
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
					
					    <c:choose>
					
					        <c:when test="${notice.stationSectionCodeList eq '전구간'}">
					
					            전구간
					
					        </c:when>
					
					        <c:when test="${empty notice.stationSectionCodeList}">
					
					            구간 정보 없음
					
					        </c:when>
					
					        <c:otherwise>
					
					            <c:forEach var="stationName"
					                       items="${notice.affectedStationNames}"
					                       varStatus="status">
					
					                ${stationName}<c:if test="${not status.last}"> , </c:if>
					
					            </c:forEach>
					
					        </c:otherwise>
					
					    </c:choose>
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