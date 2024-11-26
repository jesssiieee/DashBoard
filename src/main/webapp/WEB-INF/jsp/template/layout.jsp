<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>DashBoard Main</title>

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
            crossorigin="anonymous"></script>

    <!-- jsTree -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/themes/default/style.min.css" />
    <script
            src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/jstree.min.js"></script>

    <!-- Bootstrap -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
          integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N"
          crossorigin="anonymous">

    <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct"
            crossorigin="anonymous"></script>

    <!-- jQuery UI CSS -->
    <link rel="stylesheet"
          href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

    <!-- jQuery UI 라이브러리 -->
    <script
            src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>

    <!-- 내 스타일 시트 -->
    <link rel="stylesheet" type="text/css" href="/static/css/style.css">

    <script src="http://localhost:3000/socket.io/socket.io.js"></script>

    <script>document.addEventListener('contextmenu', event => event.preventDefault());</script>

    <style>
        .resizer {
            height: 5px;
            background: #cbd5e0;
            cursor: ns-resize;
            width: 100%;
            position: relative;
            z-index: 1;
        }
    </style>

</head>

    <body>
        <div id="wrap" class="">

            <!-- header -->
            <header>
                <jsp:include page="../include/header.jsp" />
            </header>

            <!-- section -->
            <section class="top-div">
                <jsp:include page="../${viewName}.jsp" />
            </section>

            <!-- footer -->
            <footer>
                <div class="bottom-div">
                    <jsp:include page="../include/footer.jsp" />
                </div>
            </footer>

        </div>
        <script src="/static/js/script.js"></script>
    </body>
</html>
