package com.monitor.node.bo;

import com.google.gson.Gson;
import com.monitor.node.domain.InsertInfo;
import com.monitor.node.mapper.TGWMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class InsertInfoBO {

    @Autowired
    private TGWMapper tgwMapper;

    public void saveInsertInfo(InsertInfo insertInfo) {
        tgwMapper.insertInfoList(insertInfo);
    }

    public List<InsertInfo> getInsertInfo() {
        return tgwMapper.selectInsertInfoList();
    }

    public String getMapInfoJson() {
        List<InsertInfo> insertInfoJson = getInsertInfo();
        Gson gson = new Gson();
        return gson.toJson(insertInfoJson);
    }
}
