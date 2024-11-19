package com.monitor.server;

import com.google.gson.Gson;
import com.monitor.server.domain.MyData;
import jakarta.websocket.*;
import jakarta.websocket.server.ServerEndpoint;

import java.util.Set;


@ServerEndpoint("/status")
public class WebSocketServer {

    // WebSocket 세션을 저장할 Set
    private static Set<Session> clients;
    private Gson gson = new Gson();

    @OnOpen
    public void onOpen(Session session) {
        System.out.println("WebSocket connection opened: " + session.getId());
        clients.add(session);  // 연결된 클라이언트 세션을 추가
    }

    @OnMessage
    public String onMessage(String message) {
        try {
            // JSON 문자열을 Java 객체로 변환
            MyData data = gson.fromJson(message, MyData.class);
            System.out.println("Received data: " + data);

            // Java 객체를 JSON 문자열로 변환
            String jsonResponse = gson.toJson(data);
            return jsonResponse;

        } catch (Exception e) {
            e.printStackTrace();
            return "Error processing message";
        }
    }

    @OnClose
    public void onClose(Session session) {
        System.out.println("WebSocket connection closed: " + session.getId());
        clients.remove(session);  // 연결이 종료된 세션을 제거
    }

    @OnError
    public void onError(Throwable error) {
        System.err.println("WebSocket error: " + error.getMessage());
    }

}
