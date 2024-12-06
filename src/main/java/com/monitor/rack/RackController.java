package com.monitor.rack;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Controller
@RequestMapping("/rack")
public class RackController {

    @GetMapping("/testrack")
    public String RackTestPage(HttpSession session, Model model) {
        Map<String, Object> receivedData = (Map<String, Object>) session.getAttribute("receivedData");

        if (receivedData != null) {
            // 'receivedData' 안에서 'sense_data' 추출
            Map<String, Object> senseData = (Map<String, Object>) receivedData.get("sense_data");

            if (senseData != null) {
                // 'senseData' 모델에 추가
                model.addAttribute("senseData", senseData);
            }

            // 기존 'receivedData'에서 네트워크, 디스크, 메모리 데이터 추가
            model.addAttribute("networkData", receivedData.get("net"));
            model.addAttribute("diskData", receivedData.get("disk"));
            model.addAttribute("memoryData", receivedData.get("memory"));
        }

        // 세션에서 node 관련 데이터 가져오기
        String areaName = (String) session.getAttribute("areaName");
        String nodeText = (String) session.getAttribute("nodeText");
        String nodeType = (String) session.getAttribute("nodeType");
        String nodeDepth = (String) session.getAttribute("nodeDepth");
        String nodePort = (String) session.getAttribute("nodePort");
        String nodeIp = (String) session.getAttribute("nodeIp"); // nodeIp 추가

        // 모델에 세션 데이터 추가
        model.addAttribute("areaName", areaName);
        model.addAttribute("nodeText", nodeText);
        model.addAttribute("nodeType", nodeType);
        model.addAttribute("nodeDepth", nodeDepth);
        model.addAttribute("nodePort", nodePort);
        model.addAttribute("nodeIp", nodeIp); // nodeIp 추가

        return "rack/rackNode"; // rackNode.jsp로 이동
    }

    @PostMapping("/testrack")
    @ResponseBody
    public String RackTest(@RequestBody Map<String, Object> requestData, HttpSession session) {
        try {
            String nodeText = (String) requestData.get("nodeText");
            String areaName = (String) requestData.get("areaName");
            String nodeType = (String) requestData.get("nodeType");
            String nodeDepth = (String) requestData.get("nodeDepth");
            String nodePort = (String) requestData.get("nodePort");
            String nodeIp = (String) requestData.get("nodeIp"); // nodeIp 추가

            Map<String, Object> receivedData = (Map<String, Object>) requestData.get("receivedData");
            session.setAttribute("receivedData", receivedData);
            session.setAttribute("nodeText", nodeText);
            session.setAttribute("areaName", areaName);
            session.setAttribute("nodeType", nodeType);
            session.setAttribute("nodeDepth", nodeDepth);
            session.setAttribute("nodePort", nodePort);
            session.setAttribute("nodeIp", nodeIp); // nodeIp 세션에 저장

            return "redirect:/rack/testrack"; // 리다이렉션
        } catch (Exception e) {
            // 예외 발생 시 로그 출력
            e.printStackTrace();
            return "Error occurred: " + e.getMessage();
        }
    }
}
