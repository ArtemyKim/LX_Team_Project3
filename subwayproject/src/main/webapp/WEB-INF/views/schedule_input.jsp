<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="addrbook_error.jsp" import="lx.edu.subwayproject.*"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<title>Home</title>
</head>
	<body>
	
		<form action="${pageContext.request.contextPath}/schedules"
	      method="post">
	
		출발역 
	    <input type="number"
	           name="departureStation.stationId">
		도착역
	    <input type="number"
	           name="arrivalStation.stationId">
	           
	    (임시)유저ID       
	    <input type="number"
	           name="userId">
		날짜
	    <input type="date"
	           name="travelDate">
		시각
	    <input type="time"
	           name="travelTime">
	
	    <button type="submit">
	        등록
	    </button>
	
		</form>
	</body>
</html>


