<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<head>
    <style>
        .custom-image-container {
            position: relative;
            display: inline-block;
            width: 100%;
            height: 100%;
            overflow: auto; /* 내용이 컨테이너의 크기를 넘어서면 스크롤을 추가 */
        }

        .custom-image-container img {
            width: 100%;
            height: 100%;
            object-fit: cover; /* 이미지 비율을 유지하며 크기 조정 */
        }

        .custom-overlay-container {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
        }

        .custom-draggable {
            position: absolute; /* 절대 위치 설정 */
            top: 0;
        }

        .custom-draggable img {
            height: 4rem; /* 이미지 높이 조정 */
            width: auto;
            cursor: pointer; /* 클릭 가능한 커서 */
        }

        .custom-draggable span {
            margin-top: 5px; /* 텍스트 위에 간격 추가 */
            display: block; /* span을 블록 요소로 설정하여 다음 줄로 내리도록 함 */
            text-align: center; /* 텍스트 가운데 정렬 */
        }

        #messages p {
            color: black; /* 글씨를 검정색으로 설정 */
        }

    </style>
</head>
<body>
<div class="custom-image-container">
    <div id="asideImage" style="position: relative;">
        <img src="/static/image/images/map/bg.jpg" style="width: 100%; height: 100%; object-fit: cover;" />
        <!-- 메시지 내용을 여기에 출력 -->
        <div id="messages" style="position: absolute; top: 10px; left: 10px; color: white; background-color: rgba(0, 0, 0, 0.5); padding: 10px; border-radius: 5px;">
            <!-- 동적으로 내용 추가 -->
        </div>
    </div>
</div>

<script>

</script>
</body>
</html>
