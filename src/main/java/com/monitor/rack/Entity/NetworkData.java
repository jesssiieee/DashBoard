package com.monitor.rack.Entity;

public class NetworkData {
    private long bytesRecv;
    private long bytesSent;
    private long dropin;
    private long dropout;
    private long errin;
    private long errout;
    private long packetsRecv;
    private long packetsSent;

    @Override
    public String toString() {
        return "NetworkData{" +
                "bytes_recv=" + bytesRecv +
                ", bytes_sent=" + bytesSent +
                ", dropin=" + dropin +
                ", dropout=" + dropout +
                ", errin=" + errin +
                ", errout=" + errout +
                ", packets_recv=" + packetsRecv +
                ", packets_sent=" + packetsSent +
                '}';
    }

    // 기본 생성자
    public NetworkData() {
    }

    // Getter와 Setter
    public long getBytesRecv() {
        return bytesRecv;
    }

    public void setBytesRecv(long bytesRecv) {
        this.bytesRecv = bytesRecv;
    }

    public long getBytesSent() {
        return bytesSent;
    }

    public void setBytesSent(long bytesSent) {
        this.bytesSent = bytesSent;
    }

    public long getDropin() {
        return dropin;
    }

    public void setDropin(long dropin) {
        this.dropin = dropin;
    }

    public long getDropout() {
        return dropout;
    }

    public void setDropout(long dropout) {
        this.dropout = dropout;
    }

    public long getErrin() {
        return errin;
    }

    public void setErrin(long errin) {
        this.errin = errin;
    }

    public long getErrout() {
        return errout;
    }

    public void setErrout(long errout) {
        this.errout = errout;
    }

    public long getPacketsRecv() {
        return packetsRecv;
    }

    public void setPacketsRecv(long packetsRecv) {
        this.packetsRecv = packetsRecv;
    }

    public long getPacketsSent() {
        return packetsSent;
    }

    public void setPacketsSent(long packetsSent) {
        this.packetsSent = packetsSent;
    }
}

