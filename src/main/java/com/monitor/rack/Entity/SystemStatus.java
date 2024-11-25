package com.monitor.rack.Entity;

public class SystemStatus {
    private double cpuPercent;
    private DiskData disk;
    private MemoryData memory;
    private NetworkData net;

    @Override
    public String toString() {
        return "SystemStatus{" +
                "cpu_percent=" + cpuPercent +
                ", disk=" + disk +
                ", memory=" + memory +
                ", net=" + net +
                '}';
    }

    // 기본 생성자
    public SystemStatus() {
    }

    // Getter와 Setter
    public double getCpuPercent() {
        return cpuPercent;
    }

    public void setCpuPercent(double cpuPercent) {
        this.cpuPercent = cpuPercent;
    }

    public DiskData getDisk() {
        return disk;
    }

    public void setDisk(DiskData disk) {
        this.disk = disk;
    }

    public MemoryData getMemory() {
        return memory;
    }

    public void setMemory(MemoryData memory) {
        this.memory = memory;
    }

    public NetworkData getNet() {
        return net;
    }

    public void setNet(NetworkData net) {
        this.net = net;
    }
}
