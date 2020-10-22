package com.xyst.fwgl.utils;

public class PageHelp {

    public static PageData getPageData(int pageNo, int pageSize, int totalNum) {
        int startPos = (pageNo - 1) * pageSize;//开始
        int endPos;//结束
        if (pageNo * pageSize > totalNum) {
            endPos = totalNum - startPos;
        } else {
            endPos = pageNo * pageSize - startPos;
        }
        int totalPage = (totalNum + pageSize - 1) / pageSize;//总页数
        PageData pageData = new PageData(pageNo, totalPage, totalNum, pageSize, startPos, endPos);
        return pageData;
    }
}
