<%@ page import="org.json.JSONObject" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>시스템 상태 정보</title>
</head>
<body>
<%
    // JSON 데이터 (예제 JSON 데이터를 직접 넣거나, API에서 가져오는 부분으로 수정)
    String jsonData = "{"
            + "  \"cpu_percent\": 0.2,"
            + "  \"disk\": {"
            + "    \"free\": 55284899840,"
            + "    \"percent\": 7.0,"
            + "    \"total\": 62671097856,"
            + "    \"used\": 4169482240"
            + "  },"
            + "  \"memory\": {"
            + "    \"active\": 409075712,"
            + "    \"available\": 7739408384,"
            + "    \"buffers\": 9543680,"
            + "    \"cached\": 256598016,"
            + "    \"free\": 7630274560,"
            + "    \"inactive\": 28049408,"
            + "    \"percent\": 5.8,"
            + "    \"shared\": 1335296,"
            + "    \"slab\": 46632960,"
            + "    \"total\": 8219820032,"
            + "    \"used\": 323403776"
            + "  },"
            + "  \"net\": {"
            + "    \"bytes_recv\": 3982,"
            + "    \"bytes_sent\": 1520,"
            + "    \"dropin\": 0,"
            + "    \"dropout\": 0,"
            + "    \"errin\": 0,"
            + "    \"errout\": 0,"
            + "    \"packets_recv\": 26,"
            + "    \"packets_sent\": 9"
            + "  }"
            + "}";

    // JSON 데이터를 파싱
    JSONObject jsonObject = new JSONObject(jsonData);
    double cpuPercent = jsonObject.getDouble("cpu_percent");

    JSONObject disk = jsonObject.getJSONObject("disk");
    long diskFree = disk.getLong("free");
    double diskPercent = disk.getDouble("percent");
    long diskTotal = disk.getLong("total");
    long diskUsed = disk.getLong("used");

    JSONObject memory = jsonObject.getJSONObject("memory");
    long memoryActive = memory.getLong("active");
    long memoryAvailable = memory.getLong("available");
    long memoryBuffers = memory.getLong("buffers");
    long memoryCached = memory.getLong("cached");
    long memoryFree = memory.getLong("free");
    double memoryPercent = memory.getDouble("percent");
    long memoryTotal = memory.getLong("total");
    long memoryUsed = memory.getLong("used");

    JSONObject net = jsonObject.getJSONObject("net");
    long bytesRecv = net.getLong("bytes_recv");
    long bytesSent = net.getLong("bytes_sent");
    int packetsRecv = net.getInt("packets_recv");
    int packetsSent = net.getInt("packets_sent");
%>

<h1>시스템 상태 정보</h1>
<h2>CPU 정보</h2>
<ul>
    <li><strong>CPU 사용률:</strong> <%= cpuPercent %>%</li>
</ul>

<h2>디스크 정보</h2>
<ul>
    <li><strong>디스크 전체 용량:</strong> <%= diskTotal %> 바이트</li>
    <li><strong>디스크 사용 용량:</strong> <%= diskUsed %> 바이트</li>
    <li><strong>디스크 여유 공간:</strong> <%= diskFree %> 바이트</li>
    <li><strong>디스크 사용률:</strong> <%= diskPercent %>%</li>
</ul>

<h2>메모리 정보</h2>
<ul>
    <li><strong>메모리 전체 용량:</strong> <%= memoryTotal %> 바이트</li>
    <li><strong>메모리 사용 용량:</strong> <%= memoryUsed %> 바이트</li>
    <li><strong>메모리 여유 공간:</strong> <%= memoryFree %> 바이트</li>
    <li><strong>메모리 사용률:</strong> <%= memoryPercent %>%</li>
    <li><strong>메모리 활성화된 용량:</strong> <%= memoryActive %> 바이트</li>
    <li><strong>메모리 버퍼:</strong> <%= memoryBuffers %> 바이트</li>
    <li><strong>메모리 캐시:</strong> <%= memoryCached %> 바이트</li>
</ul>

<h2>네트워크 정보</h2>
<ul>
    <li><strong>수신 바이트:</strong> <%= bytesRecv %> 바이트</li>
    <li><strong>송신 바이트:</strong> <%= bytesSent %> 바이트</li>
    <li><strong>수신 패킷:</strong> <%= packetsRecv %></li>
    <li><strong>송신 패킷:</strong> <%= packetsSent %></li>
</ul>

</body>
</html>
