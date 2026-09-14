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

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/scheduler.css">

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>


</head>

<body>

    <!-- ============ Navi begin ============ -->
    <ul class="nav">
        <li class="nav-item">
            <!-- 수정됨: login.jsp -> ${pageContext.request.contextPath}/login.do -->
            <a class="nav-link active" href="${pageContext.request.contextPath}/login.do">Logout</a>
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
                <p class="empty-msg text-center small my-3" id="emptyMsg">아직 추가한 구간이 없습니다</p>

                <div class="input-group-custom mb-3">
                    <label class="form-label fw-medium">경로 이름</label>
                    <input type="text" id="routeNameInput" class="form-control" placeholder="예: 출근길">
                </div>

                <div class="d-flex gap-2">
                    <!-- 수정됨: scheduler.jsp -> ${pageContext.request.contextPath}/main.do (메인화면 주소에 맞게 변경) -->
                    <button type="button" class="btn btn-secondary flex-fill" onclick="location.href='${pageContext.request.contextPath}/main.do'">취소</button>
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

    // 🚨 삭제되었던 '환승 구간 추가' 버튼 로직 복구!
    $('#addSegBtn').on('click', function() {
        const from = $('#fromInput').val().trim();
        const to = $('#toInput').val().trim();
        if (!from || !to) {
            alert('출발역과 도착역을 모두 입력해주세요.');
            return;
        }
        stationList.push({ from: from, to: to });
        renderStations();
        $('#fromInput').val('');
        $('#toInput').val('');
    });

    // 서버 전송 로직 (완료 버튼)
    $('#saveBtn').on('click', function() {
        const routeName = $('#routeNameInput').val().trim();
        
        // 1. 필수 입력값 검사
        if (!routeName) {
            alert('경로 이름을 입력해주세요!');
            return;
        }
        if (stationList.length === 0) {
            alert('환승 구간을 하나 이상 추가해주세요.');
            return;
        }

        // 2. 현재 백엔드 ScheduleDTO가 단일 구간만 받으므로, 리스트의 첫 번째 구간 정보 추출
        const firstSegment = stationList[0];

        // 3. 서버로 보낼 데이터 (ScheduleDTO 구조와 일치시킴)
        const payload = {
            userId: 1, // 임시 유저 ID
            'departureStation.stationName': firstSegment.from, // StationDTO 변수명에 맞게 수정 필요
            'arrivalStation.stationName': firstSegment.to,     // StationDTO 변수명에 맞게 수정 필요
            travelDate: new Date().toISOString().split('T')[0] 
        };

        // 4. AJAX 컨트롤러로 POST 요청
        $.ajax({
            url: '${pageContext.request.contextPath}/schedule',
            type: 'POST',
            data: payload,
            success: function(response) {
                if(response === 'success') {
                    alert('경로가 성공적으로 저장되었습니다!');
                    window.location.href = 'scheduler.jsp';
                } else {
                    alert('저장에 실패했습니다.');
                }
            },
            error: function(err) {
                console.error("에러 발생: ", err);
                alert('서버 통신 중 오류가 발생했습니다.');
            }
        });
    });
</script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>