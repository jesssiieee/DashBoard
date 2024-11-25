package com.monitor.rack.Entity;

public class MemoryData {
    private long active;
    private long available;
    private long buffers;
    private long cached;
    private long free;
    private long inactive;
    private double percent;
    private long shared;
    private long slab;
    private long total;
    private long used;

    @Override
    public String toString() {
        return "MemoryData{" +
                "active=" + active +
                ", available=" + available +
                ", buffers=" + buffers +
                ", cached=" + cached +
                ", free=" + free +
                ", inactive=" + inactive +
                ", percent=" + percent +
                ", shared=" + shared +
                ", slab=" + slab +
                ", total=" + total +
                ", used=" + used +
                '}';
    }

    // 기본 생성자
    public MemoryData() {
    }

    // Getter와 Setter
    public long getActive() {
        return active;
    }

    public void setActive(long active) {
        this.active = active;
    }

    public long getAvailable() {
        return available;
    }

    public void setAvailable(long available) {
        this.available = available;
    }

    public long getBuffers() {
        return buffers;
    }

    public void setBuffers(long buffers) {
        this.buffers = buffers;
    }

    public long getCached() {
        return cached;
    }

    public void setCached(long cached) {
        this.cached = cached;
    }

    public long getFree() {
        return free;
    }

    public void setFree(long free) {
        this.free = free;
    }

    public long getInactive() {
        return inactive;
    }

    public void setInactive(long inactive) {
        this.inactive = inactive;
    }

    public double getPercent() {
        return percent;
    }

    public void setPercent(double percent) {
        this.percent = percent;
    }

    public long getShared() {
        return shared;
    }

    public void setShared(long shared) {
        this.shared = shared;
    }

    public long getSlab() {
        return slab;
    }

    public void setSlab(long slab) {
        this.slab = slab;
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
