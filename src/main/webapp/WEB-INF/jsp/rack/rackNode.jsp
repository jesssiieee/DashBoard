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

<h3>Rack Node Information</h3>

<div class="section">
    <h4>Node Information</h4>
    <p><span class="data-label">Area Name:</span> ${areaName}</p>
    <p><span class="data-label">Node Text:</span> ${nodeText}</p>
    <p><span class="data-label">Node Type:</span> ${nodeType}</p>
    <p><span class="data-label">Node Depth:</span> ${nodeDepth}</p>
</div>

<div class="section">
    <h4>Received Data</h4>
    <p><span class="data-label">Network Data:</span></p>
    <pre>${networkData}</pre>

    <p><span class="data-label">Disk Data:</span></p>
    <pre>${diskData}</pre>

    <p><span class="data-label">Memory Data:</span></p>
    <pre>${memoryData}</pre>
</div>

<button class="button" onclick="window.location.href='/main/DashBoard'">Back to Dashboard</button>

</body>
</html>
