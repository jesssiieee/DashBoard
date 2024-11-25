// 전역 변수 선언
var latestDiskData;
var $dialog = $('#dialog');  // $dialog를 정의

var socket = io('http://localhost:3000');

socket.on('connect', function() {
    console.log('Socket.IO connected');
    socket.emit('register', { recipient: 'DashBoardMain' });
});

function formatBytes(bytes) {
    const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
    if (bytes === 0) return '0 Byte';
    const i = parseInt(Math.floor(Math.log(bytes) / Math.log(1024)), 10);
    return (bytes / Math.pow(1024, i)).toFixed(2) + ' ' + sizes[i];
}

socket.on('message', function(data) {
    // console.log('Message received:', data);  // 데이터 확인
    latestDiskData = data.message;  // 'message' 속성을 받아옴
    // console.log('JS latestDiskData:', latestDiskData);  // 수신된 데이터 출력

    // 데이터 유효성 검사
    if (!latestDiskData || !latestDiskData.memory || !latestDiskData.disk) {
        // console.error('Memory or Disk data is not available!');
        return;  // 데이터가 없으면 처리하지 않음
    }

    // 기존 메시지 초기화
    $('#messages').html('');

    // 새로운 데이터로 업데이트
    const container = $('<div>').addClass('message-container');

    // CPU 정보 추가
    const cpuDiv = $('<div>').html(`
        <h4>CPU</h4>
        <p>Usage: ${latestDiskData.cpu_percent}%</p>
    `);
    container.append(cpuDiv);

    // Disk 정보 추가
    const diskDiv = $('<div>').html(`
        <h4>Disk</h4>
        <p>Total: ${formatBytes(latestDiskData.disk.total)}</p>
        <p>Used: ${formatBytes(latestDiskData.disk.used)}</p>
        <p>Free: ${formatBytes(latestDiskData.disk.free)}</p>
        <p>Usage: ${latestDiskData.disk.percent}%</p>
    `);
    container.append(diskDiv);

    // Memory 정보 추가
    const memoryDiv = $('<div>').html(`
        <h4>Memory</h4>
        <p>Total: ${formatBytes(latestDiskData.memory.total)}</p>
        <p>Used: ${formatBytes(latestDiskData.memory.used)}</p>
        <p>Free: ${formatBytes(latestDiskData.memory.free)}</p>
        <p>Usage: ${latestDiskData.memory.percent}%</p>
    `);
    container.append(memoryDiv);

    // Network 정보 추가
    const netDiv = $('<div>').html(`
        <h4>Network</h4>
        <p>Bytes Received: ${formatBytes(latestDiskData.net.bytes_recv)}</p>
        <p>Bytes Sent: ${formatBytes(latestDiskData.net.bytes_sent)}</p>
        <p>Packets Received: ${latestDiskData.net.packets_recv}</p>
        <p>Packets Sent: ${latestDiskData.net.packets_sent}</p>
    `);
    container.append(netDiv);

    // 메시지 업데이트
    $('#messages').append(container);

    // 콘솔에 최신 데이터 출력
    console.log('latestDiskData:', latestDiskData);
});

// ajax 요청을 처리하는 함수
function sendDataToServer(nodeText, areaName, nodeType, nodeDepth, callback) {
    if (!latestDiskData) {
        console.error('No disk data available.');
        return;
    }

    // latestDiskData가 무엇인지 콘솔에 출력해보세요
    // console.log('latestDiskData:', latestDiskData);

    $.ajax({
        url: 'http://localhost/rack/testrack',
        method: 'POST',
        contentType: 'application/json', // JSON 데이터 전송
        data: JSON.stringify({
            nodeText: nodeText,
            areaName: areaName,
            nodeType: nodeType,
            nodeDepth: nodeDepth,
            receivedData: latestDiskData // JSON 객체 전달
        }),
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



