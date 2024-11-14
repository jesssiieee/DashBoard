<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<head>
    <style>
        .image-container {
            position: relative;
            display: inline-block;
            width: 100%;
            height: 100%;
            object-fit: cover;  /*이미지 비율을 유지하며 크기 조정*/
        }

        .image-container img {
            width: 100%;
            height: 100%;
            object-fit: cover; /* 이미지 비율을 유지하며 크기 조정 */
        }

        .overlay-text {
            position: absolute;
            color: white;  /* 텍스트 색상 */
            padding: 10px; /* 여백 */
            border-radius: 5px; /* 모서리 둥글게 */
            /* 기본 위치값 초기화 */
            left: 0;
            top: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .draggable {
            position: absolute; /* 절대 위치 설정 */
            cursor: move; /* 드래그 커서 */
            user-select: none; /* 드래그 시 텍스트 선택 방지 */
            display: flex;
            justify-content: center;
            align-items: center;
            color: #333; /* 텍스트 색상 */
            height: 0rem; /* height in pixels */
            width: 5rem; /* width in pixels */
            /* 초기 위치 설정 */
            left: 0;
            top: 0;
        }

        .draggable img {
            height: 4rem; /* 이미지 높이 조정 */
            width: auto;
        }

        .draggable .name-above {
            margin-bottom: 5px; /* 텍스트 아래 간격 추가 */
            color: white; /* 텍스트 색상 */
            text-align: center; /* 텍스트 가운데 정렬 */
        }

        .image-with-rect {
            position: relative; /* 이미지와 직사각형을 포함하는 컨테이너에 상대적 위치 설정 */
            display: inline-block;
        }

        .name-left-container {
            position: absolute;
            right: 100%; /* 이미지의 왼쪽에 위치시키기 위한 설정 */
            top: 50%;
            transform: translateY(-50%); /* 수직 중앙 정렬 */
            color: white; /* 텍스트 색상 */
            text-align: right; /* 텍스트 오른쪽 정렬 */
            white-space: nowrap; /* 텍스트가 한 줄에 표시되도록 설정 */
            margin-right: 10px; /* 이미지와 텍스트 간의 간격 */
            display: flex; /* flexbox 레이아웃 사용 */
            flex-direction: column; /* 세로 방향으로 나열 */
            align-items: flex-end; /* 오른쪽 정렬 */
        }

        .name-left {
            color: white; /* 텍스트 색상 */
            text-align: left; /* 텍스트 왼쪽 정렬 */
            white-space: nowrap; /* 텍스트가 한 줄에 표시되도록 설정 */
            margin-top: 5px; /* 텍스트 간격 추가 */
            font-size: 12px;
        }

        .rect {
            border: 1px solid green;
            position: absolute;
            left: 3px;
            top: 0;
            height: 11px;
            width: 21px;
            transition: border-color 0.3s; /* 색상 변경 시 애니메이션 효과 추가 */
            display: flex; /* 이미지를 가운데 정렬하기 위해 flexbox 사용 */
            justify-content: center;
            align-items: center;
        }

        .rect:hover {
            border-color: red; /* 마우스를 올렸을 때 테두리 색상 변경 */
        }

        .rect img {
            max-width: 100%; /* 이미지가 .rect 크기에 맞게 조정되도록 설정 */
            max-height: 100%;
            object-fit: cover; /* 이미지 비율을 유지하며 크기 조정 */
        }

        .top-right-rect {
            position: fixed;
            top: 45px;
            right: 10px;
            width: 250px;
            height: 250px;
            background-color: rgba(0, 0, 0, 0.7);
            color: black;
            display: none;
            justify-content: center;
            align-items: center;
            padding: 10px;
            border-radius: 5px;
        }

        /* 테이블 스타일 */
        #infoTable {
            width: 100%;
        }

        #infoTable th, #infoTable td {
            border: 1px solid #ddd; /* 셀 경계선 색상 */
            padding: 8px; /* 셀 패딩 */
            text-align: left; /* 텍스트 정렬 */
            border: 1px solid black;
            border-collapse: collapse; /* 테이블 경계선 겹침 방지 */
        }

        #infoTable th {
            background-color: #333; /* 헤더 배경 색상 */
            color: white; /* 헤더 텍스트 색상 */
        }

        #infoTable td {
            background-color: #444; /* 데이터 셀 배경 색상 */
            color: #fff; /* 데이터 셀 텍스트 색상 */
        }

    </style>

</head>
<body>
<div class="image-container">
    <!-- <img src="/static/image/images/map/seoul.jpg" alt="Seoul Map"> -->
    <img src="/static/image/images/map/seoul_test.jpg" alt="Seoul Map">
</div>

<div class="top-right-rect" id="topRightRect"></div>

<script>
    <%--var mapInfoAndNodeList = <c:out value="${mapInfoAndNodeJson}" escapeXml="false" />;--%>



</script>



</body>


