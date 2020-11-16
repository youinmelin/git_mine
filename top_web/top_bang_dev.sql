/*
 Navicat Premium Data Transfer

 Source Server         : 域加内网测试
 Source Server Type    : MySQL
 Source Server Version : 50730
 Source Host           : 192.168.200.1:3306
 Source Schema         : top_bang_dev

 Target Server Type    : MySQL
 Target Server Version : 50730
 File Encoding         : 65001

 Date: 22/10/2020 14:41:21
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_menu
-- ----------------------------
DROP TABLE IF EXISTS `admin_menu`;
CREATE TABLE `admin_menu` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '父级ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '名称（与视图的文件夹名称和路由路径对应）',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '类型0菜单1按钮',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `description` varchar(500) NOT NULL DEFAULT '' COMMENT '描述',
  `route_icon` varchar(200) NOT NULL DEFAULT '' COMMENT '后台页面小图标',
  `route_url` varchar(500) NOT NULL DEFAULT '' COMMENT '后台页面路由',
  `request_url` varchar(500) NOT NULL DEFAULT '' COMMENT '接口请求url',
  `request_method` varchar(10) NOT NULL DEFAULT '' COMMENT '接口请求方式GET/POST/PUT/DELETE',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `spread` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '默认是否展开，仅二级目录有效',
  `level` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '当前层级（冗余）',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '逻辑删除标识',
  PRIMARY KEY (`id`),
  KEY `admin_menu_parent_id_index` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COMMENT='后台权限列表';

-- ----------------------------
-- Records of admin_menu
-- ----------------------------
BEGIN;
INSERT INTO `admin_menu` VALUES (1, 0, 'index', 0, '主页', '', 'layui-icon-home', '/', '/', 'GET', 0, 0, 0, '2019-02-28 16:19:10', '2019-02-28 16:19:10', 0);
INSERT INTO `admin_menu` VALUES (2, 0, 'adminuser', 0, '后台设置', '', 'layui-icon-username', 'adminuser', '/', 'GET', 98, 0, 0, '2019-02-28 16:20:58', '2019-02-28 16:20:58', 0);
INSERT INTO `admin_menu` VALUES (3, 0, 'druidMonitor', 0, '数据库监控', '', 'layui-icon-auz', '/iframe/link/druidMonitor', '/', 'GET', 99, 0, 0, '2019-02-28 16:25:51', '2019-02-28 16:25:51', 0);
INSERT INTO `admin_menu` VALUES (4, 13, 'user-list', 0, '网站用户', '', 'layui-icon-rate-half', '/user/user/list', '/', 'GET', 1, 0, 2, '2019-02-28 16:27:52', '2019-02-28 16:27:52', 0);
INSERT INTO `admin_menu` VALUES (5, 2, 'administrators-list', 0, '后台管理员', '', 'layui-icon-rate-half', '/adminuser/list', '/', 'GET', 2, 0, 2, '2019-02-28 16:30:31', '2019-02-28 16:30:31', 0);
INSERT INTO `admin_menu` VALUES (6, 2, 'administrators-menulist', 0, '权限菜单管理', '', 'layui-icon-rate-half', '/adminuser/menulist', '/', 'GET', 4, 0, 2, '2019-02-28 09:56:53', '2019-02-28 09:56:57', 1);
INSERT INTO `admin_menu` VALUES (7, 2, 'administrators-rule', 0, '角色管理', '', 'layui-icon-rate-half', '/adminuser/role', '/', 'GET', 3, 0, 0, '2019-02-28 18:02:00', '2019-02-28 18:02:00', 0);
INSERT INTO `admin_menu` VALUES (8, 2, 'administrators-adminroleform', 0, '用户权限菜单', '', 'layui-icon-rate-half', '/adminuser/adminroleform', '/', 'GET', 5, 0, 2, '2019-02-28 18:03:30', '2019-02-28 23:46:32', 1);
INSERT INTO `admin_menu` VALUES (10, 0, 'deal', 0, '交易管理', '', 'layui-icon-form', 'deal', '/', 'GET', 2, 0, 0, '2019-03-05 14:21:01', '2019-03-05 14:21:01', 1);
INSERT INTO `admin_menu` VALUES (11, 10, 'deal-list', 0, '交易列表', '', 'layui-icon-rate-half', '/deal/list', '/', 'GET', 0, 0, 2, '2019-03-05 17:17:15', '2019-03-05 17:17:15', 1);
INSERT INTO `admin_menu` VALUES (12, 10, 'deal-waitaudit-list', 0, '待审交易', '', 'layui-icon-rate-half', '/deal/waitauditlist', '/', 'GET', 1, 0, 2, '2019-03-06 15:03:19', '2019-03-06 15:03:19', 1);
INSERT INTO `admin_menu` VALUES (13, 0, 'user', 0, '网站用户', '', 'layui-icon-user', 'user', '/', 'GET', 3, 0, 0, '2019-03-07 17:05:15', '2019-03-07 17:05:15', 0);
INSERT INTO `admin_menu` VALUES (14, 13, 'user-vip-pay-record', 0, '用户VIP充值记录', '', 'layui-icon-rate-half', '/user/user/uservippayrecordlist', '/', 'GET', 3, 0, 2, '2019-03-07 17:07:54', '2019-03-07 17:07:54', 1);
INSERT INTO `admin_menu` VALUES (15, 13, 'user-card-list', 0, '实名审核', '', 'layui-icon-rate-half', '/user/user/cardlist', '/', 'GET', 4, 0, 2, '2019-03-07 19:14:49', '2019-03-07 19:14:49', 0);
INSERT INTO `admin_menu` VALUES (16, 10, 'deal-delay-audit', 0, '延期审批', '', 'layui-icon-rate-half', '/deal/delayauditlist', '/', 'GET', 2, 0, 2, '2019-03-07 19:23:01', '2019-03-07 19:23:01', 1);
INSERT INTO `admin_menu` VALUES (17, 10, 'domain-manage', 0, '域名管理', '', 'layui-icon-rate-half', '/deal/pledgelist', '/', 'GET', 5, 0, 2, '2019-03-07 19:23:37', '2019-03-07 19:23:37', 1);
INSERT INTO `admin_menu` VALUES (18, 0, 'post', 0, '文章管理', '', 'layui-icon-rate-half', 'post', '/', 'GET', 11, 0, 0, '2019-03-11 09:26:43', '2019-03-11 09:26:43', 0);
INSERT INTO `admin_menu` VALUES (19, 18, 'post-list', 0, '文章列表', '', 'layui-icon-rate-half', '/post/list', '/', 'GET', 1, 0, 2, '2019-03-11 09:27:23', '2019-03-11 09:27:23', 0);
INSERT INTO `admin_menu` VALUES (20, 13, 'user-bank-card-list', 0, '用户收款方式', '', 'layui-icon-rate-half', '/user/user/bankcardlist', '/', 'GET', 6, 0, 2, '2019-03-11 18:37:48', '2019-03-11 18:37:48', 1);
INSERT INTO `admin_menu` VALUES (21, 13, 'user-vip', 0, '用户VIP', '', 'layui-icon-rate-half', '/user/user/viplist', '/', 'GET', 2, 0, 2, '2019-03-11 18:59:51', '2019-03-11 18:59:51', 1);
INSERT INTO `admin_menu` VALUES (22, 0, 'commission', 0, '佣金管理', '', 'layui-icon-rmb', 'commission', '/', 'GET', 4, 0, 0, '2019-03-11 20:22:46', '2019-03-11 20:22:46', 1);
INSERT INTO `admin_menu` VALUES (23, 22, 'commission-list', 0, '佣金列表', '', 'layui-icon-rate-half', '/commission/list', '/', 'GET', 1, 0, 2, '2019-03-11 20:23:33', '2019-03-11 20:23:33', 0);
INSERT INTO `admin_menu` VALUES (24, 22, 'commission-record-list', 0, '佣金明细', '', 'layui-icon-rate-half', '/commission/recordlist', '/', 'GET', 2, 0, 2, '2019-03-11 20:24:13', '2019-03-11 20:24:13', 0);
INSERT INTO `admin_menu` VALUES (25, 22, 'commission-withdraw-list', 0, '佣金提现', '', 'layui-icon-rate-half', '/commission/withdrawlist', '/', 'GET', 3, 0, 2, '2019-03-11 20:25:07', '2019-03-11 20:25:07', 0);
INSERT INTO `admin_menu` VALUES (26, 22, 'commission-withdraw-record-list', 0, '佣金提现记录', '', 'layui-icon-rate-half', '/commission/withdrawrecordlist', '/', 'GET', 4, 0, 2, '2019-03-11 20:25:50', '2019-03-11 20:25:50', 0);
INSERT INTO `admin_menu` VALUES (27, 3, 'd', 0, 'd', 'd', 'layui-icon-rate-half', 'd', 'd', 'GET', 1, 0, 2, '2019-03-12 01:29:56', '2019-03-12 01:30:19', 1);
INSERT INTO `admin_menu` VALUES (28, 0, 'finance', 0, '财务管理', '', 'layui-icon-dollar', 'finance', '/', 'GET', 5, 0, 0, '2019-03-12 16:26:06', '2019-03-12 16:26:06', 1);
INSERT INTO `admin_menu` VALUES (29, 10, 'finance-list', 0, '财务列表', '', 'layui-icon-rate-half', '/finance/list', '/', 'GET', 1, 0, 2, '2019-03-12 16:31:20', '2019-03-12 16:31:20', 0);
INSERT INTO `admin_menu` VALUES (30, 0, 'notice', 0, '消息通知', '', 'layui-icon-notice', 'notice', '/', 'GET', 12, 0, 0, '2019-03-25 12:47:39', '2019-03-25 12:47:39', 0);
INSERT INTO `admin_menu` VALUES (31, 30, 'notice-list', 0, '消息列表', '', 'layui-icon-rate-half', '/notice/list', '/', 'GET', 1, 0, 2, '2019-03-25 12:49:00', '2019-03-25 12:49:00', 0);
INSERT INTO `admin_menu` VALUES (32, 30, 'notice-send', 0, '消息推送', '', 'layui-icon-rate-half', '/notice/send', '/', 'GET', 2, 0, 2, '2019-03-25 12:49:27', '2019-03-25 12:49:27', 0);
INSERT INTO `admin_menu` VALUES (33, 10, 'deal-order-list', 0, '订单管理', '', 'layui-icon-rate-half', '/deal/orderlist', '/', 'GET', 3, 0, 2, '2019-03-27 14:08:26', '2019-03-27 14:08:26', 0);
INSERT INTO `admin_menu` VALUES (34, 13, 'user-company-list', 0, '企业实名审核', '', 'layui-icon-rate-half', '/user/user/companylist', '/', 'GET', 5, 0, 2, '2019-03-29 14:12:23', '2019-03-29 14:12:23', 0);
INSERT INTO `admin_menu` VALUES (35, 13, 'user-auth-list', 0, '三方登录', '', 'layui-icon-rate-half', '/user/user/authlist', '/', 'GET', 7, 0, 2, '2019-04-03 14:24:27', '2019-04-03 14:24:27', 1);
INSERT INTO `admin_menu` VALUES (36, 10, 'deal-pnp-list', 0, '号码隐私保护', '', 'layui-icon-rate-half', '/deal/pnplist', '/', 'GET', 8, 0, 2, '2019-04-08 16:37:29', '2019-04-08 16:37:29', 1);
INSERT INTO `admin_menu` VALUES (37, 10, 'deal-appeal-list', 0, '申诉列表', '', 'layui-icon-rate-half', '/deal/appeallist', '/', 'GET', 7, 0, 2, '2019-04-22 15:35:15', '2019-04-22 15:35:15', 1);
INSERT INTO `admin_menu` VALUES (38, 10, 'within-7-days-list', 0, '7日内待回购', '', 'layui-icon-rate-half', '/deal/within7dayslist', '/', 'GET', 6, 0, 2, '2019-05-23 14:37:55', '2019-05-23 14:37:55', 1);
INSERT INTO `admin_menu` VALUES (39, 10, 'deal-wait-order-list', 0, '待审订单', '', 'layui-icon-rate-half', '/deal/waitorderlist', '/', 'GET', 4, 0, 2, '2019-03-27 14:08:26', '2019-03-27 14:08:26', 1);
INSERT INTO `admin_menu` VALUES (40, 2, 'set-system-publiconf', 0, '公排设置', '', 'layui-icon-rate-half', '/set/system/publiconf', '/', 'GET', 1, 0, 2, '2019-03-11 09:27:23', '2019-03-11 09:27:23', 0);
INSERT INTO `admin_menu` VALUES (41, 10, 'deal-product-list', 0, '产品管理', '', 'layui-icon-rate-half', '/deal/productlist', '/', 'GET', 3, 0, 2, '2019-03-27 14:08:26', '2019-03-27 14:08:26', 0);
INSERT INTO `admin_menu` VALUES (42, 2, 'set-system-paymethodconf', 0, '收款方式设置', '', 'layui-icon-rate-half', '/set/system/paymethodconf', '/', 'GET', 1, 0, 2, '2019-03-11 09:27:23', '2019-03-11 09:27:23', 0);
INSERT INTO `admin_menu` VALUES (43, 13, 'user-userlevel', 0, '用户层级', '', 'layui-icon-rate-half', '/user/user/userlevel', '/', 'GET', 1, 0, 2, '2019-02-28 16:27:52', '2019-02-28 16:27:52', 0);
INSERT INTO `admin_menu` VALUES (44, 10, 'bank-list', 0, '银行卡信息', '', 'layui-icon-rate-half', '/finance/banklist', '/', 'GET', 2, 0, 2, '2019-03-12 16:31:20', '2019-03-12 16:31:20', 0);
INSERT INTO `admin_menu` VALUES (45, 18, 'banner-list', 0, 'Banner列表', '', 'layui-icon-rate-half', '/article/bannerlist', '/', 'GET', 1, 0, 2, '2019-03-11 09:27:23', '2019-03-11 09:27:23', 1);
INSERT INTO `admin_menu` VALUES (46, 10, 'finance-settle-list', 0, '结算信息', '', 'layui-icon-rate-half', '/finance/settlelist', '/', 'GET', 9, 0, 2, '2019-03-12 16:31:20', '2019-03-12 16:31:20', 0);
INSERT INTO `admin_menu` VALUES (47, 0, 'banner', 0, '轮播图', '', 'layui-icon-carousel', 'banner', '/', 'GET', 2, 0, 1, '2019-03-16 16:46:37', '2019-03-16 16:46:37', 0);
INSERT INTO `admin_menu` VALUES (48, 47, 'banner-list', 0, '轮播图列表', '', 'layui-icon-rate-half', '/banner/list', '/', 'GET', 1, 0, 2, '2019-03-16 16:48:36', '2019-03-16 16:48:36', 0);
INSERT INTO `admin_menu` VALUES (49, 47, 'banner-group-list', 0, '轮播图分组', '', 'layui-icon-rate-half', '/banner/grouplist', '/', 'GET', 2, 0, 2, '2019-03-16 16:56:17', '2019-03-16 16:56:17', 0);
INSERT INTO `admin_menu` VALUES (50, 0, 'product', 0, '产品管理', '', 'layui-icon-release', 'product', '/', 'GET', 1, 0, 1, '2019-03-16 16:46:37', '2019-03-16 16:46:37', 0);
INSERT INTO `admin_menu` VALUES (51, 50, 'product-list', 0, '产品列表', '', 'layui-icon-rate-half', '/product/list', '/', 'GET', 1, 0, 2, '2019-03-16 16:56:17', '2019-03-16 16:56:17', 0);
INSERT INTO `admin_menu` VALUES (52, 50, 'product-evaluate-list', 0, '产品评价列表', '', 'layui-icon-rate-half', '/product/productevaluatelist', '/', 'GET', 2, 0, 2, '2019-03-16 16:56:17', '2019-03-16 16:56:17', 0);
INSERT INTO `admin_menu` VALUES (53, 50, 'product-tag-list', 0, '标签管理', '', 'layui-icon-rate-half', '/product/taglist', '/', 'GET', 3, 0, 2, '2019-03-16 16:56:17', '2019-03-16 16:56:17', 0);
INSERT INTO `admin_menu` VALUES (54, 50, 'product-space-list', 0, '空间管理', '', 'layui-icon-rate-half', '/product/spacelist', '/', 'GET', 4, 0, 2, '2019-03-16 16:56:17', '2019-03-16 16:56:17', 0);
INSERT INTO `admin_menu` VALUES (55, 50, 'product-video-list', 0, '视频管理', '', 'layui-icon-rate-half', '/product/videolist', '/', 'GET', 5, 0, 2, '2019-03-16 16:56:17', '2019-03-16 16:56:17', 0);
INSERT INTO `admin_menu` VALUES (56, 0, 'payment', 0, '支付管理', '', 'layui-icon-rmb', 'payment', '/', 'GET', 2, 0, 1, '2019-03-16 16:46:37', '2019-03-16 16:46:37', 0);
INSERT INTO `admin_menu` VALUES (57, 56, 'payment-recharge-record-list', 0, '充值记录', '', 'layui-icon-rate-half', '/payment/rechargerecordlist', '/', 'GET', 1, 0, 2, '2019-03-16 16:56:17', '2019-03-16 16:56:17', 0);
INSERT INTO `admin_menu` VALUES (58, 50, 'product-video-live-list', 0, '直播管理', '', 'layui-icon-rate-half', '/product/videolivelist', '/', 'GET', 6, 0, 2, '2019-03-16 16:56:17', '2019-03-16 16:56:17', 0);
INSERT INTO `admin_menu` VALUES (59, 50, 'hot-search-list', 0, '热门搜索', '', 'layui-icon-rate-half', '/product/hotsearchlist', '/', 'GET', 7, 0, 2, '2019-03-16 16:56:17', '2019-03-16 16:56:17', 0);
INSERT INTO `admin_menu` VALUES (60, 2, 'set-my-companyinfo', 0, '公司信息设置', '', 'layui-icon-rate-half', '/set/system/companyinfo', '/', 'GET', 5, 0, 2, '2019-03-11 09:27:23', '2019-03-11 09:27:23', 0);
INSERT INTO `admin_menu` VALUES (61, 2, 'set-service-state', 0, '服务声明', '', 'layui-icon-rate-half', '/set/system/servicestate', '/', 'GET', 6, 0, 2, '2019-03-11 09:27:23', '2019-03-11 09:27:23', 0);
INSERT INTO `admin_menu` VALUES (62, 2, 'set-contactus', 0, '联系我们', '', 'layui-icon-rate-half', '/set/system/contactus', '/', 'GET', 7, 0, 2, '2019-03-11 09:27:23', '2019-03-11 09:27:23', 0);
INSERT INTO `admin_menu` VALUES (63, 2, 'set-seo', 0, '站点设置', '', 'layui-icon-rate-half', '/set/system/seo', '/', 'GET', 8, 0, 2, '2019-03-11 09:27:23', '2019-03-11 09:27:23', 0);
INSERT INTO `admin_menu` VALUES (64, 50, 'index-category-list', 0, '首页栏目配置', '', 'layui-icon-rate-half', '/product/indexcategorylist', '/', 'GET', 10, 0, 2, '2019-03-16 16:56:17', '2019-03-16 16:56:17', 0);
INSERT INTO `admin_menu` VALUES (65, 2, 'set-regagree', 0, '注册协议', '', 'layui-icon-rate-half', '/set/system/regagree', '/', 'GET', 9, 0, 2, '2019-03-11 09:27:23', '2019-03-11 09:27:23', 0);
COMMIT;

-- ----------------------------
-- Table structure for admin_role
-- ----------------------------
DROP TABLE IF EXISTS `admin_role`;
CREATE TABLE `admin_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '角色名',
  `description` varchar(500) NOT NULL DEFAULT '' COMMENT '描述',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '逻辑删除标识',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='后台管理用户角色表';

-- ----------------------------
-- Records of admin_role
-- ----------------------------
BEGIN;
INSERT INTO `admin_role` VALUES (1, '超级管理员', '', 0, '2019-02-28 23:35:55', '2019-02-28 23:35:55', 0);
INSERT INTO `admin_role` VALUES (2, '开发测试', '', 0, '2019-03-01 01:19:04', '2019-03-01 01:19:04', 0);
INSERT INTO `admin_role` VALUES (3, '客服', '13223', 0, '2019-03-01 10:41:58', '2020-06-30 15:19:37', 0);
INSERT INTO `admin_role` VALUES (4, 'ssss', 'sss', 0, '2020-06-30 15:19:47', '2020-06-30 15:19:47', 1);
COMMIT;

-- ----------------------------
-- Table structure for admin_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `admin_role_menu`;
CREATE TABLE `admin_role_menu` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '角色ID',
  `menu_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '菜单ID',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `is_deleted` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '逻辑删除标识',
  PRIMARY KEY (`id`),
  KEY `admin_role_menu_menu_id_index` (`menu_id`),
  KEY `admin_role_menu_role_id_index` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb4 COMMENT='后台角色权限';

-- ----------------------------
-- Records of admin_role_menu
-- ----------------------------
BEGIN;
INSERT INTO `admin_role_menu` VALUES (1, 1, 1, '2019-03-01 17:56:44', '2019-03-04 14:24:28', 0);
INSERT INTO `admin_role_menu` VALUES (2, 1, 2, '2019-03-01 17:56:44', '2019-03-04 14:24:28', 0);
INSERT INTO `admin_role_menu` VALUES (3, 1, 4, '2019-03-01 17:56:44', '2019-03-04 14:24:28', 0);
INSERT INTO `admin_role_menu` VALUES (4, 1, 5, '2019-03-01 17:56:44', '2019-03-04 14:24:28', 0);
INSERT INTO `admin_role_menu` VALUES (5, 1, 7, '2019-03-01 17:56:44', '2020-08-10 03:45:57', 1);
INSERT INTO `admin_role_menu` VALUES (6, 1, 6, '2019-03-01 17:56:44', '2020-07-24 03:36:52', 1);
INSERT INTO `admin_role_menu` VALUES (7, 1, 3, '2019-03-01 17:56:44', '2019-03-05 10:28:39', 0);
INSERT INTO `admin_role_menu` VALUES (8, 1, 3, '2019-03-01 17:57:32', '2019-03-05 10:28:39', 0);
INSERT INTO `admin_role_menu` VALUES (9, 3, 1, '2019-03-05 10:37:46', '2019-03-05 10:37:46', 0);
INSERT INTO `admin_role_menu` VALUES (10, 3, 3, '2019-03-05 10:46:42', '2019-03-05 10:57:03', 1);
INSERT INTO `admin_role_menu` VALUES (11, 1, 10, '2019-03-05 14:24:39', '2020-08-10 03:45:57', 1);
INSERT INTO `admin_role_menu` VALUES (12, 1, 11, '2019-03-05 17:17:25', '2020-07-24 03:36:52', 1);
INSERT INTO `admin_role_menu` VALUES (13, 1, 12, '2019-03-06 15:03:34', '2020-07-24 03:36:52', 1);
INSERT INTO `admin_role_menu` VALUES (14, 1, 13, '2019-03-07 17:08:02', '2019-03-07 17:08:02', 0);
INSERT INTO `admin_role_menu` VALUES (15, 1, 14, '2019-03-07 17:08:02', '2020-07-24 03:36:52', 1);
INSERT INTO `admin_role_menu` VALUES (16, 1, 15, '2019-03-07 19:17:22', '2020-07-24 03:36:52', 1);
INSERT INTO `admin_role_menu` VALUES (17, 1, 16, '2019-03-07 19:23:46', '2020-07-24 03:36:52', 1);
INSERT INTO `admin_role_menu` VALUES (18, 1, 17, '2019-03-07 19:23:46', '2020-07-24 03:36:52', 1);
INSERT INTO `admin_role_menu` VALUES (19, 1, 18, '2019-03-11 09:27:34', '2020-09-25 03:04:05', 0);
INSERT INTO `admin_role_menu` VALUES (20, 1, 19, '2019-03-11 09:27:34', '2020-09-25 03:04:05', 0);
INSERT INTO `admin_role_menu` VALUES (21, 1, 20, '2019-03-11 18:37:55', '2020-07-24 03:36:52', 1);
INSERT INTO `admin_role_menu` VALUES (22, 1, 21, '2019-03-11 18:59:59', '2020-07-24 03:36:52', 1);
INSERT INTO `admin_role_menu` VALUES (23, 1, 22, '2019-03-11 20:26:04', '2020-07-24 03:36:52', 1);
INSERT INTO `admin_role_menu` VALUES (24, 1, 23, '2019-03-11 20:26:04', '2020-07-24 03:36:52', 1);
INSERT INTO `admin_role_menu` VALUES (25, 1, 24, '2019-03-11 20:26:04', '2020-07-24 03:36:52', 1);
INSERT INTO `admin_role_menu` VALUES (26, 1, 25, '2019-03-11 20:26:04', '2020-07-24 03:36:52', 1);
INSERT INTO `admin_role_menu` VALUES (27, 1, 26, '2019-03-11 20:26:04', '2020-07-24 03:36:52', 1);
INSERT INTO `admin_role_menu` VALUES (28, 1, 28, '2019-03-12 16:26:13', '2020-07-24 03:36:52', 1);
INSERT INTO `admin_role_menu` VALUES (29, 1, 29, '2019-03-12 16:32:03', '2020-08-10 03:45:57', 1);
INSERT INTO `admin_role_menu` VALUES (30, 1, 30, '2019-03-25 12:47:52', '2020-08-10 03:45:57', 0);
INSERT INTO `admin_role_menu` VALUES (31, 1, 31, '2019-03-25 12:49:32', '2020-08-10 03:45:57', 0);
INSERT INTO `admin_role_menu` VALUES (32, 1, 32, '2019-03-25 12:49:32', '2020-08-10 03:45:57', 0);
INSERT INTO `admin_role_menu` VALUES (33, 2, 1, '2019-03-27 14:08:35', '2019-03-27 14:08:35', 0);
INSERT INTO `admin_role_menu` VALUES (34, 2, 10, '2019-03-27 14:08:35', '2020-08-06 06:41:54', 1);
INSERT INTO `admin_role_menu` VALUES (35, 2, 11, '2019-03-27 14:08:35', '2020-07-01 03:08:14', 1);
INSERT INTO `admin_role_menu` VALUES (36, 2, 12, '2019-03-27 14:08:35', '2020-07-01 03:08:14', 1);
INSERT INTO `admin_role_menu` VALUES (37, 2, 16, '2019-03-27 14:08:35', '2020-07-01 03:08:14', 1);
INSERT INTO `admin_role_menu` VALUES (38, 2, 33, '2019-03-27 14:08:35', '2020-08-06 06:41:54', 1);
INSERT INTO `admin_role_menu` VALUES (39, 2, 17, '2019-03-27 14:08:35', '2020-07-01 03:08:14', 1);
INSERT INTO `admin_role_menu` VALUES (40, 2, 13, '2019-03-27 14:08:35', '2020-07-02 18:41:09', 0);
INSERT INTO `admin_role_menu` VALUES (41, 2, 4, '2019-03-27 14:08:35', '2020-07-02 18:41:09', 0);
INSERT INTO `admin_role_menu` VALUES (42, 2, 21, '2019-03-27 14:08:35', '2020-07-01 03:08:14', 1);
INSERT INTO `admin_role_menu` VALUES (43, 2, 14, '2019-03-27 14:08:35', '2020-07-01 03:08:14', 1);
INSERT INTO `admin_role_menu` VALUES (44, 2, 15, '2019-03-27 14:08:35', '2020-09-28 07:35:52', 0);
INSERT INTO `admin_role_menu` VALUES (45, 2, 20, '2019-03-27 14:08:35', '2020-07-01 03:08:14', 1);
INSERT INTO `admin_role_menu` VALUES (46, 2, 22, '2019-03-27 14:08:35', '2020-07-01 03:08:14', 1);
INSERT INTO `admin_role_menu` VALUES (47, 2, 23, '2019-03-27 14:08:35', '2020-07-01 03:08:14', 1);
INSERT INTO `admin_role_menu` VALUES (48, 2, 24, '2019-03-27 14:08:35', '2020-07-01 03:08:14', 1);
INSERT INTO `admin_role_menu` VALUES (49, 2, 25, '2019-03-27 14:08:35', '2020-07-01 03:08:14', 1);
INSERT INTO `admin_role_menu` VALUES (50, 2, 26, '2019-03-27 14:08:35', '2020-07-01 03:08:14', 1);
INSERT INTO `admin_role_menu` VALUES (51, 2, 28, '2019-03-27 14:08:35', '2020-07-01 03:08:14', 1);
INSERT INTO `admin_role_menu` VALUES (52, 2, 29, '2019-03-27 14:08:35', '2020-08-06 06:41:54', 1);
INSERT INTO `admin_role_menu` VALUES (53, 2, 18, '2019-03-27 14:08:35', '2020-09-23 15:32:32', 0);
INSERT INTO `admin_role_menu` VALUES (54, 2, 19, '2019-03-27 14:08:35', '2020-09-23 15:32:32', 0);
INSERT INTO `admin_role_menu` VALUES (55, 2, 30, '2019-03-27 14:08:35', '2020-08-07 09:37:55', 0);
INSERT INTO `admin_role_menu` VALUES (56, 2, 31, '2019-03-27 14:08:35', '2020-08-07 09:37:55', 0);
INSERT INTO `admin_role_menu` VALUES (57, 2, 32, '2019-03-27 14:08:35', '2020-08-07 09:37:55', 0);
INSERT INTO `admin_role_menu` VALUES (58, 2, 2, '2019-03-27 14:08:35', '2019-03-27 14:08:35', 0);
INSERT INTO `admin_role_menu` VALUES (59, 2, 5, '2019-03-27 14:08:35', '2019-03-27 14:08:35', 0);
INSERT INTO `admin_role_menu` VALUES (60, 2, 7, '2019-03-27 14:08:35', '2019-03-27 14:08:35', 0);
INSERT INTO `admin_role_menu` VALUES (61, 2, 6, '2019-03-27 14:08:35', '2020-07-01 03:08:14', 1);
INSERT INTO `admin_role_menu` VALUES (62, 2, 3, '2019-03-27 14:08:35', '2019-03-27 14:08:35', 0);
INSERT INTO `admin_role_menu` VALUES (63, 1, 33, '2019-03-27 14:43:04', '2020-08-10 03:45:57', 1);
INSERT INTO `admin_role_menu` VALUES (64, 2, 34, '2019-03-29 14:12:28', '2020-08-07 07:37:36', 0);
INSERT INTO `admin_role_menu` VALUES (65, 1, 34, '2019-03-29 15:26:40', '2020-08-10 03:45:57', 0);
INSERT INTO `admin_role_menu` VALUES (66, 2, 35, '2019-04-03 14:24:39', '2020-07-01 03:08:14', 1);
INSERT INTO `admin_role_menu` VALUES (67, 2, 36, '2019-04-08 16:37:39', '2020-07-01 03:08:14', 1);
INSERT INTO `admin_role_menu` VALUES (68, 1, 36, '2019-04-09 15:37:53', '2020-07-24 03:36:52', 1);
INSERT INTO `admin_role_menu` VALUES (69, 1, 35, '2019-04-09 15:37:53', '2020-07-24 03:36:52', 1);
INSERT INTO `admin_role_menu` VALUES (70, 2, 37, '2019-04-22 15:35:22', '2020-07-01 03:08:14', 1);
INSERT INTO `admin_role_menu` VALUES (71, 1, 37, '2019-04-22 19:22:15', '2020-07-24 03:36:52', 1);
INSERT INTO `admin_role_menu` VALUES (72, 2, 38, '2019-05-23 14:38:01', '2020-07-01 03:08:14', 1);
INSERT INTO `admin_role_menu` VALUES (73, 1, 38, '2019-05-24 10:45:04', '2020-07-24 03:36:52', 1);
INSERT INTO `admin_role_menu` VALUES (74, 2, 39, '2019-06-17 22:42:17', '2020-07-01 03:08:14', 1);
INSERT INTO `admin_role_menu` VALUES (75, 3, 10, '2020-06-30 07:51:14', '2020-06-30 07:51:14', 0);
INSERT INTO `admin_role_menu` VALUES (76, 3, 11, '2020-06-30 07:51:14', '2020-06-30 07:51:14', 0);
INSERT INTO `admin_role_menu` VALUES (77, 3, 12, '2020-06-30 07:51:14', '2020-06-30 07:51:14', 0);
INSERT INTO `admin_role_menu` VALUES (78, 3, 16, '2020-06-30 07:51:14', '2020-06-30 07:51:14', 0);
INSERT INTO `admin_role_menu` VALUES (79, 3, 33, '2020-06-30 07:51:14', '2020-06-30 07:51:14', 0);
INSERT INTO `admin_role_menu` VALUES (80, 3, 39, '2020-06-30 07:51:14', '2020-06-30 07:51:14', 0);
INSERT INTO `admin_role_menu` VALUES (81, 3, 17, '2020-06-30 07:51:14', '2020-06-30 07:51:14', 0);
INSERT INTO `admin_role_menu` VALUES (82, 3, 38, '2020-06-30 07:51:14', '2020-06-30 07:51:14', 0);
INSERT INTO `admin_role_menu` VALUES (83, 3, 37, '2020-06-30 07:51:14', '2020-06-30 07:51:14', 0);
INSERT INTO `admin_role_menu` VALUES (84, 3, 36, '2020-06-30 07:51:14', '2020-06-30 07:51:14', 0);
INSERT INTO `admin_role_menu` VALUES (85, 2, 40, '2020-07-01 03:17:12', '2020-08-06 06:41:54', 1);
INSERT INTO `admin_role_menu` VALUES (86, 2, 41, '2020-07-06 18:36:59', '2020-08-06 06:41:54', 1);
INSERT INTO `admin_role_menu` VALUES (87, 2, 42, '2020-07-08 07:36:45', '2020-08-06 06:41:54', 1);
INSERT INTO `admin_role_menu` VALUES (88, 2, 43, '2020-07-08 22:58:57', '2020-08-06 06:41:54', 1);
INSERT INTO `admin_role_menu` VALUES (89, 2, 44, '2020-07-13 08:05:53', '2020-08-06 06:41:54', 1);
INSERT INTO `admin_role_menu` VALUES (90, 2, 45, '2020-07-13 12:28:24', '2020-08-06 08:11:23', 1);
INSERT INTO `admin_role_menu` VALUES (91, 2, 46, '2020-07-18 09:08:42', '2020-08-06 06:41:54', 1);
INSERT INTO `admin_role_menu` VALUES (92, 1, 44, '2020-07-24 03:36:52', '2020-08-10 03:45:57', 1);
INSERT INTO `admin_role_menu` VALUES (93, 1, 41, '2020-07-24 03:36:52', '2020-08-10 03:45:57', 1);
INSERT INTO `admin_role_menu` VALUES (94, 1, 46, '2020-07-24 03:36:52', '2020-08-10 03:45:57', 1);
INSERT INTO `admin_role_menu` VALUES (95, 1, 45, '2020-07-24 03:36:52', '2020-08-10 03:45:57', 1);
INSERT INTO `admin_role_menu` VALUES (96, 1, 42, '2020-07-24 03:36:52', '2020-08-10 03:45:57', 1);
INSERT INTO `admin_role_menu` VALUES (97, 2, 47, '2020-08-06 08:11:23', '2020-08-06 08:11:23', 0);
INSERT INTO `admin_role_menu` VALUES (98, 2, 48, '2020-08-06 08:11:23', '2020-08-06 08:11:23', 0);
INSERT INTO `admin_role_menu` VALUES (99, 2, 49, '2020-08-06 08:11:23', '2020-08-06 08:11:23', 0);
INSERT INTO `admin_role_menu` VALUES (100, 2, 50, '2020-08-07 08:15:14', '2020-08-07 08:15:14', 0);
INSERT INTO `admin_role_menu` VALUES (101, 2, 51, '2020-08-07 08:15:14', '2020-08-07 08:15:14', 0);
INSERT INTO `admin_role_menu` VALUES (102, 2, 52, '2020-08-07 08:38:22', '2020-08-07 08:38:22', 0);
INSERT INTO `admin_role_menu` VALUES (103, 2, 53, '2020-08-10 03:45:10', '2020-08-10 03:45:10', 0);
INSERT INTO `admin_role_menu` VALUES (104, 1, 50, '2020-08-10 03:45:57', '2020-08-10 03:45:57', 0);
INSERT INTO `admin_role_menu` VALUES (105, 1, 51, '2020-08-10 03:45:57', '2020-08-10 03:45:57', 0);
INSERT INTO `admin_role_menu` VALUES (106, 1, 52, '2020-08-10 03:45:57', '2020-08-10 03:45:57', 0);
INSERT INTO `admin_role_menu` VALUES (107, 1, 53, '2020-08-10 03:45:57', '2020-08-10 03:45:57', 0);
INSERT INTO `admin_role_menu` VALUES (108, 1, 47, '2020-08-10 03:45:57', '2020-08-10 03:45:57', 0);
INSERT INTO `admin_role_menu` VALUES (109, 1, 48, '2020-08-10 03:45:57', '2020-08-10 03:45:57', 0);
INSERT INTO `admin_role_menu` VALUES (110, 1, 49, '2020-08-10 03:45:57', '2020-08-10 03:45:57', 0);
INSERT INTO `admin_role_menu` VALUES (111, 2, 54, '2020-08-14 09:34:34', '2020-08-14 09:34:34', 0);
INSERT INTO `admin_role_menu` VALUES (112, 2, 55, '2020-08-14 09:34:34', '2020-08-14 09:34:34', 0);
INSERT INTO `admin_role_menu` VALUES (113, 2, 56, '2020-08-14 09:43:46', '2020-08-14 09:43:46', 0);
INSERT INTO `admin_role_menu` VALUES (114, 2, 57, '2020-08-14 09:43:46', '2020-08-14 09:43:46', 0);
INSERT INTO `admin_role_menu` VALUES (115, 1, 54, '2020-08-14 11:01:32', '2020-08-14 11:01:32', 0);
INSERT INTO `admin_role_menu` VALUES (116, 1, 55, '2020-08-14 11:01:32', '2020-08-14 11:01:32', 0);
INSERT INTO `admin_role_menu` VALUES (117, 1, 56, '2020-08-15 01:22:25', '2020-08-15 01:22:25', 0);
INSERT INTO `admin_role_menu` VALUES (118, 1, 57, '2020-08-15 01:22:25', '2020-08-15 01:22:25', 0);
INSERT INTO `admin_role_menu` VALUES (119, 2, 58, '2020-09-05 07:45:04', '2020-09-05 07:45:04', 0);
INSERT INTO `admin_role_menu` VALUES (120, 1, 58, '2020-09-05 11:01:13', '2020-09-05 11:01:13', 0);
INSERT INTO `admin_role_menu` VALUES (121, 2, 59, '2020-09-10 09:39:07', '2020-09-10 09:39:07', 0);
INSERT INTO `admin_role_menu` VALUES (122, 1, 59, '2020-09-10 09:48:37', '2020-09-10 09:48:37', 0);
INSERT INTO `admin_role_menu` VALUES (123, 2, 60, '2020-09-24 07:03:13', '2020-09-24 07:03:13', 0);
INSERT INTO `admin_role_menu` VALUES (124, 2, 61, '2020-09-24 08:48:16', '2020-09-24 08:48:16', 0);
INSERT INTO `admin_role_menu` VALUES (125, 2, 62, '2020-09-25 01:40:00', '2020-09-25 01:40:00', 0);
INSERT INTO `admin_role_menu` VALUES (126, 2, 63, '2020-09-25 02:37:39', '2020-09-25 02:37:39', 0);
INSERT INTO `admin_role_menu` VALUES (127, 2, 63, '2020-09-25 02:37:39', '2020-09-25 02:37:39', 0);
INSERT INTO `admin_role_menu` VALUES (128, 2, 63, '2020-09-25 02:37:39', '2020-09-25 02:37:39', 0);
INSERT INTO `admin_role_menu` VALUES (129, 1, 60, '2020-09-25 03:03:05', '2020-09-25 03:03:05', 0);
INSERT INTO `admin_role_menu` VALUES (130, 1, 61, '2020-09-25 03:03:05', '2020-09-25 03:03:05', 0);
INSERT INTO `admin_role_menu` VALUES (131, 1, 62, '2020-09-25 03:03:05', '2020-09-25 03:03:05', 0);
INSERT INTO `admin_role_menu` VALUES (132, 1, 63, '2020-09-25 03:03:05', '2020-09-25 03:03:05', 0);
INSERT INTO `admin_role_menu` VALUES (133, 2, 64, '2020-09-25 08:59:53', '2020-09-25 08:59:53', 0);
INSERT INTO `admin_role_menu` VALUES (134, 1, 64, '2020-09-28 02:05:10', '2020-09-28 02:05:10', 0);
INSERT INTO `admin_role_menu` VALUES (135, 2, 65, '2020-10-09 06:13:53', '2020-10-09 06:13:53', 0);
INSERT INTO `admin_role_menu` VALUES (136, 1, 65, '2020-10-09 07:56:12', '2020-10-09 07:56:12', 0);
COMMIT;

-- ----------------------------
-- Table structure for admin_user
-- ----------------------------
DROP TABLE IF EXISTS `admin_user`;
CREATE TABLE `admin_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(100) NOT NULL DEFAULT '' COMMENT '密码',
  `role_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户角色',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '真实姓名',
  `sex` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '性别 0-女 1-男',
  `mobile` varchar(50) NOT NULL DEFAULT '' COMMENT '手机号码',
  `email` varchar(50) NOT NULL DEFAULT '' COMMENT '邮箱地址',
  `comment` varchar(200) NOT NULL DEFAULT '' COMMENT '介绍',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '账号状态 0-禁用 1-启用',
  `gmt_create` datetime DEFAULT NULL COMMENT '注册时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `is_deleted` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '逻辑删除标记',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_index` (`user_name`),
  KEY `admin_user_user_name_password_index` (`user_name`,`password`),
  KEY `admin_user_role_id_index` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='后台管理用户表';

-- ----------------------------
-- Records of admin_user
-- ----------------------------
BEGIN;
INSERT INTO `admin_user` VALUES (1, 'admin', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 1, '超级管理员', 1, '', '', '11233', 1, '2019-01-25 14:04:45', '2020-09-07 16:08:14', 0);
INSERT INTO `admin_user` VALUES (2, 'caorui', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, '曹锐', 1, '', '', '', 1, '2019-01-25 14:39:59', '2020-07-24 11:36:27', 0);
INSERT INTO `admin_user` VALUES (7, 'yangmengna', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 3, '杨梦娜', 0, '13588107545', '2838402292@qq.com', '', 1, '2019-05-10 05:36:58', NULL, 1);
INSERT INTO `admin_user` VALUES (20, 'wyj', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 1, '王郁佳', 1, '', '', '', 1, '2019-03-20 10:29:36', '2019-03-20 10:29:36', 1);
INSERT INTO `admin_user` VALUES (21, 'yyb', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 1, '俞银标', 1, '', '', '', 1, '2019-03-20 10:31:55', '2019-03-20 10:31:55', 1);
INSERT INTO `admin_user` VALUES (22, 'csz', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 1, '陈孙智', 1, '', '', '', 1, '2019-03-20 10:32:27', '2019-03-20 10:32:27', 1);
INSERT INTO `admin_user` VALUES (23, 'zlp', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 1, '张露萍', 0, '', '', '', 1, '2019-04-22 11:24:44', '2019-04-22 11:24:44', 1);
INSERT INTO `admin_user` VALUES (26, 'test', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, '测试', 1, '', '', '', 0, NULL, NULL, 1);
INSERT INTO `admin_user` VALUES (27, 'test2', '', 2, '123', 1, '', '', '', 0, NULL, NULL, 1);
INSERT INTO `admin_user` VALUES (28, 'tttt', 'b23fcb8820e567d1143f4a15cfeaf04ba660bafd89eeb496e99ffd8bd1079f71', 1, 'tttttt', 1, '', '', '', 0, NULL, NULL, 1);
INSERT INTO `admin_user` VALUES (29, 'aaaa', '61be55a8e2f6b4e172338bddf184d6dbee29c98853e0a0485ecee7f27b9af0b4', 1, 'aaaaa', 1, '', '', '', 0, NULL, NULL, 1);
INSERT INTO `admin_user` VALUES (30, 'ffff', 'f29a448b780745bf2e10667f46c442b102e75e76a46a1fff969641866225ab56', 1, 'fffff', 1, '', '', '', 0, NULL, NULL, 1);
INSERT INTO `admin_user` VALUES (31, '32', 'c5c82b45badc39f5e8ffed4a6662394fc0cfcb0085f1ff1988b2d000d1ad3c43', 1, 'fda1', 1, '', '', '', 0, NULL, '2020-06-30 15:04:25', 1);
INSERT INTO `admin_user` VALUES (32, 'fdfdaf', '88ebe48143447d70668e7eeabc44c5c254180ed906c3e60cf94a4590333abe20', 1, 'fdafda', 1, '', '', '', 0, '2020-06-30 15:04:42', '2020-06-30 15:04:42', 1);
COMMIT;

-- ----------------------------
-- Table structure for admin_user_role
-- ----------------------------
DROP TABLE IF EXISTS `admin_user_role`;
CREATE TABLE `admin_user_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL COMMENT '用户ID',
  `role_id` int(11) unsigned NOT NULL COMMENT '权限ID',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) unsigned NOT NULL COMMENT '逻辑删除标识',
  PRIMARY KEY (`id`),
  KEY `admin_user_role_role_id_index` (`role_id`),
  KEY `admin_user_role_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='后台用户权限';

-- ----------------------------
-- Records of admin_user_role
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for banner
-- ----------------------------
DROP TABLE IF EXISTS `banner`;
CREATE TABLE `banner` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '组ID',
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `description` varchar(500) NOT NULL DEFAULT '' COMMENT '描述',
  `img_url` varchar(500) NOT NULL DEFAULT '' COMMENT '图片地址',
  `link_url` varchar(500) NOT NULL DEFAULT '' COMMENT '点击跳转地址',
  `cycle` int(11) NOT NULL DEFAULT '0' COMMENT '周期0天1月',
  `cycle_num` int(11) NOT NULL DEFAULT '0' COMMENT '周期时长',
  `gmt_due` datetime DEFAULT NULL COMMENT '到期时间',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '状态',
  `used` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否启用',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '逻辑删除标记',
  PRIMARY KEY (`id`),
  KEY `banner_group_id_index` (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COMMENT='Banner图';

-- ----------------------------
-- Records of banner
-- ----------------------------
BEGIN;
INSERT INTO `banner` VALUES (1, 2, 0, '1发打发打发', '', 'https://img01.chabug.com/test/image/image/20200713205400523000000369168086.png', '23', 0, 0, '2020-11-05 18:13:08', 1, 1, '2020-07-13 20:54:01', '2020-08-06 17:44:01', 1);
INSERT INTO `banner` VALUES (2, 1, 0, '测试', '', 'http://yujia.img.cdn.chabug.com/test/image/banner/20200905171532032000000578459312.jpeg', '', 0, 0, '2020-11-05 18:13:08', 0, 1, '2020-09-05 17:19:34', '2020-09-05 17:19:34', 0);
INSERT INTO `banner` VALUES (3, 0, 10032, '', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200908153151810000000110704524.jpg', '', 1, 2, '2020-11-05 18:13:08', 0, 1, '2020-09-05 18:13:08', '2020-09-05 18:13:08', 0);
INSERT INTO `banner` VALUES (4, 0, 10032, '', '', 'http://yujia.img.cdn.chabug.com/test/image/banner/20200905181146935000000683966563.jpg', '', 1, 2, '2020-11-05 18:13:08', 0, 1, '2020-09-05 18:13:08', '2020-09-05 18:13:08', 0);
INSERT INTO `banner` VALUES (5, 0, 10032, '', '', 'http://yujia.img.cdn.chabug.com/test/image/banner/20200905181146935000000683966563.jpg', '', 1, 2, '2020-11-05 18:13:08', 0, 1, '2020-09-05 18:13:08', '2020-09-05 18:13:08', 0);
INSERT INTO `banner` VALUES (6, 0, 10032, '', '', 'http://yujia.img.cdn.chabug.com/test/image/banner/20200905181146935000000683966563.jpg', '', 1, 2, '2020-11-05 18:13:08', 0, 1, '2020-09-05 18:13:08', '2020-09-05 18:13:08', 0);
INSERT INTO `banner` VALUES (7, 0, 10032, '', '', 'http://yujia.img.cdn.chabug.com/test/image/banner/20200905181146935000000683966563.jpg', '', 1, 2, '2020-11-05 18:13:08', 0, 1, '2020-09-05 18:13:08', '2020-09-05 18:13:08', 0);
INSERT INTO `banner` VALUES (8, 0, 10032, '', '', 'http://yujia.img.cdn.chabug.com/test/image/banner/20200905181146935000000683966563.jpg', '', 1, 2, '2020-11-05 18:13:08', 0, 1, '2020-09-05 18:13:08', '2020-09-05 18:13:08', 0);
INSERT INTO `banner` VALUES (9, 0, 10032, '', '', 'http://yujia.img.cdn.chabug.com/test/image/banner/20200905181146935000000683966563.jpg', '', 1, 2, '2020-11-05 18:13:08', 0, 1, '2020-09-05 18:13:08', '2020-09-05 18:13:08', 0);
INSERT INTO `banner` VALUES (10, 0, 10032, '', '', 'http://yujia.img.cdn.chabug.com/test/image/banner/20200905181146935000000683966563.jpg', '', 1, 2, '2020-11-05 18:13:08', 0, 1, '2020-09-05 18:13:08', '2020-09-05 18:13:08', 0);
INSERT INTO `banner` VALUES (11, 0, 10032, '', '', 'http://yujia.img.cdn.chabug.com/test/image/banner/20200905181146935000000683966563.jpg', '', 1, 2, '2020-11-05 18:13:08', 0, 1, '2020-09-05 18:13:08', '2020-09-05 18:13:08', 0);
INSERT INTO `banner` VALUES (12, 0, 10032, '', '', 'http://yujia.img.cdn.chabug.com/test/image/banner/20200905181146935000000683966563.jpg', '', 1, 2, '2020-11-05 18:13:08', 0, 1, '2020-09-05 18:13:08', '2020-09-05 18:13:08', 0);
INSERT INTO `banner` VALUES (13, 0, 10032, '', '', 'http://yujia.img.cdn.chabug.com/test/image/banner/20200905181146935000000683966563.jpg', '', 1, 2, '2020-11-05 18:13:08', 0, 1, '2020-09-05 18:13:08', '2020-09-05 18:13:08', 0);
INSERT INTO `banner` VALUES (14, 0, 10032, '', '', 'http://yujia.img.cdn.chabug.com/test/image/banner/20200905181146935000000683966563.jpg', '', 1, 2, '2020-11-05 18:13:08', 0, 1, '2020-09-05 18:13:08', '2020-09-05 18:13:08', 0);
INSERT INTO `banner` VALUES (15, 0, 10032, '', '', 'http://yujia.img.cdn.chabug.com/test/image/banner/20200905181146935000000683966563.jpg', '', 1, 2, '2020-11-05 18:13:08', 2, 1, '2020-09-05 18:13:08', '2020-10-07 12:07:44', 0);
INSERT INTO `banner` VALUES (16, 0, 10032, '', '', 'http://yujia.img.cdn.chabug.com/test/image/banner/20200905181146935000000683966563.jpg', '', 1, 2, '2020-11-05 18:13:08', 1, 1, '2020-09-05 18:13:08', '2020-10-07 12:06:27', 0);
COMMIT;

-- ----------------------------
-- Table structure for banner_group
-- ----------------------------
DROP TABLE IF EXISTS `banner_group`;
CREATE TABLE `banner_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT 'Banner组名',
  `code` varchar(50) NOT NULL DEFAULT '' COMMENT '编码（备用）\n',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '逻辑删除标记',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='Banner组';

-- ----------------------------
-- Records of banner_group
-- ----------------------------
BEGIN;
INSERT INTO `banner_group` VALUES (1, '22', '1', '2020-08-06 16:21:02', '2020-08-06 16:24:18', 1);
INSERT INTO `banner_group` VALUES (2, '2333', '2', '2020-08-06 16:30:15', '2020-08-06 16:30:18', 0);
COMMIT;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '分类名',
  `parent_id` int(10) unsigned DEFAULT NULL,
  `current_level` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '层级',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of category
-- ----------------------------
BEGIN;
INSERT INTO `category` VALUES (1, '帮助中心', 0, 1);
INSERT INTO `category` VALUES (2, '媒体报道', 0, 1);
INSERT INTO `category` VALUES (3, '常见问题', 0, 1);
COMMIT;

-- ----------------------------
-- Table structure for hot_search
-- ----------------------------
DROP TABLE IF EXISTS `hot_search`;
CREATE TABLE `hot_search` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `content` varchar(1000) NOT NULL DEFAULT '' COMMENT '搜索内容',
  `num` bigint(20) NOT NULL DEFAULT '0' COMMENT '计数',
  `sort` int(11) NOT NULL DEFAULT '999' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='热门搜索';

-- ----------------------------
-- Records of hot_search
-- ----------------------------
BEGIN;
INSERT INTO `hot_search` VALUES (1, '产品', 22, 999);
INSERT INTO `hot_search` VALUES (2, '零售', 14, 999);
INSERT INTO `hot_search` VALUES (3, '产品2', 5, 999);
INSERT INTO `hot_search` VALUES (4, '测试关键词', 10, 0);
INSERT INTO `hot_search` VALUES (5, '模拟数据', 3, 1);
INSERT INTO `hot_search` VALUES (6, '无人机', 0, 0);
COMMIT;

-- ----------------------------
-- Table structure for index_category
-- ----------------------------
DROP TABLE IF EXISTS `index_category`;
CREATE TABLE `index_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `category_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '分类ID',
  `category_name` varchar(500) NOT NULL DEFAULT '' COMMENT '分类名（冗余）',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='首页分类';

-- ----------------------------
-- Records of index_category
-- ----------------------------
BEGIN;
INSERT INTO `index_category` VALUES (1, 1087, '批发和零售业 >> ', 0);
INSERT INTO `index_category` VALUES (6, 1236, '交通运输、仓储和邮政业 >> ', 0);
INSERT INTO `index_category` VALUES (7, 1423, '金融业 >> ', 0);
INSERT INTO `index_category` VALUES (8, 1658, '水利、环境和公共设施管理业 >> ', 0);
INSERT INTO `index_category` VALUES (9, 1830, '文化、体育和娱乐业 >> ', 0);
COMMIT;

-- ----------------------------
-- Table structure for industry
-- ----------------------------
DROP TABLE IF EXISTS `industry`;
CREATE TABLE `industry` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL DEFAULT '' COMMENT '代码',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '类别名称',
  `content` varchar(1000) NOT NULL DEFAULT '' COMMENT '说明',
  `l_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '左值',
  `r_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '右值',
  `parent_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '父级ID',
  `current_level` int(11) NOT NULL DEFAULT '0' COMMENT '当前层级',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1972 DEFAULT CHARSET=utf8 COMMENT='行业分类';

-- ----------------------------
-- Records of industry
-- ----------------------------
BEGIN;
INSERT INTO `industry` VALUES (1, 'A', '农、林、牧、渔业', '', 1, 204, 0, 1);
INSERT INTO `industry` VALUES (2, '01', '农业', '', 2, 81, 1, 2);
INSERT INTO `industry` VALUES (3, '011', '谷物种植', '', 3, 12, 2, 3);
INSERT INTO `industry` VALUES (4, '0111', '稻谷种植', '', 4, 5, 3, 4);
INSERT INTO `industry` VALUES (5, '0112', '小麦种植', '', 6, 7, 3, 4);
INSERT INTO `industry` VALUES (6, '0113', '玉米种植', '', 8, 9, 3, 4);
INSERT INTO `industry` VALUES (7, '0119', '其他谷物种植', '', 10, 11, 3, 4);
INSERT INTO `industry` VALUES (8, '012', '豆类、油料和薯类种植', '', 13, 20, 2, 3);
INSERT INTO `industry` VALUES (9, '0121', '豆类种植', '', 14, 15, 8, 4);
INSERT INTO `industry` VALUES (10, '0122', '油料种植', '', 16, 17, 8, 4);
INSERT INTO `industry` VALUES (11, '0123', '薯类种植', '', 18, 19, 8, 4);
INSERT INTO `industry` VALUES (12, '013', '棉、麻、糖、烟草种植', '', 21, 30, 2, 3);
INSERT INTO `industry` VALUES (13, '0131', '棉花种植', '', 22, 23, 12, 4);
INSERT INTO `industry` VALUES (14, '0132', '麻类种植', '', 24, 25, 12, 4);
INSERT INTO `industry` VALUES (15, '0133', '糖料种植', '', 26, 27, 12, 4);
INSERT INTO `industry` VALUES (16, '0134', '烟草种植', '', 28, 29, 12, 4);
INSERT INTO `industry` VALUES (17, '014', '蔬菜、食用菌及园艺作物种植', '', 31, 40, 2, 3);
INSERT INTO `industry` VALUES (18, '0141', '蔬菜种植', '', 32, 33, 17, 4);
INSERT INTO `industry` VALUES (19, '0142', '食用菌种植', '', 34, 35, 17, 4);
INSERT INTO `industry` VALUES (20, '0143', '花卉种植', '', 36, 37, 17, 4);
INSERT INTO `industry` VALUES (21, '0149', '其他园艺作物种植', '', 38, 39, 17, 4);
INSERT INTO `industry` VALUES (22, '015', '水果种植', '', 41, 52, 2, 3);
INSERT INTO `industry` VALUES (23, '0151', '仁果类和核果类水果种植', '', 42, 43, 22, 4);
INSERT INTO `industry` VALUES (24, '0152', '葡萄种植', '', 44, 45, 22, 4);
INSERT INTO `industry` VALUES (25, '0153', '柑橘类种植', '', 46, 47, 22, 4);
INSERT INTO `industry` VALUES (26, '0154', '香蕉等亚热带水果种植', '', 48, 49, 22, 4);
INSERT INTO `industry` VALUES (27, '0159', '其他水果种植', '', 50, 51, 22, 4);
INSERT INTO `industry` VALUES (28, '016', '坚果、含油果、香料和饮料作物种植', '', 53, 64, 2, 3);
INSERT INTO `industry` VALUES (29, '0161', '坚果种植', '', 54, 55, 28, 4);
INSERT INTO `industry` VALUES (30, '0162', '含油果种植', '', 56, 57, 28, 4);
INSERT INTO `industry` VALUES (31, '0163', '香料作物种植', '', 58, 59, 28, 4);
INSERT INTO `industry` VALUES (32, '0164', '茶叶种植', '', 60, 61, 28, 4);
INSERT INTO `industry` VALUES (33, '0169', '其他饮料作物种植', '', 62, 63, 28, 4);
INSERT INTO `industry` VALUES (34, '017', '中药材种植', '', 65, 70, 2, 3);
INSERT INTO `industry` VALUES (35, '0171', '中草药种植', '', 66, 67, 34, 4);
INSERT INTO `industry` VALUES (36, '0179', '其他中药材种植', '', 68, 69, 34, 4);
INSERT INTO `industry` VALUES (37, '018', '草种植及割草', '', 71, 76, 2, 3);
INSERT INTO `industry` VALUES (38, '0181', '草种植', '', 72, 73, 37, 4);
INSERT INTO `industry` VALUES (39, '0182', '天然草原割草', '', 74, 75, 37, 4);
INSERT INTO `industry` VALUES (40, '019', '其他农业', '', 77, 80, 2, 3);
INSERT INTO `industry` VALUES (41, '0190', '其他农业', '', 78, 79, 40, 4);
INSERT INTO `industry` VALUES (42, '02', '林业', '', 82, 111, 1, 2);
INSERT INTO `industry` VALUES (43, '021', '林木育种和育苗', '', 83, 88, 42, 3);
INSERT INTO `industry` VALUES (44, '0211', '林木育种', '', 84, 85, 43, 4);
INSERT INTO `industry` VALUES (45, '0212', '林木育苗', '', 86, 87, 43, 4);
INSERT INTO `industry` VALUES (46, '022', '造林和更新', '', 89, 92, 42, 3);
INSERT INTO `industry` VALUES (47, '0220', '造林和更新', '', 90, 91, 46, 4);
INSERT INTO `industry` VALUES (48, '023', '森林经营、管护和改培', '', 93, 98, 42, 3);
INSERT INTO `industry` VALUES (49, '0231', '森林经营和管护', '', 94, 95, 48, 4);
INSERT INTO `industry` VALUES (50, '0232', '森林改培', '', 96, 97, 48, 4);
INSERT INTO `industry` VALUES (51, '024', '木材和竹材采运', '', 99, 104, 42, 3);
INSERT INTO `industry` VALUES (52, '0241', '木材采运', '', 100, 101, 51, 4);
INSERT INTO `industry` VALUES (53, '0242', '竹材采运', '', 102, 103, 51, 4);
INSERT INTO `industry` VALUES (54, '025', '林产品采集', '', 105, 110, 42, 3);
INSERT INTO `industry` VALUES (55, '0251', '木竹材林产品采集', '', 106, 107, 54, 4);
INSERT INTO `industry` VALUES (56, '0252', '非木竹材林产品采集', '', 108, 109, 54, 4);
INSERT INTO `industry` VALUES (57, '03', '畜牧业', '', 112, 149, 1, 2);
INSERT INTO `industry` VALUES (58, '031', '牲畜饲养', '', 113, 126, 57, 3);
INSERT INTO `industry` VALUES (59, '0311', '牛的饲养', '', 114, 115, 58, 4);
INSERT INTO `industry` VALUES (60, '0312', '马的饲养', '', 116, 117, 58, 4);
INSERT INTO `industry` VALUES (61, '0313', '猪的饲养', '', 118, 119, 58, 4);
INSERT INTO `industry` VALUES (62, '0314', '羊的饲养', '', 120, 121, 58, 4);
INSERT INTO `industry` VALUES (63, '0315', '骆驼饲养', '', 122, 123, 58, 4);
INSERT INTO `industry` VALUES (64, '0319', '其他牲畜饲养', '', 124, 125, 58, 4);
INSERT INTO `industry` VALUES (65, '032', '家禽饲养', '', 127, 136, 57, 3);
INSERT INTO `industry` VALUES (66, '0321', '鸡的饲养', '', 128, 129, 65, 4);
INSERT INTO `industry` VALUES (67, '0322', '鸭的饲养', '', 130, 131, 65, 4);
INSERT INTO `industry` VALUES (68, '0323', '鹅的饲养', '', 132, 133, 65, 4);
INSERT INTO `industry` VALUES (69, '0329', '其他家禽饲养', '', 134, 135, 65, 4);
INSERT INTO `industry` VALUES (70, '033', '狩猎和捕捉动物', '', 137, 140, 57, 3);
INSERT INTO `industry` VALUES (71, '0330', '狩猎和捕捉动物', '', 138, 139, 70, 4);
INSERT INTO `industry` VALUES (72, '039', '其他畜牧业', '', 141, 148, 57, 3);
INSERT INTO `industry` VALUES (73, '0391', '兔的饲养', '', 142, 143, 72, 4);
INSERT INTO `industry` VALUES (74, '0392', '蜜蜂饲养', '', 144, 145, 72, 4);
INSERT INTO `industry` VALUES (75, '0399', '其他未列明畜牧业', '', 146, 147, 72, 4);
INSERT INTO `industry` VALUES (76, '04', '渔业', '', 150, 163, 1, 2);
INSERT INTO `industry` VALUES (77, '041', '水产养殖', '', 151, 156, 76, 3);
INSERT INTO `industry` VALUES (78, '0411', '海水养殖', '', 152, 153, 77, 4);
INSERT INTO `industry` VALUES (79, '0412', '内陆养殖', '', 154, 155, 77, 4);
INSERT INTO `industry` VALUES (80, '042', '水产捕捞', '', 157, 162, 76, 3);
INSERT INTO `industry` VALUES (81, '0421', '海水捕捞', '', 158, 159, 80, 4);
INSERT INTO `industry` VALUES (82, '0422', '内陆捕捞', '', 160, 161, 80, 4);
INSERT INTO `industry` VALUES (83, '05', '农、林、牧、渔专业及辅助性活动', '', 164, 203, 1, 2);
INSERT INTO `industry` VALUES (84, '051', '农业专业及辅助性活动', '', 165, 178, 83, 3);
INSERT INTO `industry` VALUES (85, '0511', '种子种苗培育活动', '', 166, 167, 84, 4);
INSERT INTO `industry` VALUES (86, '0512', '农业机械活动', '', 168, 169, 84, 4);
INSERT INTO `industry` VALUES (87, '0513', '灌溉活动', '', 170, 171, 84, 4);
INSERT INTO `industry` VALUES (88, '0514', '农产品初加工活动', '', 172, 173, 84, 4);
INSERT INTO `industry` VALUES (89, '0515', '农作物病虫害防治活动', '', 174, 175, 84, 4);
INSERT INTO `industry` VALUES (90, '0519', '其他农业专业及辅助性活动', '', 176, 177, 84, 4);
INSERT INTO `industry` VALUES (91, '052', '林业专业及辅助性活动', '', 179, 188, 83, 3);
INSERT INTO `industry` VALUES (92, '0521', '林业有害生物防治活动', '', 180, 181, 91, 4);
INSERT INTO `industry` VALUES (93, '0522', '森林防火活动', '', 182, 183, 91, 4);
INSERT INTO `industry` VALUES (94, '0523', '林产品初级加工活动', '', 184, 185, 91, 4);
INSERT INTO `industry` VALUES (95, '0529', '其他林业专业及辅助性活动', '', 186, 187, 91, 4);
INSERT INTO `industry` VALUES (96, '053', '畜牧专业及辅助性活动', '', 189, 196, 83, 3);
INSERT INTO `industry` VALUES (97, '0531', '畜牧良种繁殖活动', '', 190, 191, 96, 4);
INSERT INTO `industry` VALUES (98, '0532', '畜禽粪污处理活动', '', 192, 193, 96, 4);
INSERT INTO `industry` VALUES (99, '0539', '其他畜牧专业及辅助性活动', '', 194, 195, 96, 4);
INSERT INTO `industry` VALUES (100, '054', '渔业专业及辅助性活动', '', 197, 202, 83, 3);
INSERT INTO `industry` VALUES (101, '0541', '鱼苗及鱼种场活动', '', 198, 199, 100, 4);
INSERT INTO `industry` VALUES (102, '0549', '其他渔业专业及辅助性活动', '', 200, 201, 100, 4);
INSERT INTO `industry` VALUES (103, 'B', '采矿业', '', 205, 336, 0, 1);
INSERT INTO `industry` VALUES (104, '06', '煤炭开采和洗选业', '', 206, 219, 103, 2);
INSERT INTO `industry` VALUES (105, '061', '烟煤和无烟煤开采洗选', '', 207, 210, 104, 3);
INSERT INTO `industry` VALUES (106, '0610', '烟煤和无烟煤开采洗选', '', 208, 209, 105, 4);
INSERT INTO `industry` VALUES (107, '062', '褐煤开采洗选', '', 211, 214, 104, 3);
INSERT INTO `industry` VALUES (108, '0620', '褐煤开采洗选', '', 212, 213, 107, 4);
INSERT INTO `industry` VALUES (109, '069', '其他煤炭采选', '', 215, 218, 104, 3);
INSERT INTO `industry` VALUES (110, '0690', '其他煤炭采选', '', 216, 217, 109, 4);
INSERT INTO `industry` VALUES (111, '07', '石油和天然气开采业', '', 220, 233, 103, 2);
INSERT INTO `industry` VALUES (112, '071', '石油开采', '', 221, 226, 111, 3);
INSERT INTO `industry` VALUES (113, '0711', '陆地石油开采', '', 222, 223, 112, 4);
INSERT INTO `industry` VALUES (114, '0712', '海洋石油开采', '', 224, 225, 112, 4);
INSERT INTO `industry` VALUES (115, '072', '天然气开采', '', 227, 232, 111, 3);
INSERT INTO `industry` VALUES (116, '0721', '陆地天然气开采', '', 228, 229, 115, 4);
INSERT INTO `industry` VALUES (117, '0722', '海洋天然气及可燃冰开采', '', 230, 231, 115, 4);
INSERT INTO `industry` VALUES (118, '08', '黑色金属矿采选业', '', 234, 247, 103, 2);
INSERT INTO `industry` VALUES (119, '081', '铁矿采选', '', 235, 238, 118, 3);
INSERT INTO `industry` VALUES (120, '0810', '铁矿采选', '', 236, 237, 119, 4);
INSERT INTO `industry` VALUES (121, '082', '锰矿、铬矿采选', '', 239, 242, 118, 3);
INSERT INTO `industry` VALUES (122, '0820', '锰矿、铬矿采选', '', 240, 241, 121, 4);
INSERT INTO `industry` VALUES (123, '089', '其他黑色金属矿采选', '', 243, 246, 118, 3);
INSERT INTO `industry` VALUES (124, '0890', '其他黑色金属矿采选', '', 244, 245, 123, 4);
INSERT INTO `industry` VALUES (125, '09', '有色金属矿采选业', '', 248, 285, 103, 2);
INSERT INTO `industry` VALUES (126, '091', '常用有色金属矿采选', '', 249, 266, 125, 3);
INSERT INTO `industry` VALUES (127, '0911', '铜矿采选', '', 250, 251, 126, 4);
INSERT INTO `industry` VALUES (128, '0912', '铅锌矿采选', '', 252, 253, 126, 4);
INSERT INTO `industry` VALUES (129, '0913', '镍钴矿采选', '', 254, 255, 126, 4);
INSERT INTO `industry` VALUES (130, '0914', '锡矿采选', '', 256, 257, 126, 4);
INSERT INTO `industry` VALUES (131, '0915', '锑矿采选', '', 258, 259, 126, 4);
INSERT INTO `industry` VALUES (132, '0916', '铝矿采选', '', 260, 261, 126, 4);
INSERT INTO `industry` VALUES (133, '0917', '镁矿采选', '', 262, 263, 126, 4);
INSERT INTO `industry` VALUES (134, '0919', '其他常用有色金属矿采选', '', 264, 265, 126, 4);
INSERT INTO `industry` VALUES (135, '092', '贵金属矿采选', '', 267, 274, 125, 3);
INSERT INTO `industry` VALUES (136, '0921', '金矿采选', '', 268, 269, 135, 4);
INSERT INTO `industry` VALUES (137, '0922', '银矿采选', '', 270, 271, 135, 4);
INSERT INTO `industry` VALUES (138, '0929', '其他贵金属矿采选', '', 272, 273, 135, 4);
INSERT INTO `industry` VALUES (139, '093', '稀有稀土金属矿采选', '', 275, 284, 125, 3);
INSERT INTO `industry` VALUES (140, '0931', '钨钼矿采选', '', 276, 277, 139, 4);
INSERT INTO `industry` VALUES (141, '0932', '稀土金属矿采选', '', 278, 279, 139, 4);
INSERT INTO `industry` VALUES (142, '0933', '放射性金属矿采选', '', 280, 281, 139, 4);
INSERT INTO `industry` VALUES (143, '0939', '其他稀有金属矿采选', '', 282, 283, 139, 4);
INSERT INTO `industry` VALUES (144, '10', '非金属矿采选业', '', 286, 315, 103, 2);
INSERT INTO `industry` VALUES (145, '101', '土砂石开采', '', 287, 296, 144, 3);
INSERT INTO `industry` VALUES (146, '1011', '石灰石、石膏开采', '', 288, 289, 145, 4);
INSERT INTO `industry` VALUES (147, '1012', '建筑装饰用石开采', '', 290, 291, 145, 4);
INSERT INTO `industry` VALUES (148, '1013', '耐火土石开采', '', 292, 293, 145, 4);
INSERT INTO `industry` VALUES (149, '1019', '粘土及其他土砂石开采', '', 294, 295, 145, 4);
INSERT INTO `industry` VALUES (150, '102', '化学矿开采', '', 297, 300, 144, 3);
INSERT INTO `industry` VALUES (151, '1020', '化学矿开采', '', 298, 299, 150, 4);
INSERT INTO `industry` VALUES (152, '103', '采盐', '', 301, 304, 144, 3);
INSERT INTO `industry` VALUES (153, '1030', '采盐', '', 302, 303, 152, 4);
INSERT INTO `industry` VALUES (154, '109', '石棉及其他非金属矿采选', '', 305, 314, 144, 3);
INSERT INTO `industry` VALUES (155, '1091', '石棉、云母矿采选', '', 306, 307, 154, 4);
INSERT INTO `industry` VALUES (156, '1092', '石墨、滑石采选', '', 308, 309, 154, 4);
INSERT INTO `industry` VALUES (157, '1093', '宝石、玉石采选', '', 310, 311, 154, 4);
INSERT INTO `industry` VALUES (158, '1099', '其他未列明非金属矿采选', '', 312, 313, 154, 4);
INSERT INTO `industry` VALUES (159, '11', '开采专业及辅助性活动', '', 316, 329, 103, 2);
INSERT INTO `industry` VALUES (160, '111', '煤炭开采和洗选专业及辅助性活动', '', 317, 320, 159, 3);
INSERT INTO `industry` VALUES (161, '1110', '煤炭开采和洗选专业及辅助性活动', '', 318, 319, 160, 4);
INSERT INTO `industry` VALUES (162, '112', '石油和天然气开采专业及辅助性活动', '', 321, 324, 159, 3);
INSERT INTO `industry` VALUES (163, '1120', '石油和天然气开采专业及辅助性活动', '', 322, 323, 162, 4);
INSERT INTO `industry` VALUES (164, '119', '其他开采专业及辅助性活动', '', 325, 328, 159, 3);
INSERT INTO `industry` VALUES (165, '1190', '其他开采专业及辅助性活动', '', 326, 327, 164, 4);
INSERT INTO `industry` VALUES (166, '12', '其他采矿业', '', 330, 335, 103, 2);
INSERT INTO `industry` VALUES (167, '120', '其他采矿业', '', 331, 334, 166, 3);
INSERT INTO `industry` VALUES (168, '1200', '其他采矿业', '', 332, 333, 167, 4);
INSERT INTO `industry` VALUES (169, 'C', '制造业', '', 337, 1976, 0, 1);
INSERT INTO `industry` VALUES (170, '13', '农副食品加工业', '', 338, 403, 169, 2);
INSERT INTO `industry` VALUES (171, '131', '谷物磨制', '', 339, 350, 170, 3);
INSERT INTO `industry` VALUES (172, '1311', '稻谷加工', '', 340, 341, 171, 4);
INSERT INTO `industry` VALUES (173, '1312', '小麦加工', '', 342, 343, 171, 4);
INSERT INTO `industry` VALUES (174, '1313', '玉米加工', '', 344, 345, 171, 4);
INSERT INTO `industry` VALUES (175, '1314', '杂粮加工', '', 346, 347, 171, 4);
INSERT INTO `industry` VALUES (176, '1319', '其他谷物磨制', '', 348, 349, 171, 4);
INSERT INTO `industry` VALUES (177, '132', '饲料加工', '', 351, 356, 170, 3);
INSERT INTO `industry` VALUES (178, '1321', '宠物饲料加工', '', 352, 353, 177, 4);
INSERT INTO `industry` VALUES (179, '1329', '其他饲料加工', '', 354, 355, 177, 4);
INSERT INTO `industry` VALUES (180, '133', '植物油加工', '', 357, 362, 170, 3);
INSERT INTO `industry` VALUES (181, '1331', '食用植物油加工', '', 358, 359, 180, 4);
INSERT INTO `industry` VALUES (182, '1332', '非食用植物油加工', '', 360, 361, 180, 4);
INSERT INTO `industry` VALUES (183, '134', '制糖业', '', 363, 366, 170, 3);
INSERT INTO `industry` VALUES (184, '1340', '制糖业', '', 364, 365, 183, 4);
INSERT INTO `industry` VALUES (185, '135', '屠宰及肉类加工', '', 367, 374, 170, 3);
INSERT INTO `industry` VALUES (186, '1351', '牲畜屠宰', '', 368, 369, 185, 4);
INSERT INTO `industry` VALUES (187, '1352', '禽类屠宰', '', 370, 371, 185, 4);
INSERT INTO `industry` VALUES (188, '1353', '肉制品及副产品加工', '', 372, 373, 185, 4);
INSERT INTO `industry` VALUES (189, '136', '水产品加工', '', 375, 384, 170, 3);
INSERT INTO `industry` VALUES (190, '1361', '水产品冷冻加工', '', 376, 377, 189, 4);
INSERT INTO `industry` VALUES (191, '1362', '鱼糜制品及水产品干腌制加工', '', 378, 379, 189, 4);
INSERT INTO `industry` VALUES (192, '1363', '鱼油提取及制品制造', '', 380, 381, 189, 4);
INSERT INTO `industry` VALUES (193, '1369', '其他水产品加工', '', 382, 383, 189, 4);
INSERT INTO `industry` VALUES (194, '137', '蔬菜、菌类、水果和坚果加工', '', 385, 392, 170, 3);
INSERT INTO `industry` VALUES (195, '1371', '蔬菜加工', '', 386, 387, 194, 4);
INSERT INTO `industry` VALUES (196, '1372', '食用菌加工', '', 388, 389, 194, 4);
INSERT INTO `industry` VALUES (197, '1373', '水果和坚果加工', '', 390, 391, 194, 4);
INSERT INTO `industry` VALUES (198, '139', '其他农副食品加工', '', 393, 402, 170, 3);
INSERT INTO `industry` VALUES (199, '1391', '淀粉及淀粉制品制造', '', 394, 395, 198, 4);
INSERT INTO `industry` VALUES (200, '1392', '豆制品制造', '', 396, 397, 198, 4);
INSERT INTO `industry` VALUES (201, '1393', '蛋品加工', '', 398, 399, 198, 4);
INSERT INTO `industry` VALUES (202, '1399', '其他未列明农副食品加工', '', 400, 401, 198, 4);
INSERT INTO `industry` VALUES (203, '14', '食品制造业', '', 404, 467, 169, 2);
INSERT INTO `industry` VALUES (204, '141', '焙烤食品制造', '', 405, 410, 203, 3);
INSERT INTO `industry` VALUES (205, '1411', '糕点、面包制造', '', 406, 407, 204, 4);
INSERT INTO `industry` VALUES (206, '1419', '饼干及其他焙烤食品制造', '', 408, 409, 204, 4);
INSERT INTO `industry` VALUES (207, '142', '糖果、巧克力及蜜饯制造', '', 411, 416, 203, 3);
INSERT INTO `industry` VALUES (208, '1421', '糖果、巧克力制造', '', 412, 413, 207, 4);
INSERT INTO `industry` VALUES (209, '1422', '蜜饯制作', '', 414, 415, 207, 4);
INSERT INTO `industry` VALUES (210, '143', '方便食品制造', '', 417, 426, 203, 3);
INSERT INTO `industry` VALUES (211, '1431', '米、面制品制造', '', 418, 419, 210, 4);
INSERT INTO `industry` VALUES (212, '1432', '速冻食品制造', '', 420, 421, 210, 4);
INSERT INTO `industry` VALUES (213, '1433', '方便面制造', '', 422, 423, 210, 4);
INSERT INTO `industry` VALUES (214, '1439', '其他方便食品制造', '', 424, 425, 210, 4);
INSERT INTO `industry` VALUES (215, '144', '乳制品制造', '', 427, 434, 203, 3);
INSERT INTO `industry` VALUES (216, '1441', '液体乳制造', '', 428, 429, 215, 4);
INSERT INTO `industry` VALUES (217, '1442', '乳粉制造', '', 430, 431, 215, 4);
INSERT INTO `industry` VALUES (218, '1449', '其他乳制品制造', '', 432, 433, 215, 4);
INSERT INTO `industry` VALUES (219, '145', '罐头食品制造', '', 435, 444, 203, 3);
INSERT INTO `industry` VALUES (220, '1451', '肉、禽类罐头制造', '', 436, 437, 219, 4);
INSERT INTO `industry` VALUES (221, '1452', '水产品罐头制造', '', 438, 439, 219, 4);
INSERT INTO `industry` VALUES (222, '1453', '蔬菜、水果罐头制造', '', 440, 441, 219, 4);
INSERT INTO `industry` VALUES (223, '1459', '其他罐头食品制造', '', 442, 443, 219, 4);
INSERT INTO `industry` VALUES (224, '146', '调味品、发酵制品制造', '', 445, 452, 203, 3);
INSERT INTO `industry` VALUES (225, '1461', '味精制造', '', 446, 447, 224, 4);
INSERT INTO `industry` VALUES (226, '1462', '酱油、食醋及类似制品制造', '', 448, 449, 224, 4);
INSERT INTO `industry` VALUES (227, '1469', '其他调味品、发酵制品制造', '', 450, 451, 224, 4);
INSERT INTO `industry` VALUES (228, '149', '其他食品制造', '', 453, 466, 203, 3);
INSERT INTO `industry` VALUES (229, '1491', '营养食品制造', '', 454, 455, 228, 4);
INSERT INTO `industry` VALUES (230, '1492', '保健食品制造', '', 456, 457, 228, 4);
INSERT INTO `industry` VALUES (231, '1493', '冷冻饮品及食用冰制造', '', 458, 459, 228, 4);
INSERT INTO `industry` VALUES (232, '1494', '盐加工', '', 460, 461, 228, 4);
INSERT INTO `industry` VALUES (233, '1495', '食品及饲料添加剂制造', '', 462, 463, 228, 4);
INSERT INTO `industry` VALUES (234, '1499', '其他未列明食品制造', '', 464, 465, 228, 4);
INSERT INTO `industry` VALUES (235, '15', '酒、饮料和精制茶制造业', '', 468, 501, 169, 2);
INSERT INTO `industry` VALUES (236, '151', '酒的制造', '', 469, 482, 235, 3);
INSERT INTO `industry` VALUES (237, '1511', '酒精制造', '', 470, 471, 236, 4);
INSERT INTO `industry` VALUES (238, '1512', '白酒制造', '', 472, 473, 236, 4);
INSERT INTO `industry` VALUES (239, '1513', '啤酒制造', '', 474, 475, 236, 4);
INSERT INTO `industry` VALUES (240, '1514', '黄酒制造', '', 476, 477, 236, 4);
INSERT INTO `industry` VALUES (241, '1515', '葡萄酒制造', '', 478, 479, 236, 4);
INSERT INTO `industry` VALUES (242, '1519', '其他酒制造', '', 480, 481, 236, 4);
INSERT INTO `industry` VALUES (243, '152', '饮料制造', '', 483, 496, 235, 3);
INSERT INTO `industry` VALUES (244, '1521', '碳酸饮料制造', '', 484, 485, 243, 4);
INSERT INTO `industry` VALUES (245, '1522', '瓶（罐）装饮用水制造', '', 486, 487, 243, 4);
INSERT INTO `industry` VALUES (246, '1523', '果菜汁及果菜汁饮料制造', '', 488, 489, 243, 4);
INSERT INTO `industry` VALUES (247, '1524', '含乳饮料和植物蛋白饮料制造', '', 490, 491, 243, 4);
INSERT INTO `industry` VALUES (248, '1525', '固体饮料制造', '', 492, 493, 243, 4);
INSERT INTO `industry` VALUES (249, '1529', '茶饮料及其他饮料制造', '', 494, 495, 243, 4);
INSERT INTO `industry` VALUES (250, '153', '精制茶加工', '', 497, 500, 235, 3);
INSERT INTO `industry` VALUES (251, '1530', '精制茶加工', '', 498, 499, 250, 4);
INSERT INTO `industry` VALUES (252, '16', '烟草制品业', '', 502, 515, 169, 2);
INSERT INTO `industry` VALUES (253, '161', '烟叶复烤', '', 503, 506, 252, 3);
INSERT INTO `industry` VALUES (254, '1610', '烟叶复烤', '', 504, 505, 253, 4);
INSERT INTO `industry` VALUES (255, '162', '卷烟制造', '', 507, 510, 252, 3);
INSERT INTO `industry` VALUES (256, '1620', '卷烟制造', '', 508, 509, 255, 4);
INSERT INTO `industry` VALUES (257, '169', '其他烟草制品制造', '', 511, 514, 252, 3);
INSERT INTO `industry` VALUES (258, '1690', '其他烟草制品制造', '', 512, 513, 257, 4);
INSERT INTO `industry` VALUES (259, '17', '纺织业', '', 516, 585, 169, 2);
INSERT INTO `industry` VALUES (260, '171', '棉纺织及印染精加工', '', 517, 524, 259, 3);
INSERT INTO `industry` VALUES (261, '1711', '棉纺纱加工', '', 518, 519, 260, 4);
INSERT INTO `industry` VALUES (262, '1712', '棉织造加工', '', 520, 521, 260, 4);
INSERT INTO `industry` VALUES (263, '1713', '棉印染精加工', '', 522, 523, 260, 4);
INSERT INTO `industry` VALUES (264, '172', '毛纺织及染整精加工', '', 525, 532, 259, 3);
INSERT INTO `industry` VALUES (265, '1721', '毛条和毛纱线加工', '', 526, 527, 264, 4);
INSERT INTO `industry` VALUES (266, '1722', '毛织造加工', '', 528, 529, 264, 4);
INSERT INTO `industry` VALUES (267, '1723', '毛染整精加工', '', 530, 531, 264, 4);
INSERT INTO `industry` VALUES (268, '173', '麻纺织及染整精加工', '', 533, 540, 259, 3);
INSERT INTO `industry` VALUES (269, '1731', '麻纤维纺前加工和纺纱', '', 534, 535, 268, 4);
INSERT INTO `industry` VALUES (270, '1732', '麻织造加工', '', 536, 537, 268, 4);
INSERT INTO `industry` VALUES (271, '1733', '麻染整精加工', '', 538, 539, 268, 4);
INSERT INTO `industry` VALUES (272, '174', '丝绢纺织及印染精加工', '', 541, 548, 259, 3);
INSERT INTO `industry` VALUES (273, '1741', '缫丝加工', '', 542, 543, 272, 4);
INSERT INTO `industry` VALUES (274, '1742', '绢纺和丝织加工', '', 544, 545, 272, 4);
INSERT INTO `industry` VALUES (275, '1743', '丝印染精加工', '', 546, 547, 272, 4);
INSERT INTO `industry` VALUES (276, '175', '化纤织造及印染精加工', '', 549, 554, 259, 3);
INSERT INTO `industry` VALUES (277, '1751', '化纤织造加工', '', 550, 551, 276, 4);
INSERT INTO `industry` VALUES (278, '1752', '化纤织物染整精加工', '', 552, 553, 276, 4);
INSERT INTO `industry` VALUES (279, '176', '针织或钩针编织物及其制品制造', '', 555, 562, 259, 3);
INSERT INTO `industry` VALUES (280, '1761', '针织或钩针编织物织造', '', 556, 557, 279, 4);
INSERT INTO `industry` VALUES (281, '1762', '针织或钩针编织物印染精加工', '', 558, 559, 279, 4);
INSERT INTO `industry` VALUES (282, '1763', '针织或钩针编织品制造', '', 560, 561, 279, 4);
INSERT INTO `industry` VALUES (283, '177', '家用纺织制成品制造', '', 563, 572, 259, 3);
INSERT INTO `industry` VALUES (284, '1771', '床上用品制造', '', 564, 565, 283, 4);
INSERT INTO `industry` VALUES (285, '1772', '毛巾类制品制造', '', 566, 567, 283, 4);
INSERT INTO `industry` VALUES (286, '1773', '窗帘、布艺类产品制造', '', 568, 569, 283, 4);
INSERT INTO `industry` VALUES (287, '1779', '其他家用纺织制成品制造', '', 570, 571, 283, 4);
INSERT INTO `industry` VALUES (288, '178', '产业用纺织制成品制造', '', 573, 584, 259, 3);
INSERT INTO `industry` VALUES (289, '1781', '非织造布制造', '', 574, 575, 288, 4);
INSERT INTO `industry` VALUES (290, '1782', '绳、索、缆制造', '', 576, 577, 288, 4);
INSERT INTO `industry` VALUES (291, '1783', '纺织带和帘子布制造', '', 578, 579, 288, 4);
INSERT INTO `industry` VALUES (292, '1784', '篷、帆布制造', '', 580, 581, 288, 4);
INSERT INTO `industry` VALUES (293, '1789', '其他产业用纺织制成品制造', '', 582, 583, 288, 4);
INSERT INTO `industry` VALUES (294, '18', '纺织服装、服饰业', '', 586, 603, 169, 2);
INSERT INTO `industry` VALUES (295, '181', '机织服装制造', '', 587, 592, 294, 3);
INSERT INTO `industry` VALUES (296, '1811', '运动机织服装制造', '', 588, 589, 295, 4);
INSERT INTO `industry` VALUES (297, '1819', '其他机织服装制造', '', 590, 591, 295, 4);
INSERT INTO `industry` VALUES (298, '182', '针织或钩针编织服装制造', '', 593, 598, 294, 3);
INSERT INTO `industry` VALUES (299, '1821', '运动休闲针织服装制造', '', 594, 595, 298, 4);
INSERT INTO `industry` VALUES (300, '1829', '其他针织或钩针编织服装制造', '', 596, 597, 298, 4);
INSERT INTO `industry` VALUES (301, '183', '服饰制造', '', 599, 602, 294, 3);
INSERT INTO `industry` VALUES (302, '1830', '服饰制造', '', 600, 601, 301, 4);
INSERT INTO `industry` VALUES (303, '19', '皮革、毛皮、羽毛及其制品和制鞋业', '', 604, 645, 169, 2);
INSERT INTO `industry` VALUES (304, '191', '皮革鞣制加工', '', 605, 608, 303, 3);
INSERT INTO `industry` VALUES (305, '1910', '皮革鞣制加工', '', 606, 607, 304, 4);
INSERT INTO `industry` VALUES (306, '192', '皮革制品制造', '', 609, 618, 303, 3);
INSERT INTO `industry` VALUES (307, '1921', '皮革服装制造', '', 610, 611, 306, 4);
INSERT INTO `industry` VALUES (308, '1922', '皮箱、包（袋）制造', '', 612, 613, 306, 4);
INSERT INTO `industry` VALUES (309, '1923', '皮手套及皮装饰制品制造', '', 614, 615, 306, 4);
INSERT INTO `industry` VALUES (310, '1929', '其他皮革制品制造', '', 616, 617, 306, 4);
INSERT INTO `industry` VALUES (311, '193', '毛皮鞣制及制品加工', '', 619, 626, 303, 3);
INSERT INTO `industry` VALUES (312, '1931', '毛皮鞣制加工', '', 620, 621, 311, 4);
INSERT INTO `industry` VALUES (313, '1932', '毛皮服装加工', '', 622, 623, 311, 4);
INSERT INTO `industry` VALUES (314, '1939', '其他毛皮制品加工', '', 624, 625, 311, 4);
INSERT INTO `industry` VALUES (315, '194', '羽毛(绒)加工及制品制造', '', 627, 632, 303, 3);
INSERT INTO `industry` VALUES (316, '1941', '羽毛（绒）加工', '', 628, 629, 315, 4);
INSERT INTO `industry` VALUES (317, '1942', '羽毛（绒）制品加工', '', 630, 631, 315, 4);
INSERT INTO `industry` VALUES (318, '195', '制鞋业', '', 633, 644, 303, 3);
INSERT INTO `industry` VALUES (319, '1951', '纺织面料鞋制造', '', 634, 635, 318, 4);
INSERT INTO `industry` VALUES (320, '1952', '皮鞋制造', '', 636, 637, 318, 4);
INSERT INTO `industry` VALUES (321, '1953', '塑料鞋制造', '', 638, 639, 318, 4);
INSERT INTO `industry` VALUES (322, '1954', '橡胶鞋制造', '', 640, 641, 318, 4);
INSERT INTO `industry` VALUES (323, '1959', '其他制鞋业', '', 642, 643, 318, 4);
INSERT INTO `industry` VALUES (324, '20', '木材加工和木、竹、藤、棕、草制品业', '', 646, 691, 169, 2);
INSERT INTO `industry` VALUES (325, '201', '木材加工', '', 647, 656, 324, 3);
INSERT INTO `industry` VALUES (326, '2011', '锯材加工', '', 648, 649, 325, 4);
INSERT INTO `industry` VALUES (327, '2012', '木片加工', '', 650, 651, 325, 4);
INSERT INTO `industry` VALUES (328, '2013', '单板加工', '', 652, 653, 325, 4);
INSERT INTO `industry` VALUES (329, '2019', '其他木材加工', '', 654, 655, 325, 4);
INSERT INTO `industry` VALUES (330, '202', '人造板制造', '', 657, 666, 324, 3);
INSERT INTO `industry` VALUES (331, '2021', '胶合板制造', '', 658, 659, 330, 4);
INSERT INTO `industry` VALUES (332, '2022', '纤维板制造', '', 660, 661, 330, 4);
INSERT INTO `industry` VALUES (333, '2023', '刨花板制造', '', 662, 663, 330, 4);
INSERT INTO `industry` VALUES (334, '2029', '其他人造板制造', '', 664, 665, 330, 4);
INSERT INTO `industry` VALUES (335, '203', '木质制品制造', '', 667, 680, 324, 3);
INSERT INTO `industry` VALUES (336, '2031', '建筑用木料及木材组件加工', '', 668, 669, 335, 4);
INSERT INTO `industry` VALUES (337, '2032', '木门窗制造', '', 670, 671, 335, 4);
INSERT INTO `industry` VALUES (338, '2033', '木楼梯制造', '', 672, 673, 335, 4);
INSERT INTO `industry` VALUES (339, '2034', '木地板制造', '', 674, 675, 335, 4);
INSERT INTO `industry` VALUES (340, '2035', '木制容器制造', '', 676, 677, 335, 4);
INSERT INTO `industry` VALUES (341, '2039', '软木制品及其他木制品制造', '', 678, 679, 335, 4);
INSERT INTO `industry` VALUES (342, '204', '竹、藤、棕、草等制品制造', '', 681, 690, 324, 3);
INSERT INTO `industry` VALUES (343, '2041', '竹制品制造', '', 682, 683, 342, 4);
INSERT INTO `industry` VALUES (344, '2042', '藤制品制造', '', 684, 685, 342, 4);
INSERT INTO `industry` VALUES (345, '2043', '棕制品制造', '', 686, 687, 342, 4);
INSERT INTO `industry` VALUES (346, '2049', '草及其他制品制造', '', 688, 689, 342, 4);
INSERT INTO `industry` VALUES (347, '21', '家具制造业', '', 692, 713, 169, 2);
INSERT INTO `industry` VALUES (348, '211', '木质家具制造', '', 693, 696, 347, 3);
INSERT INTO `industry` VALUES (349, '2110', '木质家具制造', '', 694, 695, 348, 4);
INSERT INTO `industry` VALUES (350, '212', '竹、藤家具制造', '', 697, 700, 347, 3);
INSERT INTO `industry` VALUES (351, '2120', '竹、藤家具制造', '', 698, 699, 350, 4);
INSERT INTO `industry` VALUES (352, '213', '金属家具制造', '', 701, 704, 347, 3);
INSERT INTO `industry` VALUES (353, '2130', '金属家具制造', '', 702, 703, 352, 4);
INSERT INTO `industry` VALUES (354, '214', '塑料家具制造', '', 705, 708, 347, 3);
INSERT INTO `industry` VALUES (355, '2140', '塑料家具制造', '', 706, 707, 354, 4);
INSERT INTO `industry` VALUES (356, '219', '其他家具制造', '', 709, 712, 347, 3);
INSERT INTO `industry` VALUES (357, '2190', '其他家具制造', '', 710, 711, 356, 4);
INSERT INTO `industry` VALUES (358, '22', '造纸和纸制品业', '', 714, 735, 169, 2);
INSERT INTO `industry` VALUES (359, '221', '纸浆制造', '', 715, 720, 358, 3);
INSERT INTO `industry` VALUES (360, '2211', '木竹浆制造', '', 716, 717, 359, 4);
INSERT INTO `industry` VALUES (361, '2212', '非木竹浆制造', '', 718, 719, 359, 4);
INSERT INTO `industry` VALUES (362, '222', '造纸', '', 721, 728, 358, 3);
INSERT INTO `industry` VALUES (363, '2221', '机制纸及纸板制造', '', 722, 723, 362, 4);
INSERT INTO `industry` VALUES (364, '2222', '手工纸制造', '', 724, 725, 362, 4);
INSERT INTO `industry` VALUES (365, '2223', '加工纸制造', '', 726, 727, 362, 4);
INSERT INTO `industry` VALUES (366, '223', '纸制品制造', '', 729, 734, 358, 3);
INSERT INTO `industry` VALUES (367, '2231', '纸和纸板容器制造', '', 730, 731, 366, 4);
INSERT INTO `industry` VALUES (368, '2239', '其他纸制品制造', '', 732, 733, 366, 4);
INSERT INTO `industry` VALUES (369, '23', '印刷和记录媒介复制业', '', 736, 753, 169, 2);
INSERT INTO `industry` VALUES (370, '231', '印刷', '', 737, 744, 369, 3);
INSERT INTO `industry` VALUES (371, '2311', '书、报刊印刷', '', 738, 739, 370, 4);
INSERT INTO `industry` VALUES (372, '2312', '本册印制', '', 740, 741, 370, 4);
INSERT INTO `industry` VALUES (373, '2319', '包装装潢及其他印刷', '', 742, 743, 370, 4);
INSERT INTO `industry` VALUES (374, '232', '装订及印刷相关服务', '', 745, 748, 369, 3);
INSERT INTO `industry` VALUES (375, '2320', '装订及印刷相关服务', '', 746, 747, 374, 4);
INSERT INTO `industry` VALUES (376, '233', '记录媒介复制', '', 749, 752, 369, 3);
INSERT INTO `industry` VALUES (377, '2330', '记录媒介复制', '', 750, 751, 376, 4);
INSERT INTO `industry` VALUES (378, '24', '文教、工美、体育和娱乐用品制造业', '', 754, 833, 169, 2);
INSERT INTO `industry` VALUES (379, '241', '文教办公用品制造', '', 755, 766, 378, 3);
INSERT INTO `industry` VALUES (380, '2411', '文具制造', '', 756, 757, 379, 4);
INSERT INTO `industry` VALUES (381, '2412', '笔的制造', '', 758, 759, 379, 4);
INSERT INTO `industry` VALUES (382, '2413', '教学用模型及教具制造', '', 760, 761, 379, 4);
INSERT INTO `industry` VALUES (383, '2414', '墨水、墨汁制造', '', 762, 763, 379, 4);
INSERT INTO `industry` VALUES (384, '2419', '其他文教办公用品制造', '', 764, 765, 379, 4);
INSERT INTO `industry` VALUES (385, '242', '乐器制造', '', 767, 776, 378, 3);
INSERT INTO `industry` VALUES (386, '2421', '中乐器制造', '', 768, 769, 385, 4);
INSERT INTO `industry` VALUES (387, '2422', '西乐器制造', '', 770, 771, 385, 4);
INSERT INTO `industry` VALUES (388, '2423', '电子乐器制造', '', 772, 773, 385, 4);
INSERT INTO `industry` VALUES (389, '2429', '其他乐器及零件制造', '', 774, 775, 385, 4);
INSERT INTO `industry` VALUES (390, '243', '工艺美术及礼仪用品制造', '', 777, 796, 378, 3);
INSERT INTO `industry` VALUES (391, '2431', '雕塑工艺品制造', '', 778, 779, 390, 4);
INSERT INTO `industry` VALUES (392, '2432', '金属工艺品制造', '', 780, 781, 390, 4);
INSERT INTO `industry` VALUES (393, '2433', '漆器工艺品制造', '', 782, 783, 390, 4);
INSERT INTO `industry` VALUES (394, '2434', '花画工艺品制造', '', 784, 785, 390, 4);
INSERT INTO `industry` VALUES (395, '2435', '天然植物纤维编织工艺品制造', '', 786, 787, 390, 4);
INSERT INTO `industry` VALUES (396, '2436', '抽纱刺绣工艺品制造', '', 788, 789, 390, 4);
INSERT INTO `industry` VALUES (397, '2437', '地毯、挂毯制造', '', 790, 791, 390, 4);
INSERT INTO `industry` VALUES (398, '2438', '珠宝首饰及有关物品制造', '', 792, 793, 390, 4);
INSERT INTO `industry` VALUES (399, '2439', '其他工艺美术及礼仪用品制造', '', 794, 795, 390, 4);
INSERT INTO `industry` VALUES (400, '244', '体育用品制造', '', 797, 808, 378, 3);
INSERT INTO `industry` VALUES (401, '2441', '球类制造', '', 798, 799, 400, 4);
INSERT INTO `industry` VALUES (402, '2442', '专项运动器材及配件制造', '', 800, 801, 400, 4);
INSERT INTO `industry` VALUES (403, '2443', '健身器材制造', '', 802, 803, 400, 4);
INSERT INTO `industry` VALUES (404, '2444', '运动防护用具制造', '', 804, 805, 400, 4);
INSERT INTO `industry` VALUES (405, '2449', '其他体育用品制造', '', 806, 807, 400, 4);
INSERT INTO `industry` VALUES (406, '245', '玩具制造', '', 809, 824, 378, 3);
INSERT INTO `industry` VALUES (407, '2451', '电玩具制造', '', 810, 811, 406, 4);
INSERT INTO `industry` VALUES (408, '2452', '塑胶玩具制造', '', 812, 813, 406, 4);
INSERT INTO `industry` VALUES (409, '2453', '金属玩具制造', '', 814, 815, 406, 4);
INSERT INTO `industry` VALUES (410, '2454', '弹射玩具制造', '', 816, 817, 406, 4);
INSERT INTO `industry` VALUES (411, '2455', '娃娃玩具制造', '', 818, 819, 406, 4);
INSERT INTO `industry` VALUES (412, '2456', '儿童乘骑玩耍的童车类产品制造', '', 820, 821, 406, 4);
INSERT INTO `industry` VALUES (413, '2459', '其他玩具制造', '', 822, 823, 406, 4);
INSERT INTO `industry` VALUES (414, '246', '游艺器材及娱乐用品制造', '', 825, 832, 378, 3);
INSERT INTO `industry` VALUES (415, '2461', '露天游乐场所游乐设备制造', '', 826, 827, 414, 4);
INSERT INTO `industry` VALUES (416, '2462', '游艺用品及室内游艺器材制造', '', 828, 829, 414, 4);
INSERT INTO `industry` VALUES (417, '2469', '其他娱乐用品制造', '', 830, 831, 414, 4);
INSERT INTO `industry` VALUES (418, '25', '石油、煤炭及其他燃料加工业', '', 834, 863, 169, 2);
INSERT INTO `industry` VALUES (419, '251', '精炼石油产品制造', '', 835, 840, 418, 3);
INSERT INTO `industry` VALUES (420, '2511', '原油加工及石油制品制造', '', 836, 837, 419, 4);
INSERT INTO `industry` VALUES (421, '2519', '其他原油制造', '', 838, 839, 419, 4);
INSERT INTO `industry` VALUES (422, '252', '煤炭加工', '', 841, 852, 418, 3);
INSERT INTO `industry` VALUES (423, '2521', '炼焦', '', 842, 843, 422, 4);
INSERT INTO `industry` VALUES (424, '2522', '煤制合成气生产', '', 844, 845, 422, 4);
INSERT INTO `industry` VALUES (425, '2523', '煤制液体燃料生产', '', 846, 847, 422, 4);
INSERT INTO `industry` VALUES (426, '2524', '煤制品制造', '', 848, 849, 422, 4);
INSERT INTO `industry` VALUES (427, '2529', '其他煤炭加工', '', 850, 851, 422, 4);
INSERT INTO `industry` VALUES (428, '253', '核燃料加工', '', 853, 856, 418, 3);
INSERT INTO `industry` VALUES (429, '2530', '核燃料加工', '', 854, 855, 428, 4);
INSERT INTO `industry` VALUES (430, '254', '生物质燃料加工', '', 857, 862, 418, 3);
INSERT INTO `industry` VALUES (431, '2541', ' 生物质液体燃料生产', '', 858, 859, 430, 4);
INSERT INTO `industry` VALUES (432, '2542', '生物质致密成型燃料加工', '', 860, 861, 430, 4);
INSERT INTO `industry` VALUES (433, '26', '化学原料和化学制品制造业', '', 864, 957, 169, 2);
INSERT INTO `industry` VALUES (434, '261', '基础化学原料制造', '', 865, 876, 433, 3);
INSERT INTO `industry` VALUES (435, '2611', '无机酸制造', '', 866, 867, 434, 4);
INSERT INTO `industry` VALUES (436, '2612', '无机碱制造', '', 868, 869, 434, 4);
INSERT INTO `industry` VALUES (437, '2613', '无机盐制造', '', 870, 871, 434, 4);
INSERT INTO `industry` VALUES (438, '2614', '有机化学原料制造', '', 872, 873, 434, 4);
INSERT INTO `industry` VALUES (439, '2619', '其他基础化学原料制造', '', 874, 875, 434, 4);
INSERT INTO `industry` VALUES (440, '262', '肥料制造', '', 877, 890, 433, 3);
INSERT INTO `industry` VALUES (441, '2621', '氮肥制造', '', 878, 879, 440, 4);
INSERT INTO `industry` VALUES (442, '2622', '磷肥制造', '', 880, 881, 440, 4);
INSERT INTO `industry` VALUES (443, '2623', '钾肥制造', '', 882, 883, 440, 4);
INSERT INTO `industry` VALUES (444, '2624', '复混肥料制造', '', 884, 885, 440, 4);
INSERT INTO `industry` VALUES (445, '2625', '有机肥料及微生物肥料制造', '', 886, 887, 440, 4);
INSERT INTO `industry` VALUES (446, '2629', '其他肥料制造', '', 888, 889, 440, 4);
INSERT INTO `industry` VALUES (447, '263', '农药制造', '', 891, 896, 433, 3);
INSERT INTO `industry` VALUES (448, '2631', '化学农药制造', '', 892, 893, 447, 4);
INSERT INTO `industry` VALUES (449, '2632', '生物化学农药及微生物农药制造', '', 894, 895, 447, 4);
INSERT INTO `industry` VALUES (450, '264', '涂料、油墨、颜料及类似产品制造', '', 897, 910, 433, 3);
INSERT INTO `industry` VALUES (451, '2641', '涂料制造', '', 898, 899, 450, 4);
INSERT INTO `industry` VALUES (452, '2642', '油墨及类似产品制造', '', 900, 901, 450, 4);
INSERT INTO `industry` VALUES (453, '2643', '工业颜料制造', '', 902, 903, 450, 4);
INSERT INTO `industry` VALUES (454, '2644', '工艺美术颜料制造', '', 904, 905, 450, 4);
INSERT INTO `industry` VALUES (455, '2645', '染料制造', '', 906, 907, 450, 4);
INSERT INTO `industry` VALUES (456, '2646', '密封用填料及类似品制造', '', 908, 909, 450, 4);
INSERT INTO `industry` VALUES (457, '265', '合成材料制造', '', 911, 920, 433, 3);
INSERT INTO `industry` VALUES (458, '2651', '初级形态塑料及合成树脂制造', '', 912, 913, 457, 4);
INSERT INTO `industry` VALUES (459, '2652', '合成橡胶制造', '', 914, 915, 457, 4);
INSERT INTO `industry` VALUES (460, '2653', '合成纤维单（聚合）体制造', '', 916, 917, 457, 4);
INSERT INTO `industry` VALUES (461, '2659', '其他合成材料制造', '', 918, 919, 457, 4);
INSERT INTO `industry` VALUES (462, '266', '专用化学产品制造', '', 921, 938, 433, 3);
INSERT INTO `industry` VALUES (463, '2661', '化学试剂和助剂制造', '', 922, 923, 462, 4);
INSERT INTO `industry` VALUES (464, '2662', '专项化学用品制造', '', 924, 925, 462, 4);
INSERT INTO `industry` VALUES (465, '2663', '林产化学产品制造', '', 926, 927, 462, 4);
INSERT INTO `industry` VALUES (466, '2664', '文化用信息化学品制造', '', 928, 929, 462, 4);
INSERT INTO `industry` VALUES (467, '2665', '医学生产用信息化学品制造', '', 930, 931, 462, 4);
INSERT INTO `industry` VALUES (468, '2666', '环境污染处理专用药剂材料制造', '', 932, 933, 462, 4);
INSERT INTO `industry` VALUES (469, '2667', '动物胶制造', '', 934, 935, 462, 4);
INSERT INTO `industry` VALUES (470, '2669', '其他专用化学产品制造', '', 936, 937, 462, 4);
INSERT INTO `industry` VALUES (471, '267', '炸药、火工及焰火产品制造', '', 939, 944, 433, 3);
INSERT INTO `industry` VALUES (472, '2671', '炸药及火工产品制造', '', 940, 941, 471, 4);
INSERT INTO `industry` VALUES (473, '2672', '焰火、鞭炮产品制造', '', 942, 943, 471, 4);
INSERT INTO `industry` VALUES (474, '268', '日用化学产品制造', '', 945, 956, 433, 3);
INSERT INTO `industry` VALUES (475, '2681', '肥皂及洗涤剂制造', '', 946, 947, 474, 4);
INSERT INTO `industry` VALUES (476, '2682', '化妆品制造', '', 948, 949, 474, 4);
INSERT INTO `industry` VALUES (477, '2683', '口腔清洁用品制造', '', 950, 951, 474, 4);
INSERT INTO `industry` VALUES (478, '2684', '香料、香精制造', '', 952, 953, 474, 4);
INSERT INTO `industry` VALUES (479, '2689', '其他日用化学产品制造', '', 954, 955, 474, 4);
INSERT INTO `industry` VALUES (480, '27', '医药制造业', '', 958, 993, 169, 2);
INSERT INTO `industry` VALUES (481, '271', '化学药品原料药制造', '', 959, 962, 480, 3);
INSERT INTO `industry` VALUES (482, '2710', '化学药品原料药制造', '', 960, 961, 481, 4);
INSERT INTO `industry` VALUES (483, '272', '化学药品制剂制造', '', 963, 966, 480, 3);
INSERT INTO `industry` VALUES (484, '2720', '化学药品制剂制造', '', 964, 965, 483, 4);
INSERT INTO `industry` VALUES (485, '273', '中药饮片加工', '', 967, 970, 480, 3);
INSERT INTO `industry` VALUES (486, '2730', '中药饮片加工', '', 968, 969, 485, 4);
INSERT INTO `industry` VALUES (487, '274', '中成药生产', '', 971, 974, 480, 3);
INSERT INTO `industry` VALUES (488, '2740', '中成药生产', '', 972, 973, 487, 4);
INSERT INTO `industry` VALUES (489, '275', '兽用药品制造', '', 975, 978, 480, 3);
INSERT INTO `industry` VALUES (490, '2750', '兽用药品制造', '', 976, 977, 489, 4);
INSERT INTO `industry` VALUES (491, '276', '生物药品制品制造', '', 979, 984, 480, 3);
INSERT INTO `industry` VALUES (492, '2761', '生物药品制造', '', 980, 981, 491, 4);
INSERT INTO `industry` VALUES (493, '2762', '基因工程药物和疫苗制造', '', 982, 983, 491, 4);
INSERT INTO `industry` VALUES (494, '277', '卫生材料及医药用品制造', '', 985, 988, 480, 3);
INSERT INTO `industry` VALUES (495, '2770', '卫生材料及医药用品制造', '', 986, 987, 494, 4);
INSERT INTO `industry` VALUES (496, '278', '药用辅料及包装材料', '', 989, 992, 480, 3);
INSERT INTO `industry` VALUES (497, '2780', '药用辅料及包装材料', '', 990, 991, 496, 4);
INSERT INTO `industry` VALUES (498, '28', '化学纤维制造业', '', 994, 1023, 169, 2);
INSERT INTO `industry` VALUES (499, '281', '纤维素纤维原料及纤维制造', '', 995, 1000, 498, 3);
INSERT INTO `industry` VALUES (500, '2811', '化纤浆粕制造', '', 996, 997, 499, 4);
INSERT INTO `industry` VALUES (501, '2812', '人造纤维（纤维素纤维）制造', '', 998, 999, 499, 4);
INSERT INTO `industry` VALUES (502, '282', '合成纤维制造', '', 1001, 1016, 498, 3);
INSERT INTO `industry` VALUES (503, '2821', '锦纶纤维制造', '', 1002, 1003, 502, 4);
INSERT INTO `industry` VALUES (504, '2822', '涤纶纤维制造', '', 1004, 1005, 502, 4);
INSERT INTO `industry` VALUES (505, '2823', '腈纶纤维制造', '', 1006, 1007, 502, 4);
INSERT INTO `industry` VALUES (506, '2824', '维纶纤维制造', '', 1008, 1009, 502, 4);
INSERT INTO `industry` VALUES (507, '2825', '丙纶纤维制造', '', 1010, 1011, 502, 4);
INSERT INTO `industry` VALUES (508, '2826', '氨纶纤维制造', '', 1012, 1013, 502, 4);
INSERT INTO `industry` VALUES (509, '2829', '其他合成纤维制造', '', 1014, 1015, 502, 4);
INSERT INTO `industry` VALUES (510, '283', '生物基材料制造', '', 1017, 1022, 498, 3);
INSERT INTO `industry` VALUES (511, '2831', '生物基化学纤维制造', '', 1018, 1019, 510, 4);
INSERT INTO `industry` VALUES (512, '2832', '生物基、淀粉基新材料制造', '', 1020, 1021, 510, 4);
INSERT INTO `industry` VALUES (513, '29', '橡胶和塑料制品业', '', 1024, 1061, 169, 2);
INSERT INTO `industry` VALUES (514, '291', '橡胶制品业', '', 1025, 1040, 513, 3);
INSERT INTO `industry` VALUES (515, '2911', '轮胎制造', '', 1026, 1027, 514, 4);
INSERT INTO `industry` VALUES (516, '2912', '橡胶板、管、带制造', '', 1028, 1029, 514, 4);
INSERT INTO `industry` VALUES (517, '2913', '橡胶零件制造', '', 1030, 1031, 514, 4);
INSERT INTO `industry` VALUES (518, '2914', '再生橡胶制造', '', 1032, 1033, 514, 4);
INSERT INTO `industry` VALUES (519, '2915', '日用及医用橡胶制品制造', '', 1034, 1035, 514, 4);
INSERT INTO `industry` VALUES (520, '2916', '运动场地用塑胶制造', '', 1036, 1037, 514, 4);
INSERT INTO `industry` VALUES (521, '2919', '其他橡胶制品制造', '', 1038, 1039, 514, 4);
INSERT INTO `industry` VALUES (522, '292', '塑料制品业', '', 1041, 1060, 513, 3);
INSERT INTO `industry` VALUES (523, '2921', '塑料薄膜制造', '', 1042, 1043, 522, 4);
INSERT INTO `industry` VALUES (524, '2922', '塑料板、管、型材制造', '', 1044, 1045, 522, 4);
INSERT INTO `industry` VALUES (525, '2923', '塑料丝、绳及编织品制造', '', 1046, 1047, 522, 4);
INSERT INTO `industry` VALUES (526, '2924', '泡沫塑料制造', '', 1048, 1049, 522, 4);
INSERT INTO `industry` VALUES (527, '2925', '塑料人造革、合成革制造', '', 1050, 1051, 522, 4);
INSERT INTO `industry` VALUES (528, '2926', '塑料包装箱及容器制造', '', 1052, 1053, 522, 4);
INSERT INTO `industry` VALUES (529, '2927', '日用塑料制品制造', '', 1054, 1055, 522, 4);
INSERT INTO `industry` VALUES (530, '2928', '人造草坪制造', '', 1056, 1057, 522, 4);
INSERT INTO `industry` VALUES (531, '2929', '塑料零件及其他塑料制品制造', '', 1058, 1059, 522, 4);
INSERT INTO `industry` VALUES (532, '30', '非金属矿物制品业', '', 1062, 1155, 169, 2);
INSERT INTO `industry` VALUES (533, '301', '水泥、石灰和石膏制造', '', 1063, 1068, 532, 3);
INSERT INTO `industry` VALUES (534, '3011', '水泥制造', '', 1064, 1065, 533, 4);
INSERT INTO `industry` VALUES (535, '3012', '石灰和石膏制造', '', 1066, 1067, 533, 4);
INSERT INTO `industry` VALUES (536, '302', '石膏、水泥制品及类似制品制造', '', 1069, 1080, 532, 3);
INSERT INTO `industry` VALUES (537, '3021', '水泥制品制造', '', 1070, 1071, 536, 4);
INSERT INTO `industry` VALUES (538, '3022', '砼结构构件制造', '', 1072, 1073, 536, 4);
INSERT INTO `industry` VALUES (539, '3023', '石棉水泥制品制造', '', 1074, 1075, 536, 4);
INSERT INTO `industry` VALUES (540, '3024', '轻质建筑材料制造', '', 1076, 1077, 536, 4);
INSERT INTO `industry` VALUES (541, '3029', '其他水泥类似制品制造', '', 1078, 1079, 536, 4);
INSERT INTO `industry` VALUES (542, '303', '砖瓦、石材等建筑材料制造', '', 1081, 1092, 532, 3);
INSERT INTO `industry` VALUES (543, '3031', '粘土砖瓦及建筑砌块制造', '', 1082, 1083, 542, 4);
INSERT INTO `industry` VALUES (544, '3032', '建筑用石加工', '', 1084, 1085, 542, 4);
INSERT INTO `industry` VALUES (545, '3033', '防水建筑材料制造', '', 1086, 1087, 542, 4);
INSERT INTO `industry` VALUES (546, '3034', '隔热和隔音材料制造', '', 1088, 1089, 542, 4);
INSERT INTO `industry` VALUES (547, '3039', '其他建筑材料制造', '', 1090, 1091, 542, 4);
INSERT INTO `industry` VALUES (548, '304', '玻璃制造', '', 1093, 1100, 532, 3);
INSERT INTO `industry` VALUES (549, '3041', '平板玻璃制造', '', 1094, 1095, 548, 4);
INSERT INTO `industry` VALUES (550, '3042', '特种玻璃制造', '', 1096, 1097, 548, 4);
INSERT INTO `industry` VALUES (551, '3049', '其他玻璃制造', '', 1098, 1099, 548, 4);
INSERT INTO `industry` VALUES (552, '305', '玻璃制品制造', '', 1101, 1118, 532, 3);
INSERT INTO `industry` VALUES (553, '3051', '技术玻璃制品制造', '', 1102, 1103, 552, 4);
INSERT INTO `industry` VALUES (554, '3052', '光学玻璃制造', '', 1104, 1105, 552, 4);
INSERT INTO `industry` VALUES (555, '3053', '玻璃仪器制造', '', 1106, 1107, 552, 4);
INSERT INTO `industry` VALUES (556, '3054', '日用玻璃制品制造', '', 1108, 1109, 552, 4);
INSERT INTO `industry` VALUES (557, '3055', '玻璃包装容器制造', '', 1110, 1111, 552, 4);
INSERT INTO `industry` VALUES (558, '3056', '玻璃保温容器制造', '', 1112, 1113, 552, 4);
INSERT INTO `industry` VALUES (559, '3057', '制镜及类似品加工', '', 1114, 1115, 552, 4);
INSERT INTO `industry` VALUES (560, '3059', '其他玻璃制品制造', '', 1116, 1117, 552, 4);
INSERT INTO `industry` VALUES (561, '306', '玻璃纤维和玻璃纤维增强塑料制品制', '', 1119, 1124, 532, 3);
INSERT INTO `industry` VALUES (562, '3061', '玻璃纤维及制品制造', '', 1120, 1121, 561, 4);
INSERT INTO `industry` VALUES (563, '3062', '玻璃纤维增强塑料制品制造', '', 1122, 1123, 561, 4);
INSERT INTO `industry` VALUES (564, '307', '陶瓷制品制造', '', 1125, 1140, 532, 3);
INSERT INTO `industry` VALUES (565, '3071', '建筑陶瓷制品制造', '', 1126, 1127, 564, 4);
INSERT INTO `industry` VALUES (566, '3072', '卫生陶瓷制品制造', '', 1128, 1129, 564, 4);
INSERT INTO `industry` VALUES (567, '3073', '特种陶瓷制品制造', '', 1130, 1131, 564, 4);
INSERT INTO `industry` VALUES (568, '3074', '日用陶瓷制品制造', '', 1132, 1133, 564, 4);
INSERT INTO `industry` VALUES (569, '3075', '陈设艺术陶瓷制造', '', 1134, 1135, 564, 4);
INSERT INTO `industry` VALUES (570, '3076', '园艺陶瓷制造', '', 1136, 1137, 564, 4);
INSERT INTO `industry` VALUES (571, '3079', '其他陶瓷制品制造', '', 1138, 1139, 564, 4);
INSERT INTO `industry` VALUES (572, '308', '耐火材料制品制造', '', 1141, 1148, 532, 3);
INSERT INTO `industry` VALUES (573, '3081', '石棉制品制造', '', 1142, 1143, 572, 4);
INSERT INTO `industry` VALUES (574, '3082', '云母制品制造', '', 1144, 1145, 572, 4);
INSERT INTO `industry` VALUES (575, '3089', '耐火陶瓷制品及其他耐火材料制造', '', 1146, 1147, 572, 4);
INSERT INTO `industry` VALUES (576, '309', '石墨及其他非金属矿物制品制造', '', 1149, 1154, 532, 3);
INSERT INTO `industry` VALUES (577, '3091', '石墨及碳素制品制造', '', 1150, 1151, 576, 4);
INSERT INTO `industry` VALUES (578, '3099', '其他非金属矿物制品制造', '', 1152, 1153, 576, 4);
INSERT INTO `industry` VALUES (579, '31', '黑色金属冶炼和压延加工业', '', 1156, 1173, 169, 2);
INSERT INTO `industry` VALUES (580, '311', '炼铁', '', 1157, 1160, 579, 3);
INSERT INTO `industry` VALUES (581, '3110', '炼铁', '', 1158, 1159, 580, 4);
INSERT INTO `industry` VALUES (582, '312', '炼钢', '', 1161, 1164, 579, 3);
INSERT INTO `industry` VALUES (583, '3120', '炼钢', '', 1162, 1163, 582, 4);
INSERT INTO `industry` VALUES (584, '313', '钢压延加工', '', 1165, 1168, 579, 3);
INSERT INTO `industry` VALUES (585, '3130', '钢压延加工', '', 1166, 1167, 584, 4);
INSERT INTO `industry` VALUES (586, '314', '铁合金冶炼', '', 1169, 1172, 579, 3);
INSERT INTO `industry` VALUES (587, '3140', '铁合金冶炼', '', 1170, 1171, 586, 4);
INSERT INTO `industry` VALUES (588, '32', '有色金属冶炼和压延加工业', '', 1174, 1227, 169, 2);
INSERT INTO `industry` VALUES (589, '321', '常用有色金属冶炼', '', 1175, 1194, 588, 3);
INSERT INTO `industry` VALUES (590, '3211', '铜冶炼', '', 1176, 1177, 589, 4);
INSERT INTO `industry` VALUES (591, '3212', '铅锌冶炼', '', 1178, 1179, 589, 4);
INSERT INTO `industry` VALUES (592, '3213', '镍钴冶炼', '', 1180, 1181, 589, 4);
INSERT INTO `industry` VALUES (593, '3214', '锡冶炼', '', 1182, 1183, 589, 4);
INSERT INTO `industry` VALUES (594, '3215', '锑冶炼', '', 1184, 1185, 589, 4);
INSERT INTO `industry` VALUES (595, '3216', '铝冶炼', '', 1186, 1187, 589, 4);
INSERT INTO `industry` VALUES (596, '3217', '镁冶炼', '', 1188, 1189, 589, 4);
INSERT INTO `industry` VALUES (597, '3218', '硅冶炼', '', 1190, 1191, 589, 4);
INSERT INTO `industry` VALUES (598, '3219', '其他常用有色金属冶炼', '', 1192, 1193, 589, 4);
INSERT INTO `industry` VALUES (599, '322', '贵金属冶炼', '', 1195, 1202, 588, 3);
INSERT INTO `industry` VALUES (600, '3221', '金冶炼', '', 1196, 1197, 599, 4);
INSERT INTO `industry` VALUES (601, '3222', '银冶炼', '', 1198, 1199, 599, 4);
INSERT INTO `industry` VALUES (602, '3229', '其他贵金属冶炼', '', 1200, 1201, 599, 4);
INSERT INTO `industry` VALUES (603, '323', '稀有稀土金属冶炼', '', 1203, 1210, 588, 3);
INSERT INTO `industry` VALUES (604, '3231', '钨钼冶炼', '', 1204, 1205, 603, 4);
INSERT INTO `industry` VALUES (605, '3232', '稀土金属冶炼', '', 1206, 1207, 603, 4);
INSERT INTO `industry` VALUES (606, '3239', '其他稀有金属冶炼', '', 1208, 1209, 603, 4);
INSERT INTO `industry` VALUES (607, '324', '有色金属合金制造', '', 1211, 1214, 588, 3);
INSERT INTO `industry` VALUES (608, '3240', '有色金属合金制造', '', 1212, 1213, 607, 4);
INSERT INTO `industry` VALUES (609, '325', '有色金属压延加工', '', 1215, 1226, 588, 3);
INSERT INTO `industry` VALUES (610, '3251', '铜压延加工', '', 1216, 1217, 609, 4);
INSERT INTO `industry` VALUES (611, '3252', '铝压延加工', '', 1218, 1219, 609, 4);
INSERT INTO `industry` VALUES (612, '3253', '贵金属压延加工', '', 1220, 1221, 609, 4);
INSERT INTO `industry` VALUES (613, '3254', '稀有稀土金属压延加工', '', 1222, 1223, 609, 4);
INSERT INTO `industry` VALUES (614, '3259', '其他有色金属压延加工', '', 1224, 1225, 609, 4);
INSERT INTO `industry` VALUES (615, '33', '金属制品业', '', 1228, 1305, 169, 2);
INSERT INTO `industry` VALUES (616, '331', '结构性金属制品制造', '', 1229, 1234, 615, 3);
INSERT INTO `industry` VALUES (617, '3311', '金属结构制造', '', 1230, 1231, 616, 4);
INSERT INTO `industry` VALUES (618, '3312', '金属门窗制造', '', 1232, 1233, 616, 4);
INSERT INTO `industry` VALUES (619, '332', '金属工具制造', '', 1235, 1246, 615, 3);
INSERT INTO `industry` VALUES (620, '3321', '切削工具制造', '', 1236, 1237, 619, 4);
INSERT INTO `industry` VALUES (621, '3322', '手工具制造', '', 1238, 1239, 619, 4);
INSERT INTO `industry` VALUES (622, '3323', '农用及园林用金属工具制造', '', 1240, 1241, 619, 4);
INSERT INTO `industry` VALUES (623, '3324', '刀剪及类似日用金属工具制造', '', 1242, 1243, 619, 4);
INSERT INTO `industry` VALUES (624, '3329', '其他金属工具制造', '', 1244, 1245, 619, 4);
INSERT INTO `industry` VALUES (625, '333', '集装箱及金属包装容器制造', '', 1247, 1254, 615, 3);
INSERT INTO `industry` VALUES (626, '3331', '集装箱制造', '', 1248, 1249, 625, 4);
INSERT INTO `industry` VALUES (627, '3332', '金属压力容器制造', '', 1250, 1251, 625, 4);
INSERT INTO `industry` VALUES (628, '3333', '金属包装容器及材料制造', '', 1252, 1253, 625, 4);
INSERT INTO `industry` VALUES (629, '334', '金属丝绳及其制品制造', '', 1255, 1258, 615, 3);
INSERT INTO `industry` VALUES (630, '3340', '金属丝绳及其制品制造', '', 1256, 1257, 629, 4);
INSERT INTO `industry` VALUES (631, '335', '建筑、安全用金属制品制造', '', 1259, 1268, 615, 3);
INSERT INTO `industry` VALUES (632, '3351', '建筑、家具用金属配件制造', '', 1260, 1261, 631, 4);
INSERT INTO `industry` VALUES (633, '3352', '建筑装饰及水暖管道零件制造', '', 1262, 1263, 631, 4);
INSERT INTO `industry` VALUES (634, '3353', '安全、消防用金属制品制造', '', 1264, 1265, 631, 4);
INSERT INTO `industry` VALUES (635, '3359', '其他建筑、安全用金属制品制造', '', 1266, 1267, 631, 4);
INSERT INTO `industry` VALUES (636, '336', '金属表面处理及热处理加工', '', 1269, 1272, 615, 3);
INSERT INTO `industry` VALUES (637, '3360', '金属表面处理及热处理加工', '', 1270, 1271, 636, 4);
INSERT INTO `industry` VALUES (638, '337', '搪瓷制品制造', '', 1273, 1282, 615, 3);
INSERT INTO `industry` VALUES (639, '3371', '生产专用搪瓷制品制造', '', 1274, 1275, 638, 4);
INSERT INTO `industry` VALUES (640, '3372', '建筑装饰搪瓷制品制造', '', 1276, 1277, 638, 4);
INSERT INTO `industry` VALUES (641, '3373', '搪瓷卫生洁具制造', '', 1278, 1279, 638, 4);
INSERT INTO `industry` VALUES (642, '3379', '搪瓷日用品及其他搪瓷制品制造', '', 1280, 1281, 638, 4);
INSERT INTO `industry` VALUES (643, '338', '金属制日用品制造', '', 1283, 1292, 615, 3);
INSERT INTO `industry` VALUES (644, '3381', '金属制厨房用器具制造', '', 1284, 1285, 643, 4);
INSERT INTO `industry` VALUES (645, '3382', '金属制餐具和器皿制造', '', 1286, 1287, 643, 4);
INSERT INTO `industry` VALUES (646, '3383', '金属制卫生器具制造', '', 1288, 1289, 643, 4);
INSERT INTO `industry` VALUES (647, '3389', '其他金属制日用品制造', '', 1290, 1291, 643, 4);
INSERT INTO `industry` VALUES (648, '339', '铸造及其他金属制品制造', '', 1293, 1304, 615, 3);
INSERT INTO `industry` VALUES (649, '3391', '黑色金属铸造', '', 1294, 1295, 648, 4);
INSERT INTO `industry` VALUES (650, '3392', '有色金属铸造', '', 1296, 1297, 648, 4);
INSERT INTO `industry` VALUES (651, '3393', '锻件及粉末冶金制品制造', '', 1298, 1299, 648, 4);
INSERT INTO `industry` VALUES (652, '3394', '交通及公共管理用金属标牌制造', '', 1300, 1301, 648, 4);
INSERT INTO `industry` VALUES (653, '3399', '其他未列明金属制品制造', '', 1302, 1303, 648, 4);
INSERT INTO `industry` VALUES (654, '34', '通用设备制造业', '', 1306, 1429, 169, 2);
INSERT INTO `industry` VALUES (655, '341', '锅炉及原动设备制造', '', 1307, 1320, 654, 3);
INSERT INTO `industry` VALUES (656, '3411', '锅炉及辅助设备制造', '', 1308, 1309, 655, 4);
INSERT INTO `industry` VALUES (657, '3412', '内燃机及配件制造', '', 1310, 1311, 655, 4);
INSERT INTO `industry` VALUES (658, '3413', '汽轮机及辅机制造', '', 1312, 1313, 655, 4);
INSERT INTO `industry` VALUES (659, '3414', '水轮机及辅机制造', '', 1314, 1315, 655, 4);
INSERT INTO `industry` VALUES (660, '3415', '风能原动设备制造', '', 1316, 1317, 655, 4);
INSERT INTO `industry` VALUES (661, '3419', '其他原动设备制造', '', 1318, 1319, 655, 4);
INSERT INTO `industry` VALUES (662, '342', '金属加工机械制造', '', 1321, 1334, 654, 3);
INSERT INTO `industry` VALUES (663, '3421', '金属切削机床制造', '', 1322, 1323, 662, 4);
INSERT INTO `industry` VALUES (664, '3422', '金属成形机床制造', '', 1324, 1325, 662, 4);
INSERT INTO `industry` VALUES (665, '3423', '铸造机械制造', '', 1326, 1327, 662, 4);
INSERT INTO `industry` VALUES (666, '3424', '金属切割及焊接设备制造', '', 1328, 1329, 662, 4);
INSERT INTO `industry` VALUES (667, '3425', '机床功能部件及附件制造', '', 1330, 1331, 662, 4);
INSERT INTO `industry` VALUES (668, '3429', '其他金属加工机械制造', '', 1332, 1333, 662, 4);
INSERT INTO `industry` VALUES (669, '343', '物料搬运设备制造', '', 1335, 1352, 654, 3);
INSERT INTO `industry` VALUES (670, '3431', '轻小型起重设备制造', '', 1336, 1337, 669, 4);
INSERT INTO `industry` VALUES (671, '3432', '生产专用起重机制造', '', 1338, 1339, 669, 4);
INSERT INTO `industry` VALUES (672, '3433', '生产专用车辆制造', '', 1340, 1341, 669, 4);
INSERT INTO `industry` VALUES (673, '3434', '连续搬运设备制造', '', 1342, 1343, 669, 4);
INSERT INTO `industry` VALUES (674, '3435', '电梯、自动扶梯及升降机制造', '', 1344, 1345, 669, 4);
INSERT INTO `industry` VALUES (675, '3436', '客运索道制造', '', 1346, 1347, 669, 4);
INSERT INTO `industry` VALUES (676, '3437', '机械式停车设备制造', '', 1348, 1349, 669, 4);
INSERT INTO `industry` VALUES (677, '3439', '其他物料搬运设备制造', '', 1350, 1351, 669, 4);
INSERT INTO `industry` VALUES (678, '344', '泵、阀门、压缩机及类似机械制造', '', 1353, 1366, 654, 3);
INSERT INTO `industry` VALUES (679, '3441', '泵及真空设备制造', '', 1354, 1355, 678, 4);
INSERT INTO `industry` VALUES (680, '3442', '气体压缩机械制造', '', 1356, 1357, 678, 4);
INSERT INTO `industry` VALUES (681, '3443', '阀门和旋塞制造', '', 1358, 1359, 678, 4);
INSERT INTO `industry` VALUES (682, '3444', '液压动力机械及元件制造', '', 1360, 1361, 678, 4);
INSERT INTO `industry` VALUES (683, '3445', '液力动力机械元件制造', '', 1362, 1363, 678, 4);
INSERT INTO `industry` VALUES (684, '3446', '气压动力机械及元件制造', '', 1364, 1365, 678, 4);
INSERT INTO `industry` VALUES (685, '345', '轴承、齿轮和传动部件制造', '', 1367, 1376, 654, 3);
INSERT INTO `industry` VALUES (686, '3451', '滚动轴承制造', '', 1368, 1369, 685, 4);
INSERT INTO `industry` VALUES (687, '3452', '滑动轴承制造', '', 1370, 1371, 685, 4);
INSERT INTO `industry` VALUES (688, '3453', '齿轮及齿轮减、变速箱制造', '', 1372, 1373, 685, 4);
INSERT INTO `industry` VALUES (689, '3459', '其他传动部件制造', '', 1374, 1375, 685, 4);
INSERT INTO `industry` VALUES (690, '346', '烘炉、风机、包装等设备制造', '', 1377, 1392, 654, 3);
INSERT INTO `industry` VALUES (691, '3461', '烘炉、熔炉及电炉制造', '', 1378, 1379, 690, 4);
INSERT INTO `industry` VALUES (692, '3462', '风机、风扇制造', '', 1380, 1381, 690, 4);
INSERT INTO `industry` VALUES (693, '3463', '气体、液体分离及纯净设备制造', '', 1382, 1383, 690, 4);
INSERT INTO `industry` VALUES (694, '3464', '制冷、空调设备制造', '', 1384, 1385, 690, 4);
INSERT INTO `industry` VALUES (695, '3465', '风动和电动工具制造', '', 1386, 1387, 690, 4);
INSERT INTO `industry` VALUES (696, '3466', '喷枪及类似器具制造', '', 1388, 1389, 690, 4);
INSERT INTO `industry` VALUES (697, '3467', '包装专用设备制造', '', 1390, 1391, 690, 4);
INSERT INTO `industry` VALUES (698, '347', '文化、办公用机械制造', '', 1393, 1406, 654, 3);
INSERT INTO `industry` VALUES (699, '3471', '电影机械制造', '', 1394, 1395, 698, 4);
INSERT INTO `industry` VALUES (700, '3472', '幻灯及投影设备制造', '', 1396, 1397, 698, 4);
INSERT INTO `industry` VALUES (701, '3473', '照相机及器材制造', '', 1398, 1399, 698, 4);
INSERT INTO `industry` VALUES (702, '3474', '复印和胶印设备制造', '', 1400, 1401, 698, 4);
INSERT INTO `industry` VALUES (703, '3475', '计算器及货币专用设备制造', '', 1402, 1403, 698, 4);
INSERT INTO `industry` VALUES (704, '3479', '其他文化、办公用机械制造', '', 1404, 1405, 698, 4);
INSERT INTO `industry` VALUES (705, '348', '通用零部件制造', '', 1407, 1418, 654, 3);
INSERT INTO `industry` VALUES (706, '3481', '金属密封件制造', '', 1408, 1409, 705, 4);
INSERT INTO `industry` VALUES (707, '3482', '紧固件制造', '', 1410, 1411, 705, 4);
INSERT INTO `industry` VALUES (708, '3483', '弹簧制造', '', 1412, 1413, 705, 4);
INSERT INTO `industry` VALUES (709, '3484', '机械零部件加工', '', 1414, 1415, 705, 4);
INSERT INTO `industry` VALUES (710, '3489', '其他通用零部件制造', '', 1416, 1417, 705, 4);
INSERT INTO `industry` VALUES (711, '349', '其他通用设备制造业', '', 1419, 1428, 654, 3);
INSERT INTO `industry` VALUES (712, '3491', '工业机器人制造', '', 1420, 1421, 711, 4);
INSERT INTO `industry` VALUES (713, '3492', '特殊作业机器人制造', '', 1422, 1423, 711, 4);
INSERT INTO `industry` VALUES (714, '3493', '增材制造装备制造', '', 1424, 1425, 711, 4);
INSERT INTO `industry` VALUES (715, '3499', '其他未列明通用设备制造业', '', 1426, 1427, 711, 4);
INSERT INTO `industry` VALUES (716, '35', '专用设备制造业', '', 1430, 1561, 169, 2);
INSERT INTO `industry` VALUES (717, '351', '采矿、冶金、建筑专用设备制造', '', 1431, 1446, 716, 3);
INSERT INTO `industry` VALUES (718, '3511', '矿山机械制造', '', 1432, 1433, 717, 4);
INSERT INTO `industry` VALUES (719, '3512', '石油钻采专用设备制造', '', 1434, 1435, 717, 4);
INSERT INTO `industry` VALUES (720, '3513', '深海石油钻探设备制造', '', 1436, 1437, 717, 4);
INSERT INTO `industry` VALUES (721, '3514', '建筑工程用机械制造', '', 1438, 1439, 717, 4);
INSERT INTO `industry` VALUES (722, '3515', '建筑材料生产专用机械制造', '', 1440, 1441, 717, 4);
INSERT INTO `industry` VALUES (723, '3516', '冶金专用设备制造', '', 1442, 1443, 717, 4);
INSERT INTO `industry` VALUES (724, '3517', '隧道施工专用机械制造', '', 1444, 1445, 717, 4);
INSERT INTO `industry` VALUES (725, '352', '化工、木材、非金属加工专用设备制造', '', 1447, 1460, 716, 3);
INSERT INTO `industry` VALUES (726, '3521', '炼油、化工生产专用设备制造', '', 1448, 1449, 725, 4);
INSERT INTO `industry` VALUES (727, '3522', '橡胶加工专用设备制造', '', 1450, 1451, 725, 4);
INSERT INTO `industry` VALUES (728, '3523', '塑料加工专用设备制造', '', 1452, 1453, 725, 4);
INSERT INTO `industry` VALUES (729, '3524', '木竹材加工机械制造', '', 1454, 1455, 725, 4);
INSERT INTO `industry` VALUES (730, '3525', '模具制造', '', 1456, 1457, 725, 4);
INSERT INTO `industry` VALUES (731, '3529', '其他非金属加工专用设备制造', '', 1458, 1459, 725, 4);
INSERT INTO `industry` VALUES (732, '353', '食品、饮料、烟草及饲料生产专用设备制造', '', 1461, 1470, 716, 3);
INSERT INTO `industry` VALUES (733, '3531', '食品、酒、饮料及茶生产专用设备制     指主要用于食品、酒、饮料生产及茶制品加', '', 1462, 1463, 732, 4);
INSERT INTO `industry` VALUES (734, '3532', '农副食品加工专用设备制造', '', 1464, 1465, 732, 4);
INSERT INTO `industry` VALUES (735, '3533', '烟草生产专用设备制造', '', 1466, 1467, 732, 4);
INSERT INTO `industry` VALUES (736, '3534', '饲料生产专用设备制造', '', 1468, 1469, 732, 4);
INSERT INTO `industry` VALUES (737, '354', '印刷、制药、日化及日用品生产专用设', '', 1471, 1486, 716, 3);
INSERT INTO `industry` VALUES (738, '3541', '制浆和造纸专用设备制造', '', 1472, 1473, 737, 4);
INSERT INTO `industry` VALUES (739, '3542', '印刷专用设备制造', '', 1474, 1475, 737, 4);
INSERT INTO `industry` VALUES (740, '3543', '日用化工专用设备制造', '', 1476, 1477, 737, 4);
INSERT INTO `industry` VALUES (741, '3544', '制药专用设备制造', '', 1478, 1479, 737, 4);
INSERT INTO `industry` VALUES (742, '3545', '照明器具生产专用设备制造', '', 1480, 1481, 737, 4);
INSERT INTO `industry` VALUES (743, '3546', '玻璃、陶瓷和搪瓷制品生产专用设备', '', 1482, 1483, 737, 4);
INSERT INTO `industry` VALUES (744, '3549', '其他日用品生产专用设备制造', '', 1484, 1485, 737, 4);
INSERT INTO `industry` VALUES (745, '355', '纺织、服装和皮革加工专用设备制造', '', 1487, 1496, 716, 3);
INSERT INTO `industry` VALUES (746, '3551', '纺织专用设备制造', '', 1488, 1489, 745, 4);
INSERT INTO `industry` VALUES (747, '3552', '皮革、毛皮及其制品加工专用设备制', '', 1490, 1491, 745, 4);
INSERT INTO `industry` VALUES (748, '3553', '缝制机械制造', '', 1492, 1493, 745, 4);
INSERT INTO `industry` VALUES (749, '3554', '洗涤机械制造', '', 1494, 1495, 745, 4);
INSERT INTO `industry` VALUES (750, '356', '电子和电工机械专用设备制造', '', 1497, 1506, 716, 3);
INSERT INTO `industry` VALUES (751, '3561', '电工机械专用设备制造', '', 1498, 1499, 750, 4);
INSERT INTO `industry` VALUES (752, '3562', '半导体器件专用设备制造', '', 1500, 1501, 750, 4);
INSERT INTO `industry` VALUES (753, '3563', '电子元器件与机电组件设备制造', '', 1502, 1503, 750, 4);
INSERT INTO `industry` VALUES (754, '3569', '其他电子专用设备制造', '', 1504, 1505, 750, 4);
INSERT INTO `industry` VALUES (755, '357', '农、林、牧、渔专用机械制造', '', 1507, 1524, 716, 3);
INSERT INTO `industry` VALUES (756, '3571', '拖拉机制造', '', 1508, 1509, 755, 4);
INSERT INTO `industry` VALUES (757, '3572', '机械化农业及园艺机具制造', '', 1510, 1511, 755, 4);
INSERT INTO `industry` VALUES (758, '3573', '营林及木竹采伐机械制造', '', 1512, 1513, 755, 4);
INSERT INTO `industry` VALUES (759, '3574', '畜牧机械制造', '', 1514, 1515, 755, 4);
INSERT INTO `industry` VALUES (760, '3575', '渔业机械制造', '', 1516, 1517, 755, 4);
INSERT INTO `industry` VALUES (761, '3576', '农林牧渔机械配件制造', '', 1518, 1519, 755, 4);
INSERT INTO `industry` VALUES (762, '3577', '棉花加工机械制造', '', 1520, 1521, 755, 4);
INSERT INTO `industry` VALUES (763, '3579', '其他农、林、牧、渔业机械制造', '', 1522, 1523, 755, 4);
INSERT INTO `industry` VALUES (764, '358', '医疗仪器设备及器械制造', '', 1525, 1542, 716, 3);
INSERT INTO `industry` VALUES (765, '3581', '医疗诊断、监护及治疗设备制造', '', 1526, 1527, 764, 4);
INSERT INTO `industry` VALUES (766, '3582', '口腔科用设备及器具制造', '', 1528, 1529, 764, 4);
INSERT INTO `industry` VALUES (767, '3583', '医疗实验室及医用消毒设备和器具', '', 1530, 1531, 764, 4);
INSERT INTO `industry` VALUES (768, '3584', '医疗、外科及兽医用器械制造', '', 1532, 1533, 764, 4);
INSERT INTO `industry` VALUES (769, '3585', '机械治疗及病房护理设备制造', '', 1534, 1535, 764, 4);
INSERT INTO `industry` VALUES (770, '3586', '康复辅具制造', '', 1536, 1537, 764, 4);
INSERT INTO `industry` VALUES (771, '3587', '眼镜制造', '', 1538, 1539, 764, 4);
INSERT INTO `industry` VALUES (772, '3589', '其他医疗设备及器械制造', '', 1540, 1541, 764, 4);
INSERT INTO `industry` VALUES (773, '359', '环保、邮政、社会公共服务及其他专用', '', 1543, 1560, 716, 3);
INSERT INTO `industry` VALUES (774, '3591', '环境保护专用设备制造', '', 1544, 1545, 773, 4);
INSERT INTO `industry` VALUES (775, '3592', '地质勘查专用设备制造', '', 1546, 1547, 773, 4);
INSERT INTO `industry` VALUES (776, '3593', '邮政专用机械及器材制造', '', 1548, 1549, 773, 4);
INSERT INTO `industry` VALUES (777, '3594', '商业、饮食、服务专用设备制造', '', 1550, 1551, 773, 4);
INSERT INTO `industry` VALUES (778, '3595', '社会公共安全设备及器材制造', '', 1552, 1553, 773, 4);
INSERT INTO `industry` VALUES (779, '3596', '交通安全、管制及类似专用设备制造', '', 1554, 1555, 773, 4);
INSERT INTO `industry` VALUES (780, '3597', '水资源专用机械制造', '', 1556, 1557, 773, 4);
INSERT INTO `industry` VALUES (781, '3599', '其他专用设备制造', '', 1558, 1559, 773, 4);
INSERT INTO `industry` VALUES (782, '36', '汽车制造业', '', 1562, 1593, 169, 2);
INSERT INTO `industry` VALUES (783, '361', '汽车整车制造', '', 1563, 1568, 782, 3);
INSERT INTO `industry` VALUES (784, '3611', '汽柴油车整车制造', '', 1564, 1565, 783, 4);
INSERT INTO `industry` VALUES (785, '3612', '新能源车整车制造', '', 1566, 1567, 783, 4);
INSERT INTO `industry` VALUES (786, '362', '汽车用发动机制造', '', 1569, 1572, 782, 3);
INSERT INTO `industry` VALUES (787, '3620', '汽车用发动机制造', '', 1570, 1571, 786, 4);
INSERT INTO `industry` VALUES (788, '363', '改装汽车制造', '', 1573, 1576, 782, 3);
INSERT INTO `industry` VALUES (789, '3630', '改装汽车制造', '', 1574, 1575, 788, 4);
INSERT INTO `industry` VALUES (790, '364', '低速汽车制造', '', 1577, 1580, 782, 3);
INSERT INTO `industry` VALUES (791, '3640', '低速汽车制造', '', 1578, 1579, 790, 4);
INSERT INTO `industry` VALUES (792, '365', '电车制造', '', 1581, 1584, 782, 3);
INSERT INTO `industry` VALUES (793, '3650', '电车制造', '', 1582, 1583, 792, 4);
INSERT INTO `industry` VALUES (794, '366', '汽车车身、挂车制造', '', 1585, 1588, 782, 3);
INSERT INTO `industry` VALUES (795, '3660', '汽车车身、挂车制造', '', 1586, 1587, 794, 4);
INSERT INTO `industry` VALUES (796, '367', '汽车零部件及配件制造', '', 1589, 1592, 782, 3);
INSERT INTO `industry` VALUES (797, '3670', '汽车零部件及配件制造', '', 1590, 1591, 796, 4);
INSERT INTO `industry` VALUES (798, '37', '铁路、船舶、航空航天和其他运输设备制', '', 1594, 1673, 169, 2);
INSERT INTO `industry` VALUES (799, '371', '铁路运输设备制造', '', 1595, 1610, 798, 3);
INSERT INTO `industry` VALUES (800, '3711', '高铁车组制造', '', 1596, 1597, 799, 4);
INSERT INTO `industry` VALUES (801, '3712', '铁路机车车辆制造', '', 1598, 1599, 799, 4);
INSERT INTO `industry` VALUES (802, '3713', '窄轨机车车辆制造', '', 1600, 1601, 799, 4);
INSERT INTO `industry` VALUES (803, '3714', '高铁设备、配件制造', '', 1602, 1603, 799, 4);
INSERT INTO `industry` VALUES (804, '3715', '铁路机车车辆配件制造', '', 1604, 1605, 799, 4);
INSERT INTO `industry` VALUES (805, '3716', '铁路专用设备及器材、配件制造', '', 1606, 1607, 799, 4);
INSERT INTO `industry` VALUES (806, '3719', '其他铁路运输设备制造', '', 1608, 1609, 799, 4);
INSERT INTO `industry` VALUES (807, '372', '城市轨道交通设备制造', '', 1611, 1614, 798, 3);
INSERT INTO `industry` VALUES (808, '3720', '城市轨道交通设备制造', '', 1612, 1613, 807, 4);
INSERT INTO `industry` VALUES (809, '373', '船舶及相关装置制造', '', 1615, 1632, 798, 3);
INSERT INTO `industry` VALUES (810, '3731', '金属船舶制造', '', 1616, 1617, 809, 4);
INSERT INTO `industry` VALUES (811, '3732', '非金属船舶制造', '', 1618, 1619, 809, 4);
INSERT INTO `industry` VALUES (812, '3733', '娱乐船和运动船制造', '', 1620, 1621, 809, 4);
INSERT INTO `industry` VALUES (813, '3734', '船用配套设备制造', '', 1622, 1623, 809, 4);
INSERT INTO `industry` VALUES (814, '3735', '船舶改装', '', 1624, 1625, 809, 4);
INSERT INTO `industry` VALUES (815, '3736', '船舶拆除', '', 1626, 1627, 809, 4);
INSERT INTO `industry` VALUES (816, '3737', '海洋工程装备制造', '', 1628, 1629, 809, 4);
INSERT INTO `industry` VALUES (817, '3739', '航标器材及其他相关装置制造', '', 1630, 1631, 809, 4);
INSERT INTO `industry` VALUES (818, '374', '航空、航天器及设备制造', '', 1633, 1644, 798, 3);
INSERT INTO `industry` VALUES (819, '3741', '飞机制造', '', 1634, 1635, 818, 4);
INSERT INTO `industry` VALUES (820, '3742', '航天器及运载火箭制造', '', 1636, 1637, 818, 4);
INSERT INTO `industry` VALUES (821, '3743', '航天相关设备制造', '', 1638, 1639, 818, 4);
INSERT INTO `industry` VALUES (822, '3744', '航空相关设备制造', '', 1640, 1641, 818, 4);
INSERT INTO `industry` VALUES (823, '3749', '其他航空航天器制造', '', 1642, 1643, 818, 4);
INSERT INTO `industry` VALUES (824, '375', '摩托车制造', '', 1645, 1650, 798, 3);
INSERT INTO `industry` VALUES (825, '3751', '摩托车整车制造', '', 1646, 1647, 824, 4);
INSERT INTO `industry` VALUES (826, '3752', '摩托车零部件及配件制造', '', 1648, 1649, 824, 4);
INSERT INTO `industry` VALUES (827, '376', '自行车和残疾人座车制造', '', 1651, 1656, 798, 3);
INSERT INTO `industry` VALUES (828, '3761', '自行车制造', '', 1652, 1653, 827, 4);
INSERT INTO `industry` VALUES (829, '3762', '残疾人座车制造', '', 1654, 1655, 827, 4);
INSERT INTO `industry` VALUES (830, '377', '助动车制造', '', 1657, 1660, 798, 3);
INSERT INTO `industry` VALUES (831, '3770', '助动车制造', '', 1658, 1659, 830, 4);
INSERT INTO `industry` VALUES (832, '378', '非公路休闲车及零配件制造', '', 1661, 1664, 798, 3);
INSERT INTO `industry` VALUES (833, '3780', '非公路休闲车及零配件制造', '', 1662, 1663, 832, 4);
INSERT INTO `industry` VALUES (834, '379', '潜水救捞及其他未列明运输设备制造', '', 1665, 1672, 798, 3);
INSERT INTO `industry` VALUES (835, '3791', '潜水装备制造', '', 1666, 1667, 834, 4);
INSERT INTO `industry` VALUES (836, '3792', '水下救捞装备制造', '', 1668, 1669, 834, 4);
INSERT INTO `industry` VALUES (837, '3799', '其他未列明运输设备制造', '', 1670, 1671, 834, 4);
INSERT INTO `industry` VALUES (838, '38', '电气机械和器材制造业', '', 1674, 1767, 169, 2);
INSERT INTO `industry` VALUES (839, '381', '电机制造', '', 1675, 1684, 838, 3);
INSERT INTO `industry` VALUES (840, '3811', '发电机及发电机组制造', '', 1676, 1677, 839, 4);
INSERT INTO `industry` VALUES (841, '3812', '电动机制造', '', 1678, 1679, 839, 4);
INSERT INTO `industry` VALUES (842, '3813', '微特电机及组件制造', '', 1680, 1681, 839, 4);
INSERT INTO `industry` VALUES (843, '3819', '其他电机制造', '', 1682, 1683, 839, 4);
INSERT INTO `industry` VALUES (844, '382', '输配电及控制设备制造', '', 1685, 1698, 838, 3);
INSERT INTO `industry` VALUES (845, '3821', '变压器、整流器和电感器制造', '', 1686, 1687, 844, 4);
INSERT INTO `industry` VALUES (846, '3822', '电容器及其配套设备制造', '', 1688, 1689, 844, 4);
INSERT INTO `industry` VALUES (847, '3823', '配电开关控制设备制造', '', 1690, 1691, 844, 4);
INSERT INTO `industry` VALUES (848, '3824', '电力电子元器件制造', '', 1692, 1693, 844, 4);
INSERT INTO `industry` VALUES (849, '3825', '光伏设备及元器件制造', '', 1694, 1695, 844, 4);
INSERT INTO `industry` VALUES (850, '3829', '其他输配电及控制设备制造', '', 1696, 1697, 844, 4);
INSERT INTO `industry` VALUES (851, '383', '电线、电缆、光缆及电工器材制造', '', 1699, 1710, 838, 3);
INSERT INTO `industry` VALUES (852, '3831', '电线、电缆制造', '', 1700, 1701, 851, 4);
INSERT INTO `industry` VALUES (853, '3832', '光纤制造', '', 1702, 1703, 851, 4);
INSERT INTO `industry` VALUES (854, '3833', '光缆制造', '', 1704, 1705, 851, 4);
INSERT INTO `industry` VALUES (855, '3834', '绝缘制品制造', '', 1706, 1707, 851, 4);
INSERT INTO `industry` VALUES (856, '3839', '其他电工器材制造', '', 1708, 1709, 851, 4);
INSERT INTO `industry` VALUES (857, '384', '电池制造', '', 1711, 1722, 838, 3);
INSERT INTO `industry` VALUES (858, '3841', '锂离子电池制造', '', 1712, 1713, 857, 4);
INSERT INTO `industry` VALUES (859, '3842', '镍氢电池制造', '', 1714, 1715, 857, 4);
INSERT INTO `industry` VALUES (860, '3843', '铅蓄电池制造', '', 1716, 1717, 857, 4);
INSERT INTO `industry` VALUES (861, '3844', '锌锰电池制造', '', 1718, 1719, 857, 4);
INSERT INTO `industry` VALUES (862, '3849', '其他电池制造', '', 1720, 1721, 857, 4);
INSERT INTO `industry` VALUES (863, '385', '家用电力器具制造', '', 1723, 1740, 838, 3);
INSERT INTO `industry` VALUES (864, '3851', '家用制冷电器具制造', '', 1724, 1725, 863, 4);
INSERT INTO `industry` VALUES (865, '3852', '家用空气调节器制造', '', 1726, 1727, 863, 4);
INSERT INTO `industry` VALUES (866, '3853', '家用通风电器具制造', '', 1728, 1729, 863, 4);
INSERT INTO `industry` VALUES (867, '3854', '家用厨房电器具制造', '', 1730, 1731, 863, 4);
INSERT INTO `industry` VALUES (868, '3855', '家用清洁卫生电器具制造', '', 1732, 1733, 863, 4);
INSERT INTO `industry` VALUES (869, '3856', '家用美容、保健护理电器具制造', '', 1734, 1735, 863, 4);
INSERT INTO `industry` VALUES (870, '3857', '家用电力器具专用配件制造', '', 1736, 1737, 863, 4);
INSERT INTO `industry` VALUES (871, '3859', '其他家用电力器具制造', '', 1738, 1739, 863, 4);
INSERT INTO `industry` VALUES (872, '386', '非电力家用器具制造', '', 1741, 1748, 838, 3);
INSERT INTO `industry` VALUES (873, '3861', '燃气及类似能源家用器具制造', '', 1742, 1743, 872, 4);
INSERT INTO `industry` VALUES (874, '3862', '太阳能器具制造', '', 1744, 1745, 872, 4);
INSERT INTO `industry` VALUES (875, '3869', '其他非电力家用器具制造', '', 1746, 1747, 872, 4);
INSERT INTO `industry` VALUES (876, '387', '照明器具制造', '', 1749, 1760, 838, 3);
INSERT INTO `industry` VALUES (877, '3871', '电光源制造', '', 1750, 1751, 876, 4);
INSERT INTO `industry` VALUES (878, '3872', '照明灯具制造', '', 1752, 1753, 876, 4);
INSERT INTO `industry` VALUES (879, '3873', '舞台及场地用灯制造', '', 1754, 1755, 876, 4);
INSERT INTO `industry` VALUES (880, '3874', '智能照明器具制造', '', 1756, 1757, 876, 4);
INSERT INTO `industry` VALUES (881, '3879', '灯用电器附件及其他照明器具制造', '', 1758, 1759, 876, 4);
INSERT INTO `industry` VALUES (882, '389', '其他电气机械及器材制造', '', 1761, 1766, 838, 3);
INSERT INTO `industry` VALUES (883, '3891', '电气信号设备装置制造', '', 1762, 1763, 882, 4);
INSERT INTO `industry` VALUES (884, '3899', '其他未列明电气机械及器材制造', '', 1764, 1765, 882, 4);
INSERT INTO `industry` VALUES (885, '39', '计算机、通信和其他电子设备制造业', '', 1768, 1859, 169, 2);
INSERT INTO `industry` VALUES (886, '391', '计算机制造', '', 1769, 1782, 885, 3);
INSERT INTO `industry` VALUES (887, '3911', '计算机整机制造', '', 1770, 1771, 886, 4);
INSERT INTO `industry` VALUES (888, '3912', '计算机零部件制造', '', 1772, 1773, 886, 4);
INSERT INTO `industry` VALUES (889, '3913', '计算机外围设备制造', '', 1774, 1775, 886, 4);
INSERT INTO `industry` VALUES (890, '3914', '工业控制计算机及系统制造', '', 1776, 1777, 886, 4);
INSERT INTO `industry` VALUES (891, '3915', '信息安全设备制造', '', 1778, 1779, 886, 4);
INSERT INTO `industry` VALUES (892, '3919', '其他计算机制造', '', 1780, 1781, 886, 4);
INSERT INTO `industry` VALUES (893, '392', '通信设备制造', '', 1783, 1788, 885, 3);
INSERT INTO `industry` VALUES (894, '3921', '通信系统设备制造', '', 1784, 1785, 893, 4);
INSERT INTO `industry` VALUES (895, '3922', '通信终端设备制造', '', 1786, 1787, 893, 4);
INSERT INTO `industry` VALUES (896, '393', '广播电视设备制造', '', 1789, 1800, 885, 3);
INSERT INTO `industry` VALUES (897, '3931', '广播电视节目制作及发射设备制造', '', 1790, 1791, 896, 4);
INSERT INTO `industry` VALUES (898, '3932', '广播电视接收设备制造', '', 1792, 1793, 896, 4);
INSERT INTO `industry` VALUES (899, '3933', '广播电视专用配件制造', '', 1794, 1795, 896, 4);
INSERT INTO `industry` VALUES (900, '3934', '专业音响设备制造', '', 1796, 1797, 896, 4);
INSERT INTO `industry` VALUES (901, '3939', '应用电视设备及其他广播电视设备', '', 1798, 1799, 896, 4);
INSERT INTO `industry` VALUES (902, '394', '雷达及配套设备制造', '', 1801, 1804, 885, 3);
INSERT INTO `industry` VALUES (903, '3940', '雷达及配套设备制造', '', 1802, 1803, 902, 4);
INSERT INTO `industry` VALUES (904, '395', '非专业视听设备制造', '', 1805, 1812, 885, 3);
INSERT INTO `industry` VALUES (905, '3951', '电视机制造', '', 1806, 1807, 904, 4);
INSERT INTO `industry` VALUES (906, '3952', '音响设备制造', '', 1808, 1809, 904, 4);
INSERT INTO `industry` VALUES (907, '3953', '影视录放设备制造', '', 1810, 1811, 904, 4);
INSERT INTO `industry` VALUES (908, '396', '智能消费设备制造', '', 1813, 1824, 885, 3);
INSERT INTO `industry` VALUES (909, '3961', '可穿戴智能设备制造', '', 1814, 1815, 908, 4);
INSERT INTO `industry` VALUES (910, '3962', '智能车载设备制造', '', 1816, 1817, 908, 4);
INSERT INTO `industry` VALUES (911, '3963', '智能无人飞行器制造', '', 1818, 1819, 908, 4);
INSERT INTO `industry` VALUES (912, '3964', '服务消费机器人制造', '', 1820, 1821, 908, 4);
INSERT INTO `industry` VALUES (913, '3969', '其他智能消费设备制造', '', 1822, 1823, 908, 4);
INSERT INTO `industry` VALUES (914, '397', '电子器件制造', '', 1825, 1840, 885, 3);
INSERT INTO `industry` VALUES (915, '3971', '电子真空器件制造', '', 1826, 1827, 914, 4);
INSERT INTO `industry` VALUES (916, '3972', '半导体分立器件制造', '', 1828, 1829, 914, 4);
INSERT INTO `industry` VALUES (917, '3973', '集成电路制造', '', 1830, 1831, 914, 4);
INSERT INTO `industry` VALUES (918, '3974', '显示器件制造', '', 1832, 1833, 914, 4);
INSERT INTO `industry` VALUES (919, '3975', '半导体照明器件制造', '', 1834, 1835, 914, 4);
INSERT INTO `industry` VALUES (920, '3976', '光电子器件制造', '', 1836, 1837, 914, 4);
INSERT INTO `industry` VALUES (921, '3979', '其他电子器件制造', '', 1838, 1839, 914, 4);
INSERT INTO `industry` VALUES (922, '398', '电子元件及电子专用材料制造', '', 1841, 1854, 885, 3);
INSERT INTO `industry` VALUES (923, '3981', '电阻电容电感元件制造', '', 1842, 1843, 922, 4);
INSERT INTO `industry` VALUES (924, '3982', '电子电路制造', '', 1844, 1845, 922, 4);
INSERT INTO `industry` VALUES (925, '3983', '敏感元件及传感器制造', '', 1846, 1847, 922, 4);
INSERT INTO `industry` VALUES (926, '3984', '电声器件及零件制造', '', 1848, 1849, 922, 4);
INSERT INTO `industry` VALUES (927, '3985', '电子专用材料制造', '', 1850, 1851, 922, 4);
INSERT INTO `industry` VALUES (928, '3989', '其他电子元件制造', '', 1852, 1853, 922, 4);
INSERT INTO `industry` VALUES (929, '399', '其他电子设备制造', '', 1855, 1858, 885, 3);
INSERT INTO `industry` VALUES (930, '3990', '其他电子设备制造', '', 1856, 1857, 929, 4);
INSERT INTO `industry` VALUES (931, '40', '仪器仪表制造业', '', 1860, 1913, 169, 2);
INSERT INTO `industry` VALUES (932, '401', '通用仪器仪表制造', '', 1861, 1876, 931, 3);
INSERT INTO `industry` VALUES (933, '4011', '工业自动控制系统装置制造', '', 1862, 1863, 932, 4);
INSERT INTO `industry` VALUES (934, '4012', '电工仪器仪表制造', '', 1864, 1865, 932, 4);
INSERT INTO `industry` VALUES (935, '4013', '绘图、计算及测量仪器制造', '', 1866, 1867, 932, 4);
INSERT INTO `industry` VALUES (936, '4014', '实验分析仪器制造', '', 1868, 1869, 932, 4);
INSERT INTO `industry` VALUES (937, '4015', '试验机制造', '', 1870, 1871, 932, 4);
INSERT INTO `industry` VALUES (938, '4016', '供应用仪器仪表制造', '', 1872, 1873, 932, 4);
INSERT INTO `industry` VALUES (939, '4019', '其他通用仪器制造', '', 1874, 1875, 932, 4);
INSERT INTO `industry` VALUES (940, '402', '专用仪器仪表制造', '', 1877, 1896, 931, 3);
INSERT INTO `industry` VALUES (941, '4021', '环境监测专用仪器仪表制造', '', 1878, 1879, 940, 4);
INSERT INTO `industry` VALUES (942, '4022', '运输设备及生产用计数仪表制造', '', 1880, 1881, 940, 4);
INSERT INTO `industry` VALUES (943, '4023', '导航、测绘、气象及海洋专用仪器制', '', 1882, 1883, 940, 4);
INSERT INTO `industry` VALUES (944, '4024', '农林牧渔专用仪器仪表制造', '', 1884, 1885, 940, 4);
INSERT INTO `industry` VALUES (945, '4025', '地质勘探和地震专用仪器制造', '', 1886, 1887, 940, 4);
INSERT INTO `industry` VALUES (946, '4026', '教学专用仪器制造', '', 1888, 1889, 940, 4);
INSERT INTO `industry` VALUES (947, '4027', '核子及核辐射测量仪器制造', '', 1890, 1891, 940, 4);
INSERT INTO `industry` VALUES (948, '4028', '电子测量仪器制造', '', 1892, 1893, 940, 4);
INSERT INTO `industry` VALUES (949, '4029', '其他专用仪器制造', '', 1894, 1895, 940, 4);
INSERT INTO `industry` VALUES (950, '403', '钟表与计时仪器制造', '', 1897, 1900, 931, 3);
INSERT INTO `industry` VALUES (951, '4030', '钟表与计时仪器制造', '', 1898, 1899, 950, 4);
INSERT INTO `industry` VALUES (952, '404', '光学仪器制造', '', 1901, 1904, 931, 3);
INSERT INTO `industry` VALUES (953, '4040', '光学仪器制造', '', 1902, 1903, 952, 4);
INSERT INTO `industry` VALUES (954, '405', '衡器制造', '', 1905, 1908, 931, 3);
INSERT INTO `industry` VALUES (955, '4050', '衡器制造', '', 1906, 1907, 954, 4);
INSERT INTO `industry` VALUES (956, '409', '其他仪器仪表制造业', '', 1909, 1912, 931, 3);
INSERT INTO `industry` VALUES (957, '4090', '其他仪器仪表制造业', '', 1910, 1911, 956, 4);
INSERT INTO `industry` VALUES (958, '41', '其他制造业', '', 1914, 1929, 169, 2);
INSERT INTO `industry` VALUES (959, '411', '日用杂品制造', '', 1915, 1920, 958, 3);
INSERT INTO `industry` VALUES (960, '4111', '鬃毛加工、制刷及清扫工具制造', '', 1916, 1917, 959, 4);
INSERT INTO `industry` VALUES (961, '4119', '其他日用杂品制造', '', 1918, 1919, 959, 4);
INSERT INTO `industry` VALUES (962, '412', '核辐射加工', '', 1921, 1924, 958, 3);
INSERT INTO `industry` VALUES (963, '4120', '核辐射加工', '', 1922, 1923, 962, 4);
INSERT INTO `industry` VALUES (964, '419', '其他未列明制造业', '', 1925, 1928, 958, 3);
INSERT INTO `industry` VALUES (965, '4190', '其他未列明制造业', '', 1926, 1927, 964, 4);
INSERT INTO `industry` VALUES (966, '42', '废弃资源综合利用业', '', 1930, 1939, 169, 2);
INSERT INTO `industry` VALUES (967, '421', '金属废料和碎屑加工处理', '', 1931, 1934, 966, 3);
INSERT INTO `industry` VALUES (968, '4210', '金属废料和碎屑加工处理', '', 1932, 1933, 967, 4);
INSERT INTO `industry` VALUES (969, '422', '非金属废料和碎屑加工处理', '', 1935, 1938, 966, 3);
INSERT INTO `industry` VALUES (970, '4220', '非金属废料和碎屑加工处理', '', 1936, 1937, 969, 4);
INSERT INTO `industry` VALUES (971, '43', '金属制品、机械和设备修理业', '', 1940, 1975, 169, 2);
INSERT INTO `industry` VALUES (972, '431', '金属制品修理', '', 1941, 1944, 971, 3);
INSERT INTO `industry` VALUES (973, '4310', '金属制品修理', '', 1942, 1943, 972, 4);
INSERT INTO `industry` VALUES (974, '432', '通用设备修理', '', 1945, 1948, 971, 3);
INSERT INTO `industry` VALUES (975, '4320', '通用设备修理', '', 1946, 1947, 974, 4);
INSERT INTO `industry` VALUES (976, '433', '专用设备修理', '', 1949, 1952, 971, 3);
INSERT INTO `industry` VALUES (977, '4330', '专用设备修理', '', 1950, 1951, 976, 4);
INSERT INTO `industry` VALUES (978, '434', '铁路、船舶、航空航天等运输设备修理', '', 1953, 1962, 971, 3);
INSERT INTO `industry` VALUES (979, '4341', '铁路运输设备修理', '', 1954, 1955, 978, 4);
INSERT INTO `industry` VALUES (980, '4342', '船舶修理', '', 1956, 1957, 978, 4);
INSERT INTO `industry` VALUES (981, '4343', '航空航天器修理', '', 1958, 1959, 978, 4);
INSERT INTO `industry` VALUES (982, '4349', '其他运输设备修理', '', 1960, 1961, 978, 4);
INSERT INTO `industry` VALUES (983, '435', '电气设备修理', '', 1963, 1966, 971, 3);
INSERT INTO `industry` VALUES (984, '4350', '电气设备修理', '', 1964, 1965, 983, 4);
INSERT INTO `industry` VALUES (985, '436', '仪器仪表修理', '', 1967, 1970, 971, 3);
INSERT INTO `industry` VALUES (986, '4360', '仪器仪表修理', '', 1968, 1969, 985, 4);
INSERT INTO `industry` VALUES (987, '439', '其他机械和设备修理业', '', 1971, 1974, 971, 3);
INSERT INTO `industry` VALUES (988, '4390', '其他机械和设备修理业', '', 1972, 1973, 987, 4);
INSERT INTO `industry` VALUES (989, 'D', '电力、热力、燃气及水生产和供应业', '', 1977, 2038, 0, 1);
INSERT INTO `industry` VALUES (990, '44', '电力、热力生产和供应业', '', 1978, 2005, 989, 2);
INSERT INTO `industry` VALUES (991, '441', '电力生产', '', 1979, 1996, 990, 3);
INSERT INTO `industry` VALUES (992, '4411', '火力发电', '', 1980, 1981, 991, 4);
INSERT INTO `industry` VALUES (993, '4412', '热电联产', '', 1982, 1983, 991, 4);
INSERT INTO `industry` VALUES (994, '4413', '水力发电', '', 1984, 1985, 991, 4);
INSERT INTO `industry` VALUES (995, '4414', '核力发电', '', 1986, 1987, 991, 4);
INSERT INTO `industry` VALUES (996, '4415', '风力发电', '', 1988, 1989, 991, 4);
INSERT INTO `industry` VALUES (997, '4416', '太阳能发电', '', 1990, 1991, 991, 4);
INSERT INTO `industry` VALUES (998, '4417', '生物质能发电', '', 1992, 1993, 991, 4);
INSERT INTO `industry` VALUES (999, '4419', '其他电力生产', '', 1994, 1995, 991, 4);
INSERT INTO `industry` VALUES (1000, '442', '电力供应', '', 1997, 2000, 990, 3);
INSERT INTO `industry` VALUES (1001, '4420', '电力供应', '', 1998, 1999, 1000, 4);
INSERT INTO `industry` VALUES (1002, '443', '热力生产和供应', '', 2001, 2004, 990, 3);
INSERT INTO `industry` VALUES (1003, '4430', '热力生产和供应', '', 2002, 2003, 1002, 4);
INSERT INTO `industry` VALUES (1004, '45', '燃气生产和供应业', '', 2006, 2019, 989, 2);
INSERT INTO `industry` VALUES (1005, '451', '燃气生产和供应业', '', 2007, 2014, 1004, 3);
INSERT INTO `industry` VALUES (1006, '4511', '天然气生产和供应业', '', 2008, 2009, 1005, 4);
INSERT INTO `industry` VALUES (1007, '4512', '液化石油气生产和供应业', '', 2010, 2011, 1005, 4);
INSERT INTO `industry` VALUES (1008, '4513', '煤气生产和供应业', '', 2012, 2013, 1005, 4);
INSERT INTO `industry` VALUES (1009, '452', '生物质燃气生产和供应业', '', 2015, 2018, 1004, 3);
INSERT INTO `industry` VALUES (1010, '4520', '生物质燃气生产和供应业', '', 2016, 2017, 1009, 4);
INSERT INTO `industry` VALUES (1011, '46', '水的生产和供应业', '', 2020, 2037, 989, 2);
INSERT INTO `industry` VALUES (1012, '461', '自来水生产和供应', '', 2021, 2024, 1011, 3);
INSERT INTO `industry` VALUES (1013, '4610', '自来水生产和供应', '', 2022, 2023, 1012, 4);
INSERT INTO `industry` VALUES (1014, '462', '污水处理及其再生利用', '', 2025, 2028, 1011, 3);
INSERT INTO `industry` VALUES (1015, '4620', '污水处理及其再生利用', '', 2026, 2027, 1014, 4);
INSERT INTO `industry` VALUES (1016, '463', '海水淡化处理', '', 2029, 2032, 1011, 3);
INSERT INTO `industry` VALUES (1017, '4630', '海水淡化处理', '', 2030, 2031, 1016, 4);
INSERT INTO `industry` VALUES (1018, '469', '其他水的处理、利用与分配', '', 2033, 2036, 1011, 3);
INSERT INTO `industry` VALUES (1019, '4690', '其他水的处理、利用与分配', '', 2034, 2035, 1018, 4);
INSERT INTO `industry` VALUES (1020, 'E', '建筑业', '', 2039, 2172, 0, 1);
INSERT INTO `industry` VALUES (1021, '47', '房屋建筑业', '', 2040, 2053, 1020, 2);
INSERT INTO `industry` VALUES (1022, '471', '住宅房屋建筑', '', 2041, 2044, 1021, 3);
INSERT INTO `industry` VALUES (1023, '4710', '住宅房屋建筑', '', 2042, 2043, 1022, 4);
INSERT INTO `industry` VALUES (1024, '472', '体育场馆建筑', '', 2045, 2048, 1021, 3);
INSERT INTO `industry` VALUES (1025, '4720', '体育场馆建筑', '', 2046, 2047, 1024, 4);
INSERT INTO `industry` VALUES (1026, '479', '其他房屋建筑业', '', 2049, 2052, 1021, 3);
INSERT INTO `industry` VALUES (1027, '4790', '其他房屋建筑业', '', 2050, 2051, 1026, 4);
INSERT INTO `industry` VALUES (1028, '48', '土木工程建筑业', '', 2054, 2131, 1020, 2);
INSERT INTO `industry` VALUES (1029, '481', '铁路、道路、隧道和桥梁工程建筑', '', 2055, 2066, 1028, 3);
INSERT INTO `industry` VALUES (1030, '4811', '铁路工程建筑', '', 2056, 2057, 1029, 4);
INSERT INTO `industry` VALUES (1031, '4812', '公路工程建筑', '', 2058, 2059, 1029, 4);
INSERT INTO `industry` VALUES (1032, '4813', '市政道路工程建筑', '', 2060, 2061, 1029, 4);
INSERT INTO `industry` VALUES (1033, '4814', '城市轨道交通工程建筑', '', 2062, 2063, 1029, 4);
INSERT INTO `industry` VALUES (1034, '4819', '其他道路、隧道和桥梁工程建筑', '', 2064, 2065, 1029, 4);
INSERT INTO `industry` VALUES (1035, '482', '水利和水运工程建筑', '', 2067, 2074, 1028, 3);
INSERT INTO `industry` VALUES (1036, '4821', '水源及供水设施工程建筑', '', 2068, 2069, 1035, 4);
INSERT INTO `industry` VALUES (1037, '4822', '河湖治理及防洪设施工程建筑', '', 2070, 2071, 1035, 4);
INSERT INTO `industry` VALUES (1038, '4823', '港口及航运设施工程建筑', '', 2072, 2073, 1035, 4);
INSERT INTO `industry` VALUES (1039, '483', '海洋工程建筑', '', 2075, 2086, 1028, 3);
INSERT INTO `industry` VALUES (1040, '4831', '海洋油气资源开发利用工程建筑', '', 2076, 2077, 1039, 4);
INSERT INTO `industry` VALUES (1041, '4832', '海洋能源开发利用工程建筑', '', 2078, 2079, 1039, 4);
INSERT INTO `industry` VALUES (1042, '4833', '海底隧道工程建筑', '', 2080, 2081, 1039, 4);
INSERT INTO `industry` VALUES (1043, '4834', '海底设施铺设工程建筑', '', 2082, 2083, 1039, 4);
INSERT INTO `industry` VALUES (1044, '4839', '其他海洋工程建筑', '', 2084, 2085, 1039, 4);
INSERT INTO `industry` VALUES (1045, '484', '工矿工程建筑', '', 2087, 2090, 1028, 3);
INSERT INTO `industry` VALUES (1046, '4840', '工矿工程建筑', '', 2088, 2089, 1045, 4);
INSERT INTO `industry` VALUES (1047, '485', '架线和管道工程建筑', '', 2091, 2098, 1028, 3);
INSERT INTO `industry` VALUES (1048, '4851', '架线及设备工程建筑', '', 2092, 2093, 1047, 4);
INSERT INTO `industry` VALUES (1049, '4852', '管道工程建筑', '', 2094, 2095, 1047, 4);
INSERT INTO `industry` VALUES (1050, '4853', '地下综合管廊工程建筑', '', 2096, 2097, 1047, 4);
INSERT INTO `industry` VALUES (1051, '486', '节能环保工程施工', '', 2099, 2106, 1028, 3);
INSERT INTO `industry` VALUES (1052, '4861', '节能工程施工', '', 2100, 2101, 1051, 4);
INSERT INTO `industry` VALUES (1053, '4862', '环保工程施工', '', 2102, 2103, 1051, 4);
INSERT INTO `industry` VALUES (1054, '4863', '生态保护工程施工', '', 2104, 2105, 1051, 4);
INSERT INTO `industry` VALUES (1055, '487', '电力工程施工', '', 2107, 2120, 1028, 3);
INSERT INTO `industry` VALUES (1056, '4871', '火力发电工程施工', '', 2108, 2109, 1055, 4);
INSERT INTO `industry` VALUES (1057, '4872', '水力发电工程施工', '', 2110, 2111, 1055, 4);
INSERT INTO `industry` VALUES (1058, '4873', '核电工程施工', '', 2112, 2113, 1055, 4);
INSERT INTO `industry` VALUES (1059, '4874', '风能发电工程施工', '', 2114, 2115, 1055, 4);
INSERT INTO `industry` VALUES (1060, '4875', '太阳能发电工程施工', '', 2116, 2117, 1055, 4);
INSERT INTO `industry` VALUES (1061, '4879', '其他电力工程施工', '', 2118, 2119, 1055, 4);
INSERT INTO `industry` VALUES (1062, '489', '其他土木工程建筑', '', 2121, 2130, 1028, 3);
INSERT INTO `industry` VALUES (1063, '4891', '园林绿化工程施工', '', 2122, 2123, 1062, 4);
INSERT INTO `industry` VALUES (1064, '4892', '体育场地设施工程施工', '', 2124, 2125, 1062, 4);
INSERT INTO `industry` VALUES (1065, '4893', '游乐设施工程施工', '', 2126, 2127, 1062, 4);
INSERT INTO `industry` VALUES (1066, '4899', '其他土木工程建筑施工', '', 2128, 2129, 1062, 4);
INSERT INTO `industry` VALUES (1067, '49', '建筑安装业', '', 2132, 2147, 1020, 2);
INSERT INTO `industry` VALUES (1068, '491', '电气安装', '', 2133, 2136, 1067, 3);
INSERT INTO `industry` VALUES (1069, '4910', '电气安装', '', 2134, 2135, 1068, 4);
INSERT INTO `industry` VALUES (1070, '492', '管道和设备安装', '', 2137, 2140, 1067, 3);
INSERT INTO `industry` VALUES (1071, '4920', '管道和设备安装', '', 2138, 2139, 1070, 4);
INSERT INTO `industry` VALUES (1072, '499', '其他建筑安装业', '', 2141, 2146, 1067, 3);
INSERT INTO `industry` VALUES (1073, '4991', '体育场地设施安装', '', 2142, 2143, 1072, 4);
INSERT INTO `industry` VALUES (1074, '4999', '其他建筑安装', '', 2144, 2145, 1072, 4);
INSERT INTO `industry` VALUES (1075, '50', '建筑装饰、装修和其他建筑业', '', 2148, 2171, 1020, 2);
INSERT INTO `industry` VALUES (1076, '501', '建筑装饰和装修业', '', 2149, 2156, 1075, 3);
INSERT INTO `industry` VALUES (1077, '5011', '公共建筑装饰和装修', '', 2150, 2151, 1076, 4);
INSERT INTO `industry` VALUES (1078, '5012', '住宅装饰和装修', '', 2152, 2153, 1076, 4);
INSERT INTO `industry` VALUES (1079, '5013', '建筑幕墙装饰和装修', '', 2154, 2155, 1076, 4);
INSERT INTO `industry` VALUES (1080, '502', '建筑物拆除和场地准备活动', '', 2157, 2162, 1075, 3);
INSERT INTO `industry` VALUES (1081, '5021', '建筑物拆除活动', '', 2158, 2159, 1080, 4);
INSERT INTO `industry` VALUES (1082, '5022', '场地准备活动', '', 2160, 2161, 1080, 4);
INSERT INTO `industry` VALUES (1083, '503', '提供施工设备服务', '', 2163, 2166, 1075, 3);
INSERT INTO `industry` VALUES (1084, '5030', '提供施工设备服务', '', 2164, 2165, 1083, 4);
INSERT INTO `industry` VALUES (1085, '509', '其他未列明建筑业', '', 2167, 2170, 1075, 3);
INSERT INTO `industry` VALUES (1086, '5090', '其他未列明建筑业', '', 2168, 2169, 1085, 4);
INSERT INTO `industry` VALUES (1087, 'F', '批发和零售业', '', 2173, 2470, 0, 1);
INSERT INTO `industry` VALUES (1088, '51', '批发业', '', 2174, 2323, 1087, 2);
INSERT INTO `industry` VALUES (1089, '511', '农、林、牧、渔产品批发', '', 2175, 2192, 1088, 3);
INSERT INTO `industry` VALUES (1090, '5111', '谷物、豆及薯类批发', '', 2176, 2177, 1089, 4);
INSERT INTO `industry` VALUES (1091, '5112', '种子批发', '', 2178, 2179, 1089, 4);
INSERT INTO `industry` VALUES (1092, '5113', '畜牧渔业饲料批发', '', 2180, 2181, 1089, 4);
INSERT INTO `industry` VALUES (1093, '5114', '棉、麻批发', '', 2182, 2183, 1089, 4);
INSERT INTO `industry` VALUES (1094, '5115', '林业产品批发', '', 2184, 2185, 1089, 4);
INSERT INTO `industry` VALUES (1095, '5116', '牲畜批发', '', 2186, 2187, 1089, 4);
INSERT INTO `industry` VALUES (1096, '5117', '渔业产品批发', '', 2188, 2189, 1089, 4);
INSERT INTO `industry` VALUES (1097, '5119', '其他农牧产品批发', '', 2190, 2191, 1089, 4);
INSERT INTO `industry` VALUES (1098, '512', '食品、饮料及烟草制品批发', '', 2193, 2212, 1088, 3);
INSERT INTO `industry` VALUES (1099, '5121', '米、面制品及食用油批发', '', 2194, 2195, 1098, 4);
INSERT INTO `industry` VALUES (1100, '5122', '糕点、糖果及糖批发', '', 2196, 2197, 1098, 4);
INSERT INTO `industry` VALUES (1101, '5123', '果品、蔬菜批发', '', 2198, 2199, 1098, 4);
INSERT INTO `industry` VALUES (1102, '5124', '肉、禽、蛋、奶及水产品批发', '', 2200, 2201, 1098, 4);
INSERT INTO `industry` VALUES (1103, '5125', '盐及调味品批发', '', 2202, 2203, 1098, 4);
INSERT INTO `industry` VALUES (1104, '5126', '营养和保健品批发', '', 2204, 2205, 1098, 4);
INSERT INTO `industry` VALUES (1105, '5127', '酒、饮料及茶叶批发', '', 2206, 2207, 1098, 4);
INSERT INTO `industry` VALUES (1106, '5128', '烟草制品批发', '', 2208, 2209, 1098, 4);
INSERT INTO `industry` VALUES (1107, '5129', '其他食品批发', '', 2210, 2211, 1098, 4);
INSERT INTO `industry` VALUES (1108, '513', '纺织、服装及家庭用品批发', '', 2213, 2232, 1088, 3);
INSERT INTO `industry` VALUES (1109, '5131', '纺织品、针织品及原料批发', '', 2214, 2215, 1108, 4);
INSERT INTO `industry` VALUES (1110, '5132', '服装批发', '', 2216, 2217, 1108, 4);
INSERT INTO `industry` VALUES (1111, '5133', '鞋帽批发', '', 2218, 2219, 1108, 4);
INSERT INTO `industry` VALUES (1112, '5134', '化妆品及卫生用品批发', '', 2220, 2221, 1108, 4);
INSERT INTO `industry` VALUES (1113, '5135', '厨具卫具及日用杂品批发', '', 2222, 2223, 1108, 4);
INSERT INTO `industry` VALUES (1114, '5136', '灯具、装饰物品批发', '', 2224, 2225, 1108, 4);
INSERT INTO `industry` VALUES (1115, '5137', '家用视听设备批发', '', 2226, 2227, 1108, 4);
INSERT INTO `industry` VALUES (1116, '5138', '日用家电批发', '', 2228, 2229, 1108, 4);
INSERT INTO `industry` VALUES (1117, '5139', '其他家庭用品批发', '', 2230, 2231, 1108, 4);
INSERT INTO `industry` VALUES (1118, '514', '文化、体育用品及器材批发', '', 2233, 2250, 1088, 3);
INSERT INTO `industry` VALUES (1119, '5141', '文具用品批发', '', 2234, 2235, 1118, 4);
INSERT INTO `industry` VALUES (1120, '5142', '体育用品及器材批发', '', 2236, 2237, 1118, 4);
INSERT INTO `industry` VALUES (1121, '5143', '图书批发', '', 2238, 2239, 1118, 4);
INSERT INTO `industry` VALUES (1122, '5144', '报刊批发', '', 2240, 2241, 1118, 4);
INSERT INTO `industry` VALUES (1123, '5145', '音像制品、电子和数字出版物批发', '', 2242, 2243, 1118, 4);
INSERT INTO `industry` VALUES (1124, '5146', '首饰、工艺品及收藏品批发', '', 2244, 2245, 1118, 4);
INSERT INTO `industry` VALUES (1125, '5147', '乐器批发', '', 2246, 2247, 1118, 4);
INSERT INTO `industry` VALUES (1126, '5149', '其他文化用品批发', '', 2248, 2249, 1118, 4);
INSERT INTO `industry` VALUES (1127, '515', '医药及医疗器材批发', '', 2251, 2260, 1088, 3);
INSERT INTO `industry` VALUES (1128, '5151', '西药批发', '', 2252, 2253, 1127, 4);
INSERT INTO `industry` VALUES (1129, '5152', '中药批发', '', 2254, 2255, 1127, 4);
INSERT INTO `industry` VALUES (1130, '5153', '动物用药品批发', '', 2256, 2257, 1127, 4);
INSERT INTO `industry` VALUES (1131, '5154', '医疗用品及器材批发', '', 2258, 2259, 1127, 4);
INSERT INTO `industry` VALUES (1132, '516', '矿产品、建材及化工产品批发', '', 2261, 2280, 1088, 3);
INSERT INTO `industry` VALUES (1133, '5161', '煤炭及制品批发', '', 2262, 2263, 1132, 4);
INSERT INTO `industry` VALUES (1134, '5162', '石油及制品批发', '', 2264, 2265, 1132, 4);
INSERT INTO `industry` VALUES (1135, '5163', '非金属矿及制品批发', '', 2266, 2267, 1132, 4);
INSERT INTO `industry` VALUES (1136, '5164', '金属及金属矿批发', '', 2268, 2269, 1132, 4);
INSERT INTO `industry` VALUES (1137, '5165', '建材批发', '', 2270, 2271, 1132, 4);
INSERT INTO `industry` VALUES (1138, '5166', '化肥批发', '', 2272, 2273, 1132, 4);
INSERT INTO `industry` VALUES (1139, '5167', '农药批发', '', 2274, 2275, 1132, 4);
INSERT INTO `industry` VALUES (1140, '5168', '农用薄膜批发', '', 2276, 2277, 1132, 4);
INSERT INTO `industry` VALUES (1141, '5169', '其他化工产品批发', '', 2278, 2279, 1132, 4);
INSERT INTO `industry` VALUES (1142, '517', '机械设备、五金产品及电子产品批发', '', 2281, 2300, 1088, 3);
INSERT INTO `industry` VALUES (1143, '5171', '农业机械批发', '', 2282, 2283, 1142, 4);
INSERT INTO `industry` VALUES (1144, '5172', '汽车及零配件批发', '', 2284, 2285, 1142, 4);
INSERT INTO `industry` VALUES (1145, '5173', '摩托车及零配件批发', '', 2286, 2287, 1142, 4);
INSERT INTO `industry` VALUES (1146, '5174', '五金产品批发', '', 2288, 2289, 1142, 4);
INSERT INTO `industry` VALUES (1147, '5175', '电气设备批发', '', 2290, 2291, 1142, 4);
INSERT INTO `industry` VALUES (1148, '5176', '计算机、软件及辅助设备批发', '', 2292, 2293, 1142, 4);
INSERT INTO `industry` VALUES (1149, '5177', '通讯设备批发', '', 2294, 2295, 1142, 4);
INSERT INTO `industry` VALUES (1150, '5178', '广播影视设备批发', '', 2296, 2297, 1142, 4);
INSERT INTO `industry` VALUES (1151, '5179', '其他机械设备及电子产品批发', '', 2298, 2299, 1142, 4);
INSERT INTO `industry` VALUES (1152, '518', '贸易经纪与代理', '', 2301, 2312, 1088, 3);
INSERT INTO `industry` VALUES (1153, '5181', '贸易代理', '', 2302, 2303, 1152, 4);
INSERT INTO `industry` VALUES (1154, '5182', '一般物品拍卖', '', 2304, 2305, 1152, 4);
INSERT INTO `industry` VALUES (1155, '5183', '艺术品、收藏品拍卖', '', 2306, 2307, 1152, 4);
INSERT INTO `industry` VALUES (1156, '5184', '艺术品代理', '', 2308, 2309, 1152, 4);
INSERT INTO `industry` VALUES (1157, '5189', '其他贸易经纪与代理', '', 2310, 2311, 1152, 4);
INSERT INTO `industry` VALUES (1158, '519', '其他批发业', '', 2313, 2322, 1088, 3);
INSERT INTO `industry` VALUES (1159, '5191', '再生物资回收与批发', '', 2314, 2315, 1158, 4);
INSERT INTO `industry` VALUES (1160, '5192', '宠物食品用品批发', '', 2316, 2317, 1158, 4);
INSERT INTO `industry` VALUES (1161, '5193', '互联网批发', '', 2318, 2319, 1158, 4);
INSERT INTO `industry` VALUES (1162, '5199', '其他未列明批发业', '', 2320, 2321, 1158, 4);
INSERT INTO `industry` VALUES (1163, '52', '零售业', '', 2324, 2469, 1087, 2);
INSERT INTO `industry` VALUES (1164, '521', '综合零售', '', 2325, 2334, 1163, 3);
INSERT INTO `industry` VALUES (1165, '5211', '百货零售', '', 2326, 2327, 1164, 4);
INSERT INTO `industry` VALUES (1166, '5212', '超级市场零售', '', 2328, 2329, 1164, 4);
INSERT INTO `industry` VALUES (1167, '5213', '便利店零售', '', 2330, 2331, 1164, 4);
INSERT INTO `industry` VALUES (1168, '5219', '其他综合零售', '', 2332, 2333, 1164, 4);
INSERT INTO `industry` VALUES (1169, '522', '食品、饮料及烟草制品专门零售', '', 2335, 2352, 1163, 3);
INSERT INTO `industry` VALUES (1170, '5221', '粮油零售', '', 2336, 2337, 1169, 4);
INSERT INTO `industry` VALUES (1171, '5222', '糕点、面包零售', '', 2338, 2339, 1169, 4);
INSERT INTO `industry` VALUES (1172, '5223', '果品、蔬菜零售', '', 2340, 2341, 1169, 4);
INSERT INTO `industry` VALUES (1173, '5224', '肉、禽、蛋、奶及水产品零售', '', 2342, 2343, 1169, 4);
INSERT INTO `industry` VALUES (1174, '5225', '营养和保健品零售', '', 2344, 2345, 1169, 4);
INSERT INTO `industry` VALUES (1175, '5226', '酒、饮料及茶叶零售', '', 2346, 2347, 1169, 4);
INSERT INTO `industry` VALUES (1176, '5227', '烟草制品零售', '', 2348, 2349, 1169, 4);
INSERT INTO `industry` VALUES (1177, '5229', '其他食品零售', '', 2350, 2351, 1169, 4);
INSERT INTO `industry` VALUES (1178, '523', '纺织、服装及日用品专门零售', '', 2353, 2372, 1163, 3);
INSERT INTO `industry` VALUES (1179, '5231', '纺织品及针织品零售', '', 2354, 2355, 1178, 4);
INSERT INTO `industry` VALUES (1180, '5232', '服装零售', '', 2356, 2357, 1178, 4);
INSERT INTO `industry` VALUES (1181, '5233', '鞋帽零售', '', 2358, 2359, 1178, 4);
INSERT INTO `industry` VALUES (1182, '5234', '化妆品及卫生用品零售', '', 2360, 2361, 1178, 4);
INSERT INTO `industry` VALUES (1183, '5235', '厨具卫具及日用杂品零售', '', 2362, 2363, 1178, 4);
INSERT INTO `industry` VALUES (1184, '5236', '钟表、眼镜零售', '', 2364, 2365, 1178, 4);
INSERT INTO `industry` VALUES (1185, '5237', '箱包零售', '', 2366, 2367, 1178, 4);
INSERT INTO `industry` VALUES (1186, '5238', '自行车等代步设备零售', '', 2368, 2369, 1178, 4);
INSERT INTO `industry` VALUES (1187, '5239', '其他日用品零售', '', 2370, 2371, 1178, 4);
INSERT INTO `industry` VALUES (1188, '524', '文化、体育用品及器材专门零售', '', 2373, 2392, 1163, 3);
INSERT INTO `industry` VALUES (1189, '5241', '文具用品零售', '', 2374, 2375, 1188, 4);
INSERT INTO `industry` VALUES (1190, '5242', '体育用品及器材零售', '', 2376, 2377, 1188, 4);
INSERT INTO `industry` VALUES (1191, '5243', '图书、报刊零售', '', 2378, 2379, 1188, 4);
INSERT INTO `industry` VALUES (1192, '5244', '音像制品、电子和数字出版物零售', '', 2380, 2381, 1188, 4);
INSERT INTO `industry` VALUES (1193, '5245', '珠宝首饰零售', '', 2382, 2383, 1188, 4);
INSERT INTO `industry` VALUES (1194, '5246', '工艺美术品及收藏品零售', '', 2384, 2385, 1188, 4);
INSERT INTO `industry` VALUES (1195, '5247', '乐器零售', '', 2386, 2387, 1188, 4);
INSERT INTO `industry` VALUES (1196, '5248', '照相器材零售', '', 2388, 2389, 1188, 4);
INSERT INTO `industry` VALUES (1197, '5249', '其他文化用品零售', '', 2390, 2391, 1188, 4);
INSERT INTO `industry` VALUES (1198, '525', '医药及医疗器材专门零售', '', 2393, 2404, 1163, 3);
INSERT INTO `industry` VALUES (1199, '5251', '西药零售', '', 2394, 2395, 1198, 4);
INSERT INTO `industry` VALUES (1200, '5252', '中药零售', '', 2396, 2397, 1198, 4);
INSERT INTO `industry` VALUES (1201, '5253', '动物用药品零售', '', 2398, 2399, 1198, 4);
INSERT INTO `industry` VALUES (1202, '5254', '医疗用品及器材零售', '', 2400, 2401, 1198, 4);
INSERT INTO `industry` VALUES (1203, '5255', '保健辅助治疗器材零售', '', 2402, 2403, 1198, 4);
INSERT INTO `industry` VALUES (1204, '526', '汽车、摩托车、零配件和燃料及其他动力销售', '', 2405, 2420, 1163, 3);
INSERT INTO `industry` VALUES (1205, '5261', '汽车新车零售', '', 2406, 2407, 1204, 4);
INSERT INTO `industry` VALUES (1206, '5262', '汽车旧车零售', '', 2408, 2409, 1204, 4);
INSERT INTO `industry` VALUES (1207, '5263', '汽车零配件零售', '', 2410, 2411, 1204, 4);
INSERT INTO `industry` VALUES (1208, '5264', '摩托车及零配件零售', '', 2412, 2413, 1204, 4);
INSERT INTO `industry` VALUES (1209, '5265', '机动车燃油零售', '', 2414, 2415, 1204, 4);
INSERT INTO `industry` VALUES (1210, '5266', '机动车燃气零售', '', 2416, 2417, 1204, 4);
INSERT INTO `industry` VALUES (1211, '5267', '机动车充电销售', '', 2418, 2419, 1204, 4);
INSERT INTO `industry` VALUES (1212, '527', '家用电器及电子产品专门零售', '', 2421, 2432, 1163, 3);
INSERT INTO `industry` VALUES (1213, '5271', '家用视听设备零售', '', 2422, 2423, 1212, 4);
INSERT INTO `industry` VALUES (1214, '5272', '日用家电零售', '', 2424, 2425, 1212, 4);
INSERT INTO `industry` VALUES (1215, '5273', '计算机、软件及辅助设备零售', '', 2426, 2427, 1212, 4);
INSERT INTO `industry` VALUES (1216, '5274', '通信设备零售', '', 2428, 2429, 1212, 4);
INSERT INTO `industry` VALUES (1217, '5279', '其他电子产品零售', '', 2430, 2431, 1212, 4);
INSERT INTO `industry` VALUES (1218, '528', '五金、家具及室内装饰材料专门零售', '', 2433, 2450, 1163, 3);
INSERT INTO `industry` VALUES (1219, '5281', '五金零售', '', 2434, 2435, 1218, 4);
INSERT INTO `industry` VALUES (1220, '5282', '灯具零售', '', 2436, 2437, 1218, 4);
INSERT INTO `industry` VALUES (1221, '5283', '家具零售', '', 2438, 2439, 1218, 4);
INSERT INTO `industry` VALUES (1222, '5284', '涂料零售', '', 2440, 2441, 1218, 4);
INSERT INTO `industry` VALUES (1223, '5285', '卫生洁具零售', '', 2442, 2443, 1218, 4);
INSERT INTO `industry` VALUES (1224, '5286', '木质装饰材料零售', '', 2444, 2445, 1218, 4);
INSERT INTO `industry` VALUES (1225, '5287', '陶瓷、石材装饰材料零售', '', 2446, 2447, 1218, 4);
INSERT INTO `industry` VALUES (1226, '5289', '其他室内装饰材料零售', '', 2448, 2449, 1218, 4);
INSERT INTO `industry` VALUES (1227, '529', '货摊、无店铺及其他零售业', '', 2451, 2468, 1163, 3);
INSERT INTO `industry` VALUES (1228, '5291', '流动货摊零售', '', 2452, 2453, 1227, 4);
INSERT INTO `industry` VALUES (1229, '5292', '互联网零售', '', 2454, 2455, 1227, 4);
INSERT INTO `industry` VALUES (1230, '5293', '邮购及电视、电话零售', '', 2456, 2457, 1227, 4);
INSERT INTO `industry` VALUES (1231, '5294', '自动售货机零售', '', 2458, 2459, 1227, 4);
INSERT INTO `industry` VALUES (1232, '5295', '旧货零售', '', 2460, 2461, 1227, 4);
INSERT INTO `industry` VALUES (1233, '5296', '生活用燃料零售', '', 2462, 2463, 1227, 4);
INSERT INTO `industry` VALUES (1234, '5297', '宠物食品用品零售', '', 2464, 2465, 1227, 4);
INSERT INTO `industry` VALUES (1235, '5299', '其他未列明零售业', '', 2466, 2467, 1227, 4);
INSERT INTO `industry` VALUES (1236, 'G', '交通运输、仓储和邮政业', '', 2471, 2676, 0, 1);
INSERT INTO `industry` VALUES (1237, '53', '铁路运输业', '', 2472, 2495, 1236, 2);
INSERT INTO `industry` VALUES (1238, '531', '铁路旅客运输', '', 2473, 2480, 1237, 3);
INSERT INTO `industry` VALUES (1239, '5311', '高速铁路旅客运输', '', 2474, 2475, 1238, 4);
INSERT INTO `industry` VALUES (1240, '5312', '城际铁路旅客运输', '', 2476, 2477, 1238, 4);
INSERT INTO `industry` VALUES (1241, '5313', '普通铁路旅客运输', '', 2478, 2479, 1238, 4);
INSERT INTO `industry` VALUES (1242, '532', '铁路货物运输', '', 2481, 2484, 1237, 3);
INSERT INTO `industry` VALUES (1243, '5320', '铁路货物运输', '', 2482, 2483, 1242, 4);
INSERT INTO `industry` VALUES (1244, '533', '铁路运输辅助活动', '', 2485, 2494, 1237, 3);
INSERT INTO `industry` VALUES (1245, '5331', '客运火车站', '', 2486, 2487, 1244, 4);
INSERT INTO `industry` VALUES (1246, '5332', '货运火车站（场）', '', 2488, 2489, 1244, 4);
INSERT INTO `industry` VALUES (1247, '5333', '铁路运输维护活动', '', 2490, 2491, 1244, 4);
INSERT INTO `industry` VALUES (1248, '5339', '其他铁路运输辅助活动', '', 2492, 2493, 1244, 4);
INSERT INTO `industry` VALUES (1249, '54', '道路运输业', '', 2496, 2547, 1236, 2);
INSERT INTO `industry` VALUES (1250, '541', '城市公共交通运输', '', 2497, 2508, 1249, 3);
INSERT INTO `industry` VALUES (1251, '5411', '公共电汽车客运', '', 2498, 2499, 1250, 4);
INSERT INTO `industry` VALUES (1252, '5412', '城市轨道交通', '', 2500, 2501, 1250, 4);
INSERT INTO `industry` VALUES (1253, '5413', '出租车客运', '', 2502, 2503, 1250, 4);
INSERT INTO `industry` VALUES (1254, '5414', '公共自行车服务', '', 2504, 2505, 1250, 4);
INSERT INTO `industry` VALUES (1255, '5419', '其他城市公共交通运输', '', 2506, 2507, 1250, 4);
INSERT INTO `industry` VALUES (1256, '542', '公路旅客运输', '', 2509, 2516, 1249, 3);
INSERT INTO `industry` VALUES (1257, '5421', '长途客运', '', 2510, 2511, 1256, 4);
INSERT INTO `industry` VALUES (1258, '5422', '旅游客运', '', 2512, 2513, 1256, 4);
INSERT INTO `industry` VALUES (1259, '5429', '其他公路客运', '', 2514, 2515, 1256, 4);
INSERT INTO `industry` VALUES (1260, '543', '道路货物运输', '', 2517, 2536, 1249, 3);
INSERT INTO `industry` VALUES (1261, '5431', '普通货物道路运输', '', 2518, 2519, 1260, 4);
INSERT INTO `industry` VALUES (1262, '5432', '冷藏车道路运输', '', 2520, 2521, 1260, 4);
INSERT INTO `industry` VALUES (1263, '5433', '集装箱道路运输', '', 2522, 2523, 1260, 4);
INSERT INTO `industry` VALUES (1264, '5434', '大型货物道路运输', '', 2524, 2525, 1260, 4);
INSERT INTO `industry` VALUES (1265, '5435', '危险货物道路运输', '', 2526, 2527, 1260, 4);
INSERT INTO `industry` VALUES (1266, '5436', '邮件包裹道路运输', '', 2528, 2529, 1260, 4);
INSERT INTO `industry` VALUES (1267, '5437', '城市配送', '', 2530, 2531, 1260, 4);
INSERT INTO `industry` VALUES (1268, '5438', '搬家运输', '', 2532, 2533, 1260, 4);
INSERT INTO `industry` VALUES (1269, '5439', '其他道路货物运输', '', 2534, 2535, 1260, 4);
INSERT INTO `industry` VALUES (1270, '544', '道路运输辅助活动', '', 2537, 2546, 1249, 3);
INSERT INTO `industry` VALUES (1271, '5441', '客运汽车站', '', 2538, 2539, 1270, 4);
INSERT INTO `industry` VALUES (1272, '5442', '货运枢纽（站）', '', 2540, 2541, 1270, 4);
INSERT INTO `industry` VALUES (1273, '5443', '公路管理与养护', '', 2542, 2543, 1270, 4);
INSERT INTO `industry` VALUES (1274, '5449', '其他道路运输辅助活动', '', 2544, 2545, 1270, 4);
INSERT INTO `industry` VALUES (1275, '55', '水上运输业', '', 2548, 2573, 1236, 2);
INSERT INTO `industry` VALUES (1276, '551', '水上旅客运输', '', 2549, 2556, 1275, 3);
INSERT INTO `industry` VALUES (1277, '5511', '海上旅客运输', '', 2550, 2551, 1276, 4);
INSERT INTO `industry` VALUES (1278, '5512', '内河旅客运输', '', 2552, 2553, 1276, 4);
INSERT INTO `industry` VALUES (1279, '5513', '客运轮渡运输', '', 2554, 2555, 1276, 4);
INSERT INTO `industry` VALUES (1280, '552', '水上货物运输', '', 2557, 2564, 1275, 3);
INSERT INTO `industry` VALUES (1281, '5521', '远洋货物运输', '', 2558, 2559, 1280, 4);
INSERT INTO `industry` VALUES (1282, '5522', '沿海货物运输', '', 2560, 2561, 1280, 4);
INSERT INTO `industry` VALUES (1283, '5523', '内河货物运输', '', 2562, 2563, 1280, 4);
INSERT INTO `industry` VALUES (1284, '553', '水上运输辅助活动', '', 2565, 2572, 1275, 3);
INSERT INTO `industry` VALUES (1285, '5531', '客运港口', '', 2566, 2567, 1284, 4);
INSERT INTO `industry` VALUES (1286, '5532', '货运港口', '', 2568, 2569, 1284, 4);
INSERT INTO `industry` VALUES (1287, '5539', '其他水上运输辅助活动', '', 2570, 2571, 1284, 4);
INSERT INTO `industry` VALUES (1288, '56', '航空运输业', '', 2574, 2599, 1236, 2);
INSERT INTO `industry` VALUES (1289, '561', '航空客货运输', '', 2575, 2580, 1288, 3);
INSERT INTO `industry` VALUES (1290, '5611', '航空旅客运输', '', 2576, 2577, 1289, 4);
INSERT INTO `industry` VALUES (1291, '5612', '航空货物运输', '', 2578, 2579, 1289, 4);
INSERT INTO `industry` VALUES (1292, '562', '通用航空服务', '', 2581, 2590, 1288, 3);
INSERT INTO `industry` VALUES (1293, '5621', '通用航空生产服务', '', 2582, 2583, 1292, 4);
INSERT INTO `industry` VALUES (1294, '5622', '观光游览航空服务', '', 2584, 2585, 1292, 4);
INSERT INTO `industry` VALUES (1295, '5623', '体育航空运动服务', '', 2586, 2587, 1292, 4);
INSERT INTO `industry` VALUES (1296, '5629', '其他通用航空服务', '', 2588, 2589, 1292, 4);
INSERT INTO `industry` VALUES (1297, '563', '航空运输辅助活动', '', 2591, 2598, 1288, 3);
INSERT INTO `industry` VALUES (1298, '5631', '机场', '', 2592, 2593, 1297, 4);
INSERT INTO `industry` VALUES (1299, '5632', '空中交通管理', '', 2594, 2595, 1297, 4);
INSERT INTO `industry` VALUES (1300, '5639', '其他航空运输辅助活动', '', 2596, 2597, 1297, 4);
INSERT INTO `industry` VALUES (1301, '57', '管道运输业', '', 2600, 2609, 1236, 2);
INSERT INTO `industry` VALUES (1302, '571', '海底管道运输', '', 2601, 2604, 1301, 3);
INSERT INTO `industry` VALUES (1303, '5710', '海底管道运输', '', 2602, 2603, 1302, 4);
INSERT INTO `industry` VALUES (1304, '572', '陆地管道运输', '', 2605, 2608, 1301, 3);
INSERT INTO `industry` VALUES (1305, '5720', '陆地管道运输', '', 2606, 2607, 1304, 4);
INSERT INTO `industry` VALUES (1306, '58', '多式联运和运输代理业', '', 2610, 2623, 1236, 2);
INSERT INTO `industry` VALUES (1307, '581', '多式联运', '', 2611, 2614, 1306, 3);
INSERT INTO `industry` VALUES (1308, '5810', '多式联运', '', 2612, 2613, 1307, 4);
INSERT INTO `industry` VALUES (1309, '582', '运输代理业', '', 2615, 2622, 1306, 3);
INSERT INTO `industry` VALUES (1310, '5821', '货物运输代理', '', 2616, 2617, 1309, 4);
INSERT INTO `industry` VALUES (1311, '5822', '旅客票务代理', '', 2618, 2619, 1309, 4);
INSERT INTO `industry` VALUES (1312, '5829', '其他运输代理业', '', 2620, 2621, 1309, 4);
INSERT INTO `industry` VALUES (1313, '59', '装卸搬运和仓储业', '', 2624, 2661, 1236, 2);
INSERT INTO `industry` VALUES (1314, '591', '装卸搬运', '', 2625, 2628, 1313, 3);
INSERT INTO `industry` VALUES (1315, '5910', '装卸搬运', '', 2626, 2627, 1314, 4);
INSERT INTO `industry` VALUES (1316, '592', '通用仓储', '', 2629, 2632, 1313, 3);
INSERT INTO `industry` VALUES (1317, '5920', '通用仓储', '', 2630, 2631, 1316, 4);
INSERT INTO `industry` VALUES (1318, '593', '低温仓储', '', 2633, 2636, 1313, 3);
INSERT INTO `industry` VALUES (1319, '5930', '低温仓储', '', 2634, 2635, 1318, 4);
INSERT INTO `industry` VALUES (1320, '594', '危险品仓储', '', 2637, 2644, 1313, 3);
INSERT INTO `industry` VALUES (1321, '5941', '油气仓储', '', 2638, 2639, 1320, 4);
INSERT INTO `industry` VALUES (1322, '5942', '危险化学品仓储', '', 2640, 2641, 1320, 4);
INSERT INTO `industry` VALUES (1323, '5949', '其他危险品仓储', '', 2642, 2643, 1320, 4);
INSERT INTO `industry` VALUES (1324, '595', '谷物、棉花等农产品仓储', '', 2645, 2652, 1313, 3);
INSERT INTO `industry` VALUES (1325, '5951', '谷物仓储', '', 2646, 2647, 1324, 4);
INSERT INTO `industry` VALUES (1326, '5952', '棉花仓储', '', 2648, 2649, 1324, 4);
INSERT INTO `industry` VALUES (1327, '5959', '其他农产品仓储', '', 2650, 2651, 1324, 4);
INSERT INTO `industry` VALUES (1328, '596', '中药材仓储', '', 2653, 2656, 1313, 3);
INSERT INTO `industry` VALUES (1329, '5960', '中药材仓储', '', 2654, 2655, 1328, 4);
INSERT INTO `industry` VALUES (1330, '599', '其他仓储业', '', 2657, 2660, 1313, 3);
INSERT INTO `industry` VALUES (1331, '5990', '其他仓储业', '', 2658, 2659, 1330, 4);
INSERT INTO `industry` VALUES (1332, '60', '邮政业', '', 2662, 2675, 1236, 2);
INSERT INTO `industry` VALUES (1333, '601', '邮政基本服务', '', 2663, 2666, 1332, 3);
INSERT INTO `industry` VALUES (1334, '6010', '邮政基本服务', '', 2664, 2665, 1333, 4);
INSERT INTO `industry` VALUES (1335, '602', '快递服务', '', 2667, 2670, 1332, 3);
INSERT INTO `industry` VALUES (1336, '6020', '快递服务', '', 2668, 2669, 1335, 4);
INSERT INTO `industry` VALUES (1337, '609', '其他寄递服务', '', 2671, 2674, 1332, 3);
INSERT INTO `industry` VALUES (1338, '6090', '其他寄递服务', '', 2672, 2673, 1337, 4);
INSERT INTO `industry` VALUES (1339, 'H', '住宿和餐饮业', '', 2677, 2734, 0, 1);
INSERT INTO `industry` VALUES (1340, '61', '住宿业', '', 2678, 2701, 1339, 2);
INSERT INTO `industry` VALUES (1341, '611', '旅游饭店', '', 2679, 2682, 1340, 3);
INSERT INTO `industry` VALUES (1342, '6110', '旅游饭店', '', 2680, 2681, 1341, 4);
INSERT INTO `industry` VALUES (1343, '612', '一般旅馆', '', 2683, 2688, 1340, 3);
INSERT INTO `industry` VALUES (1344, '6121', '经济型连锁酒店', '', 2684, 2685, 1343, 4);
INSERT INTO `industry` VALUES (1345, '6129', '其他一般旅馆', '', 2686, 2687, 1343, 4);
INSERT INTO `industry` VALUES (1346, '613', '民宿服务', '', 2689, 2692, 1340, 3);
INSERT INTO `industry` VALUES (1347, '6130', '民宿服务', '', 2690, 2691, 1346, 4);
INSERT INTO `industry` VALUES (1348, '614', '露营地服务', '', 2693, 2696, 1340, 3);
INSERT INTO `industry` VALUES (1349, '6140', '露营地服务', '', 2694, 2695, 1348, 4);
INSERT INTO `industry` VALUES (1350, '619', '其他住宿业', '', 2697, 2700, 1340, 3);
INSERT INTO `industry` VALUES (1351, '6190', '其他住宿业', '', 2698, 2699, 1350, 4);
INSERT INTO `industry` VALUES (1352, '62', '餐饮业', '', 2702, 2733, 1339, 2);
INSERT INTO `industry` VALUES (1353, '621', '正餐服务', '', 2703, 2706, 1352, 3);
INSERT INTO `industry` VALUES (1354, '6210', '正餐服务', '', 2704, 2705, 1353, 4);
INSERT INTO `industry` VALUES (1355, '622', '快餐服务', '', 2707, 2710, 1352, 3);
INSERT INTO `industry` VALUES (1356, '6220', '快餐服务', '', 2708, 2709, 1355, 4);
INSERT INTO `industry` VALUES (1357, '623', '饮料及冷饮服务', '', 2711, 2720, 1352, 3);
INSERT INTO `industry` VALUES (1358, '6231', '茶馆服务', '', 2712, 2713, 1357, 4);
INSERT INTO `industry` VALUES (1359, '6232', '咖啡馆服务', '', 2714, 2715, 1357, 4);
INSERT INTO `industry` VALUES (1360, '6233', '酒吧服务', '', 2716, 2717, 1357, 4);
INSERT INTO `industry` VALUES (1361, '6239', '其他饮料及冷饮服务', '', 2718, 2719, 1357, 4);
INSERT INTO `industry` VALUES (1362, '624', '餐饮配送及外卖送餐服务', '', 2721, 2726, 1352, 3);
INSERT INTO `industry` VALUES (1363, '6241', '餐饮配送服务', '', 2722, 2723, 1362, 4);
INSERT INTO `industry` VALUES (1364, '6242', '外卖送餐服务', '', 2724, 2725, 1362, 4);
INSERT INTO `industry` VALUES (1365, '629', '其他餐饮业', '', 2727, 2732, 1352, 3);
INSERT INTO `industry` VALUES (1366, '6291', '小吃服务', '', 2728, 2729, 1365, 4);
INSERT INTO `industry` VALUES (1367, '6299', '其他未列明餐饮业', '', 2730, 2731, 1365, 4);
INSERT INTO `industry` VALUES (1368, 'I', '信息传输、软件和信息技术服务业', '', 2735, 2844, 0, 1);
INSERT INTO `industry` VALUES (1369, '63', '电信、广播电视和卫星传输服务', '', 2736, 2757, 1368, 2);
INSERT INTO `industry` VALUES (1370, '631', '电信', '', 2737, 2744, 1369, 3);
INSERT INTO `industry` VALUES (1371, '6311', '固定电信服务', '', 2738, 2739, 1370, 4);
INSERT INTO `industry` VALUES (1372, '6312', '移动电信服务', '', 2740, 2741, 1370, 4);
INSERT INTO `industry` VALUES (1373, '6319', '其他电信服务', '', 2742, 2743, 1370, 4);
INSERT INTO `industry` VALUES (1374, '632', '广播电视传输服务', '', 2745, 2750, 1369, 3);
INSERT INTO `industry` VALUES (1375, '6321', '有线广播电视传输服务', '', 2746, 2747, 1374, 4);
INSERT INTO `industry` VALUES (1376, '6322', '无线广播电视传输服务', '', 2748, 2749, 1374, 4);
INSERT INTO `industry` VALUES (1377, '633', '卫星传输服务', '', 2751, 2756, 1369, 3);
INSERT INTO `industry` VALUES (1378, '6331', '广播电视卫星传输服务', '', 2752, 2753, 1377, 4);
INSERT INTO `industry` VALUES (1379, '6339', '其他卫星传输服务', '', 2754, 2755, 1377, 4);
INSERT INTO `industry` VALUES (1380, '64', '互联网和相关服务', '', 2758, 2795, 1368, 2);
INSERT INTO `industry` VALUES (1381, '641', '互联网接入及相关服务', '', 2759, 2762, 1380, 3);
INSERT INTO `industry` VALUES (1382, '6410', '互联网接入及相关服务', '', 2760, 2761, 1381, 4);
INSERT INTO `industry` VALUES (1383, '642', '互联网信息服务', '', 2763, 2770, 1380, 3);
INSERT INTO `industry` VALUES (1384, '6421', '互联网搜索服务', '', 2764, 2765, 1383, 4);
INSERT INTO `industry` VALUES (1385, '6422', '互联网游戏服务', '', 2766, 2767, 1383, 4);
INSERT INTO `industry` VALUES (1386, '6429', '互联网其他信息服务', '', 2768, 2769, 1383, 4);
INSERT INTO `industry` VALUES (1387, '643', '互联网平台', '', 2771, 2782, 1380, 3);
INSERT INTO `industry` VALUES (1388, '6431', '互联网生产服务平台', '', 2772, 2773, 1387, 4);
INSERT INTO `industry` VALUES (1389, '6432', '互联网生活服务平台', '', 2774, 2775, 1387, 4);
INSERT INTO `industry` VALUES (1390, '6433', '互联网科技创新平台', '', 2776, 2777, 1387, 4);
INSERT INTO `industry` VALUES (1391, '6434', '互联网公共服务平台', '', 2778, 2779, 1387, 4);
INSERT INTO `industry` VALUES (1392, '6439', '其他互联网平台', '', 2780, 2781, 1387, 4);
INSERT INTO `industry` VALUES (1393, '644', '互联网安全服务', '', 2783, 2786, 1380, 3);
INSERT INTO `industry` VALUES (1394, '6440', '互联网安全服务', '', 2784, 2785, 1393, 4);
INSERT INTO `industry` VALUES (1395, '645', '互联网数据服务', '', 2787, 2790, 1380, 3);
INSERT INTO `industry` VALUES (1396, '6450', '互联网数据服务', '', 2788, 2789, 1395, 4);
INSERT INTO `industry` VALUES (1397, '649', '其他互联网服务', '', 2791, 2794, 1380, 3);
INSERT INTO `industry` VALUES (1398, '6490', '其他互联网服务', '', 2792, 2793, 1397, 4);
INSERT INTO `industry` VALUES (1399, '65', '软件和信息技术服务业', '', 2796, 2843, 1368, 2);
INSERT INTO `industry` VALUES (1400, '651', '软件开发', '', 2797, 2806, 1399, 3);
INSERT INTO `industry` VALUES (1401, '6511', '基础软件开发', '', 2798, 2799, 1400, 4);
INSERT INTO `industry` VALUES (1402, '6512', '支撑软件开发', '', 2800, 2801, 1400, 4);
INSERT INTO `industry` VALUES (1403, '6513', '应用软件开发', '', 2802, 2803, 1400, 4);
INSERT INTO `industry` VALUES (1404, '6519', '其他软件开发', '', 2804, 2805, 1400, 4);
INSERT INTO `industry` VALUES (1405, '652', '集成电路设计', '', 2807, 2810, 1399, 3);
INSERT INTO `industry` VALUES (1406, '6520', '集成电路设计', '', 2808, 2809, 1405, 4);
INSERT INTO `industry` VALUES (1407, '653', '信息系统集成和物联网技术服务', '', 2811, 2816, 1399, 3);
INSERT INTO `industry` VALUES (1408, '6531', '信息系统集成服务', '', 2812, 2813, 1407, 4);
INSERT INTO `industry` VALUES (1409, '6532', '物联网技术服务', '', 2814, 2815, 1407, 4);
INSERT INTO `industry` VALUES (1410, '654', '运行维护服务', '', 2817, 2820, 1399, 3);
INSERT INTO `industry` VALUES (1411, '6540', '运行维护服务', '', 2818, 2819, 1410, 4);
INSERT INTO `industry` VALUES (1412, '655', '信息处理和存储支持服务', '', 2821, 2824, 1399, 3);
INSERT INTO `industry` VALUES (1413, '6550', '信息处理和存储支持服务', '', 2822, 2823, 1412, 4);
INSERT INTO `industry` VALUES (1414, '656', '信息技术咨询服务', '', 2825, 2828, 1399, 3);
INSERT INTO `industry` VALUES (1415, '6560', '信息技术咨询服务', '', 2826, 2827, 1414, 4);
INSERT INTO `industry` VALUES (1416, '657', '数字内容服务', '', 2829, 2836, 1399, 3);
INSERT INTO `industry` VALUES (1417, '6571', '地理遥感信息服务', '', 2830, 2831, 1416, 4);
INSERT INTO `industry` VALUES (1418, '6572', '动漫、游戏数字内容服务', '', 2832, 2833, 1416, 4);
INSERT INTO `industry` VALUES (1419, '6579', '其他数字内容服务', '', 2834, 2835, 1416, 4);
INSERT INTO `industry` VALUES (1420, '659', '其他信息技术服务业', '', 2837, 2842, 1399, 3);
INSERT INTO `industry` VALUES (1421, '6591', '呼叫中心', '', 2838, 2839, 1420, 4);
INSERT INTO `industry` VALUES (1422, '6599', '其他未列明信息技术服务业', '', 2840, 2841, 1420, 4);
INSERT INTO `industry` VALUES (1423, 'J', '金融业', '', 2845, 3002, 0, 1);
INSERT INTO `industry` VALUES (1424, '66', '货币金融服务', '', 2846, 2889, 1423, 2);
INSERT INTO `industry` VALUES (1425, '661', '中央银行服务', '', 2847, 2850, 1424, 3);
INSERT INTO `industry` VALUES (1426, '6610', '中央银行服务', '', 2848, 2849, 1425, 4);
INSERT INTO `industry` VALUES (1427, '662', '货币银行服务', '', 2851, 2862, 1424, 3);
INSERT INTO `industry` VALUES (1428, '6621', '商业银行服务', '', 2852, 2853, 1427, 4);
INSERT INTO `industry` VALUES (1429, '6622', '政策性银行服务', '', 2854, 2855, 1427, 4);
INSERT INTO `industry` VALUES (1430, '6623', '信用合作社服务', '', 2856, 2857, 1427, 4);
INSERT INTO `industry` VALUES (1431, '6624', '农村资金互助社服务', '', 2858, 2859, 1427, 4);
INSERT INTO `industry` VALUES (1432, '6629', '其他货币银行服务', '', 2860, 2861, 1427, 4);
INSERT INTO `industry` VALUES (1433, '663', '非货币银行服务', '', 2863, 2880, 1424, 3);
INSERT INTO `industry` VALUES (1434, '6631', '融资租赁服务', '', 2864, 2865, 1433, 4);
INSERT INTO `industry` VALUES (1435, '6632', '财务公司服务', '', 2866, 2867, 1433, 4);
INSERT INTO `industry` VALUES (1436, '6633', '典当', '', 2868, 2869, 1433, 4);
INSERT INTO `industry` VALUES (1437, '6634', '汽车金融公司服务', '', 2870, 2871, 1433, 4);
INSERT INTO `industry` VALUES (1438, '6635', '小额贷款公司服务', '', 2872, 2873, 1433, 4);
INSERT INTO `industry` VALUES (1439, '6636', '消费金融公司服务', '', 2874, 2875, 1433, 4);
INSERT INTO `industry` VALUES (1440, '6637', '网络借贷服务', '', 2876, 2877, 1433, 4);
INSERT INTO `industry` VALUES (1441, '6639', '其他非货币银行服务', '', 2878, 2879, 1433, 4);
INSERT INTO `industry` VALUES (1442, '664', '银行理财服务', '', 2881, 2884, 1424, 3);
INSERT INTO `industry` VALUES (1443, '6640', '银行理财服务', '', 2882, 2883, 1442, 4);
INSERT INTO `industry` VALUES (1444, '665', '银行监管服务', '', 2885, 2888, 1424, 3);
INSERT INTO `industry` VALUES (1445, '6650', '银行监管服务', '', 2886, 2887, 1444, 4);
INSERT INTO `industry` VALUES (1446, '67', '资本市场服务', '', 2890, 2927, 1423, 2);
INSERT INTO `industry` VALUES (1447, '671', '证券市场服务', '', 2891, 2896, 1446, 3);
INSERT INTO `industry` VALUES (1448, '6711', '证券市场管理服务', '', 2892, 2893, 1447, 4);
INSERT INTO `industry` VALUES (1449, '6712', '证券经纪交易服务', '', 2894, 2895, 1447, 4);
INSERT INTO `industry` VALUES (1450, '672', '公开募集证券投资基金', '', 2897, 2900, 1446, 3);
INSERT INTO `industry` VALUES (1451, '6720', '公开募集证券投资基金', '', 2898, 2899, 1450, 4);
INSERT INTO `industry` VALUES (1452, '673', '非公开募集证券投资基金', '', 2901, 2908, 1446, 3);
INSERT INTO `industry` VALUES (1453, '6731', '创业投资基金', '', 2902, 2903, 1452, 4);
INSERT INTO `industry` VALUES (1454, '6732', '天使投资', '', 2904, 2905, 1452, 4);
INSERT INTO `industry` VALUES (1455, '6739', '其他非公开募集证券投资基金', '', 2906, 2907, 1452, 4);
INSERT INTO `industry` VALUES (1456, '674', '期货市场服务', '', 2909, 2914, 1446, 3);
INSERT INTO `industry` VALUES (1457, '6741', '期货市场管理服务', '', 2910, 2911, 1456, 4);
INSERT INTO `industry` VALUES (1458, '6749', '其他期货市场服务', '', 2912, 2913, 1456, 4);
INSERT INTO `industry` VALUES (1459, '675', '证券期货监管服务', '', 2915, 2918, 1446, 3);
INSERT INTO `industry` VALUES (1460, '6750', '证券期货监管服务', '', 2916, 2917, 1459, 4);
INSERT INTO `industry` VALUES (1461, '676', '资本投资服务', '', 2919, 2922, 1446, 3);
INSERT INTO `industry` VALUES (1462, '6760', '资本投资服务', '', 2920, 2921, 1461, 4);
INSERT INTO `industry` VALUES (1463, '679', '其他资本市场服务', '', 2923, 2926, 1446, 3);
INSERT INTO `industry` VALUES (1464, '6790', '其他资本市场服务', '', 2924, 2925, 1463, 4);
INSERT INTO `industry` VALUES (1465, '68', '保险业', '', 2928, 2971, 1423, 2);
INSERT INTO `industry` VALUES (1466, '681', '人身保险', '', 2929, 2938, 1465, 3);
INSERT INTO `industry` VALUES (1467, '6811', '人寿保险', '', 2930, 2931, 1466, 4);
INSERT INTO `industry` VALUES (1468, '6812', '年金保险', '', 2932, 2933, 1466, 4);
INSERT INTO `industry` VALUES (1469, '6813', '健康保险', '', 2934, 2935, 1466, 4);
INSERT INTO `industry` VALUES (1470, '6814', '意外伤害保险', '', 2936, 2937, 1466, 4);
INSERT INTO `industry` VALUES (1471, '682', '财产保险', '', 2939, 2942, 1465, 3);
INSERT INTO `industry` VALUES (1472, '6820', '财产保险', '', 2940, 2941, 1471, 4);
INSERT INTO `industry` VALUES (1473, '683', '再保险', '', 2943, 2946, 1465, 3);
INSERT INTO `industry` VALUES (1474, '6830', '再保险', '', 2944, 2945, 1473, 4);
INSERT INTO `industry` VALUES (1475, '684', '商业养老金', '', 2947, 2950, 1465, 3);
INSERT INTO `industry` VALUES (1476, '6840', '商业养老金', '', 2948, 2949, 1475, 4);
INSERT INTO `industry` VALUES (1477, '685', '保险中介服务', '', 2951, 2958, 1465, 3);
INSERT INTO `industry` VALUES (1478, '6851', '保险经纪服务', '', 2952, 2953, 1477, 4);
INSERT INTO `industry` VALUES (1479, '6852', '保险代理服务', '', 2954, 2955, 1477, 4);
INSERT INTO `industry` VALUES (1480, '6853', '保险公估服务', '', 2956, 2957, 1477, 4);
INSERT INTO `industry` VALUES (1481, '686', '保险资产管理', '', 2959, 2962, 1465, 3);
INSERT INTO `industry` VALUES (1482, '6860', '保险资产管理', '', 2960, 2961, 1481, 4);
INSERT INTO `industry` VALUES (1483, '687', '保险监管服务', '', 2963, 2966, 1465, 3);
INSERT INTO `industry` VALUES (1484, '6870', '保险监管服务', '', 2964, 2965, 1483, 4);
INSERT INTO `industry` VALUES (1485, '689', '其他保险活动', '', 2967, 2970, 1465, 3);
INSERT INTO `industry` VALUES (1486, '6890', '其他保险活动', '', 2968, 2969, 1485, 4);
INSERT INTO `industry` VALUES (1487, '69', '其他金融业', '', 2972, 3001, 1423, 2);
INSERT INTO `industry` VALUES (1488, '691', '金融信托与管理服务', '', 2973, 2978, 1487, 3);
INSERT INTO `industry` VALUES (1489, '6911', '信托公司', '', 2974, 2975, 1488, 4);
INSERT INTO `industry` VALUES (1490, '6919', '其他金融信托与管理服务', '', 2976, 2977, 1488, 4);
INSERT INTO `industry` VALUES (1491, '692', '控股公司服务', '', 2979, 2982, 1487, 3);
INSERT INTO `industry` VALUES (1492, '6920', '控股公司服务', '', 2980, 2981, 1491, 4);
INSERT INTO `industry` VALUES (1493, '693', '非金融机构支付服务', '', 2983, 2986, 1487, 3);
INSERT INTO `industry` VALUES (1494, '6930', '非金融机构支付服务', '', 2984, 2985, 1493, 4);
INSERT INTO `industry` VALUES (1495, '694', '金融信息服务', '', 2987, 2990, 1487, 3);
INSERT INTO `industry` VALUES (1496, '6940', '金融信息服务', '', 2988, 2989, 1495, 4);
INSERT INTO `industry` VALUES (1497, '695', '金融资产管理公司', '', 2991, 2994, 1487, 3);
INSERT INTO `industry` VALUES (1498, '6950', '金融资产管理公司', '', 2992, 2993, 1497, 4);
INSERT INTO `industry` VALUES (1499, '699', '其他未列明金融业', '', 2995, 3000, 1487, 3);
INSERT INTO `industry` VALUES (1500, '6991', '货币经纪公司服务', '', 2996, 2997, 1499, 4);
INSERT INTO `industry` VALUES (1501, '6999', '其他未包括金融业', '', 2998, 2999, 1499, 4);
INSERT INTO `industry` VALUES (1502, 'K', '房地产业', '', 3003, 3026, 0, 1);
INSERT INTO `industry` VALUES (1503, '70', '房地产业', '', 3004, 3025, 1502, 2);
INSERT INTO `industry` VALUES (1504, '701', '房地产开发经营', '', 3005, 3008, 1503, 3);
INSERT INTO `industry` VALUES (1505, '7010', '房地产开发经营', '', 3006, 3007, 1504, 4);
INSERT INTO `industry` VALUES (1506, '702', '物业管理', '', 3009, 3012, 1503, 3);
INSERT INTO `industry` VALUES (1507, '7020', '物业管理', '', 3010, 3011, 1506, 4);
INSERT INTO `industry` VALUES (1508, '703', '房地产中介服务', '', 3013, 3016, 1503, 3);
INSERT INTO `industry` VALUES (1509, '7030', '房地产中介服务', '', 3014, 3015, 1508, 4);
INSERT INTO `industry` VALUES (1510, '704', '房地产租赁经营', '', 3017, 3020, 1503, 3);
INSERT INTO `industry` VALUES (1511, '7040', '房地产租赁经营', '', 3018, 3019, 1510, 4);
INSERT INTO `industry` VALUES (1512, '709', '其他房地产业', '', 3021, 3024, 1503, 3);
INSERT INTO `industry` VALUES (1513, '7090', '其他房地产业', '', 3022, 3023, 1512, 4);
INSERT INTO `industry` VALUES (1514, 'L', '租赁和商务服务业', '', 3027, 3172, 0, 1);
INSERT INTO `industry` VALUES (1515, '71', '租赁业', '', 3028, 3061, 1514, 2);
INSERT INTO `industry` VALUES (1516, '711', '机械设备经营租赁', '', 3029, 3042, 1515, 3);
INSERT INTO `industry` VALUES (1517, '7111', '汽车租赁', '', 3030, 3031, 1516, 4);
INSERT INTO `industry` VALUES (1518, '7112', '农业机械经营租赁', '', 3032, 3033, 1516, 4);
INSERT INTO `industry` VALUES (1519, '7113', '建筑工程机械与设备经营租赁', '', 3034, 3035, 1516, 4);
INSERT INTO `industry` VALUES (1520, '7114', '计算机及通讯设备经营租赁', '', 3036, 3037, 1516, 4);
INSERT INTO `industry` VALUES (1521, '7115', '医疗设备经营租赁', '', 3038, 3039, 1516, 4);
INSERT INTO `industry` VALUES (1522, '7119', '其他机械与设备经营租赁', '', 3040, 3041, 1516, 4);
INSERT INTO `industry` VALUES (1523, '712', '文体设备和用品出租', '', 3043, 3056, 1515, 3);
INSERT INTO `industry` VALUES (1524, '7121', '休闲娱乐用品设备出租', '', 3044, 3045, 1523, 4);
INSERT INTO `industry` VALUES (1525, '7122', '体育用品设备出租', '', 3046, 3047, 1523, 4);
INSERT INTO `industry` VALUES (1526, '7123', '文化用品设备出租', '', 3048, 3049, 1523, 4);
INSERT INTO `industry` VALUES (1527, '7124', '图书出租', '', 3050, 3051, 1523, 4);
INSERT INTO `industry` VALUES (1528, '7125', '音像制品出租', '', 3052, 3053, 1523, 4);
INSERT INTO `industry` VALUES (1529, '7129', '其他文体设备和用品出租', '', 3054, 3055, 1523, 4);
INSERT INTO `industry` VALUES (1530, '713', '日用品出租', '', 3057, 3060, 1515, 3);
INSERT INTO `industry` VALUES (1531, '7130', '日用品出租', '', 3058, 3059, 1530, 4);
INSERT INTO `industry` VALUES (1532, '72', '商务服务业', '', 3062, 3171, 1514, 2);
INSERT INTO `industry` VALUES (1533, '721', '组织管理服务', '', 3063, 3076, 1532, 3);
INSERT INTO `industry` VALUES (1534, '7211', '企业总部管理', '', 3064, 3065, 1533, 4);
INSERT INTO `industry` VALUES (1535, '7212', '投资与资产管理', '', 3066, 3067, 1533, 4);
INSERT INTO `industry` VALUES (1536, '7213', '资源与产权交易服务', '', 3068, 3069, 1533, 4);
INSERT INTO `industry` VALUES (1537, '7214', '单位后勤管理服务', '', 3070, 3071, 1533, 4);
INSERT INTO `industry` VALUES (1538, '7215', '农村集体经济组织管理', '', 3072, 3073, 1533, 4);
INSERT INTO `industry` VALUES (1539, '7219', '其他组织管理服务', '', 3074, 3075, 1533, 4);
INSERT INTO `industry` VALUES (1540, '722', '综合管理服务', '', 3077, 3088, 1532, 3);
INSERT INTO `industry` VALUES (1541, '7221', '园区管理服务', '', 3078, 3079, 1540, 4);
INSERT INTO `industry` VALUES (1542, '7222', '商业综合体管理服务', '', 3080, 3081, 1540, 4);
INSERT INTO `industry` VALUES (1543, '7223', '市场管理服务', '', 3082, 3083, 1540, 4);
INSERT INTO `industry` VALUES (1544, '7224', '供应链管理服务', '', 3084, 3085, 1540, 4);
INSERT INTO `industry` VALUES (1545, '7229', '其他综合管理服务', '', 3086, 3087, 1540, 4);
INSERT INTO `industry` VALUES (1546, '723', '法律服务', '', 3089, 3096, 1532, 3);
INSERT INTO `industry` VALUES (1547, '7231', '律师及相关法律服务', '', 3090, 3091, 1546, 4);
INSERT INTO `industry` VALUES (1548, '7232', '公证服务', '', 3092, 3093, 1546, 4);
INSERT INTO `industry` VALUES (1549, '7239', '其他法律服务', '', 3094, 3095, 1546, 4);
INSERT INTO `industry` VALUES (1550, '724', '咨询与调查', '', 3097, 3112, 1532, 3);
INSERT INTO `industry` VALUES (1551, '7241', '会计、审计及税务服务', '', 3098, 3099, 1550, 4);
INSERT INTO `industry` VALUES (1552, '7242', '市场调查', '', 3100, 3101, 1550, 4);
INSERT INTO `industry` VALUES (1553, '7243', '社会经济咨询', '', 3102, 3103, 1550, 4);
INSERT INTO `industry` VALUES (1554, '7244', '健康咨询', '', 3104, 3105, 1550, 4);
INSERT INTO `industry` VALUES (1555, '7245', '环保咨询', '', 3106, 3107, 1550, 4);
INSERT INTO `industry` VALUES (1556, '7246', '体育咨询', '', 3108, 3109, 1550, 4);
INSERT INTO `industry` VALUES (1557, '7249', '其他专业咨询与调查', '', 3110, 3111, 1550, 4);
INSERT INTO `industry` VALUES (1558, '725', '广告业', '', 3113, 3118, 1532, 3);
INSERT INTO `industry` VALUES (1559, '7251', '互联网广告服务', '', 3114, 3115, 1558, 4);
INSERT INTO `industry` VALUES (1560, '7259', '其他广告服务', '', 3116, 3117, 1558, 4);
INSERT INTO `industry` VALUES (1561, '726', '人力资源服务', '', 3119, 3130, 1532, 3);
INSERT INTO `industry` VALUES (1562, '7261', '公共就业服务', '', 3120, 3121, 1561, 4);
INSERT INTO `industry` VALUES (1563, '7262', '职业中介服务', '', 3122, 3123, 1561, 4);
INSERT INTO `industry` VALUES (1564, '7263', '劳务派遣服务', '', 3124, 3125, 1561, 4);
INSERT INTO `industry` VALUES (1565, '7264', '创业指导服务', '', 3126, 3127, 1561, 4);
INSERT INTO `industry` VALUES (1566, '7269', '其他人力资源服务', '', 3128, 3129, 1561, 4);
INSERT INTO `industry` VALUES (1567, '727', '安全保护服务', '', 3131, 3138, 1532, 3);
INSERT INTO `industry` VALUES (1568, '7271', '安全服务', '', 3132, 3133, 1567, 4);
INSERT INTO `industry` VALUES (1569, '7272', '安全系统监控服务', '', 3134, 3135, 1567, 4);
INSERT INTO `industry` VALUES (1570, '7279', '其他安全保护服务', '', 3136, 3137, 1567, 4);
INSERT INTO `industry` VALUES (1571, '728', '会议、展览及相关服务', '', 3139, 3150, 1532, 3);
INSERT INTO `industry` VALUES (1572, '7281', '科技会展服务', '', 3140, 3141, 1571, 4);
INSERT INTO `industry` VALUES (1573, '7282', '旅游会展服务', '', 3142, 3143, 1571, 4);
INSERT INTO `industry` VALUES (1574, '7283', '体育会展服务', '', 3144, 3145, 1571, 4);
INSERT INTO `industry` VALUES (1575, '7284', '文化会展服务', '', 3146, 3147, 1571, 4);
INSERT INTO `industry` VALUES (1576, '7289', '其他会议、会展及相关服务', '', 3148, 3149, 1571, 4);
INSERT INTO `industry` VALUES (1577, '729', '其他商务服务业', '', 3151, 3170, 1532, 3);
INSERT INTO `industry` VALUES (1578, '7291', '旅行社及相关服务', '', 3152, 3153, 1577, 4);
INSERT INTO `industry` VALUES (1579, '7292', '包装服务', '', 3154, 3155, 1577, 4);
INSERT INTO `industry` VALUES (1580, '7293', '办公服务', '', 3156, 3157, 1577, 4);
INSERT INTO `industry` VALUES (1581, '7294', '翻译服务', '', 3158, 3159, 1577, 4);
INSERT INTO `industry` VALUES (1582, '7295', '信用服务', '', 3160, 3161, 1577, 4);
INSERT INTO `industry` VALUES (1583, '7296', '非融资担保服务', '', 3162, 3163, 1577, 4);
INSERT INTO `industry` VALUES (1584, '7297', '商务代理代办服务', '', 3164, 3165, 1577, 4);
INSERT INTO `industry` VALUES (1585, '7298', '票务代理服务', '', 3166, 3167, 1577, 4);
INSERT INTO `industry` VALUES (1586, '7299', '其他未列明商务服务业', '', 3168, 3169, 1577, 4);
INSERT INTO `industry` VALUES (1587, 'M', '科学研究和技术服务业', '', 3173, 3314, 0, 1);
INSERT INTO `industry` VALUES (1588, '73', '研究和试验发展', '', 3174, 3195, 1587, 2);
INSERT INTO `industry` VALUES (1589, '731', '自然科学研究和试验发展', '', 3175, 3178, 1588, 3);
INSERT INTO `industry` VALUES (1590, '7310', '自然科学研究和试验发展', '', 3176, 3177, 1589, 4);
INSERT INTO `industry` VALUES (1591, '732', '工程和技术研究和试验发展', '', 3179, 3182, 1588, 3);
INSERT INTO `industry` VALUES (1592, '7320', '工程和技术研究和试验发展', '', 3180, 3181, 1591, 4);
INSERT INTO `industry` VALUES (1593, '733', '农业科学研究和试验发展', '', 3183, 3186, 1588, 3);
INSERT INTO `industry` VALUES (1594, '7330', '农业科学研究和试验发展', '', 3184, 3185, 1593, 4);
INSERT INTO `industry` VALUES (1595, '734', '医学研究和试验发展', '', 3187, 3190, 1588, 3);
INSERT INTO `industry` VALUES (1596, '7340', '医学研究和试验发展', '', 3188, 3189, 1595, 4);
INSERT INTO `industry` VALUES (1597, '735', '社会人文科学研究', '', 3191, 3194, 1588, 3);
INSERT INTO `industry` VALUES (1598, '7350', '社会人文科学研究', '', 3192, 3193, 1597, 4);
INSERT INTO `industry` VALUES (1599, '74', '专业技术服务业', '', 3196, 3277, 1587, 2);
INSERT INTO `industry` VALUES (1600, '741', '气象服务', '', 3197, 3200, 1599, 3);
INSERT INTO `industry` VALUES (1601, '7410', '气象服务', '', 3198, 3199, 1600, 4);
INSERT INTO `industry` VALUES (1602, '742', '地震服务', '', 3201, 3204, 1599, 3);
INSERT INTO `industry` VALUES (1603, '7420', '地震服务', '', 3202, 3203, 1602, 4);
INSERT INTO `industry` VALUES (1604, '743', '海洋服务', '', 3205, 3212, 1599, 3);
INSERT INTO `industry` VALUES (1605, '7431', '海洋气象服务', '', 3206, 3207, 1604, 4);
INSERT INTO `industry` VALUES (1606, '7432', '海洋环境服务', '', 3208, 3209, 1604, 4);
INSERT INTO `industry` VALUES (1607, '7439', '其他海洋服务', '', 3210, 3211, 1604, 4);
INSERT INTO `industry` VALUES (1608, '744', '测绘地理信息服务', '', 3213, 3218, 1599, 3);
INSERT INTO `industry` VALUES (1609, '7441', '遥感测绘服务', '', 3214, 3215, 1608, 4);
INSERT INTO `industry` VALUES (1610, '7449', '其他测绘地理信息服务', '', 3216, 3217, 1608, 4);
INSERT INTO `industry` VALUES (1611, '745', '质检技术服务', '', 3219, 3232, 1599, 3);
INSERT INTO `industry` VALUES (1612, '7451', '检验检疫服务', '', 3220, 3221, 1611, 4);
INSERT INTO `industry` VALUES (1613, '7452', '检测服务', '', 3222, 3223, 1611, 4);
INSERT INTO `industry` VALUES (1614, '7453', '计量服务', '', 3224, 3225, 1611, 4);
INSERT INTO `industry` VALUES (1615, '7454', '标准化服务', '', 3226, 3227, 1611, 4);
INSERT INTO `industry` VALUES (1616, '7455', '认证认可服务', '', 3228, 3229, 1611, 4);
INSERT INTO `industry` VALUES (1617, '7459', '其他质检技术服务', '', 3230, 3231, 1611, 4);
INSERT INTO `industry` VALUES (1618, '746', '环境与生态监测检测服务', '', 3233, 3240, 1599, 3);
INSERT INTO `industry` VALUES (1619, '7461', '环境保护监测', '', 3234, 3235, 1618, 4);
INSERT INTO `industry` VALUES (1620, '7462', '生态资源监测', '', 3236, 3237, 1618, 4);
INSERT INTO `industry` VALUES (1621, '7463', '野生动物疫源疫病防控监测', '', 3238, 3239, 1618, 4);
INSERT INTO `industry` VALUES (1622, '747', '地质勘查', '', 3241, 3252, 1599, 3);
INSERT INTO `industry` VALUES (1623, '7471', '能源矿产地质勘查', '', 3242, 3243, 1622, 4);
INSERT INTO `industry` VALUES (1624, '7472', '固体矿产地质勘查', '', 3244, 3245, 1622, 4);
INSERT INTO `industry` VALUES (1625, '7473', '水、二氧化碳等矿产地质勘查', '', 3246, 3247, 1622, 4);
INSERT INTO `industry` VALUES (1626, '7474', '基础地质勘查', '', 3248, 3249, 1622, 4);
INSERT INTO `industry` VALUES (1627, '7475', '地质勘查技术服务', '', 3250, 3251, 1622, 4);
INSERT INTO `industry` VALUES (1628, '748', '工程技术与设计服务', '', 3253, 3266, 1599, 3);
INSERT INTO `industry` VALUES (1629, '7481', '工程管理服务', '', 3254, 3255, 1628, 4);
INSERT INTO `industry` VALUES (1630, '7482', '工程监理服务', '', 3256, 3257, 1628, 4);
INSERT INTO `industry` VALUES (1631, '7483', '工程勘察活动', '', 3258, 3259, 1628, 4);
INSERT INTO `industry` VALUES (1632, '7484', '工程设计活动', '', 3260, 3261, 1628, 4);
INSERT INTO `industry` VALUES (1633, '7485', '规划设计管理', '', 3262, 3263, 1628, 4);
INSERT INTO `industry` VALUES (1634, '7486', '土地规划服务', '', 3264, 3265, 1628, 4);
INSERT INTO `industry` VALUES (1635, '749', '工业与专业设计及其他专业技术服务', '', 3267, 3276, 1599, 3);
INSERT INTO `industry` VALUES (1636, '7491', '工业设计服务', '', 3268, 3269, 1635, 4);
INSERT INTO `industry` VALUES (1637, '7492', '专业设计服务', '', 3270, 3271, 1635, 4);
INSERT INTO `industry` VALUES (1638, '7493', '兽医服务', '', 3272, 3273, 1635, 4);
INSERT INTO `industry` VALUES (1639, '7499', '其他未列明专业技术服务业', '', 3274, 3275, 1635, 4);
INSERT INTO `industry` VALUES (1640, '75', '科技推广和应用服务业', '', 3278, 3313, 1587, 2);
INSERT INTO `industry` VALUES (1641, '751', '技术推广服务', '', 3279, 3296, 1640, 3);
INSERT INTO `industry` VALUES (1642, '7511', '农林牧渔技术推广服务', '', 3280, 3281, 1641, 4);
INSERT INTO `industry` VALUES (1643, '7512', '生物技术推广服务', '', 3282, 3283, 1641, 4);
INSERT INTO `industry` VALUES (1644, '7513', '新材料技术推广服务', '', 3284, 3285, 1641, 4);
INSERT INTO `industry` VALUES (1645, '7514', '节能技术推广服务', '', 3286, 3287, 1641, 4);
INSERT INTO `industry` VALUES (1646, '7515', '新能源技术推广服务', '', 3288, 3289, 1641, 4);
INSERT INTO `industry` VALUES (1647, '7516', '环保技术推广服务', '', 3290, 3291, 1641, 4);
INSERT INTO `industry` VALUES (1648, '7517', '三维（3D)打印技术推广服务', '', 3292, 3293, 1641, 4);
INSERT INTO `industry` VALUES (1649, '7519', '其他技术推广服务', '', 3294, 3295, 1641, 4);
INSERT INTO `industry` VALUES (1650, '752', '知识产权服务', '', 3297, 3300, 1640, 3);
INSERT INTO `industry` VALUES (1651, '7520', '知识产权服务', '', 3298, 3299, 1650, 4);
INSERT INTO `industry` VALUES (1652, '753', '科技中介服务', '', 3301, 3304, 1640, 3);
INSERT INTO `industry` VALUES (1653, '7530', '科技中介服务', '', 3302, 3303, 1652, 4);
INSERT INTO `industry` VALUES (1654, '754', '创业空间服务', '', 3305, 3308, 1640, 3);
INSERT INTO `industry` VALUES (1655, '7540', '创业空间服务', '', 3306, 3307, 1654, 4);
INSERT INTO `industry` VALUES (1656, '759', '其他科技推广服务业', '', 3309, 3312, 1640, 3);
INSERT INTO `industry` VALUES (1657, '7590', '其他科技推广服务业', '', 3310, 3311, 1656, 4);
INSERT INTO `industry` VALUES (1658, 'N', '水利、环境和公共设施管理业', '', 3315, 3426, 0, 1);
INSERT INTO `industry` VALUES (1659, '76', '水利管理业', '', 3316, 3337, 1658, 2);
INSERT INTO `industry` VALUES (1660, '761', '防洪除涝设施管理', '', 3317, 3320, 1659, 3);
INSERT INTO `industry` VALUES (1661, '7610', '防洪除涝设施管理', '', 3318, 3319, 1660, 4);
INSERT INTO `industry` VALUES (1662, '762', '水资源管理', '', 3321, 3324, 1659, 3);
INSERT INTO `industry` VALUES (1663, '7620', '水资源管理', '', 3322, 3323, 1662, 4);
INSERT INTO `industry` VALUES (1664, '763', '天然水收集与分配', '', 3325, 3328, 1659, 3);
INSERT INTO `industry` VALUES (1665, '7630', '天然水收集与分配', '', 3326, 3327, 1664, 4);
INSERT INTO `industry` VALUES (1666, '764', '水文服务', '', 3329, 3332, 1659, 3);
INSERT INTO `industry` VALUES (1667, '7640', '水文服务', '', 3330, 3331, 1666, 4);
INSERT INTO `industry` VALUES (1668, '769', '其他水利管理业', '', 3333, 3336, 1659, 3);
INSERT INTO `industry` VALUES (1669, '7690', '其他水利管理业', '', 3334, 3335, 1668, 4);
INSERT INTO `industry` VALUES (1670, '77', '生态保护和环境治理业', '', 3338, 3373, 1658, 2);
INSERT INTO `industry` VALUES (1671, '771', '生态保护', '', 3339, 3354, 1670, 3);
INSERT INTO `industry` VALUES (1672, '7711', '自然生态系统保护管理', '', 3340, 3341, 1671, 4);
INSERT INTO `industry` VALUES (1673, '7712', '自然遗迹保护管理', '', 3342, 3343, 1671, 4);
INSERT INTO `industry` VALUES (1674, '7713', '野生动物保护', '', 3344, 3345, 1671, 4);
INSERT INTO `industry` VALUES (1675, '7714', '野生植物保护', '', 3346, 3347, 1671, 4);
INSERT INTO `industry` VALUES (1676, '7715', '动物园、水族馆管理服务', '', 3348, 3349, 1671, 4);
INSERT INTO `industry` VALUES (1677, '7716', '植物园管理服务', '', 3350, 3351, 1671, 4);
INSERT INTO `industry` VALUES (1678, '7719', '其他自然保护', '', 3352, 3353, 1671, 4);
INSERT INTO `industry` VALUES (1679, '772', '环境治理业', '', 3355, 3372, 1670, 3);
INSERT INTO `industry` VALUES (1680, '7721', '水污染治理', '', 3356, 3357, 1679, 4);
INSERT INTO `industry` VALUES (1681, '7722', '大气污染治理', '', 3358, 3359, 1679, 4);
INSERT INTO `industry` VALUES (1682, '7723', '固体废物治理', '', 3360, 3361, 1679, 4);
INSERT INTO `industry` VALUES (1683, '7724', '危险废物治理', '', 3362, 3363, 1679, 4);
INSERT INTO `industry` VALUES (1684, '7725', '放射性废物治理', '', 3364, 3365, 1679, 4);
INSERT INTO `industry` VALUES (1685, '7726', '土壤污染治理与修复服务', '', 3366, 3367, 1679, 4);
INSERT INTO `industry` VALUES (1686, '7727', '噪声与振动控制服务', '', 3368, 3369, 1679, 4);
INSERT INTO `industry` VALUES (1687, '7729', '其他污染治理', '', 3370, 3371, 1679, 4);
INSERT INTO `industry` VALUES (1688, '78', '公共设施管理业', '', 3374, 3403, 1658, 2);
INSERT INTO `industry` VALUES (1689, '781', '市政设施管理', '', 3375, 3378, 1688, 3);
INSERT INTO `industry` VALUES (1690, '7810', '市政设施管理', '', 3376, 3377, 1689, 4);
INSERT INTO `industry` VALUES (1691, '782', '环境卫生管理', '', 3379, 3382, 1688, 3);
INSERT INTO `industry` VALUES (1692, '7820', '环境卫生管理', '', 3380, 3381, 1691, 4);
INSERT INTO `industry` VALUES (1693, '783', '城乡市容管理', '', 3383, 3386, 1688, 3);
INSERT INTO `industry` VALUES (1694, '7830', '城乡市容管理', '', 3384, 3385, 1693, 4);
INSERT INTO `industry` VALUES (1695, '784', '绿化管理', '', 3387, 3390, 1688, 3);
INSERT INTO `industry` VALUES (1696, '7840', '绿化管理', '', 3388, 3389, 1695, 4);
INSERT INTO `industry` VALUES (1697, '785', '城市公园管理', '', 3391, 3394, 1688, 3);
INSERT INTO `industry` VALUES (1698, '7850', '城市公园管理', '', 3392, 3393, 1697, 4);
INSERT INTO `industry` VALUES (1699, '786', '游览景区管理', '', 3395, 3402, 1688, 3);
INSERT INTO `industry` VALUES (1700, '7861', '名胜风景区管理', '', 3396, 3397, 1699, 4);
INSERT INTO `industry` VALUES (1701, '7862', '森林公园管理', '', 3398, 3399, 1699, 4);
INSERT INTO `industry` VALUES (1702, '7869', '其他游览景区管理', '', 3400, 3401, 1699, 4);
INSERT INTO `industry` VALUES (1703, '79', '土地管理业', '', 3404, 3425, 1658, 2);
INSERT INTO `industry` VALUES (1704, '791', '土地整治服务', '', 3405, 3408, 1703, 3);
INSERT INTO `industry` VALUES (1705, '7910', '土地整治服务', '', 3406, 3407, 1704, 4);
INSERT INTO `industry` VALUES (1706, '792', '土地调查评估服务', '', 3409, 3412, 1703, 3);
INSERT INTO `industry` VALUES (1707, '7920', '土地调查评估服务', '', 3410, 3411, 1706, 4);
INSERT INTO `industry` VALUES (1708, '793', '土地登记服务', '', 3413, 3416, 1703, 3);
INSERT INTO `industry` VALUES (1709, '7930', '土地登记服务', '', 3414, 3415, 1708, 4);
INSERT INTO `industry` VALUES (1710, '794', '土地登记代理服务', '', 3417, 3420, 1703, 3);
INSERT INTO `industry` VALUES (1711, '7940', '土地登记代理服务', '', 3418, 3419, 1710, 4);
INSERT INTO `industry` VALUES (1712, '799', '其他土地管理服务', '', 3421, 3424, 1703, 3);
INSERT INTO `industry` VALUES (1713, '7990', '其他土地管理服务', '', 3422, 3423, 1712, 4);
INSERT INTO `industry` VALUES (1714, 'O', '居民服务、修理和其他服务业', '', 3427, 3530, 0, 1);
INSERT INTO `industry` VALUES (1715, '80', '居民服务业', '', 3428, 3469, 1714, 2);
INSERT INTO `industry` VALUES (1716, '801', '家庭服务', '', 3429, 3432, 1715, 3);
INSERT INTO `industry` VALUES (1717, '8010', '家庭服务', '', 3430, 3431, 1716, 4);
INSERT INTO `industry` VALUES (1718, '802', '托儿所服务', '', 3433, 3436, 1715, 3);
INSERT INTO `industry` VALUES (1719, '8020', '托儿所服务', '', 3434, 3435, 1718, 4);
INSERT INTO `industry` VALUES (1720, '803', '洗染服务', '', 3437, 3440, 1715, 3);
INSERT INTO `industry` VALUES (1721, '8030', '洗染服务', '', 3438, 3439, 1720, 4);
INSERT INTO `industry` VALUES (1722, '804', '理发及美容服务', '', 3441, 3444, 1715, 3);
INSERT INTO `industry` VALUES (1723, '8040', '理发及美容服务', '', 3442, 3443, 1722, 4);
INSERT INTO `industry` VALUES (1724, '805', '洗浴和保健养生服务', '', 3445, 3452, 1715, 3);
INSERT INTO `industry` VALUES (1725, '8051', '洗浴服务', '', 3446, 3447, 1724, 4);
INSERT INTO `industry` VALUES (1726, '8052', '足浴服务', '', 3448, 3449, 1724, 4);
INSERT INTO `industry` VALUES (1727, '8053', '养生保健服务', '', 3450, 3451, 1724, 4);
INSERT INTO `industry` VALUES (1728, '806', '摄影扩印服务', '', 3453, 3456, 1715, 3);
INSERT INTO `industry` VALUES (1729, '8060', '摄影扩印服务', '', 3454, 3455, 1728, 4);
INSERT INTO `industry` VALUES (1730, '807', '婚姻服务', '', 3457, 3460, 1715, 3);
INSERT INTO `industry` VALUES (1731, '8070', '婚姻服务', '', 3458, 3459, 1730, 4);
INSERT INTO `industry` VALUES (1732, '808', '殡葬服务', '', 3461, 3464, 1715, 3);
INSERT INTO `industry` VALUES (1733, '8080', '殡葬服务', '', 3462, 3463, 1732, 4);
INSERT INTO `industry` VALUES (1734, '809', '其他居民服务业', '', 3465, 3468, 1715, 3);
INSERT INTO `industry` VALUES (1735, '8090', '其他居民服务业', '', 3466, 3467, 1734, 4);
INSERT INTO `industry` VALUES (1736, '81', '机动车、电子产品和日用产品修理业', '', 3470, 3505, 1714, 2);
INSERT INTO `industry` VALUES (1737, '811', '汽车、摩托车等修理与维护', '', 3471, 3480, 1736, 3);
INSERT INTO `industry` VALUES (1738, '8111', '汽车修理与维护', '', 3472, 3473, 1737, 4);
INSERT INTO `industry` VALUES (1739, '8112', '大型车辆装备修理与维护', '', 3474, 3475, 1737, 4);
INSERT INTO `industry` VALUES (1740, '8113', '摩托车修理与维护', '', 3476, 3477, 1737, 4);
INSERT INTO `industry` VALUES (1741, '8114', '助动车等修理与维护', '', 3478, 3479, 1737, 4);
INSERT INTO `industry` VALUES (1742, '812', '计算机和办公设备维修', '', 3481, 3488, 1736, 3);
INSERT INTO `industry` VALUES (1743, '8121', '计算机和辅助设备修理', '', 3482, 3483, 1742, 4);
INSERT INTO `industry` VALUES (1744, '8122', '通讯设备修理', '', 3484, 3485, 1742, 4);
INSERT INTO `industry` VALUES (1745, '8129', '其他办公设备维修', '', 3486, 3487, 1742, 4);
INSERT INTO `industry` VALUES (1746, '813', '家用电器修理', '', 3489, 3494, 1736, 3);
INSERT INTO `industry` VALUES (1747, '8131', '家用电子产品修理', '', 3490, 3491, 1746, 4);
INSERT INTO `industry` VALUES (1748, '8132', '日用电器修理', '', 3492, 3493, 1746, 4);
INSERT INTO `industry` VALUES (1749, '819', '其他日用产品修理业', '', 3495, 3504, 1736, 3);
INSERT INTO `industry` VALUES (1750, '8191', '自行车修理', '', 3496, 3497, 1749, 4);
INSERT INTO `industry` VALUES (1751, '8192', '鞋和皮革修理', '', 3498, 3499, 1749, 4);
INSERT INTO `industry` VALUES (1752, '8193', '家具和相关物品修理', '', 3500, 3501, 1749, 4);
INSERT INTO `industry` VALUES (1753, '8199', '其他未列明日用产品修理业', '', 3502, 3503, 1749, 4);
INSERT INTO `industry` VALUES (1754, '82', '其他服务业', '', 3506, 3529, 1714, 2);
INSERT INTO `industry` VALUES (1755, '821', '清洁服务', '', 3507, 3512, 1754, 3);
INSERT INTO `industry` VALUES (1756, '8211', '建筑物清洁服务', '', 3508, 3509, 1755, 4);
INSERT INTO `industry` VALUES (1757, '8219', '其他清洁服务', '', 3510, 3511, 1755, 4);
INSERT INTO `industry` VALUES (1758, '822', '宠物服务', '', 3513, 3524, 1754, 3);
INSERT INTO `industry` VALUES (1759, '8221', '宠物饲养', '', 3514, 3515, 1758, 4);
INSERT INTO `industry` VALUES (1760, '8222', '宠物医院服务', '', 3516, 3517, 1758, 4);
INSERT INTO `industry` VALUES (1761, '8223', '宠物美容服务', '', 3518, 3519, 1758, 4);
INSERT INTO `industry` VALUES (1762, '8224', '宠物寄托收养服务', '', 3520, 3521, 1758, 4);
INSERT INTO `industry` VALUES (1763, '8229', '其他宠物服务', '', 3522, 3523, 1758, 4);
INSERT INTO `industry` VALUES (1764, '829', '其他未列明服务业', '', 3525, 3528, 1754, 3);
INSERT INTO `industry` VALUES (1765, '8290', '其他未列明服务业', '', 3526, 3527, 1764, 4);
INSERT INTO `industry` VALUES (1766, 'P', '教育', '', 3531, 3580, 0, 1);
INSERT INTO `industry` VALUES (1767, '83', '教育', '', 3532, 3579, 1766, 2);
INSERT INTO `industry` VALUES (1768, '831', '学前教育', '', 3533, 3536, 1767, 3);
INSERT INTO `industry` VALUES (1769, '8310', '学前教育', '', 3534, 3535, 1768, 4);
INSERT INTO `industry` VALUES (1770, '832', '初等教育', '', 3537, 3542, 1767, 3);
INSERT INTO `industry` VALUES (1771, '8321', '普通小学教育', '', 3538, 3539, 1770, 4);
INSERT INTO `industry` VALUES (1772, '8322', '成人小学教育', '', 3540, 3541, 1770, 4);
INSERT INTO `industry` VALUES (1773, '833', '中等教育', '', 3543, 3556, 1767, 3);
INSERT INTO `industry` VALUES (1774, '8331', '普通初中教育', '', 3544, 3545, 1773, 4);
INSERT INTO `industry` VALUES (1775, '8332', '职业初中教育', '', 3546, 3547, 1773, 4);
INSERT INTO `industry` VALUES (1776, '8333', '成人初中教育', '', 3548, 3549, 1773, 4);
INSERT INTO `industry` VALUES (1777, '8334', '普通高中教育', '', 3550, 3551, 1773, 4);
INSERT INTO `industry` VALUES (1778, '8335', '成人高中教育', '', 3552, 3553, 1773, 4);
INSERT INTO `industry` VALUES (1779, '8336', '中等职业学校教育', '', 3554, 3555, 1773, 4);
INSERT INTO `industry` VALUES (1780, '834', '高等教育', '', 3557, 3562, 1767, 3);
INSERT INTO `industry` VALUES (1781, '8341', '普通高等教育', '', 3558, 3559, 1780, 4);
INSERT INTO `industry` VALUES (1782, '8342', '成人高等教育', '', 3560, 3561, 1780, 4);
INSERT INTO `industry` VALUES (1783, '835', '特殊教育', '', 3563, 3566, 1767, 3);
INSERT INTO `industry` VALUES (1784, '8350', '特殊教育', '', 3564, 3565, 1783, 4);
INSERT INTO `industry` VALUES (1785, '839', '技能培训、教育辅助及其他教育', '', 3567, 3578, 1767, 3);
INSERT INTO `industry` VALUES (1786, '8391', '职业技能培训', '', 3568, 3569, 1785, 4);
INSERT INTO `industry` VALUES (1787, '8392', '体校及体育培训', '', 3570, 3571, 1785, 4);
INSERT INTO `industry` VALUES (1788, '8393', '文化艺术培训', '', 3572, 3573, 1785, 4);
INSERT INTO `industry` VALUES (1789, '8394', '教育辅助服务', '', 3574, 3575, 1785, 4);
INSERT INTO `industry` VALUES (1790, '8399', '其他未列明教育', '', 3576, 3577, 1785, 4);
INSERT INTO `industry` VALUES (1791, 'Q', '卫生和社会工作', '', 3581, 3658, 0, 1);
INSERT INTO `industry` VALUES (1792, '84', '卫生', '', 3582, 3631, 1791, 2);
INSERT INTO `industry` VALUES (1793, '841', '医院', '', 3583, 3596, 1792, 3);
INSERT INTO `industry` VALUES (1794, '8411', '综合医院', '', 3584, 3585, 1793, 4);
INSERT INTO `industry` VALUES (1795, '8412', '中医医院', '', 3586, 3587, 1793, 4);
INSERT INTO `industry` VALUES (1796, '8413', '中西医结合医院', '', 3588, 3589, 1793, 4);
INSERT INTO `industry` VALUES (1797, '8414', '民族医院', '', 3590, 3591, 1793, 4);
INSERT INTO `industry` VALUES (1798, '8415', '专科医院', '', 3592, 3593, 1793, 4);
INSERT INTO `industry` VALUES (1799, '8416', '疗养院', '', 3594, 3595, 1793, 4);
INSERT INTO `industry` VALUES (1800, '842', '基层医疗卫生服务', '', 3597, 3608, 1792, 3);
INSERT INTO `industry` VALUES (1801, '8421', '社区卫生服务中心（站）', '', 3598, 3599, 1800, 4);
INSERT INTO `industry` VALUES (1802, '8422', '街道卫生院', '', 3600, 3601, 1800, 4);
INSERT INTO `industry` VALUES (1803, '8423', '乡镇卫生院', '', 3602, 3603, 1800, 4);
INSERT INTO `industry` VALUES (1804, '8424', '村卫生室', '', 3604, 3605, 1800, 4);
INSERT INTO `industry` VALUES (1805, '8425', '门诊部（所）', '', 3606, 3607, 1800, 4);
INSERT INTO `industry` VALUES (1806, '843', '专业公共卫生服务', '', 3609, 3622, 1792, 3);
INSERT INTO `industry` VALUES (1807, '8431', '疾病预防控制中心', '', 3610, 3611, 1806, 4);
INSERT INTO `industry` VALUES (1808, '8432', '专科疾病防治院（所、站）', '', 3612, 3613, 1806, 4);
INSERT INTO `industry` VALUES (1809, '8433', '妇幼保健院（所、站）', '', 3614, 3615, 1806, 4);
INSERT INTO `industry` VALUES (1810, '8434', '急救中心（站）服务', '', 3616, 3617, 1806, 4);
INSERT INTO `industry` VALUES (1811, '8435', '采供血机构服务', '', 3618, 3619, 1806, 4);
INSERT INTO `industry` VALUES (1812, '8436', '计划生育技术服务活动', '', 3620, 3621, 1806, 4);
INSERT INTO `industry` VALUES (1813, '849', '其他卫生活动', '', 3623, 3630, 1792, 3);
INSERT INTO `industry` VALUES (1814, '8491', '健康体检服务', '', 3624, 3625, 1813, 4);
INSERT INTO `industry` VALUES (1815, '8492', '临床检验服务', '', 3626, 3627, 1813, 4);
INSERT INTO `industry` VALUES (1816, '8499', '其他未列明卫生服务', '', 3628, 3629, 1813, 4);
INSERT INTO `industry` VALUES (1817, '85', '社会工作', '', 3632, 3657, 1791, 2);
INSERT INTO `industry` VALUES (1818, '851', '提供住宿社会工作', '', 3633, 3648, 1817, 3);
INSERT INTO `industry` VALUES (1819, '8511', '干部休养所', '', 3634, 3635, 1818, 4);
INSERT INTO `industry` VALUES (1820, '8512', '护理机构服务', '', 3636, 3637, 1818, 4);
INSERT INTO `industry` VALUES (1821, '8513', '精神康复服务', '', 3638, 3639, 1818, 4);
INSERT INTO `industry` VALUES (1822, '8514', '老年人、残疾人养护服务', '', 3640, 3641, 1818, 4);
INSERT INTO `industry` VALUES (1823, '8515', '临终关怀服务', '', 3642, 3643, 1818, 4);
INSERT INTO `industry` VALUES (1824, '8516', '孤残儿童收养和庇护服务', '', 3644, 3645, 1818, 4);
INSERT INTO `industry` VALUES (1825, '8519', '其他提供住宿社会救助', '', 3646, 3647, 1818, 4);
INSERT INTO `industry` VALUES (1826, '852', '不提供住宿社会工作', '', 3649, 3656, 1817, 3);
INSERT INTO `industry` VALUES (1827, '8521', '社会看护与帮助服务', '', 3650, 3651, 1826, 4);
INSERT INTO `industry` VALUES (1828, '8522', '康复辅具适配服务', '', 3652, 3653, 1826, 4);
INSERT INTO `industry` VALUES (1829, '8529', '其他不提供住宿社会工作', '', 3654, 3655, 1826, 4);
INSERT INTO `industry` VALUES (1830, 'R', '文化、体育和娱乐业', '', 3659, 3820, 0, 1);
INSERT INTO `industry` VALUES (1831, '86', '新闻和出版业', '', 3660, 3681, 1830, 2);
INSERT INTO `industry` VALUES (1832, '861', '新闻业', '', 3661, 3664, 1831, 3);
INSERT INTO `industry` VALUES (1833, '8610', '新闻业', '', 3662, 3663, 1832, 4);
INSERT INTO `industry` VALUES (1834, '862', '出版业', '', 3665, 3680, 1831, 3);
INSERT INTO `industry` VALUES (1835, '8621', '图书出版', '', 3666, 3667, 1834, 4);
INSERT INTO `industry` VALUES (1836, '8622', '报纸出版', '', 3668, 3669, 1834, 4);
INSERT INTO `industry` VALUES (1837, '8623', '期刊出版', '', 3670, 3671, 1834, 4);
INSERT INTO `industry` VALUES (1838, '8624', '音像制品出版', '', 3672, 3673, 1834, 4);
INSERT INTO `industry` VALUES (1839, '8625', '电子出版物出版', '', 3674, 3675, 1834, 4);
INSERT INTO `industry` VALUES (1840, '8626', '数字出版', '', 3676, 3677, 1834, 4);
INSERT INTO `industry` VALUES (1841, '8629', '其他出版业', '', 3678, 3679, 1834, 4);
INSERT INTO `industry` VALUES (1842, '87', '广播、电视、电影和录音制作业', '', 3682, 3711, 1830, 2);
INSERT INTO `industry` VALUES (1843, '871', '广播', '', 3683, 3686, 1842, 3);
INSERT INTO `industry` VALUES (1844, '8710', '广播', '', 3684, 3685, 1843, 4);
INSERT INTO `industry` VALUES (1845, '872', '电视', '', 3687, 3690, 1842, 3);
INSERT INTO `industry` VALUES (1846, '8720', '电视', '', 3688, 3689, 1845, 4);
INSERT INTO `industry` VALUES (1847, '873', '影视节目制作', '', 3691, 3694, 1842, 3);
INSERT INTO `industry` VALUES (1848, '8730', '影视节目制作', '', 3692, 3693, 1847, 4);
INSERT INTO `industry` VALUES (1849, '874', '广播电视集成播控', '', 3695, 3698, 1842, 3);
INSERT INTO `industry` VALUES (1850, '8740', '广播电视集成播控', '', 3696, 3697, 1849, 4);
INSERT INTO `industry` VALUES (1851, '875', '电影和广播电视节目发行', '', 3699, 3702, 1842, 3);
INSERT INTO `industry` VALUES (1852, '8750', '电影和广播电视节目发行', '', 3700, 3701, 1851, 4);
INSERT INTO `industry` VALUES (1853, '876', '电影放映', '', 3703, 3706, 1842, 3);
INSERT INTO `industry` VALUES (1854, '8760', '电影放映', '', 3704, 3705, 1853, 4);
INSERT INTO `industry` VALUES (1855, '877', '录音制作', '', 3707, 3710, 1842, 3);
INSERT INTO `industry` VALUES (1856, '8770', '录音制作', '', 3708, 3709, 1855, 4);
INSERT INTO `industry` VALUES (1857, '88', '文化艺术业', '', 3712, 3747, 1830, 2);
INSERT INTO `industry` VALUES (1858, '881', '文艺创作与表演', '', 3713, 3716, 1857, 3);
INSERT INTO `industry` VALUES (1859, '8810', '文艺创作与表演', '', 3714, 3715, 1858, 4);
INSERT INTO `industry` VALUES (1860, '882', '艺术表演场馆', '', 3717, 3720, 1857, 3);
INSERT INTO `industry` VALUES (1861, '8820', '艺术表演场馆', '', 3718, 3719, 1860, 4);
INSERT INTO `industry` VALUES (1862, '883', '图书馆与档案馆', '', 3721, 3726, 1857, 3);
INSERT INTO `industry` VALUES (1863, '8831', '图书馆', '', 3722, 3723, 1862, 4);
INSERT INTO `industry` VALUES (1864, '8832', '档案馆', '', 3724, 3725, 1862, 4);
INSERT INTO `industry` VALUES (1865, '884', '文物及非物质文化遗产保护', '', 3727, 3730, 1857, 3);
INSERT INTO `industry` VALUES (1866, '8840', '文物及非物质文化遗产保护', '', 3728, 3729, 1865, 4);
INSERT INTO `industry` VALUES (1867, '885', '博物馆', '', 3731, 3734, 1857, 3);
INSERT INTO `industry` VALUES (1868, '8850', '博物馆', '', 3732, 3733, 1867, 4);
INSERT INTO `industry` VALUES (1869, '886', '烈士陵园、纪念馆', '', 3735, 3738, 1857, 3);
INSERT INTO `industry` VALUES (1870, '8860', '烈士陵园、纪念馆', '', 3736, 3737, 1869, 4);
INSERT INTO `industry` VALUES (1871, '887', '群众文体活动', '', 3739, 3742, 1857, 3);
INSERT INTO `industry` VALUES (1872, '8870', '群众文体活动', '', 3740, 3741, 1871, 4);
INSERT INTO `industry` VALUES (1873, '889', '其他文化艺术业', '', 3743, 3746, 1857, 3);
INSERT INTO `industry` VALUES (1874, '8890', '其他文化艺术业', '', 3744, 3745, 1873, 4);
INSERT INTO `industry` VALUES (1875, '89', '体育', '', 3748, 3775, 1830, 2);
INSERT INTO `industry` VALUES (1876, '891', '体育组织', '', 3749, 3756, 1875, 3);
INSERT INTO `industry` VALUES (1877, '8911', '体育竞赛组织', '', 3750, 3751, 1876, 4);
INSERT INTO `industry` VALUES (1878, '8912', '体育保障组织', '', 3752, 3753, 1876, 4);
INSERT INTO `industry` VALUES (1879, '8919', '其他体育组织', '', 3754, 3755, 1876, 4);
INSERT INTO `industry` VALUES (1880, '892', '体育场地设施管理', '', 3757, 3762, 1875, 3);
INSERT INTO `industry` VALUES (1881, '8921', '体育场馆管理', '', 3758, 3759, 1880, 4);
INSERT INTO `industry` VALUES (1882, '8929', '其他体育场地设施管理', '', 3760, 3761, 1880, 4);
INSERT INTO `industry` VALUES (1883, '893', '健身休闲活动', '', 3763, 3766, 1875, 3);
INSERT INTO `industry` VALUES (1884, '8930', '健身休闲活动', '', 3764, 3765, 1883, 4);
INSERT INTO `industry` VALUES (1885, '899', '其他体育', '', 3767, 3774, 1875, 3);
INSERT INTO `industry` VALUES (1886, '8991', '体育中介代理服务', '', 3768, 3769, 1885, 4);
INSERT INTO `industry` VALUES (1887, '8992', '体育健康服务', '', 3770, 3771, 1885, 4);
INSERT INTO `industry` VALUES (1888, '8999', '其他未列明体育', '', 3772, 3773, 1885, 4);
INSERT INTO `industry` VALUES (1889, '90', '娱乐业', '', 3776, 3819, 1830, 2);
INSERT INTO `industry` VALUES (1890, '901', '室内娱乐活动', '', 3777, 3786, 1889, 3);
INSERT INTO `industry` VALUES (1891, '9011', '歌舞厅娱乐活动', '', 3778, 3779, 1890, 4);
INSERT INTO `industry` VALUES (1892, '9012', '电子游艺厅娱乐活动', '', 3780, 3781, 1890, 4);
INSERT INTO `industry` VALUES (1893, '9013', '网吧活动', '', 3782, 3783, 1890, 4);
INSERT INTO `industry` VALUES (1894, '9019', '其他室内娱乐活动', '', 3784, 3785, 1890, 4);
INSERT INTO `industry` VALUES (1895, '902', '游乐园', '', 3787, 3790, 1889, 3);
INSERT INTO `industry` VALUES (1896, '9020', '游乐园', '', 3788, 3789, 1895, 4);
INSERT INTO `industry` VALUES (1897, '903', '休闲观光活动', '', 3791, 3794, 1889, 3);
INSERT INTO `industry` VALUES (1898, '9030', '休闲观光活动', '', 3792, 3793, 1897, 4);
INSERT INTO `industry` VALUES (1899, '904', '彩票活动', '', 3795, 3802, 1889, 3);
INSERT INTO `industry` VALUES (1900, '9041', '体育彩票服务', '', 3796, 3797, 1899, 4);
INSERT INTO `industry` VALUES (1901, '9042', '福利彩票服务', '', 3798, 3799, 1899, 4);
INSERT INTO `industry` VALUES (1902, '9049', '其他彩票服务', '', 3800, 3801, 1899, 4);
INSERT INTO `industry` VALUES (1903, '905', '文化体育娱乐活动与经纪代理服务', '', 3803, 3814, 1889, 3);
INSERT INTO `industry` VALUES (1904, '9051', '文化活动服务', '', 3804, 3805, 1903, 4);
INSERT INTO `industry` VALUES (1905, '9052', '体育表演服务', '', 3806, 3807, 1903, 4);
INSERT INTO `industry` VALUES (1906, '9053', '文化娱乐经纪人', '', 3808, 3809, 1903, 4);
INSERT INTO `industry` VALUES (1907, '9054', '体育经纪人', '', 3810, 3811, 1903, 4);
INSERT INTO `industry` VALUES (1908, '9059', '其他文化艺术经纪代理', '', 3812, 3813, 1903, 4);
INSERT INTO `industry` VALUES (1909, '909', '其他娱乐业', '', 3815, 3818, 1889, 3);
INSERT INTO `industry` VALUES (1910, '9090', '其他娱乐业', '', 3816, 3817, 1909, 4);
INSERT INTO `industry` VALUES (1911, 'S', '公共管理、社会保障和社会组织', '', 3821, 3934, 0, 1);
INSERT INTO `industry` VALUES (1912, '91', '中国共产党机关', '', 3822, 3827, 1911, 2);
INSERT INTO `industry` VALUES (1913, '910', '中国共产党机关', '', 3823, 3826, 1912, 3);
INSERT INTO `industry` VALUES (1914, '9100', '中国共产党机关', '', 3824, 3825, 1913, 4);
INSERT INTO `industry` VALUES (1915, '92', '国家机构', '', 3828, 3859, 1911, 2);
INSERT INTO `industry` VALUES (1916, '921', '国家权力机构', '', 3829, 3832, 1915, 3);
INSERT INTO `industry` VALUES (1917, '9210', '国家权力机构', '', 3830, 3831, 1916, 4);
INSERT INTO `industry` VALUES (1918, '922', '国家行政机构', '', 3833, 3846, 1915, 3);
INSERT INTO `industry` VALUES (1919, '9221', '综合事务管理机构', '', 3834, 3835, 1918, 4);
INSERT INTO `industry` VALUES (1920, '9222', '对外事务管理机构', '', 3836, 3837, 1918, 4);
INSERT INTO `industry` VALUES (1921, '9223', '公共安全管理机构', '', 3838, 3839, 1918, 4);
INSERT INTO `industry` VALUES (1922, '9224', '社会事务管理机构', '', 3840, 3841, 1918, 4);
INSERT INTO `industry` VALUES (1923, '9225', '经济事务管理机构', '', 3842, 3843, 1918, 4);
INSERT INTO `industry` VALUES (1924, '9226', '行政监督检查机构', '', 3844, 3845, 1918, 4);
INSERT INTO `industry` VALUES (1925, '923', '人民法院和人民检察院', '', 3847, 3852, 1915, 3);
INSERT INTO `industry` VALUES (1926, '9231', '人民法院', '', 3848, 3849, 1925, 4);
INSERT INTO `industry` VALUES (1927, '9232', '人民检察院', '', 3850, 3851, 1925, 4);
INSERT INTO `industry` VALUES (1928, '929', '其他国家机构', '', 3853, 3858, 1915, 3);
INSERT INTO `industry` VALUES (1929, '9291', '消防管理机构', '', 3854, 3855, 1928, 4);
INSERT INTO `industry` VALUES (1930, '9299', '其他未列明国家机构', '', 3856, 3857, 1928, 4);
INSERT INTO `industry` VALUES (1931, '93', '人民政协、民主党派', '', 3860, 3869, 1911, 2);
INSERT INTO `industry` VALUES (1932, '931', '人民政协', '', 3861, 3864, 1931, 3);
INSERT INTO `industry` VALUES (1933, '9310', '人民政协', '', 3862, 3863, 1932, 4);
INSERT INTO `industry` VALUES (1934, '932', '民主党派', '', 3865, 3868, 1931, 3);
INSERT INTO `industry` VALUES (1935, '9320', '民主党派', '', 3866, 3867, 1934, 4);
INSERT INTO `industry` VALUES (1936, '94', '社会保障', '', 3870, 3893, 1911, 2);
INSERT INTO `industry` VALUES (1937, '941', '基本保险', '', 3871, 3884, 1936, 3);
INSERT INTO `industry` VALUES (1938, '9411', '基本养老保险', '', 3872, 3873, 1937, 4);
INSERT INTO `industry` VALUES (1939, '9412', '基本医疗保险', '', 3874, 3875, 1937, 4);
INSERT INTO `industry` VALUES (1940, '9413', '失业保险', '', 3876, 3877, 1937, 4);
INSERT INTO `industry` VALUES (1941, '9414', '工伤保险', '', 3878, 3879, 1937, 4);
INSERT INTO `industry` VALUES (1942, '9415', '生育保险', '', 3880, 3881, 1937, 4);
INSERT INTO `industry` VALUES (1943, '9419', '其他基本保险', '', 3882, 3883, 1937, 4);
INSERT INTO `industry` VALUES (1944, '942', '补充保险', '', 3885, 3888, 1936, 3);
INSERT INTO `industry` VALUES (1945, '9420', '补充保险', '', 3886, 3887, 1944, 4);
INSERT INTO `industry` VALUES (1946, '949', '其他社会保障', '', 3889, 3892, 1936, 3);
INSERT INTO `industry` VALUES (1947, '9490', '其他社会保障', '', 3890, 3891, 1946, 4);
INSERT INTO `industry` VALUES (1948, '95', '群众团体、社会团体和其他成员组织', '', 3894, 3923, 1911, 2);
INSERT INTO `industry` VALUES (1949, '951', '群众团体', '', 3895, 3904, 1948, 3);
INSERT INTO `industry` VALUES (1950, '9511', '工会', '', 3896, 3897, 1949, 4);
INSERT INTO `industry` VALUES (1951, '9512', '妇联', '', 3898, 3899, 1949, 4);
INSERT INTO `industry` VALUES (1952, '9513', '共青团', '', 3900, 3901, 1949, 4);
INSERT INTO `industry` VALUES (1953, '9519', '其他群众团体', '', 3902, 3903, 1949, 4);
INSERT INTO `industry` VALUES (1954, '952', '社会团体', '', 3905, 3912, 1948, 3);
INSERT INTO `industry` VALUES (1955, '9521', '专业性团体', '', 3906, 3907, 1954, 4);
INSERT INTO `industry` VALUES (1956, '9522', '行业性团体', '', 3908, 3909, 1954, 4);
INSERT INTO `industry` VALUES (1957, '9529', '其他社会团体', '', 3910, 3911, 1954, 4);
INSERT INTO `industry` VALUES (1958, '953', '基金会', '', 3913, 3916, 1948, 3);
INSERT INTO `industry` VALUES (1959, '9530', '基金会', '', 3914, 3915, 1958, 4);
INSERT INTO `industry` VALUES (1960, '954', '宗教组织', '', 3917, 3922, 1948, 3);
INSERT INTO `industry` VALUES (1961, '9541', '宗教团体服务', '', 3918, 3919, 1960, 4);
INSERT INTO `industry` VALUES (1962, '9542', '宗教活动场所服务', '', 3920, 3921, 1960, 4);
INSERT INTO `industry` VALUES (1963, '96', '基层群众自治组织及其他组织', '', 3924, 3933, 1911, 2);
INSERT INTO `industry` VALUES (1964, '961', '社区居民自治组织', '', 3925, 3928, 1963, 3);
INSERT INTO `industry` VALUES (1965, '9610', '社区居民自治组织', '', 3926, 3927, 1964, 4);
INSERT INTO `industry` VALUES (1966, '962', '村民自治组织', '', 3929, 3932, 1963, 3);
INSERT INTO `industry` VALUES (1967, '9620', '村民自治组织', '', 3930, 3931, 1966, 4);
INSERT INTO `industry` VALUES (1968, 'T', '国际组织', '', 3935, 3942, 0, 1);
INSERT INTO `industry` VALUES (1969, '97', '国际组织', '', 3936, 3941, 1968, 2);
INSERT INTO `industry` VALUES (1970, '970', '国际组织', '', 3937, 3940, 1969, 3);
INSERT INTO `industry` VALUES (1971, '9700', '国际组织', '', 3938, 3939, 1970, 4);
COMMIT;

-- ----------------------------
-- Table structure for notice_content
-- ----------------------------
DROP TABLE IF EXISTS `notice_content`;
CREATE TABLE `notice_content` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL DEFAULT '' COMMENT '标题',
  `content` varchar(2000) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '消息内容',
  `app_url` varchar(500) NOT NULL DEFAULT '' COMMENT 'APP跳转地址',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `is_deleted` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11731 DEFAULT CHARSET=utf8mb4 COMMENT='消息内容';

-- ----------------------------
-- Records of notice_content
-- ----------------------------
BEGIN;
INSERT INTO `notice_content` VALUES (11730, '我是标题', '我是内容', '1', NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for notice_send
-- ----------------------------
DROP TABLE IF EXISTS `notice_send`;
CREATE TABLE `notice_send` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `content_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '消息内容ID',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `receive_object` varchar(200) NOT NULL DEFAULT '' COMMENT '接收对象',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '消息类型 1站内信2邮件3短信5微信6推送',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_send` datetime DEFAULT NULL COMMENT '发送时间',
  `is_send` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否已发送',
  `gmt_received` datetime DEFAULT NULL COMMENT '接收时间',
  `gmt_read` datetime DEFAULT NULL COMMENT '阅读时间',
  `is_read` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否已读',
  `user_deleted` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '用户删除标记',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `is_deleted` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '逻辑删除标记',
  PRIMARY KEY (`id`),
  KEY `notice_send_content_id_index` (`content_id`),
  KEY `notice_send_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12460 DEFAULT CHARSET=utf8mb4 COMMENT='消息发送列表';

-- ----------------------------
-- Records of notice_send
-- ----------------------------
BEGIN;
INSERT INTO `notice_send` VALUES (12444, 11730, 10032, '', 1, '2020-09-13 16:28:57', NULL, 0, NULL, NULL, 0, 0, NULL, 0);
INSERT INTO `notice_send` VALUES (12445, 11730, 10032, '', 2, NULL, NULL, 0, NULL, NULL, 0, 0, NULL, 0);
INSERT INTO `notice_send` VALUES (12446, 11730, 10032, '', 3, NULL, NULL, 0, NULL, NULL, 0, 0, NULL, 0);
INSERT INTO `notice_send` VALUES (12447, 11730, 10032, '', 5, NULL, NULL, 0, NULL, NULL, 0, 0, NULL, 0);
INSERT INTO `notice_send` VALUES (12448, 11730, 10032, '', 1, '2020-09-13 16:28:57', NULL, 0, NULL, NULL, 0, 0, NULL, 0);
INSERT INTO `notice_send` VALUES (12449, 11730, 10032, '', 1, '2020-09-13 16:28:57', NULL, 0, NULL, NULL, 0, 0, NULL, 0);
INSERT INTO `notice_send` VALUES (12450, 11730, 10032, '', 1, '2020-09-13 16:28:57', NULL, 0, NULL, NULL, 0, 0, NULL, 0);
INSERT INTO `notice_send` VALUES (12451, 11730, 10032, '', 1, '2020-09-13 16:28:57', NULL, 0, NULL, NULL, 0, 0, NULL, 0);
INSERT INTO `notice_send` VALUES (12452, 11730, 10032, '', 1, '2020-09-13 16:28:57', NULL, 0, NULL, NULL, 0, 0, NULL, 0);
INSERT INTO `notice_send` VALUES (12453, 11730, 10032, '', 1, '2020-09-13 16:28:57', NULL, 0, NULL, NULL, 0, 0, NULL, 0);
INSERT INTO `notice_send` VALUES (12454, 11730, 10032, '', 1, '2020-09-13 16:28:57', NULL, 0, NULL, NULL, 0, 0, NULL, 0);
INSERT INTO `notice_send` VALUES (12455, 11730, 10032, '', 1, '2020-09-13 16:28:57', NULL, 0, NULL, NULL, 0, 0, NULL, 0);
INSERT INTO `notice_send` VALUES (12456, 11730, 10032, '', 1, '2020-09-13 16:28:57', NULL, 0, NULL, NULL, 0, 0, NULL, 0);
INSERT INTO `notice_send` VALUES (12457, 11730, 10032, '', 1, '2020-09-13 16:28:57', NULL, 0, NULL, NULL, 0, 0, NULL, 0);
INSERT INTO `notice_send` VALUES (12458, 11730, 10032, '', 1, '2020-09-13 16:28:57', NULL, 0, NULL, NULL, 0, 0, NULL, 0);
INSERT INTO `notice_send` VALUES (12459, 11730, 10032, '', 1, '2020-09-13 16:28:57', NULL, 0, NULL, NULL, 0, 0, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for posts
-- ----------------------------
DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '标题',
  `category_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '文章分类ID',
  `type` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '类型',
  `is_top` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否置顶',
  `is_recommend` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否推荐',
  `img_url` varchar(1000) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '文章主图',
  `description` varchar(500) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '文章简介',
  `content` text COLLATE utf8_unicode_ci COMMENT '文章内容',
  `seo_title` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'SEO标题',
  `seo_description` varchar(500) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'SEO网站内容描述)',
  `seo_keywords` varchar(300) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'SEO关键字',
  `publish_at` timestamp NULL DEFAULT NULL COMMENT '发布时间',
  `sort` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `status` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `is_deleted` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '逻辑删除标记',
  PRIMARY KEY (`id`),
  KEY `posts_category_id_index` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='文章';

-- ----------------------------
-- Records of posts
-- ----------------------------
BEGIN;
INSERT INTO `posts` VALUES (1, '12321321', 0, 0, 0, 0, '', '32132', '<p>21321321321321</p>', '', '', '', NULL, 0, 0, '2020-09-24 11:38:43', '2020-09-24 11:38:43', 0);
INSERT INTO `posts` VALUES (2, '1', 1, 0, 0, 0, '', 'fdaf', '<p>fdafdafdafdfds</p>', '31232', '3213232', '321321321321', '2020-09-24 11:43:06', 0, 0, '2020-09-24 11:43:15', '2020-09-24 11:43:15', 0);
INSERT INTO `posts` VALUES (3, '2', 1, 0, 0, 0, '', 'fdaf', '<p>fdafdafdafdfds</p>', '31232', '3213232', '321321321321', '2020-09-24 11:43:06', 0, 0, '2020-09-24 11:43:15', '2020-09-24 11:43:15', 0);
INSERT INTO `posts` VALUES (4, '3', 2, 0, 0, 0, '', 'fdaf', '<p>fdafdafdafdfds</p>', '31232', '3213232', '321321321321', '2020-09-24 11:43:06', 0, 0, '2020-09-24 11:43:15', '2020-09-24 11:43:15', 0);
INSERT INTO `posts` VALUES (5, '4', 2, 0, 0, 0, '', 'fdaf', '<p>fdafdafdafdfds</p>', '31232', '3213232', '321321321321', '2020-09-24 11:43:06', 0, 0, '2020-09-24 11:43:15', '2020-09-24 11:43:15', 0);
INSERT INTO `posts` VALUES (6, '5', 2, 0, 0, 0, '', 'fdaf', '<p>fdafdafdafdfds</p>', '31232', '3213232', '321321321321', '2020-09-24 11:43:06', 0, 0, '2020-09-24 11:43:15', '2020-09-24 11:43:15', 0);
INSERT INTO `posts` VALUES (7, '6', 2, 0, 0, 0, '', 'fdaf', '<p>fdafdafdafdfds</p>', '31232', '3213232', '321321321321', '2020-09-24 11:43:06', 0, 0, '2020-09-24 11:43:15', '2020-09-24 11:43:15', 0);
INSERT INTO `posts` VALUES (8, '7', 2, 0, 0, 0, '', 'fdaf', '<p>fdafdafdafdfds</p>', '31232', '3213232', '321321321321', '2020-09-24 11:43:06', 0, 0, '2020-09-24 11:43:15', '2020-09-24 11:43:15', 0);
INSERT INTO `posts` VALUES (9, '8', 2, 0, 0, 0, '', 'fdaf', '<p>fdafdafdafdfds</p>', '31232', '3213232', '321321321321', '2020-09-24 11:43:06', 0, 0, '2020-09-24 11:43:15', '2020-09-24 11:43:15', 0);
INSERT INTO `posts` VALUES (10, '9', 1, 0, 0, 0, '', 'fdaf', '<p>fdafdafdafdfds</p>', '31232', '3213232', '321321321321', '2020-09-24 11:43:06', 0, 0, '2020-09-24 11:43:15', '2020-09-24 11:43:15', 0);
INSERT INTO `posts` VALUES (11, '0', 1, 0, 0, 0, '', 'fdaf', '<p>fdafdafdafdfds</p>', '31232', '3213232', '321321321321', '2020-09-24 11:43:06', 0, 0, '2020-09-24 11:43:15', '2020-09-24 11:43:15', 0);
INSERT INTO `posts` VALUES (12, '11', 3, 0, 0, 0, '', 'fdaf', '<p>fdafdafdafdfds</p>', '31232', '3213232', '321321321321', '2020-09-24 11:43:06', 0, 0, '2020-09-24 11:43:15', '2020-09-24 11:43:15', 0);
INSERT INTO `posts` VALUES (13, '12', 3, 0, 0, 0, '', 'fdaf', '<p>fdafdafdafdfds</p>', '31232', '3213232', '321321321321', '2020-09-24 11:43:06', 0, 0, '2020-09-24 11:43:15', '2020-09-24 11:43:15', 0);
INSERT INTO `posts` VALUES (14, '13', 3, 0, 0, 0, '', 'fdaf', '<p>fdafdafdafdfds</p>', '31232', '3213232', '321321321321', '2020-09-24 11:43:06', 0, 0, '2020-09-24 11:43:15', '2020-09-24 11:43:15', 0);
INSERT INTO `posts` VALUES (15, '14', 3, 0, 0, 0, '', 'fdaf', '<p>fdafdafdafdfds</p>', '31232', '3213232', '321321321321', '2020-09-24 11:43:06', 0, 0, '2020-09-24 11:43:15', '2020-09-24 11:43:15', 0);
INSERT INTO `posts` VALUES (16, '15', 3, 0, 0, 0, '', 'fdaf', '<p>fdafdafdafdfds</p>', '31232', '3213232', '321321321321', '2020-09-24 11:43:06', 0, 0, '2020-09-24 11:43:15', '2020-09-24 11:43:15', 0);
COMMIT;

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '产品名称',
  `description` varchar(100) NOT NULL DEFAULT '' COMMENT '产品文字说明',
  `video_img_url` varchar(1000) NOT NULL DEFAULT '' COMMENT '视频封面',
  `duration` int(11) NOT NULL DEFAULT '0' COMMENT '视频时长（冗余）',
  `industry_id` int(11) NOT NULL DEFAULT '0' COMMENT '行业ID',
  `industry_name` varchar(100) NOT NULL DEFAULT '' COMMENT '行业名称（冗余）',
  `is_custom` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否支持定制',
  `buy_url` varchar(1000) NOT NULL DEFAULT '' COMMENT '购买链接',
  `download_url` varchar(1000) NOT NULL DEFAULT '' COMMENT '使用下载链接',
  `score` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '评分',
  `price` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '价格',
  `stock` bigint(20) NOT NULL DEFAULT '0' COMMENT '库存',
  `content` text COMMENT '内容，预留',
  `collection_num` int(11) NOT NULL DEFAULT '0' COMMENT '收藏数量',
  `play_num` int(11) NOT NULL DEFAULT '0' COMMENT '播放量',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '状态',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8 COMMENT='产品';

-- ----------------------------
-- Records of product
-- ----------------------------
BEGIN;
INSERT INTO `product` VALUES (1, 0, '产品1号放大放大', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200908153151810000000110704524.jpg', 0, 0, '', 0, '', '', 0.00, 321.00, 0, '', 0, 0, 0, '2020-09-05 15:58:51', '2020-09-05 15:58:51', 0);
INSERT INTO `product` VALUES (2, 10032, '产品2号132321321', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200908153151810000000110704524.jpg', 0, 3, '', 1, '321', '321', 0.00, 321.00, 0, '<p>321321321</p>', 0, 0, 0, '2020-09-06 15:40:00', '2020-09-06 15:40:00', 0);
INSERT INTO `product` VALUES (3, 10032, '产品3号加加减减就', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200908153151810000000110704524.jpg', 0, 8, '', 1, '321321', '321321', 0.00, 321.00, 0, '<p>321321321321321</p>', 0, 0, 0, '2020-09-07 00:51:40', '2020-09-07 00:51:40', 0);
INSERT INTO `product` VALUES (4, 10032, '产品4号32132321', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200908153151810000000110704524.jpg', 0, 2, '', 1, '321', '321', 0.00, 321.00, 0, '<p>321321</p>', 0, 0, 0, '2020-09-07 01:03:52', '2020-09-07 01:03:52', 1);
INSERT INTO `product` VALUES (5, 10032, '产品5号', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200908153151810000000110704524.jpg', 0, 6, '', 0, '321', '321', 0.00, 32.00, 0, '<p>321</p>', 0, 0, 0, '2020-09-07 01:07:01', '2020-09-07 01:07:01', 0);
INSERT INTO `product` VALUES (6, 10032, '产品6号', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200908153151810000000110704524.jpg', 0, 2, '采矿业', 1, '3213', '3213213', 0.00, 321.00, 0, '<p>321321321321321321</p>', 0, 0, 0, '2020-09-07 02:06:25', '2020-09-07 02:06:25', 0);
INSERT INTO `product` VALUES (7, 10032, '产品7号啊啊啊啊啊啊啊啊', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200908153151810000000110704524.jpg', 0, 2, '采矿业', 1, '3213', '3213213', 0.00, 321.00, 0, '<p>321321321321321321</p>', 0, 0, 0, '2020-09-07 02:06:25', '2020-09-07 02:06:25', 0);
INSERT INTO `product` VALUES (8, 10032, 'DJI 大疆 御 Mavic Air 2 便携可折叠航拍器', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200912103708454000000319249582.jpg', 0, 13, '科学研究和技术服务业', 1, 'https://detail.tmall.com/item.htm?spm=a230r.1.14.22.32d973dcndBdbC&id=615311292571&ns=1&abbucket=5', 'https://detail.tmall.com/item.htm?spm=a230r.1.14.22.32d973dcndBdbC&id=615311292571&ns=1&abbucket=5', 0.00, 1999.00, 0, '<div id=\"J_BrandAttr\" class=\"tm-clear tb-hidden tm_brandAttr\">\n<div class=\"name\" data-spm-anchor-id=\"a220o.1000855.0.i1.e66a19e10Le68j\">品牌名称：<strong class=\"J_EbrandLogo\">DJI/大疆</strong></div>\n</div>\n<p class=\"attr-list-hd tm-clear\"><em>产品参数：</em></p>\n<ul id=\"J_AttrUL\">\n<li id=\"J_attrBrandName\" title=\"&nbsp;DJI/大疆\">品牌:&nbsp;DJI/大疆</li>\n<li title=\"&nbsp;大疆创新\" data-spm-anchor-id=\"a220o.1000855.0.i2.e66a19e10Le68j\">型号:&nbsp;大疆创新</li>\n<li title=\"&nbsp;御 Mavic Air 2&nbsp;御 Mavic Air 2 畅飞套装&nbsp;御 Mavic Air 2+DJI Care 随心换&nbsp;御 Mavic Air 2 畅飞套装+DJI Care 随心换\">颜色分类:&nbsp;御 Mavic Air 2&nbsp;御 Mavic Air 2 畅飞套装&nbsp;御 Mavic Air 2+DJI Care 随心换&nbsp;御 Mavic Air 2 畅飞套装+DJI Care 随心换</li>\n<li title=\"&nbsp;DJI 大疆\">生产企业:&nbsp;DJI 大疆</li>\n<li title=\"&nbsp;12个月\">保修期:&nbsp;12个月</li>\n</ul>', 0, 0, 0, '2020-09-12 10:38:41', '2020-09-12 10:38:41', 0);
INSERT INTO `product` VALUES (9, 10032, '美团餐饮收银机', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200912111427939000000470167498.png', 0, 8, '住宿和餐饮业', 1, 'https://detail.tmall.com/item.html', '', 0.00, 1555.00, 0, '<div id=\"J_BrandAttr\" class=\"tm-clear tb-hidden tm_brandAttr\">\n<div class=\"name\" data-spm-anchor-id=\"a220o.1000855.0.i3.15967b46QyPh0k\">品牌名称：<strong class=\"J_EbrandLogo\">美团点评</strong></div>\n</div>\n<p class=\"attr-list-hd tm-clear\"><em>产品参数：</em></p>\n<ul id=\"J_AttrUL\">\n<li title=\"2018010913054972\">证书编号：2018010913054972</li>\n<li title=\"有效\">证书状态：有效</li>\n<li title=\"智能收款机\">产品名称：智能收款机</li>\n<li title=\"MD-ACR1010 、MD-ACR1011、MD-ACR1012：12VDC,3.0A（电源适配器...\">3C规格型号：MD-ACR1010 、MD-ACR1011、MD-ACR1012：12VDC,3.0A（电源适配器...</li>\n<li id=\"J_attrBrandName\" title=\"&nbsp;美团点评\">品牌:&nbsp;美团点评</li>\n<li title=\"&nbsp;MD-ACR1010/MD-ACR1011\">型号:&nbsp;MD-ACR1010/MD-ACR1011</li>\n<li title=\"&nbsp;1GB\" data-spm-anchor-id=\"a220o.1000855.0.i4.15967b46QyPh0k\">内存容量:&nbsp;1GB</li>\n<li title=\"&nbsp;无\">硬盘容量:&nbsp;无</li>\n<li title=\"&nbsp;DDR3\">内存类型:&nbsp;DDR3</li>\n<li title=\"&nbsp;八核心\">核心数:&nbsp;八核心</li>\n<li title=\"&nbsp;快餐小吃方案（银色）&nbsp;奶茶饮品方案（银色）&nbsp;日韩料理方案（银色）&nbsp;正餐西餐方案（银色）&nbsp;火锅烧烤方案（银色）&nbsp;餐饮通用方案（银色）&nbsp;升级版单屏标配&nbsp;升级版单屏套餐一&nbsp;升级版单屏套餐二&nbsp;升级版单屏套餐三&nbsp;升级版单屏套餐四&nbsp;升级版单屏套餐五\">颜色分类:&nbsp;快餐小吃方案（银色）&nbsp;奶茶饮品方案（银色）&nbsp;日韩料理方案（银色）&nbsp;正餐西餐方案（银色）&nbsp;火锅烧烤方案（银色）&nbsp;餐饮通用方案（银色）&nbsp;升级版单屏标配&nbsp;升级版单屏套餐一&nbsp;升级版单屏套餐二&nbsp;升级版单屏套餐三&nbsp;升级版单屏套餐四&nbsp;升级版单屏套餐五</li>\n<li title=\"&nbsp;官方标配\">套餐类型:&nbsp;官方标配</li>\n<li title=\"&nbsp;汉平信息技术（北京）有限公司\">生产企业:&nbsp;汉平信息技术（北京）有限公司</li>\n<li title=\"&nbsp;触摸屏\">是否触摸屏:&nbsp;触摸屏</li>\n<li title=\"&nbsp;15.6英寸\">屏幕尺寸:&nbsp;15.6英寸</li>\n<li title=\"&nbsp;无\">客屏类型:&nbsp;无</li>\n<li title=\"&nbsp;无\">硬盘类型:&nbsp;无</li>\n<li title=\"&nbsp;一体机\">收款机类型:&nbsp;一体机</li>\n<li title=\"&nbsp;无\">钱箱类别:&nbsp;无</li>\n<li title=\"&nbsp;无\">CPU类型:&nbsp;无</li>\n<li title=\"&nbsp;电容屏\">屏幕类型:&nbsp;电容屏</li>\n<li title=\"&nbsp;单屏\">屏幕数量:&nbsp;单屏</li>\n</ul>\n<div class=\"col-main tm-clear\">\n<div id=\"mainwrap\" class=\"main-wrap\" role=\"main\" data-spm-anchor-id=\"a220o.1000855.0.i0.15967b46QyPh0k\">\n<div id=\"description\" class=\"J_DetailSection tshop-psm tshop-psm-bdetaildes\">\n<div class=\"content ke-post\">\n<p>&nbsp;</p>\n</div>\n</div>\n<div id=\"J_DcBottomRightWrap\">\n<div id=\"J_DcBottomRight\" class=\"J_DcAsyn tb-shop\">\n<div id=\"shop17430202461\" class=\"J_TModule\" data-widgetid=\"17430202461\" data-componentid=\"5003\" data-spm=\"110.0.5003-17430202461\" data-title=\"自定义内容区\">\n<div class=\"skin-box tb-module tshop-pbsm tshop-pbsm-shop-self-defined\"><s class=\"skin-box-tp\"></s>\n<div class=\"skin-box-bd clear-fix\">\n<div class=\"rel\" data-title=\"power by junezx 3.0\" data-rn=\"aRDiN\">&nbsp;</div>\n</div>\n<s class=\"skin-box-bt\"></s></div>\n</div>\n</div>\n</div>\n</div>\n</div>\n<div class=\"col-sub\">\n<div id=\"J_DcLeft\" class=\"J_DcAsyn tb-shop\">\n<div class=\"col-sub J_TRegion\" data-modules=\"sub\" data-width=\"b190\">\n<div id=\"shop17300019871\" class=\"J_TModule\" data-widgetid=\"17300019871\" data-componentid=\"4023\" data-spm=\"110.0.4023-17300019871\" data-title=\"宝贝排行榜\">\n<div class=\"skin-box tb-module tshop-pbsm tshop-pbsm-shop-top-list\">\n<div class=\"skin-box-bd\">\n<div class=\"panels\">\n<div class=\"control-group\">&nbsp;</div>\n</div>\n</div>\n<s class=\"skin-box-bt\"></s></div>\n</div>\n</div>\n</div>\n</div>', 0, 0, 1, '2020-09-12 11:21:12', '2020-09-27 15:13:44', 0);
INSERT INTO `product` VALUES (10, 10032, '测试视频1', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200913172458193000000259282398.png', 0, 7, '交通运输、仓储和邮政业', 0, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 4399.00, 0, '<p>我是产品内容</p>', 0, 0, 0, '2020-09-13 17:25:43', '2020-09-13 17:25:43', 0);
INSERT INTO `product` VALUES (11, 10032, '测试视频时长', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200914175714234000000430751233.png', 60, 6, '批发和零售业', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 123.00, 0, '<p>我是商品描述 内发放大</p>', 0, 0, 1, '2020-09-14 17:57:58', '2020-09-20 23:22:35', 0);
INSERT INTO `product` VALUES (12, 10032, '', '', '', 0, 3, '谷物种植', 0, '', '', 0.00, 0.00, 0, '', 0, 0, 0, '2020-09-21 04:22:03', '2020-09-21 04:22:03', 0);
INSERT INTO `product` VALUES (13, 10032, '发打发打发', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200921053313697000000439588807.png', 60, 1087, '糖果、巧克力及蜜饯制造', 0, '13', '321321', 0.00, 313213.00, 0, '<p>fd法大大s</p>', 0, 0, 1, '2020-09-21 05:33:26', '2020-09-21 05:33:26', 0);
INSERT INTO `product` VALUES (14, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (15, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (16, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (17, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (18, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (19, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (20, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (21, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (22, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (23, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (24, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (25, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (26, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (27, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (28, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (29, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (30, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (31, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (32, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (33, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (34, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (35, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (36, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (37, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (38, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (39, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (40, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (41, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (42, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (43, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (44, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (45, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (46, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (47, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (48, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (49, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1016, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (50, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1830, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (51, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1830, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (52, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1830, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (53, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1830, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (54, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1830, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (55, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1830, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (56, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1830, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (57, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1830, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (58, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1830, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (59, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1830, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (60, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1658, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (61, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1658, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (62, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1658, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (63, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1658, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (64, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1658, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (65, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1658, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (66, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1658, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (67, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1658, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (68, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1658, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (69, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1658, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (70, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1423, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (71, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1423, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (72, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1423, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (73, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1423, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (74, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1423, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (75, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1423, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (76, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1423, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (77, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1423, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (78, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1423, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (79, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1423, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (80, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1236, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (81, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1236, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (82, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1236, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (83, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1236, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (84, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1236, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (85, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1236, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (86, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1236, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (87, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1236, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (88, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1236, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (89, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1236, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (90, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1087, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (91, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1087, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (92, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1087, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (93, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1087, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (94, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1087, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (95, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1087, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (96, 10056, '测试产品数据', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144215303000001244881368.jpg', 60, 1087, '海水淡化处理', 1, 'https://www.baidu.com', 'https://www.baidu.com', 0.00, 1234.00, 0, '<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>\n<p>我是产品介绍，</p>', 0, 0, 1, '2020-09-29 14:43:26', '2020-10-09 15:22:49', 0);
INSERT INTO `product` VALUES (97, 10032, '水电费水电费', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20201014182143322000000128851418.png', 0, 115, '天然气开采', 0, 'http://top.test.chabug.com/#/memberCenter/videoRelease', 'http://top.test.chabug.com/#/memberCenter/videoRelease', 0.00, 1222.00, 0, '<p>是否水电费水电费水电费&nbsp;</p>', 0, 0, 0, '2020-10-14 18:22:34', '2020-10-14 18:22:34', 1);
INSERT INTO `product` VALUES (98, 10038, '测试数据1', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20201015152716376000000395612721.png', 0, 3, '谷物种植', 1, 'https://m.tb.cn/h.40OHzUc', 'https://m.tb.cn/h.40OHzUc', 0.00, 123.00, 0, '<p>描述编辑</p>', 0, 0, 1, '2020-10-15 15:29:03', '2020-10-15 15:30:33', 0);
INSERT INTO `product` VALUES (99, 10058, '产品编辑测试', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20201015153709233000000521299453.png', 0, 3, '谷物种植', 1, 'https://m.tb.cn/h.40OHzUc', 'https://m.tb.cn/h.40OHzUc', 0.00, 12.00, 0, '<p>我是商品描述。</p>', 0, 0, 0, '2020-10-15 15:38:03', '2020-10-15 15:38:03', 0);
INSERT INTO `product` VALUES (100, 10058, '321321', '', '', 0, 3, '谷物种植', 1, 'https://m.tb.cn/h.40OHzUc', '', 0.00, 123.00, 0, '<p>321321321321312321</p>', 0, 0, 0, '2020-10-16 11:08:41', '2020-10-16 11:08:41', 1);
INSERT INTO `product` VALUES (101, 10058, '测试', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20201016111903971000000274645495.jpg', 0, 115, '天然气开采', 0, 'https://m.tb.cn/h.40OHzUc', '', 0.00, 12.00, 0, '<p>12323</p>', 0, 0, 0, '2020-10-16 11:19:37', '2020-10-16 11:19:37', 1);
INSERT INTO `product` VALUES (102, 10058, '上传测试', '', 'http://yujia.img.cdn.chabug.com/test/image/video/20201016114219653000000455733921.jpg', 60, 105, '烟煤和无烟煤开采洗选', 1, 'https://m.tb.cn/h.40OHzUc', 'https://m.tb.cn/h.40OHzUc', 0.00, 123.00, 0, '<p>123</p>', 0, 0, 0, '2020-10-16 11:43:10', '2020-10-16 11:43:10', 0);
COMMIT;

-- ----------------------------
-- Table structure for product_apply_industry
-- ----------------------------
DROP TABLE IF EXISTS `product_apply_industry`;
CREATE TABLE `product_apply_industry` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `prod_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '产品ID',
  `industry_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '行业ID',
  `industry_name` varchar(100) NOT NULL DEFAULT '' COMMENT '行业名称（冗余）',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除标记',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COMMENT='产品应用行业';

-- ----------------------------
-- Records of product_apply_industry
-- ----------------------------
BEGIN;
INSERT INTO `product_apply_industry` VALUES (1, 6, 6, '批发和零售业', '2020-09-07 02:06:25', '2020-09-07 02:06:25', 0);
INSERT INTO `product_apply_industry` VALUES (2, 6, 7, '交通运输、仓储和邮政业', '2020-09-07 02:06:25', '2020-09-07 02:06:25', 0);
INSERT INTO `product_apply_industry` VALUES (3, 6, 8, '住宿和餐饮业', '2020-09-07 02:06:25', '2020-09-07 02:06:25', 0);
INSERT INTO `product_apply_industry` VALUES (4, 8, 1, '农、林、牧、渔业', '2020-09-12 10:38:41', '2020-09-12 10:38:41', 0);
INSERT INTO `product_apply_industry` VALUES (5, 8, 7, '交通运输、仓储和邮政业', '2020-09-12 10:38:41', '2020-09-12 10:38:41', 0);
INSERT INTO `product_apply_industry` VALUES (6, 8, 9, '信息传输、软件和信息技术服务业', '2020-09-12 10:38:41', '2020-09-12 10:38:41', 0);
INSERT INTO `product_apply_industry` VALUES (7, 9, 8, '住宿和餐饮业', '2020-09-12 11:21:12', '2020-09-12 11:21:12', 0);
INSERT INTO `product_apply_industry` VALUES (8, 9, 9, '信息传输、软件和信息技术服务业', '2020-09-12 11:21:12', '2020-09-12 11:21:12', 0);
INSERT INTO `product_apply_industry` VALUES (9, 9, 15, '居民服务、修理和其他服务业', '2020-09-12 11:21:12', '2020-09-12 11:21:12', 0);
INSERT INTO `product_apply_industry` VALUES (10, 10, 5, '建筑业', '2020-09-13 17:25:43', '2020-09-13 17:25:43', 0);
INSERT INTO `product_apply_industry` VALUES (11, 10, 6, '批发和零售业', '2020-09-13 17:25:43', '2020-09-13 17:25:43', 0);
INSERT INTO `product_apply_industry` VALUES (12, 10, 8, '住宿和餐饮业', '2020-09-13 17:25:43', '2020-09-13 17:25:43', 0);
INSERT INTO `product_apply_industry` VALUES (13, 11, 2, '采矿业', '2020-09-14 17:57:58', '2020-09-14 17:57:58', 0);
INSERT INTO `product_apply_industry` VALUES (14, 11, 4, '电力、热力、燃气及水生产和供应业', '2020-09-14 17:57:58', '2020-09-14 17:57:58', 0);
INSERT INTO `product_apply_industry` VALUES (15, 11, 6, '批发和零售业', '2020-09-14 17:57:58', '2020-09-14 17:57:58', 0);
INSERT INTO `product_apply_industry` VALUES (16, 12, 276, '化纤织造及印染精加工', '2020-09-21 04:22:04', '2020-09-21 04:22:04', 0);
INSERT INTO `product_apply_industry` VALUES (17, 12, 1169, '食品、饮料及烟草制品专门零售', '2020-09-21 04:22:04', '2020-09-21 04:22:04', 0);
INSERT INTO `product_apply_industry` VALUES (18, 13, 105, '烟煤和无烟煤开采洗选', '2020-09-21 05:33:27', '2020-09-21 05:33:27', 0);
INSERT INTO `product_apply_industry` VALUES (19, 14, 115, '天然气开采', '2020-09-29 14:43:26', '2020-09-29 14:43:26', 0);
INSERT INTO `product_apply_industry` VALUES (20, 14, 250, '精制茶加工', '2020-09-29 14:43:26', '2020-09-29 14:43:26', 0);
INSERT INTO `product_apply_industry` VALUES (21, 14, 1085, '其他未列明建筑业', '2020-09-29 14:43:26', '2020-09-29 14:43:26', 0);
INSERT INTO `product_apply_industry` VALUES (22, 97, 107, '褐煤开采洗选', '2020-10-14 18:22:34', '2020-10-14 18:22:34', 0);
INSERT INTO `product_apply_industry` VALUES (23, 97, 109, '其他煤炭采选', '2020-10-14 18:22:34', '2020-10-14 18:22:34', 0);
INSERT INTO `product_apply_industry` VALUES (24, 97, 1070, '管道和设备安装', '2020-10-14 18:22:34', '2020-10-14 18:22:34', 0);
INSERT INTO `product_apply_industry` VALUES (25, 98, 115, '天然气开采', '2020-10-15 15:29:03', '2020-10-15 15:29:03', 0);
INSERT INTO `product_apply_industry` VALUES (26, 98, 260, '棉纺织及印染精加工', '2020-10-15 15:29:03', '2020-10-15 15:29:03', 0);
INSERT INTO `product_apply_industry` VALUES (27, 99, 1016, '海水淡化处理', '2020-10-15 15:38:03', '2020-10-15 15:38:03', 0);
INSERT INTO `product_apply_industry` VALUES (28, 99, 1085, '其他未列明建筑业', '2020-10-15 15:38:03', '2020-10-15 15:38:03', 0);
INSERT INTO `product_apply_industry` VALUES (29, 101, 1085, '其他未列明建筑业', '2020-10-16 11:19:37', '2020-10-16 11:19:37', 0);
COMMIT;

-- ----------------------------
-- Table structure for product_evaluate
-- ----------------------------
DROP TABLE IF EXISTS `product_evaluate`;
CREATE TABLE `product_evaluate` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '商品ID',
  `product_user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '产品用户ID',
  `product_name` varchar(500) NOT NULL DEFAULT '' COMMENT '产品名称（冗余）',
  `trial_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '试用ID',
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `score` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '评分',
  `content` text COMMENT '内容',
  `img_url` varchar(5000) NOT NULL DEFAULT '' COMMENT '图片、视频地址',
  `is_img` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否带图',
  `is_video` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否带视频',
  `is_review` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否追评',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '好1中2差3评价',
  `reply_content` text COMMENT '回复内容',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '更新时间',
  `gmt_reply` datetime DEFAULT NULL COMMENT '回复时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COMMENT='产品评价';

-- ----------------------------
-- Records of product_evaluate
-- ----------------------------
BEGIN;
INSERT INTO `product_evaluate` VALUES (1, 6, 0, '吃爽1231232', 2, 10002, 4.00, '2132313213', '', 0, 0, 0, 0, NULL, '2020-09-07 15:06:49', '2020-09-07 15:06:49', NULL, 0);
INSERT INTO `product_evaluate` VALUES (2, 6, 0, '吃爽1231232', 2, 10002, 4.00, '2132313213', '', 0, 0, 0, 0, NULL, '2020-09-07 15:06:49', '2020-09-07 15:06:49', NULL, 0);
INSERT INTO `product_evaluate` VALUES (3, 6, 0, '吃爽1231232', 2, 10002, 4.00, '2132313213', '', 0, 0, 0, 0, NULL, '2020-09-07 15:06:49', '2020-09-07 15:06:49', NULL, 0);
INSERT INTO `product_evaluate` VALUES (4, 6, 0, '吃爽1231232', 2, 10002, 4.00, '2132313213', '', 0, 0, 0, 0, NULL, '2020-09-07 15:06:49', '2020-09-07 15:06:49', NULL, 0);
INSERT INTO `product_evaluate` VALUES (5, 6, 0, '吃爽1231232', 2, 10002, 4.00, '2132313213', '', 0, 0, 0, 0, NULL, '2020-09-07 15:06:49', '2020-09-07 15:06:49', NULL, 0);
INSERT INTO `product_evaluate` VALUES (6, 6, 0, '吃爽1231232', 2, 10002, 4.00, '2132313213', '', 0, 0, 0, 0, NULL, '2020-09-07 15:06:49', '2020-09-07 15:06:49', NULL, 0);
INSERT INTO `product_evaluate` VALUES (7, 6, 0, '吃爽1231232', 2, 10002, 4.00, '2132313213', '', 0, 0, 0, 0, NULL, '2020-09-07 15:06:49', '2020-09-07 15:06:49', NULL, 0);
INSERT INTO `product_evaluate` VALUES (8, 6, 0, '吃爽1231232', 2, 10002, 4.00, '2132313213', '', 0, 0, 0, 0, NULL, '2020-09-07 15:06:49', '2020-09-07 15:06:49', NULL, 0);
INSERT INTO `product_evaluate` VALUES (9, 6, 0, '吃爽1231232', 2, 10002, 4.00, '2132313213', '', 0, 0, 0, 0, NULL, '2020-09-07 15:06:49', '2020-09-07 15:06:49', NULL, 0);
INSERT INTO `product_evaluate` VALUES (10, 6, 0, '吃爽1231232', 2, 10002, 4.00, '2132313213', '', 0, 0, 0, 0, NULL, '2020-09-07 15:06:49', '2020-09-07 15:06:49', NULL, 0);
INSERT INTO `product_evaluate` VALUES (11, 6, 0, '吃爽1231232', 2, 10002, 4.00, '2132313213', '', 0, 0, 0, 0, NULL, '2020-09-07 15:06:49', '2020-09-07 15:06:49', NULL, 0);
INSERT INTO `product_evaluate` VALUES (12, 6, 0, '234', 2, 10002, 4.00, '2132313213', '', 0, 0, 0, 0, NULL, '2020-09-07 15:06:49', '2020-09-07 15:06:49', NULL, 0);
INSERT INTO `product_evaluate` VALUES (13, 6, 0, '234', 2, 10002, 4.00, '2132313213', '', 0, 0, 0, 0, NULL, '2020-09-07 15:06:49', '2020-09-07 15:06:49', NULL, 0);
INSERT INTO `product_evaluate` VALUES (14, 6, 0, '234', 2, 10002, 4.00, '2132313213', '', 0, 0, 0, 0, NULL, '2020-09-07 15:06:49', '2020-09-07 15:06:49', NULL, 0);
INSERT INTO `product_evaluate` VALUES (15, 6, 0, '234', 2, 10002, 4.00, '2132313213', '', 0, 0, 0, 0, NULL, '2020-09-07 15:06:49', '2020-09-07 15:06:49', NULL, 0);
INSERT INTO `product_evaluate` VALUES (16, 6, 0, '234', 2, 10002, 4.00, '2132313213', '', 0, 0, 0, 0, NULL, '2020-09-07 15:06:49', '2020-09-07 15:06:49', NULL, 0);
INSERT INTO `product_evaluate` VALUES (17, 6, 0, 'ffdaf fda', 2, 10002, 4.00, '2132313213', '', 0, 0, 0, 0, NULL, '2020-09-07 15:06:49', '2020-09-07 15:06:49', NULL, 0);
INSERT INTO `product_evaluate` VALUES (18, 6, 0, '吃爽1231232', 2, 10002, 4.00, '2132313213', '', 0, 0, 0, 0, NULL, '2020-09-07 15:06:49', '2020-09-07 15:06:49', NULL, 0);
INSERT INTO `product_evaluate` VALUES (19, 6, 0, 'f f', 2, 10002, 4.00, '2132313213', '', 0, 0, 0, 0, NULL, '2020-09-07 15:06:49', '2020-09-07 15:06:49', NULL, 0);
INSERT INTO `product_evaluate` VALUES (20, 6, 0, 'a f', 2, 10002, 4.00, '2132313213', '', 0, 0, 0, 0, NULL, '2020-09-07 15:06:49', '2020-09-07 15:06:49', NULL, 0);
INSERT INTO `product_evaluate` VALUES (21, 6, 0, ' fa ', 2, 10002, 4.00, '2132313213', '', 0, 0, 0, 0, NULL, '2020-09-07 15:06:49', '2020-09-07 15:06:49', NULL, 0);
INSERT INTO `product_evaluate` VALUES (22, 6, 0, 'fda ', 2, 10002, 4.00, '2132313213', '', 0, 0, 0, 0, NULL, '2020-09-07 15:06:49', '2020-09-07 15:06:49', NULL, 0);
INSERT INTO `product_evaluate` VALUES (23, 6, 0, '', 2, 10002, 4.00, '2132313213', '', 0, 0, 0, 0, NULL, '2020-09-07 15:06:49', '2020-09-07 15:06:49', NULL, 0);
INSERT INTO `product_evaluate` VALUES (24, 6, 0, '', 2, 10002, 4.00, '2132313213', '', 0, 0, 0, 0, NULL, '2020-09-07 15:06:49', '2020-09-07 15:06:49', NULL, 1);
INSERT INTO `product_evaluate` VALUES (25, 8, 10032, 'DJI 大疆 御 Mavic Air 2 便携可折叠航拍器', 5, 10029, 5.00, '我是评价内容测试', '', 0, 0, 0, 3, NULL, '2020-09-16 16:29:09', '2020-09-16 16:29:09', NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for product_evaluate_img
-- ----------------------------
DROP TABLE IF EXISTS `product_evaluate_img`;
CREATE TABLE `product_evaluate_img` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `eval_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '评价ID',
  `img_url` varchar(1000) NOT NULL DEFAULT '' COMMENT '图片地址',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除标记',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='评价图片';

-- ----------------------------
-- Records of product_evaluate_img
-- ----------------------------
BEGIN;
INSERT INTO `product_evaluate_img` VALUES (1, 1, 'http://yujia.img.cdn.chabug.com/test/image/video/20200907020602931000001252388430.jpeg', '2020-09-07 15:44:04', '2020-09-07 15:44:06', 0);
COMMIT;

-- ----------------------------
-- Table structure for product_tag
-- ----------------------------
DROP TABLE IF EXISTS `product_tag`;
CREATE TABLE `product_tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `prod_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '产品ID',
  `tag_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '标签ID',
  `tag_name` varchar(100) NOT NULL DEFAULT '' COMMENT '标签名（冗余）',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除标记',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='产品标签';

-- ----------------------------
-- Records of product_tag
-- ----------------------------
BEGIN;
INSERT INTO `product_tag` VALUES (1, 6, 1, '测试1', NULL, NULL, 0);
INSERT INTO `product_tag` VALUES (2, 6, 3, '测试3', NULL, NULL, 0);
INSERT INTO `product_tag` VALUES (3, 8, 1, '测试1', '2020-09-12 10:38:41', '2020-09-12 10:38:41', 0);
INSERT INTO `product_tag` VALUES (4, 8, 3, '测试3', '2020-09-12 10:38:41', '2020-09-12 10:38:41', 0);
INSERT INTO `product_tag` VALUES (5, 8, 4, '测试4', '2020-09-12 10:38:41', '2020-09-12 10:38:41', 0);
INSERT INTO `product_tag` VALUES (6, 9, 1, '测试1', '2020-09-12 11:21:12', '2020-09-12 11:21:12', 0);
INSERT INTO `product_tag` VALUES (7, 9, 3, '测试3', '2020-09-12 11:21:12', '2020-09-12 11:21:12', 0);
INSERT INTO `product_tag` VALUES (8, 10, 1, '测试1', '2020-09-13 17:25:43', '2020-09-13 17:25:43', 0);
INSERT INTO `product_tag` VALUES (9, 11, 1, '测试1', '2020-09-14 17:57:58', '2020-09-14 17:57:58', 0);
INSERT INTO `product_tag` VALUES (10, 11, 3, '测试3', '2020-09-14 17:57:58', '2020-09-14 17:57:58', 0);
INSERT INTO `product_tag` VALUES (11, 13, 1, '测试1', '2020-09-21 05:33:27', '2020-09-21 05:33:27', 0);
INSERT INTO `product_tag` VALUES (12, 13, 2, '测试2', '2020-09-21 05:33:27', '2020-09-21 05:33:27', 0);
INSERT INTO `product_tag` VALUES (13, 13, 3, '测试3', '2020-09-21 05:33:27', '2020-09-21 05:33:27', 0);
INSERT INTO `product_tag` VALUES (14, 14, 2, '测试2', '2020-09-29 14:43:26', '2020-09-29 14:43:26', 0);
INSERT INTO `product_tag` VALUES (15, 97, 1, '测试1', '2020-10-14 18:22:34', '2020-10-14 18:22:34', 0);
INSERT INTO `product_tag` VALUES (16, 97, 2, '测试2', '2020-10-14 18:22:34', '2020-10-14 18:22:34', 0);
INSERT INTO `product_tag` VALUES (17, 97, 3, '测试3', '2020-10-14 18:22:34', '2020-10-14 18:22:34', 0);
INSERT INTO `product_tag` VALUES (18, 98, 1, '测试1', '2020-10-15 15:29:03', '2020-10-15 15:29:03', 0);
INSERT INTO `product_tag` VALUES (19, 99, 1, '测试1', '2020-10-15 15:38:03', '2020-10-15 15:38:03', 0);
INSERT INTO `product_tag` VALUES (20, 99, 2, '测试2', '2020-10-15 15:38:03', '2020-10-15 15:38:03', 0);
INSERT INTO `product_tag` VALUES (21, 101, 3, '测试3', '2020-10-16 11:19:37', '2020-10-16 11:19:37', 0);
COMMIT;

-- ----------------------------
-- Table structure for product_trial
-- ----------------------------
DROP TABLE IF EXISTS `product_trial`;
CREATE TABLE `product_trial` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `prod_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '产品ID',
  `prod_user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '产品用户ID',
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '状态',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除标记',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='产品试用';

-- ----------------------------
-- Records of product_trial
-- ----------------------------
BEGIN;
INSERT INTO `product_trial` VALUES (1, 6, 10032, 10032, 1, '2020-09-07 10:52:58', '2020-09-07 10:52:58', 0);
INSERT INTO `product_trial` VALUES (2, 6, 10032, 10002, 3, '2020-09-07 14:06:54', '2020-09-07 14:06:54', 0);
INSERT INTO `product_trial` VALUES (3, 6, 10032, 10032, 1, '2020-09-07 18:28:05', '2020-09-07 18:28:05', 0);
INSERT INTO `product_trial` VALUES (4, 5, 10032, 10032, 0, '2020-09-11 15:25:14', '2020-09-11 15:25:14', 0);
INSERT INTO `product_trial` VALUES (5, 8, 10032, 10029, 3, '2020-09-16 16:27:06', '2020-09-16 16:27:06', 0);
INSERT INTO `product_trial` VALUES (6, 2, 10032, 10032, 0, '2020-09-16 16:59:08', '2020-09-16 16:59:08', 0);
INSERT INTO `product_trial` VALUES (7, 13, 10032, 10037, 1, '2020-09-25 19:14:51', '2020-09-25 19:14:51', 0);
INSERT INTO `product_trial` VALUES (8, 97, 10032, 10032, 0, '2020-10-14 18:24:26', '2020-10-14 18:24:26', 0);
INSERT INTO `product_trial` VALUES (9, 69, 10056, 10032, 1, '2020-10-16 17:32:20', '2020-10-16 17:32:20', 0);
INSERT INTO `product_trial` VALUES (10, 92, 10056, 10032, 0, '2020-10-21 14:42:25', '2020-10-21 14:42:25', 0);
COMMIT;

-- ----------------------------
-- Table structure for product_video
-- ----------------------------
DROP TABLE IF EXISTS `product_video`;
CREATE TABLE `product_video` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `prod_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '产品ID',
  `video_url` varchar(1000) NOT NULL DEFAULT '' COMMENT '视频地址',
  `duration` int(11) NOT NULL DEFAULT '0' COMMENT '视频时长',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除标记',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8 COMMENT='产品视频';

-- ----------------------------
-- Records of product_video
-- ----------------------------
BEGIN;
INSERT INTO `product_video` VALUES (1, 6, 'http://yujia.img.cdn.chabug.com/test/image/video/20200907020552524000001174988452.mp4', 0, NULL, NULL, 0);
INSERT INTO `product_video` VALUES (2, 10, 'http://yujia.img.cdn.chabug.com/test/image/video/20200913172443156000000149765364.mp4', 0, '2020-09-13 17:25:43', '2020-09-13 17:25:43', 0);
INSERT INTO `product_video` VALUES (3, 10, 'http://yujia.img.cdn.chabug.com/test/image/video/20200913172443156000000149765364.mp4', 0, '2020-09-13 17:25:43', '2020-09-13 17:25:43', 0);
INSERT INTO `product_video` VALUES (4, 11, 'http://yujia.img.cdn.chabug.com/test/image/video/20200914175701982000000366588590.mp4', 60, '2020-09-14 17:58:07', '2020-09-14 17:58:07', 0);
INSERT INTO `product_video` VALUES (5, 13, 'http://yujia.img.cdn.chabug.com/test/image/video/20200921053301791000000362406932.mp4', 60, '2020-09-21 05:33:31', '2020-09-21 05:33:31', 0);
INSERT INTO `product_video` VALUES (6, 14, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (7, 15, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (8, 16, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (9, 17, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (10, 18, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (11, 19, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (12, 20, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (13, 21, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (14, 22, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (15, 23, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (16, 24, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (17, 25, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (18, 26, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (19, 27, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (20, 28, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (21, 29, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (22, 30, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (23, 31, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (24, 32, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (25, 33, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (26, 34, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (27, 35, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (28, 36, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (29, 37, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (30, 38, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (31, 39, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (32, 40, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (33, 41, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (34, 42, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (35, 43, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (36, 44, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (37, 45, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (38, 46, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (39, 47, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (40, 48, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (41, 49, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (42, 50, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (43, 51, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (44, 52, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (45, 53, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (46, 54, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (47, 55, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (48, 56, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (49, 57, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (50, 58, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (51, 51, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (52, 52, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (53, 53, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (54, 54, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (55, 55, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (56, 56, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (57, 57, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (58, 58, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (59, 59, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (60, 60, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (61, 61, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (62, 62, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (63, 63, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (64, 64, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (65, 65, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (66, 66, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (67, 67, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (68, 68, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (69, 69, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (70, 70, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (71, 71, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (72, 72, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (73, 73, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (74, 74, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (75, 75, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (76, 76, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (77, 77, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (78, 78, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (79, 79, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (80, 80, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (81, 81, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (82, 82, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (83, 83, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (84, 84, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (85, 85, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (86, 86, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (87, 96, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (93, 99, 'http://yujia.img.cdn.chabug.com/test/image/video/20200929144200146000001177734898.mp4', 60, '2020-09-29 14:43:34', '2020-09-29 14:43:34', 0);
INSERT INTO `product_video` VALUES (94, 102, 'http://yujia.img.cdn.chabug.com/test/image/video/20201016114205999000000397796065.mp4', 60, '2020-10-16 11:43:19', '2020-10-16 11:43:19', 0);
COMMIT;

-- ----------------------------
-- Table structure for recharge_record
-- ----------------------------
DROP TABLE IF EXISTS `recharge_record`;
CREATE TABLE `recharge_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `price` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '金额',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '交易类型',
  `content` varchar(2000) NOT NULL DEFAULT '' COMMENT '描述',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='充值记录';

-- ----------------------------
-- Records of recharge_record
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for space
-- ----------------------------
DROP TABLE IF EXISTS `space`;
CREATE TABLE `space` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `total_size` bigint(20) NOT NULL DEFAULT '0' COMMENT '总大小',
  `used_size` bigint(20) NOT NULL DEFAULT '0' COMMENT '已用大小',
  `free_size` bigint(20) NOT NULL DEFAULT '0' COMMENT '空闲大小',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='空间管理';

-- ----------------------------
-- Records of space
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for tags
-- ----------------------------
DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '分类',
  `tag_name` varchar(100) NOT NULL DEFAULT '' COMMENT '标签名',
  `tag_code` varchar(100) NOT NULL DEFAULT '' COMMENT '标签编码',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='标签';

-- ----------------------------
-- Records of tags
-- ----------------------------
BEGIN;
INSERT INTO `tags` VALUES (1, 0, '测试1', 'test1', '2020-09-06 19:36:41', '2020-09-06 19:36:42', 0);
INSERT INTO `tags` VALUES (2, 0, '测试2', 'test2', '2020-09-06 19:36:41', '2020-09-06 19:36:42', 0);
INSERT INTO `tags` VALUES (3, 0, '测试3', 'test3', '2020-09-06 19:36:41', '2020-09-06 19:36:42', 0);
INSERT INTO `tags` VALUES (4, 0, '测试4', 'test4', '2020-09-06 19:36:41', '2020-09-06 19:36:42', 0);
INSERT INTO `tags` VALUES (5, 0, '测试51', 'test51', '2020-09-06 19:36:41', '2020-10-09 11:55:06', 1);
COMMIT;

-- ----------------------------
-- Table structure for tb_sys_industry_category
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_industry_category`;
CREATE TABLE `tb_sys_industry_category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父类型',
  `type` varchar(16) DEFAULT NULL COMMENT '经营类型(虚拟|实体)',
  `code` int(12) DEFAULT NULL COMMENT '类别编码',
  `name` varchar(64) DEFAULT NULL COMMENT '行业名称',
  `status` tinyint(2) DEFAULT NULL COMMENT '状态',
  `created_time` bigint(20) DEFAULT NULL,
  `created_by` bigint(20) DEFAULT NULL,
  `updated_time` bigint(20) DEFAULT NULL,
  `updated_by` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=312 DEFAULT CHARSET=utf8mb4 COMMENT='商户行业类别';

-- ----------------------------
-- Records of tb_sys_industry_category
-- ----------------------------
BEGIN;
INSERT INTO `tb_sys_industry_category` VALUES (1, 0, NULL, NULL, '个体工商户', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (2, 1, NULL, NULL, '保险', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (3, 2, '虚拟', 246, '保险代理公司', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (4, 2, '虚拟', 248, '保险公估公司', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (5, 2, '虚拟', 249, '保险兼业代理公司', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (6, 2, '虚拟', 247, '保险经纪公司', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (7, 1, NULL, NULL, '彩票', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (8, 7, '虚拟', 211, '彩票', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (9, 1, NULL, NULL, '餐饮/食品', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (10, 9, '实体', 145, '保健品/滋补品', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (11, 9, '实体', 212, '餐饮', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (12, 9, '实体', 144, '普通食品', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (13, 1, NULL, NULL, '房地产', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (14, 13, '虚拟', 488, '房屋中介', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (15, 1, NULL, NULL, '公共事业缴费', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (16, 15, '虚拟', 394, '水电煤缴费/交通罚款等生活缴费', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (17, 1, NULL, NULL, '机票/旅游', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (18, 17, '实体', 178, '机票代理', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (19, 17, '实体', 179, '旅馆/酒店/景区/度假区', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (20, 17, '实体', 176, '旅行社', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (21, 1, NULL, NULL, '机械/电子', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (22, 21, '实体', 304, '保健器械', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (23, 21, '实体', 306, '电子元器件/仪器仪表/机械设备及配件', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (24, 21, '实体', 305, '医疗器械', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (25, 1, NULL, NULL, '交通运输服务类', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (26, 25, '实体', 495, '道路运输', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (27, 25, '实体', 498, '港口经营港口理货', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (28, 25, '实体', 497, '海运', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (29, 25, '实体', 499, '航空运输', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (30, 25, '实体', 496, '水路运输', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (31, 25, '实体', 494, '铁路货物运输', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (32, 25, '实体', 489, '租车', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (33, 1, NULL, NULL, '教育/培训', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (34, 33, '虚拟', 159, '教育/培训/考试缴费/学费', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (35, 33, '虚拟', 333, '私立院校', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (36, 1, NULL, NULL, '金融', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (37, 36, '虚拟', 433, '财经资讯', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (38, 36, '虚拟', 434, '股票软件类', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (39, 1, NULL, NULL, '快递/货运服务', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (40, 39, '实体', 413, '物流/快递公司', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (41, 1, NULL, NULL, '苗木/绿化', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (42, 41, '实体', 314, '苗木种植', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (43, 41, '实体', 315, '园林绿化', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (44, 1, NULL, NULL, '母婴/玩具', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (45, 44, '实体', 158, '母婴类商城', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (46, 44, '实体', 157, '母婴用品/儿童玩具', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (47, 1, NULL, NULL, '票务', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (48, 47, '虚拟', 164, '火车票/船票/车票等交通票务', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (49, 47, '虚拟', 163, '影票/演唱会/赛事等娱乐票务', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (50, 1, NULL, NULL, '其他', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (51, 50, '实体', 292, '其他行业', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (52, 1, NULL, NULL, '其他生活缴费', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (53, 52, '虚拟', 316, '城市交通卡缴费', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (54, 52, '虚拟', 317, '其他生活缴费', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (55, 52, '虚拟', 308, '停车场', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (56, 52, '虚拟', 309, '物业管理费', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (57, 52, '虚拟', 307, '有线电视缴费', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (58, 1, NULL, NULL, '软件', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (59, 58, '虚拟', 273, '软件', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (60, 1, NULL, NULL, '生活/家居', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (61, 60, '实体', 149, '工艺品/盆栽/室内装饰品', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (62, 60, '实体', 147, '计生用品', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (63, 60, '实体', 143, '家居/建材/装饰/布艺类商城', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (64, 60, '实体', 146, '家用电器', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (65, 60, '实体', 148, '美妆/护肤/个人护理', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (66, 60, '实体', 153, '汽车/摩托/自行车/其他交通工具/配件/改装', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (67, 1, NULL, NULL, '生活/咨询服务', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (68, 67, '实体', 476, '办证/刻章', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (69, 67, '虚拟', 474, '广告公司', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (70, 67, '虚拟', 475, '会展服务/活动策划', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (71, 67, '虚拟', 471, '家政/婚庆服务/摄影服务', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (72, 67, '实体', 477, '开锁工具', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (73, 67, '虚拟', 224, '人才中介机构/招聘/猎头', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (74, 67, '虚拟', 473, '丧葬行业', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (75, 67, '虚拟', 472, '印刷/维修服务/排版/刻板', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (76, 67, '虚拟', 225, '职业社交/婚介/交友', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (77, 67, '虚拟', 470, '咨询/法律咨询/金融咨询等', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (78, 1, NULL, NULL, '时尚', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (79, 78, '实体', 111, '服饰类商城/服饰配件/箱包', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (80, 78, '实体', 113, '户外/运动/健身器材/安防', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (81, 78, '实体', 116, '黄金珠宝/钻石/玉石', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (82, 78, '实体', 114, '乐器', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (83, 78, '实体', 112, '礼品/鲜花/纪念品', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (84, 78, '实体', 117, '饰品', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (85, 78, '实体', 115, '手表/钟表/眼镜', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (86, 1, NULL, NULL, '收藏/宠物', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (87, 86, '实体', 196, '宠物/宠物食品', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (88, 86, '实体', 197, '非文物类收藏品', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (89, 86, '实体', 186, '文物复制品销售/典当', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (90, 86, '实体', 198, '文物经营', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (91, 86, '实体', 199, '文物拍卖', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (92, 1, NULL, NULL, '书籍/音像/文具', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (93, 92, '实体', 184, '书籍/音像', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (94, 92, '实体', 185, '文具', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (95, 1, NULL, NULL, '数码', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (96, 95, '实体', 214, '办公设备', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (97, 95, '实体', 213, '数码产品', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (98, 1, NULL, NULL, '数字娱乐', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (99, 98, '虚拟', 282, '彩铃', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (100, 1, NULL, NULL, '通信', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (101, 100, '虚拟', 425, '话费通讯', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (102, 100, '虚拟', 424, '宽带收费', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (103, 1, NULL, NULL, '网络虚拟服务', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (104, 103, '虚拟', 266, '门户/资讯/论坛', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (105, 103, '虚拟', 267, '视频/网络小说/在线图书/音乐', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (106, 103, '虚拟', 269, '搜索引擎/网络广告/网络推广/视频制作', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (107, 103, '虚拟', 272, '游戏/点卡/金币', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (108, 103, '虚拟', 268, '域名/建站/主机/代码', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (109, 1, NULL, NULL, '线下零售', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (110, 109, '实体', 487, '便利店', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (111, 109, '实体', 486, '其他综合零售', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (112, 1, NULL, NULL, '医疗', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (113, 112, '虚拟', 329, '保健信息咨询/心理咨询/体检卡', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (114, 112, '实体', 395, '亲子鉴定/催眠', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (115, 112, '实体', 378, '私立/民营医院/诊所', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (116, 112, '实体', 328, '药品', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (117, 1, NULL, NULL, '娱乐/健身服务', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (118, 117, '虚拟', 345, '俱乐部/高尔夫球场/休闲会所', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (119, 117, '虚拟', 344, '美容/健身类会所', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (120, 117, '虚拟', 346, '游艺厅/KTV/网吧', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (121, 1, NULL, NULL, '装饰', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (122, 121, '虚拟', 322, '室内装饰设计服务', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (123, 0, NULL, NULL, '企业', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (124, 123, NULL, NULL, '保险', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (125, 124, '虚拟', 242, '保险代理公司', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (126, 124, '虚拟', 244, '保险公估公司', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (127, 124, '虚拟', 241, '保险公司', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (128, 124, '虚拟', 245, '保险兼业代理公司', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (129, 124, '虚拟', 243, '保险经纪公司', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (130, 123, NULL, NULL, '彩票', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (131, 130, '虚拟', 210, '彩票', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (132, 123, NULL, NULL, '餐饮/食品', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (133, 132, '实体', 133, '保健品/滋补品', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (134, 132, '实体', 135, '餐饮', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (135, 132, '实体', 132, '普通食品', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (136, 123, NULL, NULL, '电商/团购', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (137, 136, '虚拟', 392, '海淘', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (138, 136, '虚拟', 391, '团购', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (139, 136, '虚拟', 393, '线上商超', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (140, 123, NULL, NULL, '房地产', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (141, 140, '虚拟', 326, '房产预售', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (142, 140, '虚拟', 327, '房屋中介', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (143, 123, NULL, NULL, '公共事业缴费', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (144, 143, '虚拟', 351, '水电煤缴费/交通罚款等生活缴费', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (145, 123, NULL, NULL, '公益', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (146, 145, '虚拟', 250, '公益', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (147, 123, NULL, NULL, '机票/旅游', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (148, 147, '实体', 173, '航空公司', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (149, 147, '实体', 174, '机票代理', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (150, 147, '实体', 175, '旅馆/酒店/景区/度假区', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (151, 147, '实体', 171, '旅行社', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (152, 147, '实体', 172, '旅游服务平台', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (153, 123, NULL, NULL, '机械/电子', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (154, 153, '实体', 301, '保健器械', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (155, 153, '实体', 303, '电子元器件/仪器仪表/机械设备及配件', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (156, 153, '实体', 302, '医疗器械', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (157, 123, NULL, NULL, '交通运输服务类', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (158, 157, '实体', 372, '道路运输', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (159, 157, '实体', 375, '港口经营港口理货', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (160, 157, '实体', 374, '海运', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (161, 157, '实体', 376, '航空运输', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (162, 157, '实体', 373, '水路运输', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (163, 157, '实体', 371, '铁路货物运输', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (164, 157, '实体', 377, '租车', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (165, 123, NULL, NULL, '教育/培训', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (166, 165, '实体', 154, '教育/培训/考试缴费/学费', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (167, 165, '虚拟', 332, '私立院校', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (168, 123, NULL, NULL, '金融', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (169, 168, '虚拟', 431, '财经资讯', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (170, 168, '虚拟', 432, '股票软件类', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (171, 123, NULL, NULL, '境外', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (172, 171, '实体', 435, '境外', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (173, 123, NULL, NULL, '快递/货运服务', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (174, 173, '实体', 411, '物流/快递公司', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (175, 123, NULL, NULL, '苗木/绿化', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (176, 175, '实体', 313, '化肥/农用药剂等', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (177, 175, '实体', 311, '苗木种植', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (178, 175, '实体', 312, '园林绿化', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (179, 123, NULL, NULL, '母婴/玩具', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (180, 179, '实体', 152, '母婴类商城', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (181, 179, '实体', 151, '母婴用品/儿童玩具', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (182, 123, NULL, NULL, '票务', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (183, 182, '虚拟', 162, '火车票/船票/车票等交通票务', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (184, 182, '虚拟', 161, '影票/演唱会/赛事等娱乐票务', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (185, 123, NULL, NULL, '平台商', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (186, 185, '虚拟', 437, '平台商', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (187, 123, NULL, NULL, '其他', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (188, 187, '实体', 291, '其他行业', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (189, 123, NULL, NULL, '其他生活缴费', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (190, 189, '虚拟', 357, '城市交通卡缴费', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (191, 189, '虚拟', 358, '其他生活缴费', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (192, 189, '虚拟', 355, '停车场', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (193, 189, '虚拟', 356, '物业管理费', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (194, 189, '虚拟', 354, '有线电视缴费', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (195, 123, NULL, NULL, '软件', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (196, 195, '虚拟', 270, '软件', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (197, 123, NULL, NULL, '生活/家居', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (198, 197, '实体', 139, '工艺品/盆栽/室内装饰品', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (199, 197, '实体', 137, '计生用品', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (200, 197, '实体', 131, '家居/建材/装饰/布艺类商城', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (201, 197, '实体', 134, '家用电器', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (202, 197, '实体', 136, '美妆/护肤/个人护理', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (203, 197, '实体', 138, '汽车/摩托/自行车/其他交通工具/配件/改装', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (204, 123, NULL, NULL, '生活/咨询服务', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (205, 204, '实体', 407, '办证/刻章', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (206, 204, '实体', 409, '报社/出版社', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (207, 204, '实体', 410, '电台/电视台', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (208, 204, '虚拟', 405, '广告公司', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (209, 204, '虚拟', 406, '会展服务/活动策划', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (210, 204, '虚拟', 402, '家政/婚庆服务/摄影服务', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (211, 204, '实体', 408, '开锁工具', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (212, 204, '虚拟', 221, '人才中介机构/招聘/猎头', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (213, 204, '虚拟', 404, '丧葬行业', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (214, 204, '虚拟', 223, '网上生活服务平台', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (215, 204, '虚拟', 403, '印刷/维修服务/排版/刻板', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (216, 204, '虚拟', 222, '职业社交/婚介/交友', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (217, 204, '虚拟', 401, '咨询/法律咨询/金融咨询等', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (218, 123, NULL, NULL, '时尚', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (219, 218, '实体', 121, '服饰类商城/服饰配件/箱包', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (220, 218, '实体', 123, '户外/运动/健身器材/安防', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (221, 218, '实体', 126, '黄金珠宝/钻石/玉石', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (222, 218, '实体', 124, '乐器', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (223, 218, '实体', 122, '礼品/鲜花/纪念品', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (224, 218, '实体', 127, '饰品', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (225, 218, '实体', 125, '手表/钟表/眼镜', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (226, 123, NULL, NULL, '收藏/宠物', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (227, 226, '实体', 191, '宠物/宠物食品', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (228, 226, '实体', 192, '非文物类收藏品', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (229, 226, '实体', 195, '文物复制品销售/典当', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (230, 226, '实体', 193, '文物经营', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (231, 226, '实体', 194, '文物拍卖', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (232, 123, NULL, NULL, '书籍/音像/文具', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (233, 232, '实体', 181, '书籍/音像', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (234, 232, '实体', 182, '文具', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (235, 123, NULL, NULL, '数码', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (236, 235, '实体', 142, '办公设备', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (237, 235, '实体', 141, '数码产品', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (238, 123, NULL, NULL, '数字娱乐', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (239, 238, '虚拟', 281, '彩铃', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (240, 238, '虚拟', 280, '企业/数字娱乐', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (241, 123, NULL, NULL, '通信', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (242, 241, '虚拟', 421, '电信运营商', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (243, 241, '虚拟', 423, '话费通讯', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (244, 241, '虚拟', 422, '宽带收费', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (245, 123, NULL, NULL, '网络虚拟服务', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (246, 245, '虚拟', 261, '门户/资讯/论坛', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (247, 245, '虚拟', 262, '视频/网络小说/在线图书/音乐', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (248, 245, '虚拟', 264, '搜索引擎/网络广告/网络推广/视频制作', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (249, 245, '虚拟', 265, '游戏/点卡/金币', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (250, 245, '虚拟', 263, '域名/建站/主机/代码', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (251, 123, NULL, NULL, '线下零售', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (252, 251, '实体', 384, '百货', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (253, 251, '实体', 382, '便利店', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (254, 251, '实体', 381, '超市', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (255, 251, '实体', 385, '其他综合零售', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (256, 251, '实体', 383, '自动贩卖机', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (257, 123, NULL, NULL, '医疗', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (258, 257, '虚拟', 362, '保健信息咨询/心理咨询/体检卡', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (259, 257, '虚拟', 364, '挂号平台', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (260, 257, '虚拟', 365, '亲子鉴定/催眠', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (261, 257, '实体', 363, '私立/民营医院/诊所', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (262, 257, '实体', 361, '药品', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (263, 257, '实体', 366, '中草药原材料', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (264, 123, NULL, NULL, '娱乐/健身服务', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (265, 264, '虚拟', 342, '俱乐部/高尔夫球场/休闲会所', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (266, 264, '虚拟', 341, '美容/健身类会所', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (267, 264, '虚拟', 343, '游艺厅/KTV/网吧', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (268, 123, NULL, NULL, '预付卡', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (269, 268, '虚拟', 439, '单用途预付卡', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (270, 123, NULL, NULL, '直销', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (271, 270, '实体', 436, '直销业务', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (272, 123, NULL, NULL, '众筹', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (273, 272, '虚拟', 438, '众筹', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (274, 123, NULL, NULL, '装饰', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (275, 274, '虚拟', 321, '室内装饰设计服务', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (276, 0, NULL, NULL, '事业单位', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (277, 276, NULL, NULL, '公共事业缴费', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (278, 277, '虚拟', 353, '事业单位', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (279, 277, '虚拟', 359, '水电煤缴费/交通罚款等生活缴费', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (280, 277, '虚拟', 352, '政府机构', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (281, 276, NULL, NULL, '机票/旅游', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (282, 281, '实体', 183, '旅馆/酒店/景区/度假区', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (283, 281, '实体', 177, '旅游服务平台', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (284, 276, NULL, NULL, '交通运输服务类', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (285, 284, '实体', 397, '道路运输', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (286, 284, '实体', 491, '港口经营港口理货', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (287, 284, '实体', 399, '海运', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (288, 284, '实体', 492, '航空运输', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (289, 284, '实体', 398, '水路运输', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (290, 284, '实体', 396, '铁路货物运输', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (291, 284, '实体', 493, '租车', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (292, 276, NULL, NULL, '教育/培训', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (293, 292, '虚拟', 331, '公立院校', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (294, 276, NULL, NULL, '快递/货运服务', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (295, 294, '实体', 412, '物流/快递公司', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (296, 276, NULL, NULL, '票务', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (297, 296, '虚拟', 165, '火车票/船票/车票等交通票务', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (298, 276, NULL, NULL, '其他生活缴费', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (299, 298, '虚拟', 324, '城市交通卡缴费', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (300, 298, '虚拟', 325, '其他生活缴费', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (301, 298, '虚拟', 319, '停车场', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (302, 298, '虚拟', 323, '物业管理费', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (303, 298, '虚拟', 318, '有线电视缴费', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (304, 276, NULL, NULL, '生活/咨询服务', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (305, 304, '虚拟', 478, '报社/出版社', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (306, 304, '虚拟', 479, '电台/电视台', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (307, 276, NULL, NULL, '医疗', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (308, 307, '虚拟', 369, '保健信息咨询/心理咨询/体检卡', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (309, 307, '实体', 367, '公立医院', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (310, 307, '虚拟', 379, '挂号平台', 0, 20171113150226, NULL, NULL, NULL);
INSERT INTO `tb_sys_industry_category` VALUES (311, 307, '实体', 368, '药品', 0, 20171113150226, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(100) NOT NULL DEFAULT '' COMMENT '用户名',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '姓名',
  `head_img` varchar(1000) NOT NULL DEFAULT '' COMMENT '头像',
  `company_name` varchar(100) NOT NULL DEFAULT '' COMMENT '公司名',
  `passwd` varchar(100) NOT NULL DEFAULT '' COMMENT '密码',
  `sex` tinyint(1) NOT NULL DEFAULT '0' COMMENT '性别',
  `phone` varchar(50) NOT NULL DEFAULT '' COMMENT '手机号',
  `email` varchar(100) NOT NULL DEFAULT '' COMMENT '邮箱',
  `id_type` int(11) NOT NULL DEFAULT '0' COMMENT '证件类型',
  `id_card` varchar(50) NOT NULL DEFAULT '' COMMENT '证件号码',
  `role` int(11) NOT NULL DEFAULT '0' COMMENT '账户角色',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '账户类型',
  `gmt_register` datetime DEFAULT NULL COMMENT '注册时间',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除标记',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12290 DEFAULT CHARSET=utf8 COMMENT='用户';

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES (10001, '', 'ceshi', '', '', '363a4d530d1367ff723e48af256f0049', 1, '12388889999', '', 0, '', 0, 0, '2020-08-07 15:08:04', '2020-08-07 15:08:04', '2020-09-02 15:17:29', 0);
INSERT INTO `user` VALUES (10002, '', '123', '', '', '363a4d530d1367ff723e48af256f0049', 0, '13329800358', '', 0, '321', 0, 0, '2020-09-01 17:31:57', '2020-09-01 17:31:57', '2020-09-01 17:31:57', 0);
INSERT INTO `user` VALUES (10003, '', '123', '', '', 'f28dbf2733030574fb5cad6e1cc4f0d1', 0, '13329800359', '', 0, '31', 0, 0, '2020-09-01 17:32:47', '2020-09-01 17:32:47', '2020-09-01 17:32:47', 0);
INSERT INTO `user` VALUES (10005, '', '231321', '', '', 'f28dbf2733030574fb5cad6e1cc4f0d1', 0, '13329800001', '', 0, '321321', 0, 0, '2020-09-01 17:33:59', '2020-09-01 17:33:59', '2020-09-01 17:33:59', 0);
INSERT INTO `user` VALUES (10006, '', '123', '', '', '73956690c8b36d2fbd21b19c7fd41b44', 0, '13329800002', '', 1, '321', 0, 2, '2020-09-01 17:36:04', '2020-09-01 17:36:04', '2020-09-01 17:36:04', 0);
INSERT INTO `user` VALUES (10007, '', '23132', '', '', 'f28dbf2733030574fb5cad6e1cc4f0d1', 0, '13329800003', '', 0, '321321', 0, 0, '2020-09-01 17:57:14', '2020-09-01 17:57:14', '2020-09-01 17:57:14', 0);
INSERT INTO `user` VALUES (10008, '', '测试数据1', '', '', 'f28dbf2733030574fb5cad6e1cc4f0d1', 0, '13329800301', '', 1, '321321321', 0, 0, '2020-09-01 17:58:04', '2020-09-01 17:58:04', '2020-09-01 17:58:04', 0);
INSERT INTO `user` VALUES (10009, '', '测试', '', '', 'f28dbf2733030574fb5cad6e1cc4f0d1', 0, '13329800032', '', 1, '321321', 0, 1, '2020-09-01 18:03:55', '2020-09-01 18:03:55', '2020-09-01 18:03:55', 0);
INSERT INTO `user` VALUES (10010, '', '测试', '', '', 'f28dbf2733030574fb5cad6e1cc4f0d1', 0, '13329800033', '', 1, '123', 0, 1, '2020-09-01 19:28:21', '2020-09-01 19:28:21', '2020-09-01 19:28:21', 0);
INSERT INTO `user` VALUES (10011, '', 'fdafdafsd', '', '', 'f28dbf2733030574fb5cad6e1cc4f0d1', 0, '13329800354', '', 0, '123', 0, 0, '2020-09-01 20:35:41', '2020-09-01 20:35:41', '2020-09-01 20:35:41', 0);
INSERT INTO `user` VALUES (10012, '', '123232', '', '', 'f28dbf2733030574fb5cad6e1cc4f0d1', 0, '13329800036', '', 1, '321', 0, 1, '2020-09-01 22:40:01', '2020-09-01 22:40:01', '2020-09-01 22:40:01', 0);
INSERT INTO `user` VALUES (10013, '', '测试2222222', '', '', 'f28dbf2733030574fb5cad6e1cc4f0d1', 0, '13329800356', '', 1, '34234', 0, 1, '2020-09-01 23:14:01', '2020-09-01 23:14:01', '2020-09-01 23:14:01', 0);
INSERT INTO `user` VALUES (10015, '', '测试', '', '', 'f28dbf2733030574fb5cad6e1cc4f0d1', 0, '13329800037', '', 1, '123', 0, 1, '2020-09-02 10:24:36', '2020-09-02 10:24:36', '2020-09-02 10:24:36', 0);
INSERT INTO `user` VALUES (10016, '', 'fdffdfd', '', '', 'f28dbf2733030574fb5cad6e1cc4f0d1', 0, '13329800038', '', 1, '32', 0, 1, '2020-09-02 10:27:15', '2020-09-02 10:27:15', '2020-09-02 10:27:15', 0);
INSERT INTO `user` VALUES (10017, '', '发顺丰', '', '', 'f28dbf2733030574fb5cad6e1cc4f0d1', 0, '13329800039', '', 0, '321', 0, 0, '2020-09-02 10:29:26', '2020-09-02 10:29:26', '2020-09-02 10:29:26', 0);
INSERT INTO `user` VALUES (10018, '', '测试3', '', '', 'f28dbf2733030574fb5cad6e1cc4f0d1', 0, '13329800398', '', 1, '3213', 0, 2, '2020-09-02 10:48:38', '2020-09-02 10:48:38', '2020-09-02 10:48:38', 0);
INSERT INTO `user` VALUES (10019, '', 'fdafda', '', '', 'f28dbf2733030574fb5cad6e1cc4f0d1', 0, '13329800041', '', 0, '321', 0, 0, '2020-09-02 11:03:37', '2020-09-02 11:03:37', '2020-09-02 11:03:37', 0);
INSERT INTO `user` VALUES (10020, '', '测试请求', '', '', 'f28dbf2733030574fb5cad6e1cc4f0d1', 0, '13329800042', '', 0, '1232132', 0, 0, '2020-09-02 11:33:41', '2020-09-02 11:33:41', '2020-09-02 11:33:41', 0);
INSERT INTO `user` VALUES (10021, '', '放大范德萨发', '', '', 'f28dbf2733030574fb5cad6e1cc4f0d1', 0, '13329800043', '', 0, '3213', 0, 0, '2020-09-02 11:38:33', '2020-09-02 11:38:33', '2020-09-02 11:38:33', 0);
INSERT INTO `user` VALUES (10022, '', '13231', '', '', 'f28dbf2733030574fb5cad6e1cc4f0d1', 0, '13329800381', '', 0, '31321', 0, 0, '2020-09-02 11:44:48', '2020-09-02 11:44:48', '2020-09-02 11:44:48', 0);
INSERT INTO `user` VALUES (10023, '', 'fdafda', '', '', 'f28dbf2733030574fb5cad6e1cc4f0d1', 0, '13329800567', '', 0, '321', 0, 0, '2020-09-02 11:45:34', '2020-09-02 11:45:34', '2020-09-02 11:45:34', 0);
INSERT INTO `user` VALUES (10025, '', '3213', '', '', 'f28dbf2733030574fb5cad6e1cc4f0d1', 0, '13329838331', '', 0, '321', 0, 0, '2020-09-02 11:46:41', '2020-09-02 11:46:41', '2020-09-02 11:46:41', 0);
INSERT INTO `user` VALUES (10026, '', 'f132', '', '', 'f28dbf2733030574fb5cad6e1cc4f0d1', 0, '18912345678', '', 0, '321', 0, 0, '2020-09-02 11:48:05', '2020-09-02 11:48:05', '2020-09-02 11:48:05', 0);
INSERT INTO `user` VALUES (10027, '', '32', '', '', 'f28dbf2733030574fb5cad6e1cc4f0d1', 0, '18912345679', '', 0, '321', 0, 0, '2020-09-02 11:49:38', '2020-09-02 11:49:38', '2020-09-02 11:49:38', 0);
INSERT INTO `user` VALUES (10028, '', '321321', '', '', 'f28dbf2733030574fb5cad6e1cc4f0d1', 0, '18923456789', '', 0, '321', 0, 0, '2020-09-02 11:51:38', '2020-09-02 11:51:38', '2020-09-02 11:51:38', 0);
INSERT INTO `user` VALUES (10029, '', '321', '', '', '363a4d530d1367ff723e48af256f0049', 0, '18934567890', '', 0, '', 0, 0, '2020-09-02 14:38:13', '2020-09-02 14:38:13', '2020-09-02 14:38:13', 0);
INSERT INTO `user` VALUES (10030, '', '321', '', '公司名', 'f28dbf2733030574fb5cad6e1cc4f0d1', 0, '18968123456', '123', 0, '', 1, 1, '2020-09-03 14:08:19', '2020-09-03 14:08:19', '2020-09-03 14:08:19', 0);
INSERT INTO `user` VALUES (10031, '', '321321', '', '放大放大', 'f28dbf2733030574fb5cad6e1cc4f0d1', 0, '18968112345', '12321', 0, '', 1, 2, '2020-09-03 14:21:59', '2020-09-03 14:21:59', '2020-09-03 14:21:59', 0);
INSERT INTO `user` VALUES (10032, '', '3213', 'http://yujia.img.cdn.chabug.com/test/image/head/20201013175249901000000348662707.png', '我是公司名称', 'f28dbf2733030574fb5cad6e1cc4f0d1', 0, '18968113232', '321321', 1, '', 1, 1, '2020-09-03 14:26:45', '2020-09-03 14:26:45', '2020-10-13 17:52:52', 0);
INSERT INTO `user` VALUES (10033, '', '测试账号', '', '', '363a4d530d1367ff723e48af256f0049', 0, '13328800123', '', 1, '420599199311090012', 0, 0, '2020-09-25 16:45:43', '2020-09-25 16:45:43', '2020-09-25 16:45:43', 0);
INSERT INTO `user` VALUES (10036, '', '123', '', '', '363a4d530d1367ff723e48af256f0049', 0, '13329800099', '', 1, '420599199311090012', 0, 0, '2020-09-25 17:34:58', '2020-09-25 17:34:58', '2020-09-25 17:34:58', 0);
INSERT INTO `user` VALUES (10037, '', '芒大果', '', '', '29333a28f1a725ae55aca9155bedd0f2', 0, '15999999999', '', 1, '330105199811083242', 0, 0, '2020-09-25 18:07:10', '2020-09-25 18:07:10', '2020-09-25 18:07:10', 0);
INSERT INTO `user` VALUES (10038, '', '张三', '', '测试公司1', 'f28dbf2733030574fb5cad6e1cc4f0d1', 0, '15900188222', 'zhonglei2612@163.com', 0, '', 1, 1, '2020-09-25 19:34:56', '2020-09-25 19:34:56', '2020-09-25 19:34:56', 0);
INSERT INTO `user` VALUES (10039, '', '测试', '', '', '363a4d530d1367ff723e48af256f0049', 0, '18968551234', '', 1, '420582199809090032', 0, 0, '2020-09-27 14:45:04', '2020-09-27 14:45:04', '2020-09-27 14:45:04', 0);
INSERT INTO `user` VALUES (10050, '', '张三', '', '', '363a4d530d1367ff723e48af256f0049', 0, '18968121234', '', 1, '420582199809090033', 0, 0, '2020-09-27 14:53:32', '2020-09-27 14:53:32', '2020-09-27 14:53:32', 0);
INSERT INTO `user` VALUES (10051, '', '张三', '', '', '363a4d530d1367ff723e48af256f0049', 0, '18968811307', '1234567@qq.com', 0, '', 0, 0, '2020-09-28 14:31:40', '2020-09-28 14:31:40', '2020-09-28 14:31:40', 0);
INSERT INTO `user` VALUES (10052, 'test', '', 'http://yujia.img.cdn.chabug.com/test/image/head/20200928152713451000000729654527.jpg', '', '363a4d530d1367ff723e48af256f0049', 0, '18977731234', '123@qq.com', 0, '', 0, 0, '2020-09-28 14:53:55', '2020-09-28 14:53:55', '2020-09-28 15:27:17', 0);
INSERT INTO `user` VALUES (10053, 'test2', '', '', '', '363a4d530d1367ff723e48af256f0049', 0, '13329900345', '123@qq.com', 0, '', 0, 0, '2020-09-28 16:00:23', '2020-09-28 16:00:23', '2020-09-28 16:00:23', 0);
INSERT INTO `user` VALUES (10055, 'test', '', 'http://yujia.img.cdn.chabug.com/test/image/head/20200928173620845000000925817813.jpg', '', '363a4d530d1367ff723e48af256f0049', 0, '13329800035', '111@qq.com', 0, '', 0, 0, '2020-09-28 16:40:12', '2020-09-28 16:40:12', '2020-09-29 11:53:08', 0);
INSERT INTO `user` VALUES (10056, 'test', '负责人', '', '企业名称', '363a4d530d1367ff723e48af256f0049', 0, '18932321234', '123@qq.com', 0, '', 1, 1, '2020-09-29 14:00:35', '2020-09-29 14:00:35', '2020-09-29 14:00:35', 0);
INSERT INTO `user` VALUES (10057, '测试2020', '', '', '', '24f46a84e3af452e9138e2da103979a4', 0, '15012345678', 'kekej@qq.com', 0, '', 0, 0, '2020-09-29 15:32:37', '2020-09-29 15:32:37', '2020-09-29 15:32:37', 0);
INSERT INTO `user` VALUES (10058, '域加', '测试', '', '测试科技有限公司', '363a4d530d1367ff723e48af256f0049', 0, '13329800012', '123@qq.com', 0, '', 1, 1, '2020-10-15 15:33:57', '2020-10-15 15:33:57', '2020-10-15 15:33:57', 0);
COMMIT;

-- ----------------------------
-- Table structure for user_card
-- ----------------------------
DROP TABLE IF EXISTS `user_card`;
CREATE TABLE `user_card` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL DEFAULT '0',
  `name` varchar(45) NOT NULL DEFAULT '',
  `cardno` varchar(45) DEFAULT NULL COMMENT '证件号码',
  `image_url` varchar(200) NOT NULL DEFAULT '',
  `image_url2` varchar(200) NOT NULL DEFAULT '',
  `valid_start` date DEFAULT NULL COMMENT '开始时间',
  `valid_end` date DEFAULT NULL COMMENT '有效时间',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '证件类型',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '审核状态',
  `gmt_create` datetime DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='用户证件表';

-- ----------------------------
-- Records of user_card
-- ----------------------------
BEGIN;
INSERT INTO `user_card` VALUES (1, 0, '发放', NULL, '', '', NULL, NULL, 0, 0, '2020-09-02 10:50:05', '2020-09-02 10:50:05', 0);
INSERT INTO `user_card` VALUES (2, 0, '发放', NULL, '', '', NULL, NULL, 0, 0, '2020-09-02 10:54:33', '2020-09-02 10:54:33', 0);
INSERT INTO `user_card` VALUES (3, 0, '发放', NULL, '', '', NULL, NULL, 0, 0, '2020-09-02 10:56:31', '2020-09-02 10:56:31', 0);
INSERT INTO `user_card` VALUES (4, 0, '发放', NULL, '', '', NULL, NULL, 0, 0, '2020-09-02 10:56:39', '2020-09-02 10:56:39', 0);
INSERT INTO `user_card` VALUES (5, 0, '发放', NULL, '', '', NULL, NULL, 0, 0, '2020-09-02 10:56:41', '2020-09-02 10:56:41', 0);
INSERT INTO `user_card` VALUES (6, 10019, 'fdafda', '', '', '', NULL, NULL, 0, 0, '2020-09-02 11:03:54', '2020-09-02 11:03:54', 0);
INSERT INTO `user_card` VALUES (7, 10019, '123', '321321', '', '', NULL, NULL, 0, 0, '2020-09-02 11:14:49', '2020-09-02 11:14:49', 0);
INSERT INTO `user_card` VALUES (8, 10020, '放大放大', '32132', '', '', NULL, NULL, 0, 0, '2020-09-02 11:33:48', '2020-09-02 11:33:48', 0);
INSERT INTO `user_card` VALUES (9, 10026, '321', '321', '', '', NULL, NULL, 0, 0, '2020-09-02 11:48:14', '2020-09-02 11:48:14', 0);
INSERT INTO `user_card` VALUES (10, 10027, '132', '', '', '', NULL, NULL, 0, 0, '2020-09-02 11:49:43', '2020-09-02 11:49:43', 0);
INSERT INTO `user_card` VALUES (11, 10028, '3213', '', '', '', NULL, NULL, 0, 0, '2020-09-02 11:51:42', '2020-09-02 11:51:42', 0);
INSERT INTO `user_card` VALUES (12, 10036, '姓名', '420599199311090012', '', '', NULL, NULL, 0, 0, '2020-09-25 17:37:20', '2020-09-25 17:37:20', 0);
INSERT INTO `user_card` VALUES (13, 10037, '芒大果', '330105199811083242', 'http://yujia.img.cdn.chabug.com/test/image/card/20200925190138939000000166705405.png', 'http://yujia.img.cdn.chabug.com/test/image/card/20200925190146369000000252242556.png', NULL, NULL, 0, 0, '2020-09-25 19:01:49', '2020-09-25 19:01:49', 0);
INSERT INTO `user_card` VALUES (14, 10039, '测试', '420582199809090033', '', '', NULL, NULL, 0, 0, '2020-09-27 14:45:58', '2020-09-27 14:45:58', 0);
INSERT INTO `user_card` VALUES (15, 10050, '张三', '420581299809090012', '', '', NULL, NULL, 0, 0, '2020-09-27 14:54:13', '2020-09-27 14:54:13', 0);
INSERT INTO `user_card` VALUES (16, 10051, '张三', '420581199312090035', '', '', NULL, NULL, 0, 1, '2020-09-28 14:32:56', '2020-09-28 15:56:53', 0);
INSERT INTO `user_card` VALUES (17, 10053, '张三', '420582199312090035', '', '', NULL, NULL, 0, 0, '2020-09-28 16:04:57', '2020-09-28 16:04:57', 0);
INSERT INTO `user_card` VALUES (18, 10055, '张三', '420582199312090035', '', '', '2020-09-22', '2020-09-26', 0, 0, '2020-09-28 16:51:55', '2020-09-28 16:51:55', 0);
COMMIT;

-- ----------------------------
-- Table structure for user_company
-- ----------------------------
DROP TABLE IF EXISTS `user_company`;
CREATE TABLE `user_company` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `unit_name` varchar(50) NOT NULL DEFAULT '' COMMENT '企业名称',
  `social_credit_code` varchar(50) NOT NULL DEFAULT '' COMMENT '统一社会信用代码',
  `reg_capital` varchar(50) NOT NULL DEFAULT '' COMMENT '注册资本',
  `establish_date` varchar(50) NOT NULL DEFAULT '' COMMENT '成立日期',
  `expiration_date` varchar(50) NOT NULL DEFAULT '' COMMENT '营业期限',
  `reg_address` varchar(300) NOT NULL DEFAULT '' COMMENT '注册地址',
  `img_url` varchar(500) NOT NULL DEFAULT '' COMMENT '营业执照图片地址',
  `staff_size` varchar(100) NOT NULL DEFAULT '' COMMENT '员工规模',
  `business_scope` varchar(100) NOT NULL DEFAULT '' COMMENT '业务范畴',
  `customer_base` varchar(100) NOT NULL DEFAULT '' COMMENT '客户群体',
  `content` text COMMENT '介绍',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '法人姓名',
  `card_no` varchar(50) NOT NULL DEFAULT '' COMMENT '法人证件号',
  `just_img_url` varchar(500) NOT NULL DEFAULT '' COMMENT '法人证件正面图片地址',
  `sign_org` varchar(50) NOT NULL DEFAULT '' COMMENT '法人证件签发机关',
  `valid_start` datetime DEFAULT NULL COMMENT '法人证件有效期开始时间',
  `valid_end` datetime DEFAULT NULL COMMENT '法人证件结束时间',
  `back_img_url` varchar(500) NOT NULL DEFAULT '' COMMENT '法人证件背面图片地址',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '审核状态',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '逻辑删除标记',
  PRIMARY KEY (`id`),
  KEY `user_idx` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='用户公司信息';

-- ----------------------------
-- Records of user_company
-- ----------------------------
BEGIN;
INSERT INTO `user_company` VALUES (1, 10032, '我是公司名称', '321', '', '', '', '321', 'http://yujia.img.cdn.chabug.com/test/image/card/20200903142654437000000312017319.jpeg', '3', '332', '321', '111111111111111111111', '321', '32', '', '', NULL, NULL, '', 0, '2020-09-03 14:30:27', '2020-09-03 14:30:27', 0);
INSERT INTO `user_company` VALUES (2, 10056, '企业名称', '321', '', '2020-09-14T16:00:00.000Z', '2020-09-23T16:00:00.000Z', '123', '', '31', '231', '321', NULL, '321', '321', '', '', NULL, NULL, '', 0, '2020-09-29 14:07:52', '2020-09-29 14:07:52', 0);
INSERT INTO `user_company` VALUES (3, 10058, '测试科技有限公司', '91330106MA2GK35R57', '', '2020-10-12', '2020-10-31', '企业注册地址', 'http://yujia.img.cdn.chabug.com/test/image/card/20201015153627298000000411751971.png', '50', '软件开发', '客户群体', NULL, '法人', '420581199209091234', '', '', '2020-10-04 00:00:00', '2020-10-31 00:00:00', '', 0, '2020-10-15 15:36:52', '2020-10-15 15:36:52', 0);
COMMIT;

-- ----------------------------
-- Table structure for user_login_history
-- ----------------------------
DROP TABLE IF EXISTS `user_login_history`;
CREATE TABLE `user_login_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8 COMMENT='用户登录历史';

-- ----------------------------
-- Records of user_login_history
-- ----------------------------
BEGIN;
INSERT INTO `user_login_history` VALUES (1, 10032, '2020-09-07 04:47:59');
INSERT INTO `user_login_history` VALUES (2, 10002, '2020-09-07 11:48:49');
INSERT INTO `user_login_history` VALUES (3, 10032, '2020-09-07 17:38:13');
INSERT INTO `user_login_history` VALUES (4, 10032, '2020-09-07 18:23:11');
INSERT INTO `user_login_history` VALUES (5, 10002, '2020-09-08 16:48:59');
INSERT INTO `user_login_history` VALUES (6, 10032, '2020-09-12 09:53:07');
INSERT INTO `user_login_history` VALUES (7, 10029, '2020-09-12 10:46:12');
INSERT INTO `user_login_history` VALUES (8, 10032, '2020-09-12 11:12:41');
INSERT INTO `user_login_history` VALUES (9, 10029, '2020-09-14 14:46:37');
INSERT INTO `user_login_history` VALUES (10, 10029, '2020-09-14 15:51:45');
INSERT INTO `user_login_history` VALUES (11, 10029, '2020-09-14 15:55:27');
INSERT INTO `user_login_history` VALUES (12, 10029, '2020-09-14 15:56:54');
INSERT INTO `user_login_history` VALUES (13, 10032, '2020-09-14 17:54:00');
INSERT INTO `user_login_history` VALUES (14, 10029, '2020-09-15 16:07:02');
INSERT INTO `user_login_history` VALUES (15, 10032, '2020-09-16 16:27:19');
INSERT INTO `user_login_history` VALUES (16, 10032, '2020-09-16 17:28:15');
INSERT INTO `user_login_history` VALUES (17, 10032, '2020-09-16 17:54:59');
INSERT INTO `user_login_history` VALUES (18, 10032, '2020-09-16 18:05:09');
INSERT INTO `user_login_history` VALUES (19, 10032, '2020-09-16 18:09:11');
INSERT INTO `user_login_history` VALUES (20, 10032, '2020-09-21 11:39:46');
INSERT INTO `user_login_history` VALUES (21, 10032, '2020-09-24 14:48:45');
INSERT INTO `user_login_history` VALUES (22, 10032, '2020-09-26 13:24:09');
INSERT INTO `user_login_history` VALUES (23, 10039, '2020-09-27 14:45:04');
INSERT INTO `user_login_history` VALUES (24, 10050, '2020-09-27 14:53:32');
INSERT INTO `user_login_history` VALUES (25, 10032, '2020-09-27 15:05:13');
INSERT INTO `user_login_history` VALUES (26, 10051, '2020-09-28 14:31:40');
INSERT INTO `user_login_history` VALUES (27, 10052, '2020-09-28 14:53:55');
INSERT INTO `user_login_history` VALUES (28, 10053, '2020-09-28 16:00:23');
INSERT INTO `user_login_history` VALUES (29, 10055, '2020-09-28 16:40:12');
INSERT INTO `user_login_history` VALUES (30, 10032, '2020-09-29 11:58:53');
INSERT INTO `user_login_history` VALUES (31, 10056, '2020-09-29 14:00:35');
INSERT INTO `user_login_history` VALUES (32, 10056, '2020-09-29 14:11:43');
INSERT INTO `user_login_history` VALUES (33, 10057, '2020-09-29 15:32:37');
INSERT INTO `user_login_history` VALUES (34, 10032, '2020-09-29 16:09:01');
INSERT INTO `user_login_history` VALUES (35, 10002, '2020-09-30 15:15:52');
INSERT INTO `user_login_history` VALUES (36, 10032, '2020-09-30 15:36:39');
INSERT INTO `user_login_history` VALUES (37, 10032, '2020-09-30 17:39:02');
INSERT INTO `user_login_history` VALUES (38, 10032, '2020-09-30 17:42:27');
INSERT INTO `user_login_history` VALUES (39, 10032, '2020-09-30 17:42:39');
INSERT INTO `user_login_history` VALUES (40, 10032, '2020-09-30 17:42:41');
INSERT INTO `user_login_history` VALUES (41, 10032, '2020-09-30 17:42:51');
INSERT INTO `user_login_history` VALUES (42, 10032, '2020-09-30 17:43:09');
INSERT INTO `user_login_history` VALUES (43, 10032, '2020-09-30 17:43:36');
INSERT INTO `user_login_history` VALUES (44, 10032, '2020-09-30 17:45:12');
INSERT INTO `user_login_history` VALUES (45, 10032, '2020-10-09 15:56:23');
INSERT INTO `user_login_history` VALUES (46, 10032, '2020-10-10 14:37:09');
INSERT INTO `user_login_history` VALUES (47, 10032, '2020-10-10 16:26:11');
INSERT INTO `user_login_history` VALUES (48, 10032, '2020-10-10 16:26:11');
INSERT INTO `user_login_history` VALUES (49, 10032, '2020-10-13 15:16:10');
INSERT INTO `user_login_history` VALUES (50, 10032, '2020-10-13 16:33:20');
INSERT INTO `user_login_history` VALUES (51, 10032, '2020-10-13 17:07:27');
INSERT INTO `user_login_history` VALUES (52, 10032, '2020-10-13 17:18:44');
INSERT INTO `user_login_history` VALUES (53, 10032, '2020-10-13 17:31:16');
INSERT INTO `user_login_history` VALUES (54, 10032, '2020-10-13 17:36:50');
INSERT INTO `user_login_history` VALUES (55, 10032, '2020-10-13 17:52:17');
INSERT INTO `user_login_history` VALUES (56, 10033, '2020-10-15 11:22:13');
INSERT INTO `user_login_history` VALUES (57, 10038, '2020-10-15 11:24:28');
INSERT INTO `user_login_history` VALUES (58, 10038, '2020-10-15 15:17:06');
INSERT INTO `user_login_history` VALUES (59, 10058, '2020-10-15 15:33:57');
INSERT INTO `user_login_history` VALUES (60, 10032, '2020-10-16 10:41:24');
INSERT INTO `user_login_history` VALUES (61, 10032, '2020-10-16 17:19:37');
INSERT INTO `user_login_history` VALUES (62, 10032, '2020-10-16 17:30:58');
INSERT INTO `user_login_history` VALUES (63, 10032, '2020-10-16 17:32:39');
INSERT INTO `user_login_history` VALUES (64, 10032, '2020-10-16 17:34:40');
INSERT INTO `user_login_history` VALUES (65, 10032, '2020-10-16 21:03:28');
INSERT INTO `user_login_history` VALUES (66, 10032, '2020-10-19 18:20:56');
INSERT INTO `user_login_history` VALUES (67, 10032, '2020-10-21 14:34:44');
INSERT INTO `user_login_history` VALUES (68, 10032, '2020-10-21 15:26:16');
COMMIT;

-- ----------------------------
-- Table structure for user_product_browse_history
-- ----------------------------
DROP TABLE IF EXISTS `user_product_browse_history`;
CREATE TABLE `user_product_browse_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `prod_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '产品ID',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除标记',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COMMENT='用户产品浏览记录';

-- ----------------------------
-- Records of user_product_browse_history
-- ----------------------------
BEGIN;
INSERT INTO `user_product_browse_history` VALUES (1, 10029, 8, '2020-09-16 15:19:35', '2020-09-16 18:03:29', 0);
INSERT INTO `user_product_browse_history` VALUES (2, 10029, 7, '2020-09-16 15:19:42', '2020-09-16 15:19:42', 0);
INSERT INTO `user_product_browse_history` VALUES (3, 10029, 2, '2020-09-16 15:20:18', '2020-09-16 15:20:18', 0);
INSERT INTO `user_product_browse_history` VALUES (4, 10029, 1, '2020-09-16 15:23:07', '2020-09-16 15:41:20', 0);
INSERT INTO `user_product_browse_history` VALUES (5, 10032, 2, NULL, NULL, 0);
INSERT INTO `user_product_browse_history` VALUES (6, 10032, 11, NULL, '2020-10-21 15:01:03', 0);
INSERT INTO `user_product_browse_history` VALUES (7, 10032, 11, NULL, '2020-10-21 15:01:03', 0);
INSERT INTO `user_product_browse_history` VALUES (8, 10032, 8, NULL, '2020-10-13 15:17:26', 0);
INSERT INTO `user_product_browse_history` VALUES (9, 10032, 11, NULL, '2020-10-21 15:01:03', 0);
INSERT INTO `user_product_browse_history` VALUES (10, 10032, 8, NULL, '2020-10-13 15:17:26', 0);
INSERT INTO `user_product_browse_history` VALUES (11, 10032, 10, NULL, '2020-09-16 18:34:58', 0);
INSERT INTO `user_product_browse_history` VALUES (12, 10032, 8, NULL, '2020-10-13 15:17:26', 0);
INSERT INTO `user_product_browse_history` VALUES (13, 10032, 8, NULL, '2020-10-13 15:17:26', 0);
INSERT INTO `user_product_browse_history` VALUES (14, 10032, 8, NULL, '2020-10-13 15:17:26', 0);
INSERT INTO `user_product_browse_history` VALUES (15, 10029, 11, '2020-09-16 17:32:04', '2020-09-16 18:03:33', 0);
INSERT INTO `user_product_browse_history` VALUES (16, 10029, 10, '2020-09-16 17:32:58', '2020-09-16 17:33:57', 0);
INSERT INTO `user_product_browse_history` VALUES (17, 10032, 6, '2020-09-16 18:19:20', '2020-10-13 17:40:54', 0);
INSERT INTO `user_product_browse_history` VALUES (18, 10032, 9, '2020-09-16 18:21:27', '2020-10-21 14:39:28', 0);
INSERT INTO `user_product_browse_history` VALUES (19, 10032, 13, '2020-09-21 05:33:38', '2020-10-16 21:31:11', 0);
INSERT INTO `user_product_browse_history` VALUES (20, 10032, 12, '2020-09-21 05:45:02', '2020-09-21 05:45:02', 0);
INSERT INTO `user_product_browse_history` VALUES (21, 10037, 13, '2020-09-25 19:07:56', '2020-09-25 19:14:45', 0);
INSERT INTO `user_product_browse_history` VALUES (22, 10055, 11, '2020-09-28 17:36:43', '2020-09-28 17:36:43', 0);
INSERT INTO `user_product_browse_history` VALUES (23, 10056, 14, '2020-09-29 14:43:43', '2020-09-29 15:32:07', 0);
INSERT INTO `user_product_browse_history` VALUES (24, 10032, 93, '2020-10-09 15:57:12', '2020-10-21 14:56:20', 0);
INSERT INTO `user_product_browse_history` VALUES (25, 10032, 96, '2020-10-10 15:28:19', '2020-10-22 13:26:24', 0);
INSERT INTO `user_product_browse_history` VALUES (26, 10032, 95, '2020-10-13 15:16:33', '2020-10-19 18:12:08', 0);
INSERT INTO `user_product_browse_history` VALUES (27, 10032, 92, '2020-10-13 15:16:38', '2020-10-21 14:42:21', 0);
INSERT INTO `user_product_browse_history` VALUES (28, 10032, 87, '2020-10-13 17:38:48', '2020-10-13 17:38:48', 0);
INSERT INTO `user_product_browse_history` VALUES (29, 10032, 89, '2020-10-13 17:39:13', '2020-10-21 14:42:13', 0);
INSERT INTO `user_product_browse_history` VALUES (30, 10032, 90, '2020-10-13 17:39:13', '2020-10-13 17:39:13', 0);
INSERT INTO `user_product_browse_history` VALUES (31, 10032, 7, '2020-10-13 17:40:47', '2020-10-13 17:40:47', 0);
INSERT INTO `user_product_browse_history` VALUES (32, 10032, 97, '2020-10-14 18:23:07', '2020-10-14 18:24:22', 0);
INSERT INTO `user_product_browse_history` VALUES (33, 10038, 98, '2020-10-15 15:31:15', '2020-10-15 15:32:01', 0);
INSERT INTO `user_product_browse_history` VALUES (34, 10058, 99, '2020-10-15 15:38:08', '2020-10-15 15:43:23', 0);
INSERT INTO `user_product_browse_history` VALUES (35, 10058, 97, '2020-10-15 15:50:57', '2020-10-16 12:12:25', 0);
INSERT INTO `user_product_browse_history` VALUES (36, 10058, 102, '2020-10-16 11:43:27', '2020-10-16 14:16:21', 0);
INSERT INTO `user_product_browse_history` VALUES (37, 10058, 78, '2020-10-16 11:46:31', '2020-10-16 11:51:25', 0);
INSERT INTO `user_product_browse_history` VALUES (38, 10058, 34, '2020-10-16 11:47:03', '2020-10-16 11:48:56', 0);
INSERT INTO `user_product_browse_history` VALUES (39, 10058, 46, '2020-10-16 11:50:29', '2020-10-16 11:50:31', 0);
INSERT INTO `user_product_browse_history` VALUES (40, 10058, 98, '2020-10-16 11:50:34', '2020-10-16 17:32:52', 0);
INSERT INTO `user_product_browse_history` VALUES (41, 10058, 63, '2020-10-16 11:51:15', '2020-10-16 11:51:15', 0);
INSERT INTO `user_product_browse_history` VALUES (42, 10058, 95, '2020-10-16 13:59:47', '2020-10-16 17:32:37', 0);
INSERT INTO `user_product_browse_history` VALUES (43, 10058, 101, '2020-10-16 14:16:16', '2020-10-16 14:16:16', 0);
INSERT INTO `user_product_browse_history` VALUES (44, 10058, 7, '2020-10-16 15:12:39', '2020-10-16 15:12:39', 0);
INSERT INTO `user_product_browse_history` VALUES (45, 10032, 14, '2020-10-16 17:22:45', '2020-10-16 17:22:45', 0);
INSERT INTO `user_product_browse_history` VALUES (46, 10032, 98, '2020-10-16 17:31:14', '2020-10-21 14:57:28', 0);
INSERT INTO `user_product_browse_history` VALUES (47, 10032, 69, '2020-10-16 17:31:32', '2020-10-16 21:22:24', 0);
INSERT INTO `user_product_browse_history` VALUES (48, 10032, 66, '2020-10-16 17:32:31', '2020-10-16 17:32:31', 0);
INSERT INTO `user_product_browse_history` VALUES (49, 10058, 96, '2020-10-16 17:32:37', '2020-10-16 17:34:07', 0);
INSERT INTO `user_product_browse_history` VALUES (50, 10032, 59, '2020-10-16 21:22:06', '2020-10-16 21:22:06', 0);
INSERT INTO `user_product_browse_history` VALUES (51, 10032, 94, '2020-10-19 18:11:47', '2020-10-21 14:37:10', 0);
INSERT INTO `user_product_browse_history` VALUES (52, 10032, 68, '2020-10-21 14:46:59', '2020-10-21 14:46:59', 0);
INSERT INTO `user_product_browse_history` VALUES (53, 10032, 84, '2020-10-21 14:57:18', '2020-10-21 14:57:18', 0);
COMMIT;

-- ----------------------------
-- Table structure for user_product_collection
-- ----------------------------
DROP TABLE IF EXISTS `user_product_collection`;
CREATE TABLE `user_product_collection` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `prod_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '产品ID',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除标记',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='用户产品收藏';

-- ----------------------------
-- Records of user_product_collection
-- ----------------------------
BEGIN;
INSERT INTO `user_product_collection` VALUES (1, 10029, 8, '2020-09-16 16:17:21', '2020-09-16 16:17:21', 0);
INSERT INTO `user_product_collection` VALUES (2, 10037, 13, '2020-09-25 19:07:59', '2020-09-25 19:07:59', 0);
INSERT INTO `user_product_collection` VALUES (3, 10032, 69, '2020-10-16 17:31:35', '2020-10-16 17:31:59', 0);
COMMIT;

-- ----------------------------
-- Table structure for video
-- ----------------------------
DROP TABLE IF EXISTS `video`;
CREATE TABLE `video` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `prod_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '产品ID',
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户ID（冗余）',
  `video_url` varchar(1000) NOT NULL DEFAULT '' COMMENT '视频地址',
  `img_url` varchar(1000) NOT NULL DEFAULT '' COMMENT '图片地址',
  `duration` bigint(20) NOT NULL DEFAULT '0' COMMENT '视频时长',
  `size` bigint(20) NOT NULL DEFAULT '0' COMMENT '视频大小',
  `content` varchar(2000) NOT NULL DEFAULT '' COMMENT '描述介绍',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='视频管理';

-- ----------------------------
-- Records of video
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for video_live
-- ----------------------------
DROP TABLE IF EXISTS `video_live`;
CREATE TABLE `video_live` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `title` varchar(200) NOT NULL DEFAULT '' COMMENT '标题',
  `platform_id` int(11) NOT NULL DEFAULT '0' COMMENT '直播平台ID',
  `platform_name` varchar(100) NOT NULL DEFAULT '' COMMENT '直播平台名称（冗余）',
  `live_link` varchar(1000) NOT NULL DEFAULT '' COMMENT '直播链接',
  `video_img_url` varchar(1000) NOT NULL DEFAULT '' COMMENT '视频封面',
  `industry_id` int(11) NOT NULL DEFAULT '0' COMMENT '行业ID',
  `industry_name` varchar(100) NOT NULL DEFAULT '' COMMENT '行业名称（冗余）',
  `price` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '价格',
  `is_custom` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否支持定制',
  `buy_url` varchar(1000) NOT NULL DEFAULT '' COMMENT '购买链接',
  `download_url` varchar(1000) NOT NULL DEFAULT '' COMMENT '试用下载链接',
  `content` text COMMENT '商品描述',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '状态',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除标记',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='视频直播';

-- ----------------------------
-- Records of video_live
-- ----------------------------
BEGIN;
INSERT INTO `video_live` VALUES (1, 10032, '测试1', 1, '', 'https://www.baidu.com', 'http://yujia.img.cdn.chabug.com/test/image/video/20200908153151810000000110704524.jpg', 2, '', 1022.00, 1, 'https://www.baidu.com', '', '', 0, '2020-09-05 16:06:08', '2020-09-05 16:06:08', 0);
INSERT INTO `video_live` VALUES (2, 10032, '测试2', 0, '', 'https://www.baidu.com', 'http://yujia.img.cdn.chabug.com/test/image/video/20200908153151810000000110704524.jpg', 0, '', 32.00, 1, 'https://www.baidu.com', '321', '', 0, '2020-09-05 16:26:02', '2020-09-05 16:26:02', 0);
INSERT INTO `video_live` VALUES (3, 10032, '测试3', 0, '', 'https://www.baidu.com', 'http://yujia.img.cdn.chabug.com/test/image/video/20200908153151810000000110704524.jpg', 0, '', 4343243.00, 1, 'https://www.baidu.com', '321', NULL, 0, '2020-09-05 16:28:40', '2020-09-05 16:28:40', 0);
INSERT INTO `video_live` VALUES (4, 10032, '测试4', 1, '', 'https://www.baidu.com', 'http://yujia.img.cdn.chabug.com/test/image/video/20200908153151810000000110704524.jpg', 1, '', 434.00, 1, 'https://www.baidu.com', '3213', '<p>321321321</p>', 0, '2020-09-06 14:32:37', '2020-09-06 14:32:37', 0);
INSERT INTO `video_live` VALUES (5, 10032, '测试5', 1, '', 'https://www.baidu.com', 'http://yujia.img.cdn.chabug.com/test/image/video/20200908153151810000000110704524.jpg', 1, '', 43432.00, 1, 'https://www.baidu.com', '3213', '<p>321321321</p>', 1, '2020-09-06 14:32:37', '2020-10-16 21:29:46', 0);
INSERT INTO `video_live` VALUES (6, 10032, '测试6', 1, '', 'https://www.baidu.com', 'http://yujia.img.cdn.chabug.com/test/image/video/20200908153151810000000110704524.jpg', 1, '', 132321.00, 1, 'https://www.baidu.com', '3213', '<p>321321321</p>', 1, '2020-09-06 14:32:37', '2020-10-09 11:01:10', 0);
INSERT INTO `video_live` VALUES (7, 10058, '123', 1, '', 'https://m.tb.cn/h.40OHzUc', 'http://yujia.img.cdn.chabug.com/test/image/video/20201016151121281000000679271002.jpg', 3, '', 321.00, 1, 'https://m.tb.cn/h.40OHzUc', '', '<p>123321</p>', 1, '2020-10-16 15:11:45', '2020-10-16 17:18:28', 0);
COMMIT;

-- ----------------------------
-- Table structure for video_live_apply_industry
-- ----------------------------
DROP TABLE IF EXISTS `video_live_apply_industry`;
CREATE TABLE `video_live_apply_industry` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `video_live_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '直播ID',
  `industry_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '行业ID',
  `industry_name` varchar(100) NOT NULL DEFAULT '' COMMENT '行业名称（冗余）',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除标记',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='直播应用行业';

-- ----------------------------
-- Records of video_live_apply_industry
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for web_options
-- ----------------------------
DROP TABLE IF EXISTS `web_options`;
CREATE TABLE `web_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `option_key` varchar(200) NOT NULL DEFAULT '' COMMENT '键',
  `option_value` text NOT NULL COMMENT '值',
  PRIMARY KEY (`id`),
  UNIQUE KEY `web_options_option_key_uindex` (`option_key`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='系统配置';

-- ----------------------------
-- Records of web_options
-- ----------------------------
BEGIN;
INSERT INTO `web_options` VALUES (1, 'publiconf', '{\"directPush\":\"400\",\"directPushStatus\":\"1\",\"see1\":\"400\",\"see1Status\":\"1\",\"see2\":\"300\",\"see2Status\":\"1\",\"see3\":\"200\",\"see3Status\":\"1\",\"see4\":\"100\",\"see4Status\":\"1\",\"max5Reward\":\"2000\",\"realPay\":\"95\",\"fullRow\":\"1\"}');
INSERT INTO `web_options` VALUES (2, 'paymethodconf', '{\"aliPayImg\":\"https://img01.chabug.com/test/image/image/20200708160829201000000444303414.jpg\",\"file\":\"\",\"aliPayShow\":\"1\",\"weixinPayImg\":\"https://img01.chabug.com/test/image/image/20200708160905153000000545851736.png\",\"bankCardNumber\":\"6214000022229999\",\"bankName\":\"测试名称\",\"bankDeposit\":\"招商银行\",\"bankBranch\":\"杭州支行\"}');
INSERT INTO `web_options` VALUES (3, 'setCompanyInfo', '{\"companyName\":\"TOP帮\",\"name\":\"联系人设置\",\"phone\":\"电话号码\",\"siteUrl\":\"我是网址信息\",\"address\":\"浙江省杭州市\",\"content\":\"公司简介内容公司简介内容公司简介内容公司简介内容公司简介内容公司简介内容公司简介内容公司简介内容公司简介内容公司简介内容公司简介内容公司简介内容公司简介内容公司简介内容公司简介内容公司简介内容公司简介内容\"}');
INSERT INTO `web_options` VALUES (4, 'setServiceState', '{\"content\":\"<p>下面是模拟的内容</p>\\n<p>&ldquo;表情商店&rdquo;是腾讯公司提供给用户的一项下载、使用微信表情作品的平台服务，包含&ldquo;朋友表情&rdquo;和&ldquo;更多表情&rdquo;两个栏目，相关表情作品由腾讯公司或第三方（以下称为&ldquo;投稿人&rdquo;）提供，用户可以通过表情商店付费或免费下载表情作品，并添加到聊天表情中使用。本声明为《腾讯微信软件许可及服务协议》《微信表情开放平台服务协议》不可分割的一部分，用户使用表情商店，需遵守上述协议及本声明如下条款：</p>\\n<p>1. 你理解并同意，腾讯公司仅为用户提供表情作品下载及使用的平台，除用户通过本人微信帐号在表情商店下载后自行在本人微信帐号中使用外，未经腾讯或相关权利人书面许可，任何人不得以其他任何形式进行使用或创造相关衍生作品。</p>\\n<p>2. 你在表情商店所下载的表情作品会与你的微信帐号绑定，但仅限于你下载时所使用的微信帐号。为确保表情作品的正常使用，请你使用本人微信帐号下载表情作品。我们会统计表情作品的下载情况，用于&ldquo;朋友表情&rdquo;和&ldquo;更多表情&rdquo;相关的排行、推荐或其他推广。</p>\\n<p>3. 表情商店的赞赏功能是腾讯为微信用户自愿就表情作品赠与款项以示鼓励的行为提供相应技术支持的功能。你是否赠与，由你自行决定，但赠与后除因法定情形或其他相关规定的原因外不可撤回。为公开展示用户对艺术家的支持，我们会展现已赞赏的人数以及已赞赏用户的头像。</p>\\n<p>4. 表情商店的付费功能是腾讯为微信用户自愿就艺术家提供的付费表情作品进行付费以获得使用许可的行为提供相应技术支持的功能。你是否付费，由你自行决定，但付费后除因法定情形或其他相关规定的原因外不可撤回。表情艺术家将从你的付费金额中获得收益。</p>\\n<p>5.因投稿人的表情作品产生的任何纠纷、责任等，以及投稿人违反相关法律法规或平台规则引发的任何后果，均由投稿人独立承担责任、赔偿损失，与腾讯无关。如侵害到腾讯或他人权益的，投稿人须自行承担全部责任和赔偿一切损失。</p>\\n<p>6. 表情商店仅在微信部分软件版本上提供，请你确认所使用的软件版本支持表情商店功能，否则你将无法下载、使用表情作品。</p>\\n<p>7. 表情商店的服务是按照现有技术和条件所能达到的现状提供的。腾讯会尽最大努力向你提供服务，确保服务的连贯性和安全性；但腾讯不能保证其所提供的服务毫无瑕疵，也无法随时预见和防范法律、技术以及其他风险，包括但不限于不可抗力、病毒、木马、黑客攻击、系统不稳定、第三方服务瑕疵、政府行为等原因可能导致的服务中断、数据丢失以及其他的损失和风险。你理解并同意，因上述原因导致你不能正常使用表情商店或给你造成损失的，腾讯公司不承担责任。</p>\\n<p>8. 若你有任何违反相关法律法规或本声明的规定，腾讯公司有权视你的行为性质，在不事先通知你的情况下，采取包括但不限于中断使用、限制使用、删除相关文件、中止或终止服务、追究法律责任等措施，若因此造成腾讯公司或他人损失的，你应予赔偿。</p>\\n<p>9. 腾讯公司坚决反对任何危害国家安全统一、破坏社会稳定、违反公序良俗、侮辱、诽谤、淫秽、暴力以及任何违反国家法律法规或侵犯第三方合法权益的内容，你使用本服务过程中如发现相关内容存在违反法律法规或者侵犯了你的权利，请及时向我们举报或投诉（电子邮箱：<a href=\\\"mailto:wxsticker_support@tencent.com\\\">wxsticker_support@tencent.com</a>），我们将依法处理。</p>\\n<p>10. 根据用户需求及产品更新的需要，腾讯公司可能会对表情商店功能及本免责声明条款进行修改。如有修改，我们会在产品和网页中显著的位置发布以便及时通知到用户。如果你选择继续使用我们的服务，即表示你已接受修改后的内容。</p>\"}');
INSERT INTO `web_options` VALUES (5, 'setContactus', '{\"wxMpImg\":\"http://yujia.img.cdn.chabug.com/test/image/image/20200925095156063000000162916189.jpg\",\"file\":\"\",\"cooperationHotline\":\"400-123\",\"salesHotline\":\"400-234\",\"customerServiceHotline\":\"400-456\",\"email\":\"123456@qq.com\"}');
INSERT INTO `web_options` VALUES (6, 'setSeo', '{\"seoTitle\":\"123\",\"seoDescription\":\"321\",\"seoKeywords\":\"321321\",\"indexBannerImg\":\"http://yujia.img.cdn.chabug.com/test/image/image/20200925103847342000000315584245.jpg\",\"file\":\"\"}');
INSERT INTO `web_options` VALUES (7, 'setRegAgree', '{\"content\":\"<p>【阅读】您在申谞注册流程中点击同意前，应当认真阅读以下协议。谞您务必审憤阅读、充分理 解协议中相关条款内容，其中包括：</p>\\n<p>1、 与您约定免除或限制贵任的条款；</p>\\n<p>2、 与您约定法律适用和管辖的条款；</p>\\n<p>3、 其他以粗体下划线标识的重要条款。</p>\\n<p>如您对协议有任何疑问，可向100帮服务中心（请点击）咨询</p>\\n<p>【特别提示】您已充分理解，100帮是一个商业贸易采购平台，而并非面向消费者的消费购买市场， 当您按照注册页面提示填写信患、阅读并同意协议且完成全部注册程序后，即表示您已充分阅读、理 解并接受协议的全部内容，并将基于您的真实贸易需求而使用阿里巴巴服务。如您因阿里巴巴服务与 阿里巴巴发生争议，应适用<span class=\\\"blue\\\">《TOP帮服务条款》</span>处理；如您在使用阿里巴巴服务中与其他用户发生争 议，依您与其他用户达成的协议处理。</p>\\n<p>阅读协议的过程中，如果您不同意相关协议或其中任何条款约定，您应立即停止注册程序。</p>\"}');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
