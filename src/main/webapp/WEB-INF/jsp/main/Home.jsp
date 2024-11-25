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
<%--        <div id="messages" style="position: absolute; top: 10px; left: 10px; color: white; background-color: rgba(0, 0, 0, 0.5); padding: 10px; border-radius: 5px;">--%>
<%--            <!-- 동적으로 내용 추가 -->--%>
<%--        </div>--%>
        <div class="custom-overlay-container" id="overlayContainer">
            <c:forEach items="${mapInfoList}" var="mapInfo" varStatus="loop">
                <c:choose>
                    <c:when test="${mapInfo.type == 2 and mapInfo.depth == 1}">

                        <div class="custom-draggable" data-index="${loop.index}">
                            <img
                                    src="/static/image/images/map/tam_rack.png"
                                    data-name="${mapInfo.name}"
                                    data-areaname="${mapInfo.area_name}"
                                    data-nodetype="${mapInfo.type}"
                                    data-nodedepth="${mapInfo.depth }">
                            <span>${mapInfo.name}</span>
                        </div>
                    </c:when>
                </c:choose>
            </c:forEach>
        </div>
    </div>
</div>

<script>
    function adjustImagePositions() {
        const overlayContainer = document.getElementById('overlayContainer');
        const asideImage = document.getElementById('asideImage');
        const elements = overlayContainer.querySelectorAll('.custom-draggable');

        const imageWidth = asideImage.offsetWidth; // asideImage의 넓이를 px 단위로
        const imageHeight = asideImage.offsetHeight; // asideImage의 높이를 px 단위로

        let currentLeft = 50;
        let currentTop = 70;
        const elementWidth = 180;  // 각 요소의 너비 (픽셀 단위로 설정), 간격
        const elementHeight = 150; // 각 요소의 높이 (픽셀 단위로 설정)

        elements.forEach(element => {
            if (currentLeft + elementWidth > imageWidth) { // 요소가 이미지의 너비를 넘어서면 다음 줄로 내림
                currentLeft = 50;
                currentTop += elementHeight;
            }

            element.style.left = currentLeft + 'px';
            element.style.top = currentTop + 'px';

            currentLeft += elementWidth;

            // 클릭 이벤트 추가
            const img = element.querySelector('img');
            img.addEventListener('click', function () {
                const nodeText = this.getAttribute('data-name');
                const areaName = this.getAttribute('data-areaname');
                const nodeType = this.getAttribute('data-nodetype');
                const nodeDepth = this.getAttribute('data-nodedepth');

                sendDataToServer(nodeText, areaName, nodeType, nodeDepth, function () {
                    console.log("ajax 실행");
                    // 요청 성공 후 페이지 이동
                    window.location.href = 'http://localhost/rack/testrack?areaName=' + encodeURIComponent(areaName) + '&nodeText=' + encodeURIComponent(nodeText) + '&nodeType=' + encodeURIComponent(nodeType) + '&nodeDepth=' +encodeURIComponent(nodeDepth);
                    // window.location.href = 'http://localhost/rack/testrack?areaName=' + encodeURIComponent(areaName) + '&nodeText=' + encodeURIComponent(nodeText) + '&nodeType=' + encodeURIComponent(nodeType) + '&nodeDepth=' +encodeURIComponent(nodeDepth);
                });
            });
        });
    }

    window.addEventListener('load', adjustImagePositions);
    window.addEventListener('resize', adjustImagePositions);
</script>
</body>
</html>
