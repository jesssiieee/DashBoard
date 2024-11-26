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
    public String RackTestPage(
            HttpSession session,
            Model model) {

        Map<String, Object> receivedData = (Map<String, Object>) session.getAttribute("receivedData");

        if (receivedData != null) {
            // 받은 데이터를 Model에 추가
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

        // 모델에 세션 데이터 추가
        model.addAttribute("areaName", areaName);
        model.addAttribute("nodeText", nodeText);
        model.addAttribute("nodeType", nodeType);
        model.addAttribute("nodeDepth", nodeDepth);
        model.addAttribute("nodePort", nodePort);

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

            Map<String, Object> receivedData = (Map<String, Object>) requestData.get("receivedData");
            session.setAttribute("receivedData", receivedData);
            session.setAttribute("nodeText", nodeText);
            session.setAttribute("areaName", areaName);
            session.setAttribute("nodeType", nodeType);
            session.setAttribute("nodeDepth", nodeDepth);
            session.setAttribute("nodePort", nodePort);

//            System.out.println("Node Text: " + nodeText);
//            System.out.println("Area Name: " + areaName);
//            System.out.println("Node Type: " + nodeType);
//            System.out.println("Node Depth: " + nodeDepth);

            return "redirect:/testrack";
        } catch (Exception e) {
            // 예외 발생 시 로그 출력
            e.printStackTrace();
            return "Error occurred: " + e.getMessage();
        }
    }
}
