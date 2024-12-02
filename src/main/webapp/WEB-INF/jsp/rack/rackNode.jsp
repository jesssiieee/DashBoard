<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rack Node Information</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        h3 {
            color: #333;
            border-bottom: 2px solid #3498db;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }

        .section {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 30px;
        }

        .section p {
            font-size: 1.1em;
            color: #555;
            margin: 10px 0;
        }

        .section pre {
            background-color: #2c3e50;
            color: #ecf0f1;
            padding: 15px;
            border-radius: 5px;
            overflow-x: auto;
        }

        .section .data-label {
            font-weight: bold;
            color: #3498db;
        }

        .button {
            background-color: #3498db;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1.1em;
            text-align: center;
            display: block;
            width: 200px;
            margin: 0 auto;
            margin-top: 20px;
        }

        .button:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>

<h3>Rack Node 정보</h3>

<div class="section">
    <h4>Node 정보</h4>
    <p><span class="data-label">구역 이름:</span> ${areaName}</p>
    <p><span class="data-label">노드 텍스트:</span> ${nodeText}</p>
    <p><span class="data-label">노드 포트:</span> ${nodePort}</p>

    <!-- nodeIp가 있을 경우에만 표시 -->
    <c:if test="${not empty nodeIp}">
        <p><span class="data-label">노드 IP:</span> ${nodeIp}</p>
    </c:if>
</div>

<div class="section">
    <h4>수신된 데이터</h4>

    <h5>네트워크 데이터</h5>
    <p><span class="data-label">수신된 바이트:</span> ${networkData.bytes_recv} 바이트</p>
    <p><span class="data-label">전송된 바이트:</span> ${networkData.bytes_sent} 바이트</p>
    <p><span class="data-label">수신된 패킷:</span> ${networkData.packets_recv} 개</p>
    <p><span class="data-label">전송된 패킷:</span> ${networkData.packets_sent} 개</p>
    <p><span class="data-label">입력된 드롭:</span> ${networkData.dropin} 개</p>
    <p><span class="data-label">출력된 드롭:</span> ${networkData.dropout} 개</p>
    <p><span class="data-label">입력된 오류:</span> ${networkData.errin} 개</p>
    <p><span class="data-label">출력된 오류:</span> ${networkData.errout} 개</p>

    <h5>디스크 데이터</h5>
    <p><span class="data-label">여유 공간:</span>
        <c:out value="${diskData.free / 1073741824}"/> GB
    </p>
    <p><span class="data-label">사용된 공간:</span>
        <c:out value="${diskData.used / 1073741824}"/> GB
    </p>
    <p><span class="data-label">전체 공간:</span>
        <c:out value="${diskData.total / 1073741824}"/> GB
    </p>
    <p><span class="data-label">사용 비율:</span> ${diskData.percent}%</p>

    <p><span class="data-label">계산된 사용 비율:</span>
        <c:choose>
            <c:when test="${not empty diskData.percent_calculated}">
                ${diskData.percent_calculated}%
            </c:when>
            <c:otherwise>계산 불가</c:otherwise>
        </c:choose>
    </p>

    <h5>메모리 데이터</h5>
    <p><span class="data-label">활성 메모리:</span>
        <c:out value="${memoryData.active / 1073741824}"/> GB
    </p>
    <p><span class="data-label">사용 가능한 메모리:</span>
        <c:out value="${memoryData.available / 1073741824}"/> GB
    </p>
    <p><span class="data-label">여유 메모리:</span>
        <c:out value="${memoryData.free / 1073741824}"/> GB
    </p>
    <p><span class="data-label">비활성 메모리:</span>
        <c:out value="${memoryData.inactive / 1073741824}"/> GB
    </p>
    <p><span class="data-label">사용된 메모리:</span>
        <c:out value="${memoryData.used / 1073741824}"/> GB
    </p>
    <p><span class="data-label">고정 메모리:</span>
        <c:out value="${memoryData.wired / 1073741824}"/> GB
    </p>

    <p><span class="data-label">계산된 메모리 사용 비율:</span>
        <c:choose>
            <c:when test="${not empty memoryData.percent_calculated}">
                ${memoryData.percent_calculated}%
            </c:when>
            <c:otherwise>계산 불가</c:otherwise>
        </c:choose>
    </p>
</div>

<button class="button" onclick="window.location.href='/main/DashBoard'">대시보드로 돌아가기</button>

</body>
</html>
