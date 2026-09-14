<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>경로 스케쥴러창</title>
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

<link rel="stylesheet" href="css/scheduler.css">

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

            <!-- 버튼을 오른쪽으로 정렬: Bootstrap 유틸리티(d-flex, justify-content-end, mb-3)만으로 처리 -->
            <div class="d-flex justify-content-end mb-3">
                <button type="button" class="btn btn-primary" id="newRouteBtn">+ 새 경로 추가하기</button>
            </div>

            <!--
              ★ 서버가 처음 페이지를 그릴 때, 컨트롤러가 조회해둔 routeList를
              JSTL로 여기다 뿌려주는 게 정석이지만, 지금은 DB 연동 전이라
              자바스크립트 쪽 renderRoutes()가 그 역할을 대신하고 있음.
              (연동 방법은 채팅 설명 참고)
            -->
            <div id="routeListArea"></div>

            <p class="empty-msg text-center rounded-4 p-5" id="emptyMsg" style="display:none;">
                "새 경로 추가하기"로 안전한 경로 일정을 관리하세요
            </p>

        </div>
    </div>

    <script>
        // ===== 상태 정의: green(정상) / yellow(상황진행중) 두 단계만 사용 =====
        const STATUS = {
            green:  { text: '정상',     className: 'status-green'  },
            yellow: { text: '상황진행중', className: 'status-yellow' }
        };

        // ===============================================
        // ★ 지금은 DB가 없어서 localStorage에 경로 목록을 저장해두는 걸로 대체함.
        //   실제 서비스에서는 이 자리가 서버 DB 조회로 바뀜.
        //   (자세한 설명은 채팅 답변 참고)
        // ===============================================
        function loadRoutes() {
            return JSON.parse(localStorage.getItem('routes') || '[]');
        }

        function saveRoutes(routes) {
            localStorage.setItem('routes', JSON.stringify(routes));
        }

        function renderRoutes() {
            const routes = loadRoutes();
            const $area = $('#routeListArea');
            $area.empty();

            if (routes.length === 0) {
                $('#emptyMsg').show();
                return;
            }
            $('#emptyMsg').hide();

            routes.forEach(function(route) {
                const status = STATUS[route.statusCode] || STATUS.green;

                // route.stations: [{ from, to }, ...] 형태의 역 구간 배열
                const stationHtml = route.stations.map(function(sta) {
                    return '<div class="station-block d-flex align-items-center gap-2 mb-2">' +
                           '<span class="dot"></span>' +
                           sta.from + ' → ' + sta.to + '</div>';
                }).join('');

                const noticeHtml = (route.statusCode === 'yellow' && route.noticeContent)
                    ? '<div class="notice-text rounded-3 p-2 mt-2" style="display:block;">' + route.noticeContent + '</div>'
                    : '<div class="notice-text rounded-3 p-2 mt-2"></div>';

                const $card = $(
                    '<div class="route-card rounded-4 shadow-sm p-4 mb-3" data-id="' + route.routeGroupId + '">' +
                        '<div class="d-flex justify-content-between align-items-center mb-2">' +
                            '<span class="route-name fw-bold">' + route.routeName + '</span>' +
                            '<span class="badge rounded-pill ' + status.className + '">' + status.text + '</span>' +
                        '</div>' +
                        stationHtml +
                        noticeHtml +
                        '<div class="d-flex gap-2 mt-3">' +
                            '<button type="button" class="btn btn-edit flex-fill">수정</button>' +
                            '<button type="button" class="btn btn-delete flex-fill">삭제</button>' +
                        '</div>' +
                    '</div>'
                );

                $card.find('.btn-edit').on('click', function() {
                    window.location.href = 'schedulerForm.jsp?routeGroupId=' + route.routeGroupId;
                });

                $card.find('.btn-delete').on('click', function() {
                    if (confirm('"' + route.routeName + '" 경로를 삭제할까?')) {
                        const updated = loadRoutes().filter(function(r) {
                            return r.routeGroupId !== route.routeGroupId;
                        });
                        saveRoutes(updated);
                        renderRoutes();
                    }
                });

                $area.append($card);
            });
        }

        // ===============================================
        // ★ 실시간 상태 갱신 (1분마다)
        //   지금은 DB/API가 없어서 더미로 랜덤 상태를 넣어주는 함수.
        //   나중에 이 함수 내용만 실제 $.getJSON('routeStatus.do', ...)로 바꾸면 됨.
        //   상태는 green(정상)/yellow(상황진행중) 두 단계만 사용.
        // ===============================================
        const NOTICE_SAMPLES = [
            '4호선 혜화역 인근 집회로 일부 출입구 통제 중',
            '2호선 건대입구역 무정차 통과 중',
            '시위로 인한 서행 운행, 5~10분 지연 예상'
        ];

        function refreshStatus() {
            const routes = loadRoutes();

            routes.forEach(function(route) {
                // 30% 확률로 상태 변경 (더미 시뮬레이션)
                if (Math.random() < 0.3) {
                    const codes = ['green', 'yellow'];
                    route.statusCode = codes[Math.floor(Math.random() * codes.length)];
                    route.noticeContent = route.statusCode === 'yellow'
                        ? NOTICE_SAMPLES[Math.floor(Math.random() * NOTICE_SAMPLES.length)]
                        : '';
                }
            });

            saveRoutes(routes);
            renderRoutes();

            /*
              ★ 실제 연동 시 이렇게 교체:

              $.getJSON('routeStatus.do', function(statusList) {
                  const routes = loadRoutes();
                  statusList.forEach(function(item) {
                      const target = routes.find(r => r.routeGroupId === item.routeGroupId);
                      if (target) {
                          target.statusCode = item.statusCode;
                          target.noticeContent = item.noticeContent;
                      }
                  });
                  saveRoutes(routes);
                  renderRoutes();
              });
            */
        }

        $('#newRouteBtn').on('click', function() {
            window.location.href = 'schedulerForm.jsp';
        });

        renderRoutes();
        setInterval(refreshStatus, 60000); // 1분마다 실행
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>