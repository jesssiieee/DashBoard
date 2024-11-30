<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<footer>
    <div>
        <!-- IP 주소 입력 -->
        <label for="ipInput">IP 주소:</label>
        <input type="text" id="ipInput" placeholder="IP 주소 입력">

        <!-- Name 입력 -->
        <label for="nameInput">Name:</label>
        <input type="text" id="nameInput" placeholder="Name 입력">

        <!-- Port 번호 입력 -->
        <label for="portInput">Port:</label>
        <input type="number" id="portInput" placeholder="Port 입력">

        <!-- 전송 버튼 -->
        <button onclick="sendIp()">전송</button>
    </div>
</footer>

<script>
    function sendIp() {

        console.log('sendIp 함수 실행됨');

        const ip = document.getElementById('ipInput').value;
        const name = document.getElementById('nameInput').value;
        const port = document.getElementById('portInput').value;

        // 고정된 값 설정
        const area = "수도권"; // Area Name 고정
        const type = "1"; // Type 고정
        const depth = "1"; // Depth 고정
        const forwardGroup = "수도권"; // Forward Group Name 고정
        const image = "bg"; // Image Name 고정

        console.log({
            ip,
            area,
            type,
            name,
            depth,
            forwardGroup,
            port,
            image
        });

        const data = {
            ip,
            area,
            type,
            name,
            depth,
            forwardGroup,
            port,
            image
        };

    }
</script>
