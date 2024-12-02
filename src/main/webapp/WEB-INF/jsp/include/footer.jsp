<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>

    footer label {
        display: block;
        margin-top: 10px;
        font-weight: bold;
    }

    footer input {
        width: 100%;
        padding: 8px;
        margin-top: 5px;
        margin-bottom: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }

    footer button {
        width: 100%;
        padding: 10px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    footer button:hover {
        background-color: #0056b3;
    }

    .port-info {
        margin-top: 20px; /* 버튼 아래 여백 추가 */
        font-size: 14px;
        color: #333;
    }

    .port-info span {
        display: block; /* 각 포트를 줄바꿈 */
        margin-top: 5px;
    }

    .port-info .in-use {
        color: red; /* 이미 사용 중인 포트 강조 */
    }
</style>

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

    <!-- 현재 사용 중인 포트 표시 -->
    <div class="port-info">
        <h5>현재 사용 중인 포트 번호</h5>
        <c:forEach begin="5001" end="5005" varStatus="loop">
            <span class="in-use">${loop.index}번 포트: 이미 사용 중</span>
        </c:forEach>

        <!-- 추가적인 포트 정보 -->
        <c:forEach items="${insertInfoList}" var="insertInfo">
            <span>${insertInfo.port}번 포트: 사용 중</span>
        </c:forEach>
    </div>
</div>


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
