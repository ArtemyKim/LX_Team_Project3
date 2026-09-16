<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="addrbook_error.jsp" import="lx.edu.subwayproject.*"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ page session="false"%>
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/schedulerForm.css">

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">

<title>스케줄 등록</title>

<script>

    // 현재까지 만들어진 Route 개수
    let routeCount = 1;

    // contextPath 경로용
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
	
		        '<div class="route-title-row">' +
		            '<h3>Route ' + (index + 1) + '</h3>' +
	
		            '<button type="button" ' +
		                    'class="btn-delete-route" ' +
		                    'onclick="deleteRoute(this)">' +
		                '경로 삭제' +
		            '</button>' +
		        '</div>' +
	
		        '<div class="form-row">' +
		            '<label>호선</label>' +
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
		        '</div>' +
	
		        '<div class="form-row">' +
		            '<label>출발역</label>' +
		            '<select ' +
		                'name="routes[' + index + '].departureStationId" ' +
		                'id="departureStation-' + index + '" ' +
		                'required disabled>' +
	
		                '<option value="">호선을 먼저 선택하세요</option>' +
	
		            '</select>' +
		        '</div>' +
	
		        '<div class="form-row">' +
		            '<label>도착역</label>' +
		            '<select ' +
		                'name="routes[' + index + '].arrivalStationId" ' +
		                'id="arrivalStation-' + index + '" ' +
		                'required disabled>' +
	
		                '<option value="">호선을 먼저 선택하세요</option>' +
	
		            '</select>' +
		        '</div>';
	
		    routeContainer.appendChild(routeDiv);
	
		    routeCount++;
		}
    
	 /*
	  * 루트 삭제
	  */
	 function deleteRoute(button) {

	     const routeContainer =
	         document.getElementById("routeContainer");

	     const routeItems =
	         routeContainer.querySelectorAll(".route-item");

	     // 최소 1개의 경로는 유지
	     if (routeItems.length <= 1) {
	         alert("경로는 최소 1개 이상 있어야 합니다.");
	         return;
	     }

	     // 누른 버튼이 들어있는 route-item 삭제
	     const routeItem =
	         button.closest(".route-item");

	     routeItem.remove();

	     // 삭제 후 인덱스 다시 정리
	     reindexRoutes();
	 }
	 
	 
	 // 지금 스케쥴에 Route들을 리스트로 넣고 있기 때문에 중간에 하나 삭제해버리면 인덱스 오류남
	 // 그래서 Route 삭제 후에도 routes[0], routes[1], routes[2]..처럼 유지할 수 있게 reindex기능
	 function reindexRoutes() {

	     const routeItems =
	         document.querySelectorAll("#routeContainer .route-item");

	     routeItems.forEach(function(routeItem, index) {

	         // Route 제목 수정
	         const title =
	             routeItem.querySelector("h3");

	         title.textContent =
	             "Route " + (index + 1);


	         // 호선 select 수정
	         const lineSelect =
	             routeItem.querySelector(".line-select");

	         lineSelect.name =
	             "routes[" + index + "].lineName";

	         lineSelect.dataset.index =
	             index;


	         // 출발역 select 수정
	         const departureSelect =
	             routeItem.querySelector(
	                 'select[name*="departureStationId"]'
	             );

	         departureSelect.name =
	             "routes[" + index + "].departureStationId";

	         departureSelect.id =
	             "departureStation-" + index;


	         // 도착역 select 수정
	         const arrivalSelect =
	             routeItem.querySelector(
	                 'select[name*="arrivalStationId"]'
	             );

	         arrivalSelect.name =
	             "routes[" + index + "].arrivalStationId";

	         arrivalSelect.id =
	             "arrivalStation-" + index;
	     });

	     // 현재 Route 개수로 맞춤
	     routeCount = routeItems.length;
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

<div class="subway-scene">

    <div class="card-wrap">

        <form action="${pageContext.request.contextPath}/schedules"
              method="post">

            <div class="schedule-card">

                <!-- ===================== -->
                <!-- 스케줄 정보 -->
                <!-- ===================== -->

                <h2>스케줄 등록</h2>

                <div class="form-row">
                    <label>스케줄 이름</label>

                    <input type="text"
                           name="scheduleName"
                           placeholder="스케줄 이름을 입력하세요"
                           required>
                </div>

                <div class="form-row">
                    <label>날짜</label>

                    <input type="date"
                           name="travelDate"
                           required>
                </div>


                <!-- ===================== -->
                <!-- 경로 -->
                <!-- ===================== -->

                <div class="route-header">
                    <strong>경로</strong>
                </div>

                <div id="routeContainer">
				
				<div class="route-item">
				
				    <div class="route-title-row">
				
				        <h3>Route 1</h3>
				
				        <button type="button"
				                class="btn-delete-route"
				                onclick="deleteRoute(this)">
				            경로 삭제
				        </button>
				
				    </div>
				
				    <div class="form-row">
                            <label>호선</label>

                            <select
                                name="routes[0].lineName"
                                class="line-select"
                                data-index="0"
                                required>

                                <option value="">호선을 선택하세요</option>
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
                        </div>

                        <div class="form-row">
                            <label>출발역</label>

                            <select
                                name="routes[0].departureStationId"
                                id="departureStation-0"
                                required
                                disabled>

                                <option value="">
                                    호선을 먼저 선택하세요
                                </option>

                            </select>
                        </div>

                        <div class="form-row">
                            <label>도착역</label>

                            <select
                                name="routes[0].arrivalStationId"
                                id="arrivalStation-0"
                                required
                                disabled>

                                <option value="">
                                    호선을 먼저 선택하세요
                                </option>

                            </select>
                        </div>

                    </div>

                </div>


                <div class="button-row">

                    <button type="button"
                            class="btn-route"
                            onclick="addRoute()">
                        + 루트 추가
                    </button>

                    <button type="submit"
                            class="btn-save">
                        스케줄 저장
                    </button>

                </div>

            </div>

        </form>

    </div>

</div>

</body>

</html>