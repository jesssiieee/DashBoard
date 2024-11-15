<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
    <meta charset="UTF-8">
    <title>${nodeName}</title>

    <%-- 내가 만든 스타일 시트 --%>
    <link rel="stylesheet" type="text/css" href="/static/css/rack.css">

</head>
<body>

<div id="">

</div>

<script>
    $(document).ready(function() {

        $('.section').on('click', function() {
            var id = $(this).attr('class').split(' ')[1];
            alert('Clicked on ' + id);
            // 창의 크기를 조정합니다.
            //window.resizeTo(1500, 900);
        });

        $('#sizebig').on('click', function() {
            window.resizeTo(1500, 900);
        });

    });
</script>
