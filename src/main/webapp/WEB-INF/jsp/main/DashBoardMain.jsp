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
    let mapInfoList = ${getMapInfoJson};

    // 트리 노드 생성 함수
    function createTreeNodes() {
        return areaName.map(area => ({
            "text": area,
            "icon": "jstree-themeicon-custom",
            "data": { "nodeName": area, "areaName": area },
            "children": getChildrenForArea(area)
        }));
    }

    function getChildrenForArea(area) {
        let childNodes = [];

        mapInfoList.forEach(info => {
            if (info.depth === 1 && info.forward_group_name === area) {
                let iconType = (info.type === 0) ? "jstree-special-themeicon-custom" :
                    (info.type === 2) ? "jstree-child-themeicon-custom" :
                        "jstree-child-themeicon-custom-end";

                let children = getChildrenNodes(info.name, 2, area);
                childNodes.push({
                    "text": info.name,
                    "icon": iconType,
                    "children": children
                });
            }
        });

        return childNodes;
    }

    function getChildrenNodes(parentName, currentDepth, area) {
        let childNodes = [];

        mapInfoList.forEach(info => {
            if (info.depth === currentDepth && info.forward_group_name === parentName) {
                let iconType = (info.type === 0) ? "jstree-special-themeicon-custom" :
                    (info.type === 2) ? "jstree-child-themeicon-custom" :
                        "jstree-child-themeicon-custom-end";

                let children = getChildrenNodes(info.name, currentDepth + 1, area);
                childNodes.push({
                    "text": info.name,
                    "icon": iconType,
                    "children": children
                });
            }
        });

        return childNodes.length > 0 ? childNodes : null;
    }

    // 트리 초기화
    $(document).ready(async function() {

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
        }).on('dblclick.jstree', function (e, data) {
            console.log("Tree node double clicked:", data.node);
        });
    });

    // NETWORK & 지역이름 부분 누르면 지도 생성
    $('#tree-container').on('click', '.jstree-anchor', function() {
        var node = $(this).closest("li"); // 클릭한 요소의 가장 가까운 li 요소를 찾음
        var nodeId = node.attr("id");
        var nodeData = $('#tree-container').jstree(true).get_node(nodeId).data; // 노드의 데이터를 가져옴
        var areaName = nodeData ? nodeData.areaName : null; // areaName을 가져옴 (예외처리)
        var nodeText = $('#tree-container').jstree(true).get_text(nodeId); // 노드의 텍스트를 가져옴
        var nodeType = nodeData ? nodeData.nodeType : null; // nodeType을 가져옴 (예외처리)
        var nodeDepth = nodeData ? nodeData.depth : null; // nodeType을 가져옴 (예외처리)

        console.log("node", node);
        console.log("nodeId", nodeId);
        console.log("nodeData", nodeData);
        console.log("areaName", areaName);
        console.log("nodeText", nodeText);
        console.log("nodeType", nodeType);
        console.log("nodeDepth", nodeDepth);

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
            window.location.href = 'http://localhost/main/EMS';
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
</script>

