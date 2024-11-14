<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>


<header>
    <div class="d-flex">

        <%-- section1 --%>
        <div class="ml-2" style="border: 0.5px solid;">
            <button class="mr-2">
                <img src="/static/image/images/common/tgw.gif" />
            </button>
            <button class="mr-2">
                <img src="/static/image/images/common/menu.gif" />
            </button>
            <button>
                <img src="/static/image/images/common/unlock.gif" />
            </button>
        </div>

        <%-- section2 --%>
        <div class="ml-3" style="border: 0.5px solid;">
            <img src="/static/image/images/common/top_critical.gif" class="ml-2"/>
            <input type="text" class="input-box" value="0" style="width: 50px; border: none;">

            <img src="/static/image/images/common/top_major.gif" />
            <input type="text" class="input-box" value="0" style="width: 50px; border: none;">

            <img src="/static/image/images/common/top_minor.gif" />
            <input type="text" class="input-box" value="0" style="width: 50px; border: none;">

            <button>
                <img src="/static/image/images/common/bn_pause.gif" />
            </button>
            <button>
                <img src="/static/image/images/common/sound_on.gif" />
            </button>
            <button>
                <img src="/static/image/images/common/plugOut.gif" />
            </button>
            <button>
                <img src="/static/image/images/common/version.gif" />
            </button>
        </div>

        <%-- section3 --%>
        <div class="ml-2" style="border: 0.5px solid;">
            <button>
                <img src="/static/image/images/common/setUp2.gif" />
            </button>
            <button>
                <img src="/static/image/images/common/userSMS.gif" />
            </button>
            <button>
                <img src="/static/image/images/common/history2.gif" />
            </button>
            <button>
                <img src="/static/image/images/common/messenger_01.gif" />
            </button>
        </div>

        <%-- section4 --%>
        <div class="ml-2" style="border: 0.5px solid;">
            <button>
                <img src="/static/image/images/common/wholeSee.gif" />
            </button>
        </div>

        <%-- section5 --%>
        <div class="ml-2 d-flex" style="border: 0.5px solid;">
            <button>
                <img src="/static/image/images/common/arrow_1.gif" />
            </button>

            <div id="minimizedContainer" class="mt-1 minimized-windows"></div>

            <button>
                <img src="/static/image/images/common/arrow_2.gif" />
            </button>
            <button>
                <img src="/static/image/images/common/bluearrow.gif" />
            </button>
        </div>
    </div>
</header>

<style>
    button {
        border: none;
        background-color: white;
    }

    .minimized-windows {
        display: flex;
        align-items: center;
        background-color: black;
        height: 22px;
        width: 100px;
    }
    .minimized-windows img {
        width: 20px;
        height: 20px;
        cursor: pointer;
    }

    .ui-dialog-titlebar-minimize {
        position: absolute;
        right: 1.5em;
        top: 50%;
        width: 20px;
        height: 20px;
        margin-top: -10px;
        cursor: pointer;
    }
</style>

<script>

    let dialogContent = $('#dialog');
    let minimizedContainer = $('#minimizedContainer');

    /*     dialogContent.dialog({
            autoOpen: false, // 자동으로 열리지 않도록 설정
            width: 400,
            height: 300,
        }); */

    /* 	window.addEventListener('message', function(event) {
            //console.log('Received message:', event);
            // 메시지를 보낸 출처가 유효한지 확인
            if (event.data.origin === 'http://localhost/rack/NSTM1_10.20.3.208') {
                console.log('Origin is valid:', event.data.origin);
                if (event.data.type === 'minimize') {
                    //console.log('Type is minimize');
                    minimizedContainer.html(event.data.html);
                    //console.log('Updated minimizedContainer with:', event.data.html);
                }
            }
        }, false); */


    // 최소화된 창 복원 함수
    window.restoreDialog = function() {
        dialogContent.dialog('widget').show();
        minimizedContainer.html('');
        isMinimized = false;
    };

    // Dialog 열기
    $('#dialog').dialog('open');

</script>
