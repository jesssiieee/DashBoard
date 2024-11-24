// var socket = io('http://localhost:3000');
//
// socket.on('connect', function() {
//     console.log('Socket.IO connected');
//     socket.emit('register', { recipient: 'DashBoardMain' });
// });
//
// function formatBytes(bytes) {
//     const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
//     if (bytes === 0) return '0 Byte';
//     const i = parseInt(Math.floor(Math.log(bytes) / Math.log(1024)), 10);
//     return (bytes / Math.pow(1024, i)).toFixed(2) + ' ' + sizes[i];
// }
//
// socket.on('message', function(data) {
//     console.log('Message received:', data);
//
//     const container = $('<div>').addClass('message-container');
//
//     const diskDiv = $('<div>').html(`
//         <h4>Disk</h4>
//         <p>Total: ${formatBytes(data.message.disk.total)}</p>
//         <p>Used: ${formatBytes(data.message.disk.used)}</p>
//         <p>Free: ${formatBytes(data.message.disk.free)}</p>
//         <p>Usage: ${data.message.disk.percent}%</p>
//     `);
//     container.append(diskDiv);
//
//     $('#messages').append(container);
// });

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
    console.log('Message received:', data);

    // 기존 메시지 초기화
    $('#messages').html('');

    // 새로운 데이터로 업데이트
    const container = $('<div>').addClass('message-container');

    const diskDiv = $('<div>').html(`
        <h4>Disk</h4>
        <p>Total: ${formatBytes(data.message.disk.total)}</p>
        <p>Used: ${formatBytes(data.message.disk.used)}</p>
        <p>Free: ${formatBytes(data.message.disk.free)}</p>
        <p>Usage: ${data.message.disk.percent}%</p>
    `);
    container.append(diskDiv);

    $('#messages').append(container);
});
