// 전역 변수 선언
var latestDiskData;

var socket = io('http://localhost:3000');

socket.on('connect', function() {
    console.log('Socket.IO connected');
    socket.emit('register', { recipient: 'DashBoardMain' });
});

socket.on('sendIp', (data) => {
    // console.log('Received IP:', data.ip);
});

// 메시지를 처리하는 이벤트
socket.on('message', function(data) {
    latestDiskData = data.message;

    // 데이터 유효성 검사
    if (!latestDiskData || !latestDiskData.memory || !latestDiskData.disk) {
        return;
    }

    // 메시지 업데이트 코드 추가
    updateMessageUI(latestDiskData);
});

// UI 업데이트 함수
function updateMessageUI(latestDiskData) {
    // CPU, Disk, Memory, Network 정보를 UI에 업데이트하는 코드
    const container = $('<div>').addClass('message-container');

    // CPU, Disk, Memory, Network 정보를 추가하는 부분 (기존 코드 유지)
    // 예시:
    const cpuDiv = $('<div>').html(`<h4>CPU</h4><p>Usage: ${latestDiskData.cpu_percent}%</p>`);
    container.append(cpuDiv);
    $('#messages').html(container);
}

// ajax 요청을 처리하는 함수
function sendDataToServer(nodeText, areaName, nodeType, nodeDepth, nodePort, callback, nodeIp) {
    if (!latestDiskData) {
        console.error('No disk data available.');
        return;
    }

    // 전송 데이터 객체 생성
    const data = {
        nodeText: nodeText,
        areaName: areaName,
        nodeType: nodeType,
        nodeDepth: nodeDepth,
        nodePort: nodePort,
        receivedData: latestDiskData // JSON 객체 전달
    };

    // nodeIp가 존재하면 데이터에 추가
    if (nodeIp) {
        data.nodeIp = nodeIp;
    }

    $.ajax({
        url: 'http://localhost/rack/testrack',
        method: 'POST',
        contentType: 'application/json', // JSON 데이터 전송
        data: JSON.stringify(data),
        success: function (response) {
            console.log('Request successful:', response);
            if (callback) callback(); // 성공 시 콜백 호출
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.error('Failed to send request:', textStatus, errorThrown);
            console.log('Response:', jqXHR.responseText); // 서버의 응답 메시지 확인
        }
    });
}


// IP 주소 전송
function sendIp() {
    const ip = document.getElementById("ipInput").value;
    const name = document.getElementById("nameInput").value;
    const port = document.getElementById("portInput").value;

    if (!ip) {
        alert("IP 주소를 입력해주세요!");
        return;
    }

    // 고정된 값 설정
    const area = "수도권";
    const type = "1";
    const depth = "1";
    const forward_group = "수도권";
    const image = "bg";

    const data = {
        ip,
        area,
        type,
        name,
        depth,
        forward_group,
        port,
        image
    };

    if (socket.connected) {
        socket.emit('sendIp', data); // 고정값과 함께 데이터 전송
        // console.log(data);
        alert("IP 주소와 설정된 데이터가 서버로 전송되었습니다!");
    } else {
        alert("Socket.IO 서버에 연결되지 않았습니다.");
    }

    $.ajax({
        url: '/insert-info/save',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(data),
        success: function(response) {
            alert('전송 성공');
            location.reload();  // 요청 성공 후 페이지 새로고침
        },
        error: function(xhr, status, error) {
            console.error('에러 발생:', error);
            alert('서버 요청 실패');
        }
    });
}


// 서버로부터 응답 처리
socket.on('nodePortReceived', function(data) {
    // console.log('서버로부터 받은 응답:', data);

    // 응답 처리 (예: 페이지 갱신, 알림 등)
    if (data.status === 'success') {
        // alert('Node port가 성공적으로 전송되었습니다!');
    }
});

