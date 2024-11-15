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

        var socket = new WebSocket('ws://localhost:9000'); // 서버의 WebSocket 주소로 변경하세요.

        socket.onopen = function(event) {
            console.log('WebSocket 연결 성공');
        };

        socket.onmessage = function(event) {
            console.log('서버로부터 받은 메시지:', event.data);
        };

        socket.onerror = function(error) {
            console.log('WebSocket 오류:', error);
        };

        socket.onclose = function(event) {
            console.log('WebSocket 연결 종료:', event);
        };


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

        // 다이얼로그 생성 함수
        function createDialog(dialogId) {
            var $dialog = $('<div></div>')
                .attr('id', dialogId)
                .html('<p>Loading...</p>')
                .dialog({
                    autoOpen: false,
                    width: 1000,
                    height: 1000,
                    modal: true,
                    open: function(event, ui) {
                        // 최소화 버튼 추가
                        if (!$('.ui-dialog-titlebar-minimize', $(this).parent()).length) {
                            $('.ui-dialog-titlebar', $(this).parent()).append('<span class="ui-dialog-titlebar-minimize">_</span>');
                        }
                        // 최소화 버튼 클릭 이벤트 바인딩
                        $('.ui-dialog-titlebar-minimize').off('click').on('click', function() {
                            // console.log("MinimizedialogId", dialogId);
                            // console.log("MinimizedclickIsMinimized", minimizedDialogs[dialogId] ? minimizedDialogs[dialogId].isMinimized : false);

                            // restoringDialogs가 존재하고 Set일 때
                            if (restoringDialogs && restoringDialogs instanceof Set && restoringDialogs.size > 0) {
                                // Set을 배열로 변환
                                const restoringDialogsArray = Array.from(restoringDialogs);

                                // 배열에서 첫 번째 요소를 꺼냄
                                const firstDialogId = restoringDialogsArray[0]; // 예를 들어 첫 번째 요소를 가져옴
                                console.log("First dialog ID in restoringDialogs:", firstDialogId);

                                // 다이얼로그를 숨기기
                                const dialogToHide = $('#' + firstDialogId); // firstDialogId를 이용해 jQuery 객체를 선택
                                if (dialogToHide.length) { // 선택한 다이얼로그가 존재하는지 확인
                                    dialogToHide.dialog('widget').hide(); // 다이얼로그 위젯을 숨깁니다.
                                    // minimizedImageCount++;
                                    const leftPosition = minimizedImageCount * (imageWidth + imageGap);
                                    $('.ui-widget-overlay').hide(); // 오버레이 숨기기
                                    minimizedContainer.append('<img src="/static/image/images/map/treeRack.gif" class="minimized-img" data-dialog-id="' + firstDialogId + '" onclick="restoreDialog(\'' + firstDialogId + '\')" style="position: absolute; left: ' + leftPosition + 'px;" />');
                                    restoringDialogs.delete(firstDialogId);
                                    minimizedImageCount = Object.keys(minimizedDialogs).filter(key => minimizedDialogs[key].isMinimized).length; // 최소화 상태 개수 업데이트

                                    reorderMinimizedImages();
                                    /*
                                                                        console.log("minized - restoringDialogs: ", restoringDialogs);
                                                                        console.log("minized - minimizedImageCount:", minimizedImageCount); */
                                } else {
                                    console.log("Dialog with ID " + firstDialogId + " not found.");
                                }
                            } else if (!restoringDialogs || (restoringDialogs && restoringDialogs.size === 0)) {
                                // minimizedDialogs[dialogId]가 존재하지 않거나, 존재하지만 isMinimized가 false인 경우에만 최소화 처리
                                if (!minimizedDialogs[dialogId] || !minimizedDialogs[dialogId].isMinimized) {
                                    $dialog.dialog('widget').hide();

                                    const leftPosition = minimizedImageCount * (imageWidth + imageGap);

                                    // 최소화된 다이얼로그를 목록에 추가
                                    if (!minimizedDialogs[dialogId]) {
                                        minimizedDialogs[dialogId] = { leftPosition: leftPosition, isMinimized: true };
                                        minimizedContainer.append('<img src="/static/image/images/map/treeRack.gif" class="minimized-img" data-dialog-id="' + dialogId + '" onclick="restoreDialog(\'' + dialogId + '\')" style="position: absolute; left: ' + leftPosition + 'px;" />');
                                    } else {
                                        minimizedDialogs[dialogId].leftPosition = leftPosition;
                                        minimizedDialogs[dialogId].isMinimized = true;
                                        // 최소화된 이미지를 다시 추가
                                        if (!$('.minimized-img[data-dialog-id="' + dialogId + '"]').length) {
                                            minimizedContainer.append('<img src="/static/image/images/map/treeRack.gif" class="minimized-img" data-dialog-id="' + dialogId + '" onclick="restoreDialog(\'' + dialogId + '\')" style="position: absolute; left: ' + leftPosition + 'px;" />');
                                        }
                                    }

                                    $('.ui-widget-overlay').hide(); // 오버레이 숨기기
                                    minimizedImageCount = Object.keys(minimizedDialogs).filter(key => minimizedDialogs[key].isMinimized).length; // 최소화 상태 개수 업데이트

                                    console.log("afterMinimized:", minimizedDialogs[dialogId].isMinimized);
                                    console.log("minimizedImageCount:", minimizedImageCount);

                                    // 최소화된 이미지를 다시 정렬
                                    reorderMinimizedImages();
                                }
                            } else {
                                console.log("restoringDialogs is either null/undefined or not a Set.");
                            }
                        });
                    },
                    beforeClose: function(event, ui) {
                        const dialogId = $(this).attr('id');
                        $('.minimized-img[data-dialog-id="' + dialogId + '"]').remove();
                        delete minimizedDialogs[dialogId]; // 최소화된 다이얼로그 목록에서 해당 다이얼로그 제거
                        minimizedImageCount = Object.keys(minimizedDialogs).filter(key => minimizedDialogs[key].isMinimized).length; // 최소화 상태 개수 업데이트

                        if (!Object.values(minimizedDialogs).some(dialog => dialog.isMinimized)) {
                            $('.ui-widget-overlay').hide(); // 모든 다이얼로그가 닫힐 때 오버레이 숨기기
                        }

                        // 모든 최소화 이미지를 다시 정렬
                        reorderMinimizedImages();
                    },
                    close: function(event, ui) {
                        if ($('.ui-dialog:visible').length === 0) {
                            $('.ui-widget-overlay').hide(); // 모든 다이얼로그가 닫힐 때 오버레이 숨기기
                        }
                    }
                });

            return $dialog;
        }

        // 다이얼로그 복원 함수
        window.restoreDialog = function(dialogId) {
            /*             console.log("Restoring dialog:", dialogId);
                        console.log("Before restore - minimizedDialogs:", minimizedDialogs);
                        console.log("restoreIsMinimized", minimizedDialogs[dialogId]?.isMinimized); // true */

            restoringDialogs.add(dialogId); // 복원 중인 다이얼로그 ID 추가

            var dialog = $('#' + dialogId);
            dialog.dialog('widget').show();
            $('.ui-widget-overlay').show(); // 오버레이 다시 표시

            // 복원 후 최소화된 이미지를 제거
            // console.log("Removing minimized image for dialogId:", dialogId); // 추가된 콘솔 로그
            $('.minimized-img[data-dialog-id="' + dialogId + '"]').remove();

            // 최소화 상태를 false로 변경하고 객체에서 제거
            if (minimizedDialogs[dialogId]) {
                delete minimizedDialogs[dialogId]; // 객체에서 항목 제거
            }

            minimizedImageCount = Object.keys(minimizedDialogs).filter(key => minimizedDialogs[key].isMinimized).length; // 현재 최소화된 이미지 개수로 업데이트
            /*             console.log("minimizedImageCount:", minimizedImageCount);
                        console.log("After restore - minimizedDialogs:", minimizedDialogs);
                        console.log("After restore - dialogId:", dialogId);
                        console.log("After restore - restoringDialogs:", restoringDialogs); */

            // 모든 최소화 이미지를 다시 정렬
            reorderMinimizedImages();
        };


        // 모든 최소화 이미지를 다시 정렬하는 함수
        function reorderMinimizedImages() {
            var minimizedImages = $('.minimized-img');
            minimizedImages.each(function(index) {
                const leftPosition = index * (imageWidth + imageGap);
                $(this).css('left', leftPosition + 'px');
            });
        }

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
            console.log("initializing", initializing);

            if (nodeData && nodeData.nodeName) {
                var nodeName = nodeData.nodeName;
                console.log("nodeName",nodeName);

                var dialogId = 'dialog-' + (dialogCounter++);
                console.log("dbdialogId: ", dialogId);
                console.log("create - minimizedDialogs[dialogId]: ", minimizedDialogs[dialogId]);
                var $dialog = createDialog(dialogId);

                selectedNodeId = node.attr("id");

                if (!minimizedDialogs[dialogId]) {
                    minimizedDialogs[dialogId] = {
                        leftPosition: minimizedImageCount * (imageWidth + imageGap),
                        isMinimized: false // 초기화 상태는 최소화되지 않음
                    };
                    minimizedImageCount++;
                    const leftPosition = minimizedDialogs[dialogId].leftPosition;

                    minimizedContainer.append('<img src="/static/image/images/map/treeRack.gif" class="minimized-img" data-dialog-id="' + dialogId + '" onclick="restoreDialog(\'' + dialogId + '\')" style="position: absolute; left: ' + leftPosition + 'px;" />');
                }

                $dialog.dialog('option', 'title', nodeData.nodeName);
                $dialog.dialog('open');
                $dialog.html('<p>Loading...</p>');

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

                // JSON stringify the rackNodes
                var rackNodesJson = JSON.stringify(rackNodes);

                $.ajax({
                    url: 'http://localhost/rack/' + encodeURIComponent(nodeName),
                    method: 'GET',
                    // data: {
                    //     nodeType: nodeData.nodeType,
                    //     nodeId: nodeData.nodeId,
                    //     shelfId: nodeData.shelfId,
                    //     ops: nodeData.ops,
                    //     rackNodes: rackNodesJson // JSON stringified rackNodes
                    // },
                    success: function(response) {
                        $dialog.html(response);
                    },
                    error: function() {
                        $dialog.html('<p>Failed to load content</p>');
                    }
                });
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
                    "data": { "nodeName": area, "areaName": area },
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
                        "nodeName": info.name,
                        "nodeType": info.type,
                        "areaName": area,
                        "depth": info.depth,
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
                        "nodeName": info.name,
                        "nodeType": info.type,
                        "areaName": area,
                        "depth": info.depth,
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

            // console.log("node", node);
            // console.log("nodeId", nodeId);
            // console.log("nodeData", nodeData);
            // console.log("areaName", areaName);
            // console.log("nodeText", nodeText);
            // console.log("nodeType", nodeType);
            // console.log("nodeDepth", nodeDepth);

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
    }); // ready
</script>

