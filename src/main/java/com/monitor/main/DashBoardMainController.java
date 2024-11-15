package com.monitor.main;

import com.monitor.node.bo.MapInfoBO;
import com.monitor.node.domain.MapInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/main")
public class DashBoardMainController {

    @Autowired
    private MapInfoBO mapInfoBO;

    @GetMapping("/DashBoard")
    // url: http://localhost/main/DashBoard
    public String DashBoardMainPage(Model model) {

        String mapInfoJson = mapInfoBO.getMapInfoJson();
        List<MapInfo> mapInfoList = mapInfoBO.getMapInfo(); // content1탭 트리 구성
        model.addAttribute("getMapInfoJson", mapInfoJson); // content1탭 트리 구성
        model.addAttribute("mapInfoList", mapInfoList); // 각지역.jsp에 요소 삽입

        model.addAttribute("viewName", "main/DashBoardMain"); // jsp
        return "template/layout";
    }

}


