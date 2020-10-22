package com.xyst.fwgl.utils;

public class PageData {
    private int pageNo;//当前页数
    private int totalPageNo;//总页数
    private int totalNum;//记录总数
    private int pageSize;//每页记录数
    private int startPos;//开发位置
    private int endPos;//分页查找的记录数

    public int getStartPos() {
        return startPos;
    }

    public void setStartPos(int startPos) {
        this.startPos = startPos;
    }

    public int getEndPos() {
        return endPos;
    }

    public void setEndPos(int endPos) {
        this.endPos = endPos;
    }

    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }

    public int getTotalPageNo() {
        return totalPageNo;
    }

    public void setTotalPageNo(int totalPageNo) {
        this.totalPageNo = totalPageNo;
    }

    public int getTotalNum() {
        return totalNum;
    }

    public void setTotalNum(int totalNum) {
        this.totalNum = totalNum;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public PageData(int pageNo, int totalPageNo, int totalNum, int pageSize, int startPos, int endPos) {
        this.pageNo = pageNo;
        this.totalPageNo = totalPageNo;
        this.totalNum = totalNum;
        this.pageSize = pageSize;
        this.startPos = startPos;
        this.endPos = endPos;
    }
}
