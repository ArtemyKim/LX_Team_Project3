<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="addrbook_error.jsp" import="lx.edu.subwayproject.*"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ page session="false"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">

<title>스케줄 등록</title>

<script>

    // 현재까지 만들어진 Route 번호
    let routeCount = 1;

    // contextPath
    const contextPath = "${pageContext.request.contextPath}";


    /*
     * 루트 추가
     */
    function addRoute() {

        const routeContainer =
            document.getElementById("routeContainer");

        const routeDiv =
            document.createElement("div");

        routeDiv.className = "route-item";

        const index = routeCount;

        routeDiv.innerHTML =
            '<hr>' +

            '<h3>Route ' + (index + 1) + '</h3>' +

            '호선 : ' +

            '<select ' +
            'name="routes[' + index + '].lineName" ' +
            'class="line-select" ' +
            'data-index="' + index + '" ' +
            'required>' +

                '<option value="">호선을 선택하세요</option>' +

                '<option value="1호선">1호선</option>' +
                '<option value="2호선">2호선</option>' +
                '<option value="3호선">3호선</option>' +
                '<option value="4호선">4호선</option>' +
                '<option value="5호선">5호선</option>' +
                '<option value="6호선">6호선</option>' +
                '<option value="7호선">7호선</option>' +
                '<option value="8호선">8호선</option>' +
                '<option value="9호선">9호선</option>' +

            '</select>' +

            '<br><br>' +

            '출발역 : ' +

            '<select ' +
            'name="routes[' + index + '].departureStationId" ' +
            'id="departureStation-' + index + '" ' +
            'required disabled>' +

                '<option value="">호선을 먼저 선택하세요</option>' +

            '</select>' +

            '<br><br>' +

            '도착역 : ' +

            '<select ' +
            'name="routes[' + index + '].arrivalStationId" ' +
            'id="arrivalStation-' + index + '" ' +
            'required disabled>' +

                '<option value="">호선을 먼저 선택하세요</option>' +

            '</select>' +

            '<br><br>';


        routeContainer.appendChild(routeDiv);

        routeCount++;
    }


    /*
     * 선택한 호선에 속하는 역을 서버에서 가져옴
     */
    function loadStations(lineName, index) {

        const departureSelect =
            document.getElementById(
                "departureStation-" + index
            );

        const arrivalSelect =
            document.getElementById(
                "arrivalStation-" + index
            );


        // 호선을 선택하지 않은 경우
        if (lineName === "") {

            departureSelect.innerHTML =
                '<option value="">호선을 먼저 선택하세요</option>';

            arrivalSelect.innerHTML =
                '<option value="">호선을 먼저 선택하세요</option>';

            departureSelect.disabled = true;

            arrivalSelect.disabled = true;

            return;
        }


        // 서버에 호선별 역 목록 요청
        fetch(
            contextPath
            + "/stationsByLine.do?lineName="
            + encodeURIComponent(lineName)
        )

        .then(function(response) {

            if (!response.ok) {
                throw new Error("역 목록 조회 실패");
            }

            return response.json();
        })

        .then(function(stations) {

            // 기존 목록 제거
            departureSelect.innerHTML =
                '<option value="">출발역 선택</option>';

            arrivalSelect.innerHTML =
                '<option value="">도착역 선택</option>';


            // 서버에서 받은 역 목록 추가
            stations.forEach(function(station) {

                const departureOption =
                    document.createElement("option");

                departureOption.value =
                    station.stationId;

                departureOption.textContent =
                    station.stationName;


                const arrivalOption =
                    document.createElement("option");

                arrivalOption.value =
                    station.stationId;

                arrivalOption.textContent =
                    station.stationName;


                departureSelect.appendChild(
                    departureOption
                );

                arrivalSelect.appendChild(
                    arrivalOption
                );
            });


            departureSelect.disabled = false;

            arrivalSelect.disabled = false;

        })

        .catch(function(error) {

            console.error(error);

            alert("역 목록을 불러오는 중 오류가 발생했습니다.");
        });
    }


    /*
     * 동적으로 생성된 select까지 처리하기 위해
     * 이벤트 위임 사용
     */
    document.addEventListener(
        "change",
        function(event) {

            if (
                event.target.classList.contains(
                    "line-select"
                )
            ) {

                const lineName =
                    event.target.value;

                const index =
                    event.target.dataset.index;

                loadStations(
                    lineName,
                    index
                );
            }
        }
    );

</script>

</head>


<body>


<h1>스케줄 등록</h1>


<form action="${pageContext.request.contextPath}/schedules"
      method="post">


    <!-- ========================== -->
    <!-- Schedule 정보 -->
    <!-- ========================== -->

    <h2>스케줄 정보</h2>


    스케줄 이름 :

    <input type="text"
           name="scheduleName"
           required>

    <br><br>


    날짜 :

    <input type="date"
           name="travelDate"
           required>


    <br><br>


    <!-- ========================== -->
    <!-- Route 정보 -->
    <!-- ========================== -->

    <h2>경로</h2>


    <div id="routeContainer">


        <!-- 최초 Route 1개 -->

        <div class="route-item">


            <h3>Route 1</h3>


            호선 :

            <select
                name="routes[0].lineName"
                class="line-select"
                data-index="0"
                required>

                <option value="">
                    호선을 선택하세요
                </option>

                <option value="1호선">1호선</option>
                <option value="2호선">2호선</option>
                <option value="3호선">3호선</option>
                <option value="4호선">4호선</option>
                <option value="5호선">5호선</option>
                <option value="6호선">6호선</option>
                <option value="7호선">7호선</option>
                <option value="8호선">8호선</option>
                <option value="9호선">9호선</option>

            </select>


            <br><br>


            출발역 :

            <select
                name="routes[0].departureStationId"
                id="departureStation-0"
                required
                disabled>

                <option value="">
                    호선을 먼저 선택하세요
                </option>

            </select>


            <br><br>


            도착역 :

            <select
                name="routes[0].arrivalStationId"
                id="arrivalStation-0"
                required
                disabled>

                <option value="">
                    호선을 먼저 선택하세요
                </option>

            </select>


            <br><br>


        </div>


    </div>


    <!-- Route 추가 -->

    <button type="button"
            onclick="addRoute()">

        루트 추가

    </button>


    <br><br><br>


    <!-- Schedule 저장 -->

    <button type="submit">

        스케줄 저장

    </button>


</form>


</body>

</html>