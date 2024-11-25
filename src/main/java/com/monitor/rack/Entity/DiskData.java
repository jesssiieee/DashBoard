package com.monitor.rack.Entity;

public class DiskData {
    private long free;
    private double percent;
    private long total;
    private long used;

    // 기본 생성자
    public DiskData() {
    }

    // 모든 필드를 초기화하는 생성자
    public DiskData(long free, double percent, long total, long used) {
        this.free = free;
        this.percent = percent;
        this.total = total;
        this.used = used;
    }

    // Getter와 Setter
    public long getFree() {
        return free;
    }

    public void setFree(long free) {
        this.free = free;
    }

    public double getPercent() {
        return percent;
    }

    public void setPercent(double percent) {
        this.percent = percent;
    }

    public long getTotal() {
        return total;
    }

    public void setTotal(long total) {
        this.total = total;
    }

    public long getUsed() {
        return used;
    }

    public void setUsed(long used) {
        this.used = used;
    }
}
