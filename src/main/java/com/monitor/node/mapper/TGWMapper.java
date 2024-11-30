package com.monitor.node.mapper;

import com.monitor.node.domain.InsertInfo;
import com.monitor.node.domain.MapInfo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TGWMapper {
    public List<MapInfo> selectTgwList();

    public List<InsertInfo> selectInsertInfoList();

    void insertInfoList(InsertInfo insertInfo);
}
