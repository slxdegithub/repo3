package com.xyst.fwgl.utils;


import com.alibaba.fastjson.JSONObject;

public class Test {
    public static void main(String[] args) throws Exception{
        JSONObject jsonObject = new JSONObject();
       /* jsonObject.put("expiryDate","20280808");
        jsonObject.put("serviceCode","abcd");*/
        jsonObject.put("serviceName", "用户登录");
        //jsonObject.put("transMedium", "21001");
        String url="http://47.96.154.180:8030/bus/service/count";

        PostToJson postToJson = new PostToJson();
        String send = postToJson.send(url, jsonObject, "utf-8","");
        System.out.println(send);
        /*jsonObject=(JSONObject)JSONObject.parse(send);
        String result=jsonObject.get("result").toString();
        jsonObject=(JSONObject)JSONObject.parse(jsonObject.get("result").toString());
        System.out.println(jsonObject.get("token"));
        String url1="http://47.96.154.180:8030/shiro/user/current";
        JSONObject json = new JSONObject();
        String send1=postToJson.send(url1,json,"utf-8",jsonObject.get("token").toString());
        System.out.println(send1);*/
    }
}
