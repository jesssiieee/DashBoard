package com.monitor.server.domain;

public class MyData {
    private double cpu_percent;
    private Disk disk;
    private Memory memory;
    private Net net;

    // 기본 생성자
    public MyData() {}

    // Getter 및 Setter 메서드
    public double getCpu_percent() {
        return cpu_percent;
    }

    public void setCpu_percent(double cpu_percent) {
        this.cpu_percent = cpu_percent;
    }

    public Disk getDisk() {
        return disk;
    }

    public void setDisk(Disk disk) {
        this.disk = disk;
    }

    public Memory getMemory() {
        return memory;
    }

    public void setMemory(Memory memory) {
        this.memory = memory;
    }

    public Net getNet() {
        return net;
    }

    public void setNet(Net net) {
        this.net = net;
    }

    @Override
    public String toString() {
        return "MyData{" +
                "cpu_percent=" + cpu_percent +
                ", disk=" + disk +
                ", memory=" + memory +
                ", net=" + net +
                '}';
    }

    // 내부 클래스: Disk
    public static class Disk {
        private long free;
        private double percent;
        private long total;
        private long used;

        // Getter 및 Setter
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

        @Override
        public String toString() {
            return "Disk{" +
                    "free=" + free +
                    ", percent=" + percent +
                    ", total=" + total +
                    ", used=" + used +
                    '}';
        }
    }

    // 내부 클래스: Memory
    public static class Memory {
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

        // Getter 및 Setter
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

        @Override
        public String toString() {
            return "Memory{" +
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
    }

    // 내부 클래스: Net
    public static class Net {
        private long bytes_recv;
        private long bytes_sent;
        private int dropin;
        private int dropout;
        private int errin;
        private int errout;
        private int packets_recv;
        private int packets_sent;

        // Getter 및 Setter
        public long getBytes_recv() {
            return bytes_recv;
        }

        public void setBytes_recv(long bytes_recv) {
            this.bytes_recv = bytes_recv;
        }

        public long getBytes_sent() {
            return bytes_sent;
        }

        public void setBytes_sent(long bytes_sent) {
            this.bytes_sent = bytes_sent;
        }

        public int getDropin() {
            return dropin;
        }

        public void setDropin(int dropin) {
            this.dropin = dropin;
        }

        public int getDropout() {
            return dropout;
        }

        public void setDropout(int dropout) {
            this.dropout = dropout;
        }

        public int getErrin() {
            return errin;
        }

        public void setErrin(int errin) {
            this.errin = errin;
        }

        public int getErrout() {
            return errout;
        }

        public void setErrout(int errout) {
            this.errout = errout;
        }

        public int getPackets_recv() {
            return packets_recv;
        }

        public void setPackets_recv(int packets_recv) {
            this.packets_recv = packets_recv;
        }

        public int getPackets_sent() {
            return packets_sent;
        }

        public void setPackets_sent(int packets_sent) {
            this.packets_sent = packets_sent;
        }

        @Override
        public String toString() {
            return "Net{" +
                    "bytes_recv=" + bytes_recv +
                    ", bytes_sent=" + bytes_sent +
                    ", dropin=" + dropin +
                    ", dropout=" + dropout +
                    ", errin=" + errin +
                    ", errout=" + errout +
                    ", packets_recv=" + packets_recv +
                    ", packets_sent=" + packets_sent +
                    '}';
        }
    }
}

