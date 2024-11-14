package com.monitor.node.domain;

public class MapInfo {

    private  int id;
    private String area_name;
    private String forward_group_name;
    private int type;
    private int depth;
    private String name;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getArea_name() {
        return area_name;
    }

    public void setArea_name(String area_name) {
        this.area_name = area_name;
    }

    public String getForward_group_name() {
        return forward_group_name;
    }

    public void setForward_group_name(String forward_group_name) {
        this.forward_group_name = forward_group_name;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public int getDepth() {
        return depth;
    }

    public void setDepth(int depth) {
        this.depth = depth;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }


}
