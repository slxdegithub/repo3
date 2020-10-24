/*
Navicat MySQL Data Transfer

Source Server         : 宋
Source Server Version : 50720
Source Host           : localhost:3306
Source Database       : fwgl

Target Server Type    : MYSQL
Target Server Version : 50720
File Encoding         : 65001

Date: 2020-10-24 20:02:22
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `category`
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cname` varchar(255) NOT NULL COMMENT '服务类别名称',
  `description` varchar(255) NOT NULL COMMENT '服务类别摘要',
  `create_time` varchar(255) DEFAULT NULL COMMENT '类别创建时间',
  `audit_time` varchar(255) DEFAULT NULL COMMENT '创建者Id',
  `result` varchar(255) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '0:创建 1:提交审核  2：审核通过 3:审核未通过',
  `type` int(11) NOT NULL COMMENT '1:表示一级目录  2：表示二级目录',
  `pre_category` int(11) DEFAULT NULL COMMENT '上级目录ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('85', '新余数投', '新余数投公司接口服务目录', '2020-08-31 21:19:39', '2020-08-31 21:24:32', '同意', null, '2', '1', '0');
INSERT INTO `category` VALUES ('86', '新余公安', '新余公安信息接口', '2020-08-31 21:29:14', '2020-08-31 21:30:22', '同意', 'asdfasdf', '2', '1', '0');
INSERT INTO `category` VALUES ('87', '新余教育', '新余教育局信息目录', '2020-08-31 21:20:30', '2020-08-31 21:24:19', '同意', null, '2', '1', '0');
INSERT INTO `category` VALUES ('88', '新余交通', '新余交通局信息目录', '2020-08-31 21:20:51', '2020-08-31 21:24:15', '同意', null, '2', '1', '0');
INSERT INTO `category` VALUES ('89', '新余民政', '新余民政局信息目录', '2020-08-31 21:21:07', '2020-08-31 21:24:11', '同意', null, '2', '1', '0');
INSERT INTO `category` VALUES ('90', '新余发改', '新余发改委信息目录', '2020-08-31 21:21:31', '2020-08-31 21:24:06', '同意', null, '2', '1', '0');
INSERT INTO `category` VALUES ('91', '新余城投', '新余城投目录', '2020-08-31 21:21:48', '2020-08-31 21:24:02', '同意', null, '2', '1', '0');
INSERT INTO `category` VALUES ('92', '新余卫健委', '新余卫健委数据目录', '2020-08-31 21:23:03', '2020-08-31 21:23:58', '同意', null, '2', '1', '0');
INSERT INTO `category` VALUES ('93', '登录', '新余数投登录信息', '2020-08-31 21:32:13', '2020-08-31 21:44:37', '同意', null, '2', '2', '85');
INSERT INTO `category` VALUES ('94', '贷前准入', '新余数投贷前准入接口', '2020-08-31 21:32:45', '2020-08-31 21:44:33', '同意', null, '2', '2', '85');
INSERT INTO `category` VALUES ('95', '贷中评估', '贷中评估', '2020-08-31 21:33:08', '2020-08-31 21:44:30', '同意', null, '2', '2', '85');
INSERT INTO `category` VALUES ('96', '贷后预警', '贷后预警信息', '2020-08-31 21:33:34', '2020-08-31 21:44:26', '同意', null, '2', '2', '85');
INSERT INTO `category` VALUES ('97', '身份信息', '身份信息目录', '2020-08-31 21:33:57', '2020-08-31 21:44:23', '同意', null, '2', '2', '86');
INSERT INTO `category` VALUES ('98', '交通违规', '交通违规信息', '2020-08-31 21:34:22', '2020-08-31 21:44:19', '同意', null, '2', '2', '86');
INSERT INTO `category` VALUES ('99', '治安管理', '治安管理目录', '2020-08-31 21:35:18', '2020-08-31 21:44:16', '同意', null, '2', '2', '86');
INSERT INTO `category` VALUES ('100', '学籍信息', '学籍信息目录', '2020-08-31 21:36:06', '2020-08-31 21:44:13', '同意', null, '2', '2', '87');
INSERT INTO `category` VALUES ('101', '转学信息', '转学信息目录', '2020-08-31 21:36:36', '2020-08-31 21:44:09', '同意', null, '2', '2', '86');
INSERT INTO `category` VALUES ('102', '学历认证', '学历认证信息目录', '2020-08-31 21:37:10', '2020-08-31 21:44:06', '同意', null, '2', '2', '87');
INSERT INTO `category` VALUES ('103', '666', '', '2020-09-03 13:31:10', '2020-09-03 13:31:39', '同意', null, '2', '2', '92');

-- ----------------------------
-- Table structure for `dictionary`
-- ----------------------------
DROP TABLE IF EXISTS `dictionary`;
CREATE TABLE `dictionary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '词典名称',
  `type` int(2) DEFAULT NULL COMMENT '1:服务类型 RPC SOAP REST 2：协议类型 http https ',
  `create_time` varchar(255) DEFAULT NULL COMMENT '创建时间',
  `description` varchar(255) DEFAULT NULL COMMENT '词典描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dictionary
-- ----------------------------
INSERT INTO `dictionary` VALUES ('7', 'RPC', '1', '2020-08-31 20:34:11', '远程过程调用服务');
INSERT INTO `dictionary` VALUES ('8', 'SOAP', '1', '2020-08-31 20:34:38', '简单对象访问协议类型服务');
INSERT INTO `dictionary` VALUES ('9', 'REST', '1', '2020-08-31 20:34:53', 'REST风格服务');
INSERT INTO `dictionary` VALUES ('10', 'http', '2', '2020-08-31 20:35:08', 'http协议');
INSERT INTO `dictionary` VALUES ('11', 'https', '2', '2020-08-31 21:16:05', 'https协议');

-- ----------------------------
-- Table structure for `guide`
-- ----------------------------
DROP TABLE IF EXISTS `guide`;
CREATE TABLE `guide` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file_name` varchar(255) DEFAULT NULL,
  `suffix` varchar(255) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `upload_time` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of guide
-- ----------------------------
INSERT INTO `guide` VALUES ('2', '普惠金融用户中心接口文档', 'docx', 'C:\\upload\\1598879925489.docx', '2020-08-31 21:18:45');

-- ----------------------------
-- Table structure for `log_info`
-- ----------------------------
DROP TABLE IF EXISTS `log_info`;
CREATE TABLE `log_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) DEFAULT NULL,
  `content` varchar(255) NOT NULL,
  `access_time` varchar(255) DEFAULT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6572 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of log_info
-- ----------------------------
INSERT INTO `log_info` VALUES ('5936', '匿名用户', '进入登录页面', '2020-09-01 13:59:57', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5937', 'czy', '登录系统', '2020-09-01 14:00:10', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5938', 'czy', '查看服务分类信息', '2020-09-01 14:00:10', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5939', 'czy', '获取id为102服务分类信息', '2020-09-01 14:00:13', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5940', 'czy', '查看服务分类信息', '2020-09-01 14:04:24', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5941', 'czy', '查看服务分类信息', '2020-09-01 14:08:42', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5942', 'czy', '查看服务分类信息', '2020-09-01 14:09:51', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5943', '匿名用户', '进入登录页面', '2020-09-01 15:55:58', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5944', 'czy', '登录系统', '2020-09-01 15:56:00', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5945', 'czy', '查看服务分类信息', '2020-09-01 15:56:01', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5946', 'czy', '查看服务分类信息', '2020-09-01 15:56:11', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5947', 'czy', '获取所有的一级目录信息', '2020-09-01 15:56:19', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5948', 'czy', '根据ID获取所有的二级目录信息', '2020-09-01 15:58:54', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5949', 'czy', '查看服务分类信息', '2020-09-01 15:59:09', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5950', 'czy', '退出登录系统', '2020-09-01 15:59:58', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5951', '匿名用户', '进入登录页面', '2020-09-01 16:01:07', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5952', 'czy', '登录系统', '2020-09-01 16:01:24', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5953', 'czy', '查看服务分类信息', '2020-09-01 16:01:24', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5954', 'czy', '查看服务分类信息', '2020-09-01 16:01:38', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5955', 'czy', '获取id为102服务分类信息', '2020-09-01 16:01:40', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5956', 'czy', '获取id为101服务分类信息', '2020-09-01 16:01:42', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5957', 'czy', '获取id为99服务分类信息', '2020-09-01 16:01:44', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5958', 'czy', '查看服务分类信息', '2020-09-01 16:01:48', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5959', 'czy', '查看服务分类信息', '2020-09-01 16:01:49', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5960', 'czy', '获取id为99服务分类信息', '2020-09-01 16:01:51', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5961', 'czy', '获取id为97服务分类信息', '2020-09-01 16:01:53', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5962', 'czy', '获取id为95服务分类信息', '2020-09-01 16:01:55', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5963', 'czy', '获取id为94服务分类信息', '2020-09-01 16:01:57', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5964', 'czy', '查看服务分类信息', '2020-09-01 16:02:00', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5965', 'czy', '查看服务分类信息', '2020-09-01 16:02:01', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5966', 'czy', '查看服务分类信息', '2020-09-01 16:02:02', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5967', 'czy', '查看服务分类信息', '2020-09-01 16:02:03', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5968', 'czy', '查看服务分类信息', '2020-09-01 16:02:03', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5969', 'czy', '查看服务分类信息', '2020-09-01 16:02:04', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5970', 'czy', '查看服务分类信息', '2020-09-01 16:02:04', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5971', 'czy', '查看服务分类信息', '2020-09-01 16:02:04', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5972', 'czy', '查看服务分类信息', '2020-09-01 16:02:05', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5973', 'czy', '查看服务分类信息', '2020-09-01 16:02:05', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5974', 'czy', '查看服务分类信息', '2020-09-01 16:02:05', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5975', 'czy', '查看服务分类信息', '2020-09-01 16:02:06', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5976', 'czy', '查看服务分类信息', '2020-09-01 16:02:06', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5977', 'czy', '查看服务分类信息', '2020-09-01 16:02:06', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5978', 'czy', '查看服务分类信息', '2020-09-01 16:02:07', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5979', 'czy', '查看服务分类信息', '2020-09-01 16:02:07', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5980', 'czy', '查看服务分类信息', '2020-09-01 16:02:08', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5981', 'czy', '查看服务分类信息', '2020-09-01 16:02:08', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5982', 'czy', '查看服务分类信息', '2020-09-01 16:02:08', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5983', 'czy', '查看服务分类信息', '2020-09-01 16:02:09', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5984', 'czy', '查看服务分类信息', '2020-09-01 16:02:09', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5985', 'czy', '查看服务分类信息', '2020-09-01 16:02:10', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5986', 'czy', '查看服务分类信息', '2020-09-01 16:02:10', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5987', 'czy', '查看服务分类信息', '2020-09-01 16:02:11', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5988', 'czy', '查看服务分类信息', '2020-09-01 16:02:11', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5989', 'czy', '查看服务分类信息', '2020-09-01 16:02:11', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5990', 'czy', '查看服务分类信息', '2020-09-01 16:02:12', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5991', 'czy', '查看服务分类信息', '2020-09-01 16:02:12', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5992', 'czy', '查看服务分类信息', '2020-09-01 16:02:13', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5993', 'czy', '查看服务分类信息', '2020-09-01 16:02:13', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5994', 'czy', '查看服务分类信息', '2020-09-01 16:02:13', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5995', 'czy', '查看服务分类信息', '2020-09-01 16:02:17', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5996', 'czy', '查看服务分类信息', '2020-09-01 16:02:22', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5997', 'czy', '查看服务分类信息', '2020-09-01 16:03:05', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5998', 'czy', '查看服务分类信息', '2020-09-01 16:03:12', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('5999', 'czy', '查看服务分类信息', '2020-09-01 16:03:25', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6000', 'czy', '查看服务分类信息', '2020-09-01 16:03:29', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6001', 'czy', '查看服务分类信息', '2020-09-01 16:03:41', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6002', 'czy', '查看服务分类信息', '2020-09-01 16:03:49', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6003', '匿名用户', '进入登录页面', '2020-09-01 17:11:53', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6004', '匿名用户', '登录系统', '2020-09-01 17:11:56', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6005', '匿名用户', '登录系统', '2020-09-01 17:12:00', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6006', 'admin', '登录系统', '2020-09-01 17:12:07', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6007', 'admin', '退出登录系统', '2020-09-01 17:12:47', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6008', '匿名用户', '进入登录页面', '2020-09-01 17:12:49', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6009', '匿名用户', '登录系统', '2020-09-01 17:12:58', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6010', '匿名用户', '登录系统', '2020-09-01 17:13:04', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6011', '匿名用户', '登录系统', '2020-09-01 17:13:15', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6012', '匿名用户', '登录系统', '2020-09-01 17:13:24', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6013', '匿名用户', '登录系统', '2020-09-01 17:13:37', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6014', 'operater', '登录系统', '2020-09-01 17:14:00', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6015', 'operater', '查看服务分类信息', '2020-09-01 17:14:00', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6016', 'operater', '查看服务分类信息', '2020-09-01 17:14:05', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6017', 'operater', '查看服务分类信息', '2020-09-01 17:14:13', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6018', 'operater', '退出登录系统', '2020-09-01 17:33:59', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6019', '匿名用户', '进入登录页面', '2020-09-01 17:34:01', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6020', 'admin', '登录系统', '2020-09-01 17:34:06', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6021', 'admin', '退出登录系统', '2020-09-01 17:34:23', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6022', '匿名用户', '进入登录页面', '2020-09-01 17:34:24', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6023', 'operater', '登录系统', '2020-09-01 17:34:31', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6024', 'operater', '查看服务分类信息', '2020-09-01 17:34:31', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6025', 'operater', '获取所有的一级目录信息', '2020-09-01 17:34:51', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6026', 'operater', '根据ID获取所有的二级目录信息', '2020-09-01 17:35:30', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6027', 'operater', 'operater添加名为获取小学转学信息的服务信息', '2020-09-01 17:36:00', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6028', 'operater', '获取所有的一级目录信息', '2020-09-01 17:36:03', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6029', 'operater', '根据ID获取所有的二级目录信息', '2020-09-01 17:36:18', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6030', 'operater', 'operater添加名为获取身份认证信息的服务信息', '2020-09-01 17:37:24', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6031', 'operater', '获取所有的一级目录信息', '2020-09-01 17:37:28', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6032', 'operater', '根据ID获取所有的二级目录信息', '2020-09-01 17:37:44', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6033', 'operater', '根据ID获取所有的二级目录信息', '2020-09-01 17:37:46', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6034', 'operater', 'operater添加名为获取贷前准入信息的服务信息', '2020-09-01 17:39:17', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6035', 'operater', '获取所有的一级目录信息', '2020-09-01 17:39:20', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6036', 'operater', '根据ID获取所有的二级目录信息', '2020-09-01 17:41:04', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6037', 'operater', 'operater添加名为获取贷后预警信息的服务信息', '2020-09-01 17:41:40', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6038', 'operater', '获取所有的一级目录信息', '2020-09-01 17:41:43', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6039', 'operater', '退出登录系统', '2020-09-01 18:06:26', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6040', '匿名用户', '进入登录页面', '2020-09-02 10:52:47', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6041', 'operater', '登录系统', '2020-09-02 10:53:00', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6042', 'operater', '查看服务分类信息', '2020-09-02 10:53:00', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6043', 'operater', '查看服务分类信息', '2020-09-02 10:53:03', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6044', 'operater', '查看服务分类信息', '2020-09-02 10:53:06', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6045', 'operater', '获取所有的一级目录信息', '2020-09-02 10:53:09', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6046', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 10:53:17', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6047', 'operater', 'operater添加名为1的服务信息', '2020-09-02 10:53:31', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6048', 'operater', '获取所有的一级目录信息', '2020-09-02 10:53:34', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6049', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 10:53:41', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6050', 'operater', 'operater添加名为2的服务信息', '2020-09-02 10:53:55', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6051', 'operater', '获取所有的一级目录信息', '2020-09-02 10:53:57', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6052', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 10:54:03', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6053', 'operater', 'operater添加名为3的服务信息', '2020-09-02 10:54:15', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6054', 'operater', '获取所有的一级目录信息', '2020-09-02 10:54:18', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6055', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 10:54:29', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6056', 'operater', 'operater添加名为4的服务信息', '2020-09-02 10:54:39', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6057', 'operater', '获取所有的一级目录信息', '2020-09-02 10:54:42', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6058', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 10:55:02', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6059', 'operater', 'operater添加名为5的服务信息', '2020-09-02 10:55:34', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6060', 'operater', '获取所有的一级目录信息', '2020-09-02 10:55:38', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6061', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 10:55:44', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6062', 'operater', 'operater添加名为6的服务信息', '2020-09-02 10:55:58', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6063', 'operater', '获取所有的一级目录信息', '2020-09-02 10:56:00', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6064', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 10:56:06', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6065', 'operater', 'operater添加名为7的服务信息', '2020-09-02 10:56:18', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6066', 'operater', '获取所有的一级目录信息', '2020-09-02 10:56:20', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6067', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 10:56:26', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6068', 'operater', 'operater添加名为8的服务信息', '2020-09-02 10:56:37', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6069', 'operater', '获取所有的一级目录信息', '2020-09-02 10:56:39', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6070', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 10:56:44', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6071', 'operater', 'operater添加名为9的服务信息', '2020-09-02 10:56:55', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6072', 'operater', '获取所有的一级目录信息', '2020-09-02 10:56:57', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6073', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 10:57:05', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6074', 'operater', 'operater添加名为10的服务信息', '2020-09-02 10:57:18', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6075', 'operater', '获取所有的一级目录信息', '2020-09-02 10:57:20', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6076', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 10:57:28', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6077', 'operater', 'operater添加名为11的服务信息', '2020-09-02 10:57:45', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6078', 'operater', '获取所有的一级目录信息', '2020-09-02 10:57:47', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6079', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 10:57:54', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6080', 'operater', 'operater添加名为12的服务信息', '2020-09-02 10:58:09', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6081', 'operater', '获取所有的一级目录信息', '2020-09-02 10:58:11', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6082', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 10:58:18', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6083', 'operater', 'operater添加名为13的服务信息', '2020-09-02 10:58:29', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6084', 'operater', '获取所有的一级目录信息', '2020-09-02 10:58:38', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6085', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 10:58:47', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6086', 'operater', 'operater添加名为14的服务信息', '2020-09-02 10:58:58', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6087', 'operater', '获取所有的一级目录信息', '2020-09-02 10:59:00', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6088', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 10:59:12', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6089', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 10:59:14', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6090', 'operater', 'operater添加名为15的服务信息', '2020-09-02 10:59:25', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6091', 'operater', '获取所有的一级目录信息', '2020-09-02 10:59:27', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6092', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 10:59:35', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6093', 'operater', 'operater添加名为16的服务信息', '2020-09-02 10:59:43', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6094', 'operater', '获取所有的一级目录信息', '2020-09-02 10:59:45', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6095', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 10:59:52', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6096', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 10:59:53', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6097', 'operater', 'operater添加名为17的服务信息', '2020-09-02 11:00:04', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6098', 'operater', '获取所有的一级目录信息', '2020-09-02 11:00:06', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6099', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 11:00:14', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6100', 'operater', 'operater添加名为18的服务信息', '2020-09-02 11:00:22', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6101', 'operater', '获取所有的一级目录信息', '2020-09-02 11:00:24', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6102', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 11:00:31', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6103', 'operater', 'operater添加名为19的服务信息', '2020-09-02 11:00:43', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6104', 'operater', '获取所有的一级目录信息', '2020-09-02 11:00:45', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6105', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 11:00:52', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6106', 'operater', 'operater添加名为20的服务信息', '2020-09-02 11:01:01', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6107', 'operater', '获取所有的一级目录信息', '2020-09-02 11:01:03', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6108', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 11:01:09', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6109', 'operater', 'operater添加名为21的服务信息', '2020-09-02 11:01:19', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6110', 'operater', '获取所有的一级目录信息', '2020-09-02 11:01:22', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6111', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 11:01:28', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6112', 'operater', 'operater添加名为22的服务信息', '2020-09-02 11:01:49', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6113', 'operater', '获取所有的一级目录信息', '2020-09-02 11:01:52', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6114', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 11:01:58', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6115', 'operater', 'operater添加名为23的服务信息', '2020-09-02 11:02:08', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6116', 'operater', '获取所有的一级目录信息', '2020-09-02 11:02:11', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6117', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 11:03:14', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6118', 'operater', 'operater添加名为24的服务信息', '2020-09-02 11:03:20', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6119', 'operater', '获取所有的一级目录信息', '2020-09-02 11:03:24', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6120', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 11:03:30', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6121', 'operater', 'operater添加名为25的服务信息', '2020-09-02 11:03:40', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6122', 'operater', '获取所有的一级目录信息', '2020-09-02 11:03:42', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6123', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 11:03:49', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6124', 'operater', 'operater添加名为26的服务信息', '2020-09-02 11:03:58', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6125', 'operater', '获取所有的一级目录信息', '2020-09-02 11:04:00', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6126', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 11:04:07', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6127', 'operater', 'operater添加名为27的服务信息', '2020-09-02 11:04:18', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6128', 'operater', '获取所有的一级目录信息', '2020-09-02 11:04:20', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6129', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 11:04:30', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6130', 'operater', 'operater添加名为28的服务信息', '2020-09-02 11:04:41', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6131', 'operater', '获取所有的一级目录信息', '2020-09-02 11:04:43', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6132', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 11:04:54', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6133', 'operater', 'operater添加名为29的服务信息', '2020-09-02 11:05:01', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6134', 'operater', '获取所有的一级目录信息', '2020-09-02 11:05:04', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6135', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 11:05:18', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6136', 'operater', 'operater添加名为30的服务信息', '2020-09-02 11:05:28', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6137', 'operater', '获取所有的一级目录信息', '2020-09-02 11:05:30', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6138', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 11:05:39', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6139', 'operater', 'operater添加名为31的服务信息', '2020-09-02 11:05:48', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6140', 'operater', '获取所有的一级目录信息', '2020-09-02 11:05:50', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6141', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 11:05:55', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6142', 'operater', 'operater添加名为32的服务信息', '2020-09-02 11:06:06', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6143', 'operater', '获取所有的一级目录信息', '2020-09-02 11:06:08', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6144', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 11:06:18', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6145', 'operater', 'operater添加名为32的服务信息', '2020-09-02 11:06:28', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6146', 'operater', 'operater添加名为33的服务信息', '2020-09-02 11:06:32', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6147', 'operater', '获取所有的一级目录信息', '2020-09-02 11:06:34', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6148', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 11:06:43', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6149', 'operater', 'operater添加名为34的服务信息', '2020-09-02 11:06:55', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6150', 'operater', '获取所有的一级目录信息', '2020-09-02 11:06:56', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6151', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 11:07:02', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6152', 'operater', 'operater添加名为35的服务信息', '2020-09-02 11:07:12', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6153', 'operater', '获取所有的一级目录信息', '2020-09-02 11:07:14', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6154', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 11:07:22', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6155', 'operater', 'operater添加名为36的服务信息', '2020-09-02 11:07:33', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6156', 'operater', '获取所有的一级目录信息', '2020-09-02 11:07:36', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6157', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 11:07:42', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6158', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 11:07:48', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6159', 'operater', 'operater添加名为37的服务信息', '2020-09-02 11:07:57', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6160', 'operater', '获取所有的一级目录信息', '2020-09-02 11:08:21', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6161', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 11:08:42', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6162', 'operater', 'operater添加名为38的服务信息', '2020-09-02 11:08:51', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6163', 'operater', '获取所有的一级目录信息', '2020-09-02 11:08:54', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6164', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 11:09:01', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6165', 'operater', 'operater添加名为39的服务信息', '2020-09-02 11:09:09', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6166', 'operater', '获取所有的一级目录信息', '2020-09-02 11:09:11', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6167', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 11:09:17', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6168', 'operater', 'operater添加名为40的服务信息', '2020-09-02 11:09:26', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6169', 'operater', '获取所有的一级目录信息', '2020-09-02 11:09:28', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6170', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 11:10:08', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6171', 'operater', 'operater添加名为41的服务信息', '2020-09-02 11:10:13', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6172', 'operater', '退出登录系统', '2020-09-02 11:13:09', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6173', '匿名用户', '进入登录页面', '2020-09-02 11:13:11', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6174', 'auditer', '登录系统', '2020-09-02 11:13:14', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6175', 'auditer', '查看服务分类信息', '2020-09-02 11:13:15', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6176', 'auditer', '查看服务分类信息', '2020-09-02 11:13:19', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6177', 'auditer', '查看服务分类信息', '2020-09-02 11:13:25', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6178', 'auditer', '查看服务分类信息', '2020-09-02 11:13:34', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6179', 'auditer', '查看服务分类信息', '2020-09-02 11:14:42', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6180', 'auditer', '查看服务分类信息', '2020-09-02 11:17:17', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6181', 'auditer', '查看服务分类信息', '2020-09-02 11:17:27', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6182', 'auditer', '退出登录系统', '2020-09-02 11:17:45', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6183', '匿名用户', '进入登录页面', '2020-09-02 11:17:47', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6184', 'customer', '登录系统', '2020-09-02 11:17:51', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6189', '匿名用户', '进入登录页面', '2020-09-02 11:21:23', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6190', 'customer', '登录系统', '2020-09-02 11:21:25', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6191', 'customer', '申请订阅服务', '2020-09-02 11:21:30', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6192', 'customer', '申请订阅服务', '2020-09-02 11:21:33', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6193', 'customer', '申请订阅服务', '2020-09-02 11:21:36', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6194', 'customer', '申请订阅服务', '2020-09-02 11:21:39', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6195', 'customer', '申请订阅服务', '2020-09-02 11:21:41', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6196', 'customer', '退出登录系统', '2020-09-02 11:22:15', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6197', '匿名用户', '进入登录页面', '2020-09-02 11:22:17', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6198', 'auditer', '登录系统', '2020-09-02 11:22:31', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6199', 'auditer', '查看服务分类信息', '2020-09-02 11:22:31', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6200', 'auditer', '查看服务分类信息', '2020-09-02 11:22:36', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6201', 'auditer', '退出登录系统', '2020-09-02 11:23:14', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6202', '匿名用户', '进入登录页面', '2020-09-02 11:23:16', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6203', 'customer', '登录系统', '2020-09-02 11:23:19', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6204', '匿名用户', '进入登录页面', '2020-09-02 12:01:41', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6205', 'customer', '登录系统', '2020-09-02 12:01:45', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6206', 'customer', '登录系统', '2020-09-02 12:01:46', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6207', 'customer', '退出登录系统', '2020-09-02 12:02:21', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6208', '匿名用户', '进入登录页面', '2020-09-02 12:02:23', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6209', 'operater', '登录系统', '2020-09-02 12:02:28', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6210', 'operater', '查看服务分类信息', '2020-09-02 12:02:29', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6211', '匿名用户', '进入登录页面', '2020-09-02 12:15:01', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6212', 'operater', '登录系统', '2020-09-02 12:15:07', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6213', 'operater', '查看服务分类信息', '2020-09-02 12:15:07', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6214', '匿名用户', '退出登录系统', '2020-09-02 13:22:35', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6215', '匿名用户', '退出登录系统', '2020-09-02 13:22:37', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6216', '匿名用户', '进入登录页面', '2020-09-02 13:23:14', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6217', 'customer', '登录系统', '2020-09-02 13:23:18', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6218', 'customer', '退出登录系统', '2020-09-02 13:23:23', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6219', '匿名用户', '进入登录页面', '2020-09-02 13:23:25', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6220', 'customer2', '登录系统', '2020-09-02 13:23:28', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6221', 'customer2', '申请订阅服务', '2020-09-02 13:23:31', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6222', 'customer2', '申请订阅服务', '2020-09-02 13:23:33', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6223', 'customer2', '申请订阅服务', '2020-09-02 13:23:35', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6224', 'customer2', '申请订阅服务', '2020-09-02 13:23:38', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6225', 'customer2', '申请订阅服务', '2020-09-02 13:23:40', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6226', 'customer2', '退出登录系统', '2020-09-02 13:23:42', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6227', '匿名用户', '进入登录页面', '2020-09-02 13:23:44', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6228', 'customer3', '登录系统', '2020-09-02 13:23:46', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6229', 'customer3', '申请订阅服务', '2020-09-02 13:23:50', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6230', 'customer3', '申请订阅服务', '2020-09-02 13:23:52', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6231', 'customer3', '申请订阅服务', '2020-09-02 13:23:54', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6232', 'customer3', '申请订阅服务', '2020-09-02 13:23:56', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6233', 'customer3', '申请订阅服务', '2020-09-02 13:23:58', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6234', 'customer3', '退出登录系统', '2020-09-02 13:24:00', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6235', '匿名用户', '进入登录页面', '2020-09-02 13:24:02', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6236', 'auditer', '登录系统', '2020-09-02 13:24:06', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6237', 'auditer', '查看服务分类信息', '2020-09-02 13:24:06', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6238', 'auditer', '查看服务分类信息', '2020-09-02 13:24:08', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6239', 'auditer', '审核服务订阅申请', '2020-09-02 13:24:23', null);
INSERT INTO `log_info` VALUES ('6240', 'auditer', '审核服务订阅申请', '2020-09-02 13:24:31', null);
INSERT INTO `log_info` VALUES ('6241', 'auditer', '审核服务订阅申请', '2020-09-02 13:24:36', null);
INSERT INTO `log_info` VALUES ('6244', 'auditer', '查看服务分类信息', '2020-09-02 13:26:16', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6254', 'auditer', '查看服务分类信息', '2020-09-02 13:27:41', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6256', '匿名用户', '进入登录页面', '2020-09-02 13:30:44', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6257', 'auditer', '登录系统', '2020-09-02 13:30:47', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6258', 'auditer', '查看服务分类信息', '2020-09-02 13:30:47', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6259', 'auditer', '审核服务订阅申请', '2020-09-02 13:30:54', null);
INSERT INTO `log_info` VALUES ('6260', 'auditer', '退出登录系统', '2020-09-02 13:31:17', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6261', '匿名用户', '进入登录页面', '2020-09-02 13:31:19', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6262', 'auditer', '登录系统', '2020-09-02 13:31:21', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6263', 'auditer', '查看服务分类信息', '2020-09-02 13:31:21', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6264', 'auditer', '审核服务订阅申请', '2020-09-02 13:31:28', null);
INSERT INTO `log_info` VALUES ('6265', '匿名用户', '进入登录页面', '2020-09-02 13:32:26', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6266', 'auditer', '登录系统', '2020-09-02 13:32:28', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6267', 'auditer', '查看服务分类信息', '2020-09-02 13:32:28', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6268', 'auditer', '审核服务订阅申请', '2020-09-02 13:32:35', null);
INSERT INTO `log_info` VALUES ('6269', '匿名用户', '进入登录页面', '2020-09-02 13:33:37', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6270', 'auditer', '登录系统', '2020-09-02 13:33:38', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6271', 'auditer', '查看服务分类信息', '2020-09-02 13:33:39', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6272', 'auditer', '审核服务订阅申请', '2020-09-02 13:33:46', null);
INSERT INTO `log_info` VALUES ('6273', 'auditer', '登录系统', '2020-09-02 13:34:03', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6274', 'auditer', '查看服务分类信息', '2020-09-02 13:34:03', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6278', 'auditer', '退出登录系统', '2020-09-02 13:34:11', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6279', '匿名用户', '进入登录页面', '2020-09-02 13:34:15', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6280', 'auditer', '登录系统', '2020-09-02 13:34:17', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6281', 'auditer', '查看服务分类信息', '2020-09-02 13:34:17', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6289', 'auditer', '登录系统', '2020-09-02 13:35:30', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6290', 'auditer', '查看服务分类信息', '2020-09-02 13:35:32', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6292', '匿名用户', '进入登录页面', '2020-09-02 13:38:29', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6293', 'auditer', '登录系统', '2020-09-02 13:38:31', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6294', 'auditer', '查看服务分类信息', '2020-09-02 13:38:31', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6295', 'auditer', '审核服务订阅申请', '2020-09-02 13:38:36', null);
INSERT INTO `log_info` VALUES ('6296', 'auditer', '审核服务订阅申请', '2020-09-02 13:38:40', null);
INSERT INTO `log_info` VALUES ('6300', 'auditer', '审核服务订阅申请', '2020-09-02 13:38:55', null);
INSERT INTO `log_info` VALUES ('6301', 'auditer', '审核服务订阅申请', '2020-09-02 13:39:00', null);
INSERT INTO `log_info` VALUES ('6302', 'auditer', '审核服务订阅申请', '2020-09-02 13:39:04', null);
INSERT INTO `log_info` VALUES ('6304', 'auditer', '审核服务订阅申请', '2020-09-02 13:39:55', null);
INSERT INTO `log_info` VALUES ('6305', 'auditer', '审核服务订阅申请', '2020-09-02 13:39:59', null);
INSERT INTO `log_info` VALUES ('6306', 'auditer', '审核服务订阅申请', '2020-09-02 13:40:03', null);
INSERT INTO `log_info` VALUES ('6307', 'auditer', '审核服务订阅申请', '2020-09-02 13:40:06', null);
INSERT INTO `log_info` VALUES ('6308', 'auditer', '审核服务订阅申请', '2020-09-02 13:40:09', null);
INSERT INTO `log_info` VALUES ('6309', 'auditer', '审核服务订阅申请', '2020-09-02 13:40:13', null);
INSERT INTO `log_info` VALUES ('6310', 'auditer', '审核服务订阅申请', '2020-09-02 13:40:16', null);
INSERT INTO `log_info` VALUES ('6312', '匿名用户', '进入登录页面', '2020-09-02 13:47:25', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6313', 'auditer', '登录系统', '2020-09-02 13:47:32', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6314', 'auditer', '查看服务分类信息', '2020-09-02 13:47:32', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6315', 'auditer', '退出登录系统', '2020-09-02 13:47:44', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6316', '匿名用户', '进入登录页面', '2020-09-02 13:47:46', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6317', 'customer2', '登录系统', '2020-09-02 13:47:53', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6318', 'customer2', '退出登录系统', '2020-09-02 13:48:13', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6319', '匿名用户', '进入登录页面', '2020-09-02 13:48:15', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6320', 'customer3', '登录系统', '2020-09-02 13:48:22', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6321', '匿名用户', '进入登录页面', '2020-09-02 13:50:43', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6322', 'customer3', '登录系统', '2020-09-02 13:50:46', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6323', 'customer3', '申请订阅服务', '2020-09-02 13:50:50', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6324', 'customer3', '申请订阅服务', '2020-09-02 13:50:52', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6325', 'customer3', '申请订阅服务', '2020-09-02 13:50:55', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6326', 'customer3', '申请订阅服务', '2020-09-02 13:50:57', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6327', 'customer3', '申请订阅服务', '2020-09-02 13:50:59', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6328', 'customer3', '退出登录系统', '2020-09-02 13:51:01', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6329', '匿名用户', '进入登录页面', '2020-09-02 13:51:03', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6330', 'customer2', '登录系统', '2020-09-02 13:51:08', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6331', 'customer2', '申请订阅服务', '2020-09-02 13:51:13', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6332', 'customer2', '申请订阅服务', '2020-09-02 13:51:15', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6333', 'customer2', '申请订阅服务', '2020-09-02 13:51:17', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6334', 'customer2', '申请订阅服务', '2020-09-02 13:51:20', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6335', 'customer2', '申请订阅服务', '2020-09-02 13:51:22', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6336', 'customer2', '退出登录系统', '2020-09-02 13:51:25', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6337', '匿名用户', '进入登录页面', '2020-09-02 13:51:27', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6338', 'auditer', '登录系统', '2020-09-02 13:51:30', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6339', 'auditer', '查看服务分类信息', '2020-09-02 13:51:30', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6340', 'auditer', '审核服务订阅申请', '2020-09-02 13:51:36', null);
INSERT INTO `log_info` VALUES ('6341', 'auditer', '审核服务订阅申请', '2020-09-02 13:51:45', null);
INSERT INTO `log_info` VALUES ('6342', 'auditer', '审核服务订阅申请', '2020-09-02 13:51:50', null);
INSERT INTO `log_info` VALUES ('6343', 'auditer', '审核服务订阅申请', '2020-09-02 13:51:53', null);
INSERT INTO `log_info` VALUES ('6344', 'auditer', '审核服务订阅申请', '2020-09-02 13:51:59', null);
INSERT INTO `log_info` VALUES ('6345', 'auditer', '审核服务订阅申请', '2020-09-02 13:52:03', null);
INSERT INTO `log_info` VALUES ('6346', 'auditer', '审核服务订阅申请', '2020-09-02 13:52:07', null);
INSERT INTO `log_info` VALUES ('6347', 'auditer', '审核服务订阅申请', '2020-09-02 13:52:11', null);
INSERT INTO `log_info` VALUES ('6348', 'auditer', '审核服务订阅申请', '2020-09-02 13:52:14', null);
INSERT INTO `log_info` VALUES ('6349', 'auditer', '审核服务订阅申请', '2020-09-02 13:52:17', null);
INSERT INTO `log_info` VALUES ('6350', 'auditer', 'auditer获取服务信息', '2020-09-02 13:52:25', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6351', 'auditer', 'auditer获取服务信息', '2020-09-02 13:52:29', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6352', '匿名用户', '进入登录页面', '2020-09-02 14:03:01', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6353', 'auditer', '登录系统', '2020-09-02 14:03:03', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6354', 'auditer', '查看服务分类信息', '2020-09-02 14:03:04', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6355', 'auditer', '退出登录系统', '2020-09-02 14:03:06', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6356', '匿名用户', '进入登录页面', '2020-09-02 14:03:09', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6357', 'auditer', '登录系统', '2020-09-02 14:08:20', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6358', 'auditer', '查看服务分类信息', '2020-09-02 14:08:22', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6359', 'auditer', '退出登录系统', '2020-09-02 14:08:57', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6360', '匿名用户', '进入登录页面', '2020-09-02 14:09:00', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6361', 'customer2', '登录系统', '2020-09-02 14:09:06', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6362', 'customer2', '申请取消订阅服务', '2020-09-02 14:09:19', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6363', 'customer2', '申请取消订阅服务', '2020-09-02 14:09:22', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6364', 'customer2', '申请取消订阅服务', '2020-09-02 14:09:24', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6365', 'customer2', '申请取消订阅服务', '2020-09-02 14:09:27', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6366', 'customer2', '申请取消订阅服务', '2020-09-02 14:09:32', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6367', 'customer2', '退出登录系统', '2020-09-02 14:09:36', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6368', '匿名用户', '进入登录页面', '2020-09-02 14:09:38', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6369', 'customer3', '登录系统', '2020-09-02 14:09:42', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6370', 'customer3', '申请取消订阅服务', '2020-09-02 14:09:46', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6371', 'customer3', '申请取消订阅服务', '2020-09-02 14:09:49', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6372', 'customer3', '申请取消订阅服务', '2020-09-02 14:09:52', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6373', 'customer3', '申请取消订阅服务', '2020-09-02 14:09:54', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6374', 'customer3', '申请取消订阅服务', '2020-09-02 14:10:07', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6375', 'customer3', '退出登录系统', '2020-09-02 14:10:13', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6376', '匿名用户', '进入登录页面', '2020-09-02 14:10:14', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6377', 'auditer', '登录系统', '2020-09-02 14:10:18', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6378', 'auditer', '查看服务分类信息', '2020-09-02 14:10:18', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6379', 'auditer', '审核取消服务订阅申请', '2020-09-02 14:10:51', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6380', 'auditer', '审核取消服务订阅申请', '2020-09-02 14:10:54', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6381', 'auditer', '审核取消服务订阅申请', '2020-09-02 14:10:58', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6382', 'auditer', '审核取消服务订阅申请', '2020-09-02 14:11:00', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6383', 'auditer', '审核取消服务订阅申请', '2020-09-02 14:11:03', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6384', 'auditer', '审核取消服务订阅申请', '2020-09-02 14:11:06', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6385', 'auditer', '审核取消服务订阅申请', '2020-09-02 14:11:09', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6386', 'auditer', '审核取消服务订阅申请', '2020-09-02 14:11:11', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6387', 'auditer', '审核取消服务订阅申请', '2020-09-02 14:11:14', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6388', 'auditer', '审核取消服务订阅申请', '2020-09-02 14:11:17', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6389', 'auditer', '退出登录系统', '2020-09-02 14:11:41', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6390', '匿名用户', '进入登录页面', '2020-09-02 14:11:43', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6391', 'customer2', '登录系统', '2020-09-02 14:11:47', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6392', 'customer2', '申请订阅服务', '2020-09-02 14:11:53', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6393', 'customer2', '申请订阅服务', '2020-09-02 14:11:56', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6394', 'customer2', '申请订阅服务', '2020-09-02 14:11:58', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6395', 'customer2', '申请订阅服务', '2020-09-02 14:12:01', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6396', 'customer2', '申请订阅服务', '2020-09-02 14:12:03', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6397', 'customer2', '退出登录系统', '2020-09-02 14:12:56', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6398', '匿名用户', '进入登录页面', '2020-09-02 14:12:58', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6399', 'customer3', '登录系统', '2020-09-02 14:13:02', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6400', 'customer3', '申请订阅服务', '2020-09-02 14:13:08', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6401', 'customer3', '申请订阅服务', '2020-09-02 14:13:11', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6402', 'customer3', '申请订阅服务', '2020-09-02 14:13:14', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6403', 'customer3', '申请订阅服务', '2020-09-02 14:13:16', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6404', 'customer3', '申请订阅服务', '2020-09-02 14:13:18', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6405', 'customer3', '退出登录系统', '2020-09-02 14:13:23', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6406', '匿名用户', '进入登录页面', '2020-09-02 14:13:24', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6407', 'auditer', '登录系统', '2020-09-02 14:13:28', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6408', 'auditer', '查看服务分类信息', '2020-09-02 14:13:28', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6409', 'auditer', '审核服务订阅申请', '2020-09-02 14:13:33', null);
INSERT INTO `log_info` VALUES ('6410', 'auditer', '审核服务订阅申请', '2020-09-02 14:13:36', null);
INSERT INTO `log_info` VALUES ('6411', 'auditer', '审核服务订阅申请', '2020-09-02 14:13:39', null);
INSERT INTO `log_info` VALUES ('6412', 'auditer', '审核服务订阅申请', '2020-09-02 14:13:44', null);
INSERT INTO `log_info` VALUES ('6413', 'auditer', '审核服务订阅申请', '2020-09-02 14:13:47', null);
INSERT INTO `log_info` VALUES ('6414', 'auditer', '审核服务订阅申请', '2020-09-02 14:13:51', null);
INSERT INTO `log_info` VALUES ('6415', 'auditer', '审核服务订阅申请', '2020-09-02 14:13:53', null);
INSERT INTO `log_info` VALUES ('6416', 'auditer', '审核服务订阅申请', '2020-09-02 14:13:56', null);
INSERT INTO `log_info` VALUES ('6417', 'auditer', '审核服务订阅申请', '2020-09-02 14:13:59', null);
INSERT INTO `log_info` VALUES ('6418', 'auditer', '审核服务订阅申请', '2020-09-02 14:14:02', null);
INSERT INTO `log_info` VALUES ('6419', '匿名用户', '进入登录页面', '2020-09-02 14:31:23', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6420', '匿名用户', '进入登录页面', '2020-09-02 15:01:16', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6421', 'auditer', '登录系统', '2020-09-02 15:01:20', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6422', 'auditer', '查看服务分类信息', '2020-09-02 15:01:20', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6423', 'auditer', '退出登录系统', '2020-09-02 15:02:14', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6424', '匿名用户', '进入登录页面', '2020-09-02 15:03:54', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6425', 'auditer', '登录系统', '2020-09-02 15:03:57', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6426', 'auditer', '查看服务分类信息', '2020-09-02 15:03:57', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6427', 'auditer', '退出登录系统', '2020-09-02 15:04:17', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6428', '匿名用户', '进入登录页面', '2020-09-02 15:05:04', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6429', 'auditer', '登录系统', '2020-09-02 15:05:06', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6430', 'auditer', '查看服务分类信息', '2020-09-02 15:05:06', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6431', 'auditer', '查看服务分类信息', '2020-09-02 15:05:30', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6432', 'auditer', '查看服务分类信息', '2020-09-02 15:05:32', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6433', 'auditer', '查看服务分类信息', '2020-09-02 15:05:35', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6434', 'auditer', '查看服务分类信息', '2020-09-02 15:05:41', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6435', 'auditer', '查看服务分类信息', '2020-09-02 15:05:48', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6436', 'auditer', '查看服务分类信息', '2020-09-02 15:05:50', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6437', 'auditer', '查看服务分类信息', '2020-09-02 15:05:50', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6438', 'auditer', '退出登录系统', '2020-09-02 15:06:07', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6439', '匿名用户', '进入登录页面', '2020-09-02 15:06:09', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6440', 'operater', '登录系统', '2020-09-02 15:06:18', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6441', 'operater', '查看服务分类信息', '2020-09-02 15:06:18', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6442', 'operater', '获取所有的一级目录信息', '2020-09-02 15:06:21', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6443', 'operater', '获取所有的一级目录信息', '2020-09-02 15:07:34', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6444', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 15:07:48', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6445', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 15:07:53', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6446', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 15:08:16', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6447', 'operater', '根据ID获取所有的二级目录信息', '2020-09-02 15:08:21', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6448', 'operater', '退出登录系统', '2020-09-02 15:09:30', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6449', '匿名用户', '进入登录页面', '2020-09-02 15:09:32', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6450', 'admin', '登录系统', '2020-09-02 15:09:36', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6451', 'admin', 'admin获取服务信息', '2020-09-02 15:12:03', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6452', 'admin', 'admin获取服务信息', '2020-09-02 15:12:05', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6453', 'admin', 'admin获取服务信息', '2020-09-02 15:12:06', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6454', 'admin', 'admin获取服务信息', '2020-09-02 15:14:49', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6455', 'admin', 'admin获取服务信息', '2020-09-02 15:18:03', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6456', 'admin', 'admin获取服务信息', '2020-09-02 15:18:04', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6457', 'admin', 'admin获取服务信息', '2020-09-02 15:18:04', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6458', 'admin', 'admin获取服务信息', '2020-09-02 15:18:04', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6459', 'admin', '退出登录系统', '2020-09-02 15:18:09', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6460', '匿名用户', '进入登录页面', '2020-09-02 15:18:11', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6461', 'admin', '登录系统', '2020-09-02 15:18:13', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6462', 'admin', '退出登录系统', '2020-09-02 15:18:27', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6463', '匿名用户', '进入登录页面', '2020-09-02 15:18:30', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6464', 'admin', '登录系统', '2020-09-02 15:18:32', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6465', 'admin', 'admin获取服务信息', '2020-09-02 15:18:42', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6466', 'admin', 'admin获取服务信息', '2020-09-02 15:18:44', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6467', 'admin', 'admin获取服务信息', '2020-09-02 15:19:08', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6468', '匿名用户', '进入登录页面', '2020-09-02 15:27:06', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6469', 'auditer', '登录系统', '2020-09-02 15:27:12', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6470', 'auditer', '查看服务分类信息', '2020-09-02 15:27:12', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6471', 'auditer', 'auditer获取服务信息', '2020-09-02 15:27:16', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6472', '匿名用户', '进入登录页面', '2020-09-02 15:28:51', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6473', 'auditer', '登录系统', '2020-09-02 15:28:53', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6474', 'auditer', '查看服务分类信息', '2020-09-02 15:28:54', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6475', 'auditer', 'auditer获取服务信息', '2020-09-02 15:28:56', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6476', '匿名用户', '进入登录页面', '2020-09-02 15:29:51', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6477', 'auditer', '登录系统', '2020-09-02 15:29:53', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6478', 'auditer', '查看服务分类信息', '2020-09-02 15:29:53', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6479', 'auditer', 'auditer获取服务信息', '2020-09-02 15:29:56', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6480', 'auditer', '登录系统', '2020-09-02 15:31:49', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6481', 'auditer', '查看服务分类信息', '2020-09-02 15:31:50', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6482', 'auditer', 'auditer获取服务信息', '2020-09-02 15:31:53', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6483', 'auditer', '登录系统', '2020-09-02 15:33:39', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6484', 'auditer', '查看服务分类信息', '2020-09-02 15:33:40', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6485', 'auditer', 'auditer获取服务信息', '2020-09-02 15:33:43', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6486', 'auditer', 'auditer获取服务信息', '2020-09-02 15:33:44', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6487', 'auditer', 'auditer获取服务信息', '2020-09-02 15:33:45', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6488', 'auditer', 'auditer获取服务信息', '2020-09-02 15:33:45', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6489', 'auditer', '登录系统', '2020-09-02 15:34:41', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6490', 'auditer', '查看服务分类信息', '2020-09-02 15:34:41', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6491', 'auditer', 'auditer获取服务信息', '2020-09-02 15:34:45', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6492', 'auditer', 'auditer获取服务信息', '2020-09-02 15:34:46', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6493', 'auditer', '登录系统', '2020-09-02 15:35:34', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6494', 'auditer', '查看服务分类信息', '2020-09-02 15:35:34', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6495', 'auditer', 'auditer获取服务信息', '2020-09-02 15:35:40', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6496', 'auditer', 'auditer获取服务信息', '2020-09-02 15:35:43', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6497', 'auditer', '登录系统', '2020-09-02 15:36:09', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6498', 'auditer', '查看服务分类信息', '2020-09-02 15:36:09', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6499', 'auditer', 'auditer获取服务信息', '2020-09-02 15:36:12', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6500', 'auditer', 'auditer获取服务信息', '2020-09-02 15:37:20', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6501', 'auditer', 'auditer获取服务信息', '2020-09-02 15:37:24', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6502', 'auditer', '退出登录系统', '2020-09-02 15:42:18', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6503', '匿名用户', '进入登录页面', '2020-09-02 15:42:19', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6504', 'operater', '登录系统', '2020-09-02 15:42:26', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6505', 'operater', '查看服务分类信息', '2020-09-02 15:42:26', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6506', 'operater', '查看服务分类信息', '2020-09-02 15:46:44', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6507', '匿名用户', '进入登录页面', '2020-09-02 17:01:02', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6508', 'operater ', '登录系统', '2020-09-02 17:02:19', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6509', 'operater ', '查看服务分类信息', '2020-09-02 17:02:19', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6510', 'operater ', '查看服务分类信息', '2020-09-02 17:05:03', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6511', 'operater ', '获取所有的一级目录信息', '2020-09-02 17:05:05', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6512', 'operater ', '根据ID获取所有的二级目录信息', '2020-09-02 17:05:16', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6513', 'operater ', '查看服务分类信息', '2020-09-02 17:05:24', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6514', 'operater ', '获取所有的一级目录信息', '2020-09-02 17:05:32', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6515', 'operater ', '根据ID获取所有的二级目录信息', '2020-09-02 17:05:40', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6516', 'operater ', '根据ID获取所有的二级目录信息', '2020-09-02 17:05:41', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6517', 'operater ', 'operater 添加名为q的服务信息', '2020-09-02 17:06:03', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6518', 'operater ', '查看服务分类信息', '2020-09-02 17:18:23', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6519', 'operater ', '查看服务分类信息', '2020-09-02 17:21:53', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6520', 'operater ', 'operater 获取服务信息', '2020-09-02 17:26:50', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6521', 'operater ', '获取所有的一级目录信息', '2020-09-02 17:43:49', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6522', 'operater ', '获取所有的一级目录信息', '2020-09-02 17:43:53', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6523', 'operater ', '根据ID获取所有的二级目录信息', '2020-09-02 17:43:54', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6524', 'operater ', '根据ID获取所有的二级目录信息', '2020-09-02 17:44:06', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6525', 'operater ', '根据ID获取所有的二级目录信息', '2020-09-02 17:44:10', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6526', 'operater ', '根据ID获取所有的二级目录信息', '2020-09-02 17:45:42', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6527', '匿名用户', '进入登录页面', '2020-09-03 07:49:23', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6528', 'operater', '登录系统', '2020-09-03 07:49:38', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6529', 'operater', '查看服务分类信息', '2020-09-03 07:49:38', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6530', 'operater', '获取所有的一级目录信息', '2020-09-03 07:49:43', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6531', 'operater', 'operater获取服务信息', '2020-09-03 07:51:22', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6532', 'operater', 'operater获取服务信息', '2020-09-03 07:51:42', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6533', 'operater', 'operater获取服务信息', '2020-09-03 07:51:46', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6534', 'operater', 'operater获取服务信息', '2020-09-03 07:51:50', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6535', 'operater', '查看服务分类信息', '2020-09-03 07:51:57', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6536', 'operater', 'operater获取服务信息', '2020-09-03 07:52:13', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6537', '匿名用户', '获取服务信息', '2020-09-03 08:17:23', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6538', '匿名用户', '获取服务信息', '2020-09-03 10:55:34', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6539', '匿名用户', '获取服务信息', '2020-09-03 10:55:37', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6540', '匿名用户', '进入登录页面', '2020-09-03 13:30:48', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6541', 'operater', '登录系统', '2020-09-03 13:30:56', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6542', 'operater', '查看服务分类信息', '2020-09-03 13:30:56', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6543', 'operater', '获取一级分类信息', '2020-09-03 13:31:01', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6544', 'operater', '创建服务分类信息', '2020-09-03 13:31:10', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6545', 'operater', '查看服务分类信息', '2020-09-03 13:31:10', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6546', 'operater', '查看服务分类信息', '2020-09-03 13:31:18', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6547', 'operater', '提交审核服务分类信息', '2020-09-03 13:31:23', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6548', 'operater', '查看服务分类信息', '2020-09-03 13:31:24', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6549', 'operater', '退出登录系统', '2020-09-03 13:31:25', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6550', '匿名用户', '进入登录页面', '2020-09-03 13:31:27', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6551', 'auditer', '登录系统', '2020-09-03 13:31:35', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6552', 'auditer', '查看服务分类信息', '2020-09-03 13:31:35', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6553', 'auditer', '获取id为103服务分类信息', '2020-09-03 13:31:37', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6554', 'auditer', '更新id为103服务分类信息', '2020-09-03 13:31:39', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6555', 'auditer', '查看服务分类信息', '2020-09-03 13:31:40', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6556', 'auditer', '查看服务分类信息', '2020-09-03 13:31:43', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6557', 'auditer', '获取id为103服务分类信息', '2020-09-03 13:31:48', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6558', '匿名用户', '进入登录页面', '2020-09-03 14:48:21', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6559', 'auditer', '登录系统', '2020-09-03 14:48:48', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6560', 'auditer', '查看服务分类信息', '2020-09-03 14:48:49', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6561', 'auditer', '查看服务分类信息', '2020-09-03 14:48:52', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6562', 'auditer', '查看服务分类信息', '2020-09-03 14:48:58', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6563', 'auditer', '查看服务分类信息', '2020-09-03 14:49:04', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6564', '匿名用户', '进入登录页面', '2020-09-06 19:02:39', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6565', '匿名用户', '登录系统', '2020-09-06 19:02:44', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6566', '匿名用户', '登录系统', '2020-09-06 19:05:00', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6567', '匿名用户', '登录系统', '2020-09-06 19:05:07', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6568', '匿名用户', '登录系统', '2020-09-06 19:05:14', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6569', 'admin', '登录系统', '2020-09-06 19:05:30', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6570', '匿名用户', '进入登录页面', '2020-09-11 22:21:41', '0:0:0:0:0:0:0:1');
INSERT INTO `log_info` VALUES ('6571', '匿名用户', '退出登录系统', '2020-09-11 22:22:02', '0:0:0:0:0:0:0:1');

-- ----------------------------
-- Table structure for `notice`
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `release_time` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES ('1', '维护公告', '8月31日晚上22:00至24:00之间进行系统升级维护，增加新功能，敬请期待！', '2020-08-31 21:17:13');

-- ----------------------------
-- Table structure for `service_audit`
-- ----------------------------
DROP TABLE IF EXISTS `service_audit`;
CREATE TABLE `service_audit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `service_id` int(11) DEFAULT NULL,
  `type` int(255) DEFAULT NULL COMMENT '审核类型 1：发布挂载审核 2：作废服务审核 3 服务卸载审核',
  `reason` varchar(255) DEFAULT NULL COMMENT '拒绝理由',
  `audit_time` varchar(255) DEFAULT NULL COMMENT '审核时间',
  `result` int(11) DEFAULT NULL COMMENT '1:同意  2:拒绝',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of service_audit
-- ----------------------------
INSERT INTO `service_audit` VALUES ('69', '46', '1', '', '2020-09-02 11:14:04', '1');
INSERT INTO `service_audit` VALUES ('70', '47', '1', '', '2020-09-02 11:14:08', '1');
INSERT INTO `service_audit` VALUES ('71', '48', '1', '', '2020-09-02 11:14:19', '1');
INSERT INTO `service_audit` VALUES ('72', '49', '1', '', '2020-09-02 11:14:23', '1');
INSERT INTO `service_audit` VALUES ('73', '50', '1', '', '2020-09-02 11:14:28', '1');
INSERT INTO `service_audit` VALUES ('74', '51', '1', '', '2020-09-02 11:14:37', '1');
INSERT INTO `service_audit` VALUES ('75', '52', '1', '', '2020-09-02 11:14:50', '1');
INSERT INTO `service_audit` VALUES ('76', '53', '1', '', '2020-09-02 11:14:55', '1');
INSERT INTO `service_audit` VALUES ('77', '54', '1', '', '2020-09-02 11:14:58', '1');
INSERT INTO `service_audit` VALUES ('78', '55', '1', '', '2020-09-02 11:15:02', '1');
INSERT INTO `service_audit` VALUES ('79', '56', '1', '', '2020-09-02 11:15:06', '1');
INSERT INTO `service_audit` VALUES ('80', '57', '1', '12', '2020-09-02 11:15:12', '2');
INSERT INTO `service_audit` VALUES ('81', '58', '1', '', '2020-09-02 11:15:15', '1');
INSERT INTO `service_audit` VALUES ('82', '59', '1', '', '2020-09-02 11:15:22', '1');
INSERT INTO `service_audit` VALUES ('83', '60', '1', '', '2020-09-02 11:15:26', '1');
INSERT INTO `service_audit` VALUES ('84', '61', '1', '', '2020-09-02 11:15:30', '1');
INSERT INTO `service_audit` VALUES ('85', '62', '1', '', '2020-09-02 11:15:34', '1');
INSERT INTO `service_audit` VALUES ('86', '63', '1', '', '2020-09-02 11:15:38', '1');
INSERT INTO `service_audit` VALUES ('87', '64', '1', '', '2020-09-02 11:15:41', '1');
INSERT INTO `service_audit` VALUES ('88', '65', '1', '', '2020-09-02 11:15:44', '1');
INSERT INTO `service_audit` VALUES ('89', '66', '1', '', '2020-09-02 11:15:47', '1');
INSERT INTO `service_audit` VALUES ('90', '67', '1', '', '2020-09-02 11:15:51', '1');
INSERT INTO `service_audit` VALUES ('91', '68', '1', '', '2020-09-02 11:15:54', '1');
INSERT INTO `service_audit` VALUES ('92', '69', '1', '24', '2020-09-02 11:16:01', '2');
INSERT INTO `service_audit` VALUES ('93', '70', '1', '25', '2020-09-02 11:16:07', '2');
INSERT INTO `service_audit` VALUES ('94', '71', '1', '', '2020-09-02 11:16:11', '1');
INSERT INTO `service_audit` VALUES ('95', '72', '1', '', '2020-09-02 11:16:16', '1');
INSERT INTO `service_audit` VALUES ('96', '73', '1', '', '2020-09-02 11:16:20', '1');
INSERT INTO `service_audit` VALUES ('97', '74', '1', '29', '2020-09-02 11:16:27', '2');
INSERT INTO `service_audit` VALUES ('98', '75', '1', '', '2020-09-02 11:16:33', '1');
INSERT INTO `service_audit` VALUES ('99', '76', '1', '', '2020-09-02 11:22:42', '1');
INSERT INTO `service_audit` VALUES ('100', '77', '1', '', '2020-09-02 11:22:46', '1');
INSERT INTO `service_audit` VALUES ('101', '78', '1', '', '2020-09-02 11:16:37', '1');
INSERT INTO `service_audit` VALUES ('102', '79', '1', '', '2020-09-02 11:22:49', '1');
INSERT INTO `service_audit` VALUES ('103', '80', '1', '', '2020-09-02 11:22:52', '1');
INSERT INTO `service_audit` VALUES ('104', '81', '1', '', '2020-09-02 11:22:55', '1');
INSERT INTO `service_audit` VALUES ('105', '82', '1', '', '2020-09-02 11:22:59', '1');
INSERT INTO `service_audit` VALUES ('106', '83', '1', '', '2020-09-02 11:23:02', '1');
INSERT INTO `service_audit` VALUES ('107', '84', '1', '', '2020-09-02 11:23:05', '1');
INSERT INTO `service_audit` VALUES ('108', '85', '1', '', '2020-09-02 11:23:08', '1');
INSERT INTO `service_audit` VALUES ('109', '86', '1', '', '2020-09-02 11:23:12', '1');

-- ----------------------------
-- Table structure for `service_info`
-- ----------------------------
DROP TABLE IF EXISTS `service_info`;
CREATE TABLE `service_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `service_type` int(11) NOT NULL COMMENT '服务接口类别：1：RPC、2：SOAP、3：REST',
  `open_type` int(255) NOT NULL COMMENT '公开类型：1:公开 2：半公开 3：保密',
  `address` varchar(255) NOT NULL COMMENT '服务地址 http://192.168.1.2/getName?XXX=xxx',
  `version` varchar(255) NOT NULL COMMENT '版本',
  `status` int(11) DEFAULT NULL COMMENT '0:注册服务 1：提交发布审核 2：服务发布 3：发布审核未通过 4：申请作废 5：服务作废  6:作废未通过 7:申请服务卸载 8:卸载审核通过 9:卸载审核未通过',
  `category_id` int(11) DEFAULT NULL COMMENT '类别ID，外键',
  `create_time` varchar(255) DEFAULT NULL COMMENT '注册时间 yyyy-mm-dd hh:mm:ss',
  `mount_time` varchar(255) DEFAULT NULL COMMENT '发布时间 yyyy-mm-dd hh:mm:ss',
  `cancel_time` varchar(255) DEFAULT NULL COMMENT '作废时间 yyyy-mm-dd hh:mm:ss',
  `req_method` varchar(255) DEFAULT NULL COMMENT '请求方法 POST GET',
  `req_params` varchar(255) DEFAULT NULL,
  `res_params` varchar(255) DEFAULT NULL,
  `unmount_time` varchar(255) DEFAULT NULL,
  `protocol_type` varchar(255) DEFAULT NULL COMMENT '请求协议类型 ： HTTP以及HTTPS',
  `file_path` varchar(255) DEFAULT NULL COMMENT '接口文件路径',
  `file_name` varchar(255) DEFAULT NULL COMMENT '接口文件名称',
  `description` varchar(255) DEFAULT NULL COMMENT '功能描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of service_info
-- ----------------------------
INSERT INTO `service_info` VALUES ('46', '1信息新余', '7', '1', '1', '1', '2', '93', '2020-09-02 10:53:31', '2020-09-02 11:14:04', null, 'POST', '1,String,1;', '1,String,1;', null, '10', 'C:\\upload\\1599015212066.doc', '0720.doc', '1');
INSERT INTO `service_info` VALUES ('47', '2信息新余', '7', '3', '2', '2', '2', '93', '2020-09-02 10:53:55', '2020-09-02 11:14:08', null, 'POST', '2,String,2;', '2,String,2;', null, '10', 'C:\\upload\\1599015235212.doc', '0703.doc', '2');
INSERT INTO `service_info` VALUES ('48', '3信息新余', '7', '1', '33', '3', '2', '88', '2020-09-02 10:54:15', '2020-09-02 11:14:19', null, 'POST', '3,String,3;', '3,String,3;', null, '10', 'C:\\upload\\1599015255754.doc', '0725 后台.doc', '3');
INSERT INTO `service_info` VALUES ('49', '4信息', '7', '1', '4', '4', '2', '87', '2020-09-02 10:54:39', '2020-09-02 11:14:23', null, 'POST', '4,String,4;', '4,String,4;', null, '11', 'C:\\upload\\1599015279891.doc', '0730 fwgl.doc', '4');
INSERT INTO `service_info` VALUES ('50', '5信息新余', '8', '1', '139.9.222.252/jtwg', '5', '2', '94', '2020-09-02 10:55:34', '2020-09-02 11:14:28', null, 'POST', '5,String,5;', '5,String,5;', null, '10', 'C:\\upload\\1599015334450.doc', '0720.doc', '5');
INSERT INTO `service_info` VALUES ('51', '6信息', '8', '1', '6', '6', '2', '100', '2020-09-02 10:55:58', '2020-09-02 11:14:37', null, 'POST', '6,String,6;', '6,String,6;', null, '10', 'C:\\upload\\1599015358485.doc', '0730 fwgl.doc', '6');
INSERT INTO `service_info` VALUES ('52', '7信息', '7', '1', '7', '7', '2', '102', '2020-09-02 10:56:18', '2020-09-02 11:14:50', null, 'POST', '7,String,7;', '7,String,7;', null, '10', 'C:\\upload\\1599015378488.doc', '0730 fwgl.doc', '7');
INSERT INTO `service_info` VALUES ('53', '8信息新余', '7', '1', '8', '8', '2', '87', '2020-09-02 10:56:37', '2020-09-02 11:14:55', null, 'POST', '8,String,8;', '8,String,8;', null, '10', 'C:\\upload\\1599015397478.doc', '0730 fwgl.doc', '8');
INSERT INTO `service_info` VALUES ('54', '9新余', '8', '1', '9', '9', '2', '98', '2020-09-02 10:56:55', '2020-09-02 11:14:58', null, 'POST', '9,String,9;', '9,String,9;', null, '10', 'C:\\upload\\1599015415166.doc', '0725 后台.doc', '9');
INSERT INTO `service_info` VALUES ('55', '10新余', '8', '1', '10', '10', '2', '100', '2020-09-02 10:57:18', '2020-09-02 11:15:02', null, 'POST', '10,String,10;', '10,String,10;', null, '10', 'C:\\upload\\1599015438645.doc', '0720.doc', '10');
INSERT INTO `service_info` VALUES ('56', '11新余', '8', '1', '11', '11', '2', '102', '2020-09-02 10:57:45', '2020-09-02 11:15:06', null, 'POST', '11,String,11;', '11,String,11;', null, '10', 'C:\\upload\\1599015465334.doc', '0730 fwgl.doc', '11');
INSERT INTO `service_info` VALUES ('57', '12', '8', '1', '12', '12', '3', '98', '2020-09-02 10:58:09', null, null, 'POST', '12,String,12;', '12,String,12;', null, '11', 'C:\\upload\\1599015490042.doc', '0730 fwgl.doc', '12');
INSERT INTO `service_info` VALUES ('58', '13新余', '9', '3', '13', '13', '2', '97', '2020-09-02 10:58:29', '2020-09-02 11:15:15', null, 'POST', '13,String,13;', '13,String,13;', null, '11', 'C:\\upload\\1599015509590.doc', '0703.doc', '13');
INSERT INTO `service_info` VALUES ('59', '14', '9', '2', '14', '14', '2', '89', '2020-09-02 10:58:58', '2020-09-02 11:15:22', null, 'POST', '14,String,14;', '14,String,14;', null, '11', 'C:\\upload\\1599015538649.doc', '0720.doc', '14');
INSERT INTO `service_info` VALUES ('60', '15', '8', '1', '15', '15', '2', '91', '2020-09-02 10:59:25', '2020-09-02 11:15:26', null, 'POST', '15,String,15;', '15,String,15;', null, '11', 'C:\\upload\\1599015565714.doc', '0730 fwgl.doc', '15');
INSERT INTO `service_info` VALUES ('61', '16信息', '8', '1', '16', '16', '2', '90', '2020-09-02 10:59:43', '2020-09-02 11:15:30', null, 'POST', '16,String,16;', '16,String,16;', null, '11', 'C:\\upload\\1599015583180.doc', '0725 后台.doc', '16');
INSERT INTO `service_info` VALUES ('62', '17信息', '9', '1', '17', '17', '2', '91', '2020-09-02 11:00:04', '2020-09-02 11:15:34', null, 'POST', '17,String,17;', '17,String,71;', null, '11', 'C:\\upload\\1599015604677.doc', '0720.doc', '17');
INSERT INTO `service_info` VALUES ('63', '18信息', '8', '1', '18', '18', '2', '86', '2020-09-02 11:00:22', '2020-09-02 11:15:38', null, 'POST', '18,String,18;', '18,String,18;', null, '11', 'C:\\upload\\1599015623002.doc', '0725 后台.doc', '18');
INSERT INTO `service_info` VALUES ('64', '19信息', '8', '1', '19', '19', '2', '89', '2020-09-02 11:00:43', '2020-09-02 11:15:41', null, 'POST', '19,String,19;', '19,String,19;', null, '10', 'C:\\upload\\1599015643264.doc', '0725 后台.doc', '19');
INSERT INTO `service_info` VALUES ('65', '20新余', '8', '1', '20', '20', '2', '92', '2020-09-02 11:01:01', '2020-09-02 11:15:44', null, 'POST', '20,String,20;', '20,String,20;', null, '11', 'C:\\upload\\1599015661666.doc', '0725 后台.doc', '20');
INSERT INTO `service_info` VALUES ('66', '21新余', '9', '1', '21', '21', '2', '89', '2020-09-02 11:01:19', '2020-09-02 11:15:47', null, 'POST', '21,String,21;', '21,String,21;', null, '10', 'C:\\upload\\1599015679813.doc', '0703.doc', '21');
INSERT INTO `service_info` VALUES ('67', '22新余', '8', '1', '22', '22', '2', '99', '2020-09-02 11:01:49', '2020-09-02 11:15:51', null, 'POST', '22,String,22;', '22,String,22;', null, '10', 'C:\\upload\\1599015709678.doc', '0720.doc', '22');
INSERT INTO `service_info` VALUES ('68', '23新余', '8', '1', '23', '23', '2', '90', '2020-09-02 11:02:08', '2020-09-02 11:15:54', null, 'POST', '23,String,23;', '23,String,23;', null, '11', 'C:\\upload\\1599015728614.doc', '0725 后台.doc', '23');
INSERT INTO `service_info` VALUES ('69', '24', '9', '1', '24', '24', '3', '92', '2020-09-02 11:03:20', null, null, 'POST', '24,String,24;', '24,String,24;', null, '10', 'C:\\upload\\1599015801058.doc', '0703.doc', '24');
INSERT INTO `service_info` VALUES ('70', '25新余', '8', '1', '25', '25', '3', '98', '2020-09-02 11:03:40', null, null, 'POST', '25,String,25;', '25,String,25;', null, '11', 'C:\\upload\\1599015820133.doc', '0725 后台.doc', '25');
INSERT INTO `service_info` VALUES ('71', '26', '8', '1', '26', '26', '2', '90', '2020-09-02 11:03:58', '2020-09-02 11:16:11', null, 'POST', '26,String,26;', '26,String,26;', null, '10', 'C:\\upload\\1599015839024.doc', '0725 后台.doc', '26');
INSERT INTO `service_info` VALUES ('72', '27新余', '8', '1', '27', '27', '2', '89', '2020-09-02 11:04:18', '2020-09-02 11:16:16', null, 'POST', '27,String,72;', '27,String,27;', null, '11', 'C:\\upload\\1599015858960.doc', '0725 后台.doc', '27');
INSERT INTO `service_info` VALUES ('73', '28', '7', '1', '28', '28', '2', '88', '2020-09-02 11:04:41', '2020-09-02 11:16:20', null, 'POST', '28,String,28;', '28,String,28;', null, '11', 'C:\\upload\\1599015881994.doc', '0720.doc', '28');
INSERT INTO `service_info` VALUES ('74', '29新余', '7', '1', '29', '29', '3', '91', '2020-09-02 11:05:01', null, null, 'POST', '29,String,29;', '29,String,29;', null, '11', 'C:\\upload\\1599015901904.doc', '0730 fwgl.doc', '29');
INSERT INTO `service_info` VALUES ('75', '30', '9', '1', '30', '30', '2', '102', '2020-09-02 11:05:28', '2020-09-02 11:16:33', null, 'POST', '30,String,30;', '30,String,30;', null, '11', 'C:\\upload\\1599015928795.doc', '0720.doc', '30');
INSERT INTO `service_info` VALUES ('76', '31新余', '8', '1', '31', '31', '2', '100', '2020-09-02 11:05:48', '2020-09-02 11:22:42', null, 'POST', '31,String,31;', '31,String,31;', null, '10', 'C:\\upload\\1599015948707.doc', '0720.doc', '31');
INSERT INTO `service_info` VALUES ('77', '32新余', '9', '1', '32', '32', '2', '90', '2020-09-02 11:06:06', '2020-09-02 11:22:46', null, 'POST', '32,String,32;', '32,String,32;', null, '11', 'C:\\upload\\1599015967105.doc', '0720.doc', '32');
INSERT INTO `service_info` VALUES ('78', '33新余', '7', '1', '33', '33', '2', '87', '2020-09-02 11:06:32', '2020-09-02 11:16:37', null, 'POST', '333,String,33;', '33,String,33;', null, '10', 'C:\\upload\\1599015992188.doc', '0725 后台.doc', '33');
INSERT INTO `service_info` VALUES ('79', '34新余', '9', '1', '34', '34', '2', '89', '2020-09-02 11:06:55', '2020-09-02 11:22:49', null, 'POST', '34,String,34;', '34,String,34;', null, '10', 'C:\\upload\\1599016015279.doc', '0720.doc', '34');
INSERT INTO `service_info` VALUES ('80', '35新余', '8', '1', '35', '35', '2', '102', '2020-09-02 11:07:12', '2020-09-02 11:22:52', null, 'POST', '35,String,35;', '35,String,35;', null, '11', 'C:\\upload\\1599016032228.doc', '0720.doc', '35');
INSERT INTO `service_info` VALUES ('81', '36新余', '8', '1', '36', '36', '2', '88', '2020-09-02 11:07:33', '2020-09-02 11:22:55', null, 'POST', '36,String,36;', '36,String,36;', null, '11', 'C:\\upload\\1599016054006.doc', '0730 fwgl.doc', '36');
INSERT INTO `service_info` VALUES ('82', '37', '8', '1', '37', '37', '2', '89', '2020-09-02 11:07:57', '2020-09-02 11:22:59', null, 'POST', '37,String,73;', '37,String,37;', null, '11', 'C:\\upload\\1599016077541.doc', '0720.doc', '37');
INSERT INTO `service_info` VALUES ('83', '38', '9', '1', '38', '38', '2', '86', '2020-09-02 11:08:51', '2020-09-02 11:23:02', null, 'POST', '38,String,38;', '38,String,38;', null, '11', 'C:\\upload\\1599016131949.doc', '0725 后台.doc', '38');
INSERT INTO `service_info` VALUES ('84', '39新余', '8', '1', '39', '39', '2', '98', '2020-09-02 11:09:09', '2020-09-02 11:23:05', null, 'POST', '39,String,39;', '39,String,93;', null, '10', 'C:\\upload\\1599016149897.doc', '0703.doc', '39');
INSERT INTO `service_info` VALUES ('85', '40', '8', '1', '40', '40', '2', '89', '2020-09-02 11:09:26', '2020-09-02 11:23:08', null, 'POST', '40,String,40;', '40,String,40;', null, '11', 'C:\\upload\\1599016166883.doc', '0730 fwgl.doc', '40');
INSERT INTO `service_info` VALUES ('86', '41', '7', '1', '41', '41', '2', '92', '2020-09-02 11:10:13', '2020-09-02 11:23:12', null, 'POST', '41,String,41;', '41,String,41;', null, '10', 'C:\\upload\\1599016213750.doc', '0703.doc', '41');
INSERT INTO `service_info` VALUES ('87', 'q', '7', '1', 'q', 'w', '0', '87', '2020-09-02 17:06:03', null, null, 'POST', 'w,String,w;', 'w,String,w;', null, '10', 'C:\\upload\\1599037563394.docx', '普惠金融平台服务目录管理系统需求分析.docx', 'w');

-- ----------------------------
-- Table structure for `subscribe`
-- ----------------------------
DROP TABLE IF EXISTS `subscribe`;
CREATE TABLE `subscribe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `service_id` int(11) DEFAULT NULL,
  `subscriber` varchar(255) DEFAULT NULL,
  `status` int(255) DEFAULT NULL COMMENT '1:申请订阅 2:订阅成功 3:订阅失败 4:申请取消订阅 5：取消订阅成功 6：取消订阅失败',
  `apply_time` varchar(255) DEFAULT NULL COMMENT '申请订阅时间',
  `describe_time` varchar(255) DEFAULT NULL COMMENT '订阅时间',
  `cancel_time` varchar(255) DEFAULT NULL COMMENT '取消订阅时间',
  `trans_medium` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of subscribe
-- ----------------------------

-- ----------------------------
-- Table structure for `subscribe_audit`
-- ----------------------------
DROP TABLE IF EXISTS `subscribe_audit`;
CREATE TABLE `subscribe_audit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subscribe_id` int(11) NOT NULL,
  `type` int(11) DEFAULT NULL COMMENT '1:申请订阅审核 2：取消订阅审核',
  `audit_time` varchar(255) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `result` int(4) NOT NULL COMMENT '1：同意 2：拒绝',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of subscribe_audit
-- ----------------------------

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', '123456', '1');
INSERT INTO `user` VALUES ('2', 'operator', '123456', '2');
INSERT INTO `user` VALUES ('3', 'auditer', '123456', '3');
INSERT INTO `user` VALUES ('4', 'yhyh', '123456', '4');
INSERT INTO `user` VALUES ('5', 'yhyh1', '123456', '4');

-- ----------------------------
-- View structure for `fullservice`
-- ----------------------------
DROP VIEW IF EXISTS `fullservice`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `fullservice` AS select `service_info`.`id` AS `id`,`service_info`.`name` AS `name`,`service_info`.`service_type` AS `serviceType`,`service_info`.`open_type` AS `openType`,`service_info`.`address` AS `address`,`service_info`.`version` AS `version`,`service_info`.`status` AS `status`,`service_info`.`create_time` AS `createTime`,`service_info`.`mount_time` AS `mountTime`,`service_info`.`cancel_time` AS `cancelTime`,`service_info`.`req_method` AS `reqMethod`,`service_info`.`req_params` AS `reqParams`,`service_info`.`res_params` AS `resParams`,`service_info`.`unmount_time` AS `unmountTime`,`service_info`.`protocol_type` AS `protocolType`,`service_info`.`file_path` AS `filePath`,`service_info`.`file_name` AS `fileName`,`service_info`.`description` AS `description`,`category`.`cname` AS `cname` from (`category` join `service_info`) where (`service_info`.`category_id` = `category`.`id`) group by `service_info`.`id` ;

-- ----------------------------
-- View structure for `service`
-- ----------------------------
DROP VIEW IF EXISTS `service`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `service` AS select `service_info`.`id` AS `id`,`service_info`.`name` AS `name`,`service_info`.`service_type` AS `serviceType`,`service_info`.`open_type` AS `openType`,`service_info`.`address` AS `address`,`service_info`.`version` AS `version`,`service_info`.`status` AS `serviceStatus`,`service_info`.`mount_time` AS `mountTime`,`subscribe`.`apply_time` AS `applyTime`,`service_info`.`category_id` AS `categoryId`,`service_info`.`create_time` AS `createTime`,`service_info`.`cancel_time` AS `cancelTime`,`service_info`.`req_method` AS `reqMethod`,`service_info`.`req_params` AS `reqParams`,`service_info`.`res_params` AS `resParams`,`service_info`.`unmount_time` AS `unmountTime`,`subscribe`.`service_id` AS `serviceId`,`subscribe`.`subscriber` AS `subscriber`,`subscribe`.`status` AS `subscribeStatus`,`category`.`cname` AS `cname` from ((`service_info` join `subscribe`) join `category`) where ((`service_info`.`id` = `subscribe`.`service_id`) and (`service_info`.`category_id` = `category`.`id`)) ;

-- ----------------------------
-- View structure for `test`
-- ----------------------------
DROP VIEW IF EXISTS `test`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `test` AS select `service_info`.`id` AS `id`,`service_info`.`name` AS `name`,`service_info`.`service_type` AS `serviceType`,`service_info`.`open_type` AS `openType`,`service_info`.`address` AS `address`,`service_info`.`version` AS `version`,`service_info`.`status` AS `status`,`service_info`.`create_time` AS `createTime`,`service_info`.`mount_time` AS `mountTime`,`service_info`.`cancel_time` AS `cancelTime`,`service_info`.`req_method` AS `reqMethod`,`service_info`.`req_params` AS `reqParams`,`service_info`.`res_params` AS `resParams`,`service_info`.`unmount_time` AS `unmountTime`,`service_info`.`protocol_type` AS `protocolType`,`service_info`.`file_path` AS `filePath`,`service_info`.`file_name` AS `fileName`,`service_info`.`description` AS `description`,`category`.`cname` AS `cname`,count(`subscribe`.`service_id`) AS `count` from ((`category` join `subscribe`) join `service_info`) where ((`subscribe`.`service_id` = `service_info`.`id`) and (`service_info`.`category_id` = `category`.`id`)) group by `service_info`.`id` ;

-- ----------------------------
-- View structure for `tongji2`
-- ----------------------------
DROP VIEW IF EXISTS `tongji2`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `tongji2` AS select `category`.`cname` AS `cname`,count(`service_info`.`id`) AS `count` from (`service_info` join `category`) where ((`service_info`.`category_id` = `category`.`id`) and (`service_info`.`status` in (2,7,9))) group by `category`.`cname` ;

-- ----------------------------
-- View structure for `tongji3`
-- ----------------------------
DROP VIEW IF EXISTS `tongji3`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `tongji3` AS select `category`.`id` AS `cid`,count(`subscribe`.`id`) AS `count` from ((`category` join `subscribe`) join `service_info`) where ((`category`.`id` = `service_info`.`category_id`) and (`service_info`.`id` = `subscribe`.`service_id`) and (`subscribe`.`status` in (2,4,6))) group by `category`.`id` ;
