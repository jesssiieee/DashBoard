package com.monitor.node.bo;

import com.google.gson.Gson;
import com.monitor.node.domain.MapInfo;
import com.monitor.node.mapper.TGWMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MapInfoBO {

    @Autowired
    private TGWMapper tgwMapper;

    public List<MapInfo> getMapInfo() {
        return tgwMapper.selectTgwList();
    }

    public String getMapInfoJson() {
        List<MapInfo> mapInfoList = getMapInfo();
        Gson gson = new Gson();
        return gson.toJson(mapInfoList);
    }
}
