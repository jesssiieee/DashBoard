package com.monitor.node;

import com.monitor.node.bo.InsertInfoBO;
import com.monitor.node.domain.InsertInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/insert-info")
public class InsertInfoController {

    @Autowired
    private InsertInfoBO insertInfoBO;

    @PostMapping("/save")
    public String saveInsertInfo(@RequestBody InsertInfo insertInfo) {
        insertInfoBO.saveInsertInfo(insertInfo);
        return "success";
    }

}
