<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="contents flex">
    <div class="content1 left-div">
        <ul class="sectiontabs ml-3">
            <li class="sectiontab-link current" data-tab="sectiontab-search">탐색창</li>
            <li class="sectiontab-link" data-tab="sectiontab-information">정보창</li>
        </ul>

        <div id="sectiontab-search" class="sectiontab-content current">
            <jsp:include page="tree.jsp" />
        </div>
        <div id="sectiontab-information" class="sectiontab-content">
            <%--            <jsp:include page="content2.jsp" />--%>
        </div>
    </div>


    <aside class="right-div" style="overflow: auto; width:100%; height: 100%; object-fit: cover;">
        <div id="asideImageContainer">
            <div id="imgContent" class="mapcontent mapcurrent">
                <!-- <img id="asideImage" src="/static/image/images/map/bg.jpg" /> -->
                <jsp:include page="Home.jsp" />
            </div>
            <div id="jspContent" class="mapcontent">
                <jsp:include page="map.jsp" />
            </div>
        </div>
    </aside>
</div>

<script>
    // 지역 정보 하드코딩
    const areaName = ["강원", "경남", "경북", "수도권", "전남", "전북", "제주", "충남", "충북"];

    $(document).ready(function() {
        let getMapInfo = ${getMapInfoJson}

        var selectedNodeId = null;
        var initializing = true;
        let isMinimized = false; // dialog가 최소화 되지 않음

        var dialogCounter = 0; // 다이얼로그 고유 ID 생성 카운터
        var minimizedImageCount = 0; // 최소화된 이미지의 개수를 추적합니다.
        var imageWidth = 20; // 최소화된 이미지의 너비를 설정합니다.
        var imageGap = 1; // 최소화된 이미지 간의 간격을 설정합니다.
        var minimizedDialogs = {}; // 객체로 변경
        var restoringDialogs = new Set(); // 복원 중인 다이얼로그 ID를 저장할 Set

        var latestDiskData = null;  // 처음에는 null로 설정

        // 트리 초기화
        $('#tree-container').jstree({
            'core': {
                'check_callback': true,
                'data': [
                    {
                        "text": "NETWORK",
                        "icon": "custom",
                        "children": createTreeNodes() // 데이터 기반으로 트리 생성
                    }
                ]
            },
            'plugins': ["contextmenu", "dnd", "state", "types", "wholerow"]
        }).on('dblclick.jstree', function(e, data) {
            var node = $(e.target).closest("li");
            var nodeData = $('#tree-container').jstree(true).get_node(node.attr("id")).data;
            console.log("nodeData",nodeData);

            // 부모 노드와 조부모 노드를 가져옵니다.
            var parentNodeId = $('#tree-container').jstree(true).get_node(node.attr("id")).parent;
            var grandParentNodeId = $('#tree-container').jstree(true).get_node(parentNodeId).parent;
            var parentNodeData = $('#tree-container').jstree(true).get_node(parentNodeId).data;
            var grandParentNodeData = $('#tree-container').jstree(true).get_node(grandParentNodeId).data;

            var areaName = grandParentNodeData;

            if (initializing) return;

            if (nodeData && nodeData.nodeName) {
                var nodeName = nodeData.nodeName;
                var nodeId = nodeData.id;
                // console.log("nodeName:",nodeName);

                // rackNodes가 null인지 확인
                var rackNodes = nodeData.rackNodes;

                if (!rackNodes || rackNodes.length === 0) {
                    // rackNodes가 null이나 빈 배열일 경우 부모 노드에서 데이터 가져오기
                    if (parentNodeData && parentNodeData.rackNodes) {
                        rackNodes = parentNodeData.rackNodes;
                    } else if (grandParentNodeData && grandParentNodeData.rackNodes) {
                        // 부모 노드도 없을 경우 조부모 노드에서 데이터 가져오기
                        rackNodes = grandParentNodeData.rackNodes;
                    } else {
                        rackNodes = []; // 모든 경우가 실패할 경우 빈 배열을 사용
                    }
                }

                // 여기에 nodeName을 활용한 로직을 작성합니다.
                console.log("Double-clicked nodeName:", nodeName);
                console.log("Double-clicked nodeId:", nodeId);

            }
        });

        setTimeout(function() {
            initializing = false;
        }, 1000);


        // 트리 노드 생성 함수
        function createTreeNodes() {
            var childrenNodes = [];
            for (var i = 0; i < areaName.length; i++) {
                var area = areaName[i];
                childrenNodes.push({
                    "text": area,
                    "icon": "jstree-themeicon-custom",
                    "data": { "nodeName": area, "areaName": area},
                    "children": getChildrenForArea(area)
                });
            }
            return childrenNodes;
        }

        function getChildrenForArea(area) {
            var childNodes = [];

            // 모든 getMapInfo 항목을 순회합니다.
            for (var j = 0; j < getMapInfo.length; j++) {
                var info = getMapInfo[j];

                // info.depth와 info.forward_group_name이 일치하는 경우
                if (info.depth === 1 && info.forward_group_name === area) {
                    var iconType = (info.type === 0) ? "jstree-special-themeicon-custom" :
                        (info.type === 2) ? "jstree-child-themeicon-custom" :
                            "jstree-child-themeicon-custom-end";

                    // 기본 nodeData 객체를 만듭니다.
                    var nodeData = {
                        "id": info.id,
                        "nodeName": info.name,
                        "nodeType": info.type,
                        "areaName": area,
                        "depth": info.depth,
                        "port": info.port,
                        "rackNodes": []  // 일치하는 노드들을 저장할 배열
                    };
                    // childNodes 배열에 추가합니다.
                    childNodes.push({
                        "text": info.name,
                        "icon": iconType,
                        "data": nodeData,
                        "children": getChildrenNodes(info.name, 2, area)
                    });
                }
            }

            return childNodes;
        }

        function getChildrenNodes(parentName, currentDepth, area) {
            var childNodes = [];

            for (var k = 0; k < getMapInfo.length; k++) {
                var info = getMapInfo[k];

                // 해당 depth와 parentName에 맞는 노드를 찾습니다.
                if (info.depth === currentDepth && info.forward_group_name === parentName) {
                    var iconType = (info.type === 0) ? "jstree-special-themeicon-custom" :
                        (info.type === 2) ? "jstree-child-themeicon-custom" :
                            "jstree-child-themeicon-custom-end";

                    // 기본 nodeData 객체를 만듭니다.
                    var nodeData = {
                        "id": info.id,
                        "nodeName": info.name,
                        "nodeType": info.type,
                        "areaName": area,
                        "depth": info.depth,
                        "port": info.port,
                        "rackNodes": []  // 일치하는 노드들을 저장할 배열
                    };

                    // 자식 노드를 추가합니다.
                    childNodes.push({
                        "text": info.name,
                        "icon": iconType,
                        "data": nodeData,
                        "children": getChildrenNodes(info.name, currentDepth + 1, area)
                    });
                }
            }

            return childNodes.length > 0 ? childNodes : null;
        }

        // NETWORK & 지역이름 부분 누르면 지도 생성
        $('#tree-container').on('click', '.jstree-anchor', function() {
            let node = $(this).closest("li"); // 클릭한 요소의 가장 가까운 li 요소를 찾음
            let nodeId = node.attr("id");
            let nodeData = $('#tree-container').jstree(true).get_node(nodeId).data; // 노드의 데이터를 가져옴
            let areaName = nodeData ? nodeData.areaName : null; // areaName을 가져옴 (예외처리)
            let nodeText = $('#tree-container').jstree(true).get_text(nodeId); // 노드의 텍스트를 가져옴
            let nodeType = nodeData ? nodeData.nodeType : null; // nodeType을 가져옴 (예외처리)
            let nodeDepth = nodeData ? nodeData.depth : null; // nodeType을 가져옴 (예외처리)

            $.ajax({
                url: 'http://localhost/main/DashBoard',
                method: 'GET',
                data: {
                    nodeText: nodeText,
                },
                success: function(response) {
                    // 서버의 응답을 특정 div에 업데이트
                    dialogContent.html(response);
                },
                error: function(xhr, status, error) {
                    // AJAX 요청 실패 시 처리
                    console.error('AJAX 요청 실패:', status, error);
                }
            });


            // Perform actions based on nodeText or areaName
            if (nodeText === "NETWORK") {
                $('#jspContent').removeClass('mapcurrent');
                $('#imgContent').addClass('mapcurrent');
                $('#seoulJspContent, #JejuJspContent, #NorthChungcheongJspContent, #SouthChungcheongJspContent, #NorthJeollaJspContent, #GangwonJspContent, #NorthGyeongsangJspContent, #SouthGyeongsangJspContent, #SouthJeollaJspContent, #list')
                    .removeClass('mapchangecurrent');
                $('#maporigincontent').addClass('mapchangecurrent');
            } else if (nodeText === "수도권" && areaName === "수도권") {
                $('#imgContent').removeClass('mapcurrent');
                $('#jspContent').addClass('mapcurrent');
                $('#maporigincontent').removeClass('mapchangecurrent');
                $('#seoulJspContent, #JejuJspContent, #NorthChungcheongJspContent, #SouthChungcheongJspContent, #NorthJeollaJspContent, #GangwonJspContent, #NorthGyeongsangJspContent, #SouthGyeongsangJspContent, #SouthJeollaJspContent, #list')
                    .removeClass('mapchangecurrent');
                $('#seoulJspContent').addClass('mapchangecurrent');
            } else {
                $('#jspContent').removeClass('mapcurrent');
                $('#imgContent').addClass('mapcurrent');
            }
        });
    }); // ready
</script>

