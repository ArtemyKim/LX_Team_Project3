<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>경로 입력창</title>

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

<link rel="stylesheet" href="css/schedulerForm.css">

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>


</head>

<body>

    <!-- ============ Navi begin ============ href 바꿔야함 -->
    <ul class="nav">
        <li class="nav-item">
            <a class="nav-link active" href="login.jsp">Login</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">Community</a>
        </li>
    </ul>
    <!-- ============ Navi end ============ -->

    <div class="subway-scene">
        <div class="card-wrap">
            <div class="card rounded-4 shadow-sm p-4">

                <h2 id="formTitle" class="text-center fw-bold mb-4">ADD SEGMENT</h2>

                <div class="input-group-custom mb-3">
                    <label class="form-label fw-medium">출발역</label>
                    <input type="text" id="fromInput" class="form-control" placeholder="예: 노원">
                </div>
                <div class="input-group-custom mb-3">
                    <label class="form-label fw-medium">도착역</label>
                    <input type="text" id="toInput" class="form-control" placeholder="예: 건대입구">
                </div>
                <button type="button" class="btn btn-secondary w-100" id="addSegBtn">환승 구간 추가</button>

                <div class="d-flex flex-column gap-2 my-3" id="stationList"></div>
                <p class="empty-msg text-center small my-3" id="emptyMsg">아직 추가한 구간이 없어.</p>

                <div class="input-group-custom mb-3">
                    <label class="form-label fw-medium">경로 이름</label>
                    <input type="text" id="routeNameInput" class="form-control" placeholder="예: 출근길">
                </div>

                <div class="d-flex gap-2">
                    <button type="button" class="btn btn-secondary flex-fill" onclick="location.href='scheduler.jsp'">취소</button>
                    <button type="button" class="btn btn-primary flex-fill" id="saveBtn">완료</button>
                </div>

            </div>
        </div>
    </div>

    <script>
        const params = new URLSearchParams(window.location.search);
        const routeGroupId = params.get('routeGroupId'); // 있으면 수정 모드

        let stationList = [];

        function loadRoutes() {
            return JSON.parse(localStorage.getItem('routes') || '[]');
        }
        function saveRoutes(routes) {
            localStorage.setItem('routes', JSON.stringify(routes));
        }

        function renderStations() {
            const $list = $('#stationList');
            $list.empty();

            if (stationList.length === 0) {
                $('#emptyMsg').show();
                return;
            }
            $('#emptyMsg').hide();

            stationList.forEach(function(sta) {
                $list.append(
                    '<div class="station-block rounded-3 p-2 d-flex align-items-center gap-2">' +
                    '<span class="dot"></span>' +
                    sta.from + ' → ' + sta.to + '</div>'
                );
            });
        }

        // 수정 모드면 기존 데이터 채워넣기
        if (routeGroupId) {
            $('#formTitle').text('EDIT ROUTE');
            const routes = loadRoutes();
            const target = routes.find(function(r) { return r.routeGroupId == routeGroupId; });
            if (target) {
                stationList = JSON.parse(JSON.stringify(target.stations));
                $('#routeNameInput').val(target.routeName);
            }
        }
        renderStations();

        $('#addSegBtn').on('click', function() {
            const from = $('#fromInput').val().trim();
            const to = $('#toInput').val().trim();
            if (!from || !to) {
                alert('출발역과 도착역을 모두 입력해줘');
                return;
            }
            stationList.push({ from: from, to: to });
            renderStations();
            $('#fromInput').val('');
            $('#toInput').val('');
        });

        $('#saveBtn').on('click', function() {
            const routeName = $('#routeNameInput').val().trim();
            if (!routeName) {
                alert('경로 이름을 입력해줘');
                return;
            }
            if (stationList.length === 0) {
                alert('구간을 하나 이상 추가해줘');
                return;
            }

            const routes = loadRoutes();

            if (routeGroupId) {
                // 수정: 기존 항목 덮어쓰기
                const target = routes.find(function(r) { return r.routeGroupId == routeGroupId; });
                target.routeName = routeName;
                target.stations = stationList;
            } else {
                // 신규 저장
                routes.push({
                    routeGroupId: Date.now(),
                    routeName: routeName,
                    stations: stationList,
                    statusCode: 'green',
                    noticeContent: ''
                });
            }

            saveRoutes(routes);
            window.location.href = 'scheduler.jsp';

            /*
              ★ 실제 연동 시 이렇게 교체:

              const payload = { routeName: routeName, stations: JSON.stringify(stationList) };
              if (routeGroupId) {
                  payload.routeGroupId = routeGroupId;
                  $.post('updateRoute.do', payload, function() {
                      window.location.href = 'scheduler.jsp';
                  });
              } else {
                  $.post('saveRoute.do', payload, function() {
                      window.location.href = 'scheduler.jsp';
                  });
              }
            */
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>