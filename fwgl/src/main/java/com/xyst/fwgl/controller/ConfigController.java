package com.xyst.fwgl.controller;

import com.xyst.fwgl.model.*;
import com.xyst.fwgl.service.GuideService;
import com.xyst.fwgl.service.LogInfoService;
import com.xyst.fwgl.service.NoticeService;
import net.sf.json.JSONObject;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * @author hyl
 * @Date 2020/7/21 9:40
 */
@Controller
@RequestMapping("/config")
public class ConfigController {
    @Autowired
    private NoticeService noticeService;
    @Autowired
    private GuideService guideService;
    @Autowired
    private LogInfoService logInfoService;

    /**
     * @param request  通过request 获取分类的属性值 title,content
     *                 最后添加到数据库
     * @param response 添加成功返回1;添加失败返回0
     * @description 添加公告信息
     */
    @RequestMapping("/addNotice")
    public void addNotice(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("----addNotice-----------");
        String result;
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        User user = (User) request.getSession().getAttribute("loginUser");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String createTime = sdf.format(new Date());
        LogInfo logInfo = new LogInfo();
        String creator;
        if (user != null) {
            creator = user.getUserName();
            logInfo.setUserName(creator);
        } else {
            logInfo.setUserName("匿名用户");
        }
        logInfo.setAccessTime(createTime);
        logInfo.setIpAddress(request.getRemoteAddr());
        logInfo.setContent("创建公告信息");
        logInfoService.save(logInfo);
        Notice notice = new Notice();
        notice.setContent(content);
        notice.setReleaseTime(createTime);
        notice.setTitle(title);
        Integer flag = noticeService.save(notice);
        if (flag > 0) {
            result = "1";
        } else {
            result = "0";
        }
        try {
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().write("{\"msg\":\"" + result + "\"}");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * @param request  获取分类的id值
     * @param response 删除成功返回1;否则返回0
     * @description 删除公告信息
     */
    @RequestMapping("/delNotice")
    public void delNotice(HttpServletRequest request, HttpServletResponse response) {
        String result;
        int id = Integer.parseInt(request.getParameter("id"));
        System.out.println("id=" + id);
        User loginUser = (User) request.getSession().getAttribute("loginUser");
        LogInfo logInfo = new LogInfo();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String recordTime = sdf.format(new Date());
        logInfo.setAccessTime(recordTime);
        if (loginUser == null) {
            logInfo.setContent("删除公告信息");
            logInfo.setUserName("匿名用户");
        } else {
            logInfo.setContent("删除公告信息");
            logInfo.setUserName(loginUser.getUserName());
        }
        logInfo.setIpAddress(request.getRemoteAddr());
        logInfoService.save(logInfo);
        int flag = noticeService.delete(id);
        if (flag > 0) {
            result = "1";
        } else {
            result = "0";
        }
        try {
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().write("{\"msg\":\"" + result + "\"}");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * @param request  获取公告id
     * @param response 如果存在则返回公告对象;否则返回null
     * @description 通过分类id 获取公告信息
     */
    @ResponseBody
    @RequestMapping("/getNotice")
    public void getCategory(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        System.out.println("id=" + id);
        Notice notice = noticeService.findById(id);
        JSONObject json = new JSONObject();
        json.put("notice", notice);
        try {
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().write(json.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * @param request  获取公告内容的最新属性值,获取更新时间后保存到数据库
     * @param response 更新成功返回1;否则返回0
     * @description 更新公告内容信息
     */
    @RequestMapping("/updateNotice")
    public void updateCategory(HttpServletRequest request, HttpServletResponse response) {
        String result;
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String createTime = sdf.format(new Date());
        User loginUser = (User) request.getSession().getAttribute("loginUser");
        LogInfo logInfo = new LogInfo();
        logInfo.setAccessTime(createTime);
        if (loginUser == null) {
            logInfo.setContent("更新id为" + id + "公告内容信息");
            logInfo.setUserName("匿名用户");
        } else {
            logInfo.setContent("更新id为" + id + "公告内容信息");
            logInfo.setUserName(loginUser.getUserName());
        }
        logInfoService.save(logInfo);
        Notice notice = noticeService.findById(id);
        notice.setTitle(title);
        notice.setContent(content);
        notice.setReleaseTime(createTime);
        int flag = noticeService.update(notice);
        if (flag > 0) {
            result = "1";
        } else {
            result = "0";
        }
        try {
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().write("{\"msg\":\"" + result + "\"}");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("/uploadGuide")
    @ResponseBody
    public String uploadGuide(@RequestParam(value = "uploadFile") MultipartFile file, HttpServletRequest request, HttpServletResponse response) {
        String uploadFolderName = "C:\\upload\\";

        String result="0";
        // 判断文件是否存在
        if (!file.isEmpty()) {
            System.out.println("uploadFile is not empty");
            String innerName = String.valueOf(System.currentTimeMillis());
            String fileName = file.getOriginalFilename();  // 文件名
            String fileType = fileName.substring(fileName.lastIndexOf(".")+1);
            String path = uploadFolderName + innerName + "." + fileType;
            fileName=fileName.substring(0,fileName.lastIndexOf("."));
            Guide guide = new Guide();
            guide.setFileName(fileName);
            guide.setSuffix(fileType);
            guide.setFilePath(path);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            guide.setUploadTime(sdf.format(new Date()));
            try {
                FileUtils.copyInputStreamToFile(file.getInputStream(), new File(uploadFolderName, innerName + "." + fileType));
            } catch (Exception e) {
                e.printStackTrace();
            }
            Integer flag = guideService.save(guide);
            if (flag > 0) {
                result = "1";
            } else {
                result = "0";
            }
        }
        JSONObject json=new JSONObject();
        json.put("result",result);
        return json.toString();
    }
    /**
     * @param request  获取分类的id值
     * @param response 删除成功返回1;否则返回0
     * @description 删除公告信息
     */
    @RequestMapping("/delGuide")
    @ResponseBody
    public String delGuide(HttpServletRequest request, HttpServletResponse response) {
        String result="0";
        int id = Integer.parseInt(request.getParameter("id"));
        System.out.println("id=" + id);
        User loginUser = (User) request.getSession().getAttribute("loginUser");
        LogInfo logInfo = new LogInfo();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String recordTime = sdf.format(new Date());
        logInfo.setAccessTime(recordTime);
        if (loginUser == null) {
            logInfo.setContent("删除操作指南文件");
            logInfo.setUserName("匿名用户");
        } else {
            logInfo.setContent("删除操作指南文件");
            logInfo.setUserName(loginUser.getUserName());
        }
        logInfo.setIpAddress(request.getRemoteAddr());
        logInfoService.save(logInfo);
        Guide guide=guideService.findById(id);
        File file = new File(guide.getFilePath());
        boolean delFile=false;
        // 判断目录或文件是否存在
        if (file.isFile() && file.exists()) {
            file.delete();
            delFile = true;
        }
        if(delFile) {
            int flag = guideService.delete(id);
            if (flag > 0) {
                result = "1";
            } else {
                result = "0";
            }
        }
        JSONObject json=new JSONObject();
        json.put("result",result);
        return json.toString();
    }
    @RequestMapping("/downloadfile")
    public void downLoadFile(HttpServletRequest request, HttpServletResponse response) throws IOException {
        /**
         * 前提：客户端已经进行了权限验证。
         * 为防止从地址栏下载文件，服务器端应先检查当前用户是否有相应的下载权限。
         */
        // int id= Integer.parseInt(request.getParameter("id"));
        List<Guide> guideList = guideService.findAll();
        if (guideList != null && guideList.size() > 0) {
            Guide guide = guideList.get(0);
            //获得请求文件名
            String filename = guide.getFileName();
            String suffix = guide.getSuffix();
            //设置文件MIME类型
            response.reset();
            response.setContentType("application/x-msdownload");
            response.setHeader("Content-Type", "application/octet-stream");
            String agent = request.getHeader("User-Agent").toUpperCase(); //获得浏览器信息并转换为大写
            if (agent.indexOf("EDGE") > 0 || agent.indexOf("MSIE") > 0 || (agent.indexOf("GECKO") > 0 && agent.indexOf("RV:11") > 0)) {  //IE浏览器和Edge浏览器
                filename = URLEncoder.encode(filename + "." + suffix, "UTF-8");
            } else {  //其他浏览器
                filename = new String(filename.getBytes("UTF-8"), "iso-8859-1");
            }
            response.setHeader("content-disposition", "attachment;filename=" + filename + "." + suffix);
            String fullFileName = guide.getFilePath();
            //读取文件
            InputStream in = new FileInputStream(fullFileName);
            OutputStream out = response.getOutputStream();

            //写文件
            int b;
            while ((b = in.read()) != -1) {
                out.write(b);
            }

            in.close();
            out.close();
        }
    }
}
