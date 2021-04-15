/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50718
 Source Host           : localhost:3306
 Source Schema         : testdb

 Target Server Type    : MySQL
 Target Server Version : 50718
 File Encoding         : 65001

 Date: 15/04/2021 17:18:53
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for persistent_logins
-- ----------------------------
DROP TABLE IF EXISTS `persistent_logins`;
CREATE TABLE `persistent_logins`  (
  `username` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `series` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_used` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`series`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_api
-- ----------------------------
DROP TABLE IF EXISTS `sys_api`;
CREATE TABLE `sys_api`  (
  `id` bigint(20) NOT NULL,
  `api_pid` bigint(20) NOT NULL COMMENT '接口父ID(即接口分组)',
  `api_pids` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '当前接口的所有上级id(即所有上级分组)',
  `is_leaf` tinyint(1) NOT NULL COMMENT '0:不是叶子节点，1:是叶子节点',
  `api_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '接口名称',
  `url` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '跳转URL',
  `api_sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `level` int(11) NOT NULL COMMENT '层级，1：接口分组，2：接口',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否禁用，0:启用(否）,1:禁用(是)',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '本条记录创建人',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '本条记录创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '本条记录修改人',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '本条记录的修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统Http接口表，配合sys_role_api控制接口访问权限' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_api
-- ----------------------------
INSERT INTO `sys_api` VALUES (1, 0, '[0]', 0, '系统数据接口', NULL, 1, 1, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (2, 1, '[0],[1]', 0, '系统管理模块', NULL, 1, 2, 0, '', '2021-01-16 01:50:45', 'admin', '2021-02-10 07:18:33');
INSERT INTO `sys_api` VALUES (3, 2, '[0],[1],[2]', 1, '用户信息接口', '/sysuser/info', 1, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (4, 2, '[0],[1],[2]', 1, '组织管理-树形数据接口', '/sysorg/tree', 2, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (5, 2, '[0],[1],[2]', 1, '组织管理-新增组织接口', '/sysorg/add', 3, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (6, 2, '[0],[1],[2]', 1, '组织管理-修改组织接口', '/sysorg/update', 4, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (7, 2, '[0],[1],[2]', 1, '组织管理-删除组织接口', '/sysorg/delete', 5, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (8, 2, '[0],[1],[2]', 1, '菜单树形数据加载接口', '/sysmenu/tree', 6, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (9, 2, '[0],[1],[2]', 1, '菜单管理-新增菜单项接口', '/sysmenu/add', 7, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (10, 2, '[0],[1],[2]', 1, '菜单管理-修改菜单项接口', '/sysmenu/update', 8, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (11, 2, '[0],[1],[2]', 1, '菜单管理-删除菜单项接口', '/sysmenu/delete', 9, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (12, 2, '[0],[1],[2]', 1, '查询某角色已具备菜单权限接口', '/sysmenu/checkedtree', 10, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (13, 2, '[0],[1],[2]', 1, '保存某角色分配勾选的菜单权限', '/sysmenu/savekeys', 11, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (14, 2, '[0],[1],[2]', 1, '接口分类树形结构数据加载', '/sysapi/tree', 12, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (15, 2, '[0],[1],[2]', 1, '接口管理-新增接口', '/sysapi/add', 13, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (16, 2, '[0],[1],[2]', 1, '接口管理-更新接口数据', '/sysapi/update', 14, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (17, 2, '[0],[1],[2]', 1, '接口管理-删除接口', '/sysapi/delete', 15, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (18, 2, '[0],[1],[2]', 1, '查询某角色已具备的接口访问权限', '/sysapi/checkedtree', 16, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (19, 2, '[0],[1],[2]', 1, '保存某角色勾选分配的接口访问权限', '/sysapi/savekeys', 17, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (20, 2, '[0],[1],[2]', 1, '角色管理-列表查询', '/sysrole/query', 18, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (21, 2, '[0],[1],[2]', 1, '角色管理-新增角色', '/sysrole/add', 19, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (22, 2, '[0],[1],[2]', 1, '角色管理-更新角色数据', '/sysrole/update', 20, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (23, 2, '[0],[1],[2]', 1, '角色管理-删除角色', '/sysrole/delete', 21, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (24, 2, '[0],[1],[2]', 1, '查询某用户具备的角色id列表', '/sysrole/checkedroles', 22, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (25, 2, '[0],[1],[2]', 1, '保存为某用户分配的角色', '/sysrole/savekeys', 23, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (26, 2, '[0],[1],[2]', 1, '用户管理-用户列表查询', '/sysuser/query', 24, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (27, 2, '[0],[1],[2]', 1, '用户管理-新增用户', '/sysuser/add', 25, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (28, 2, '[0],[1],[2]', 1, '用户管理-修改用户信息', '/sysuser/update', 26, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (29, 2, '[0],[1],[2]', 1, '用户管理-删除用户', '/sysuser/delete', 27, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (30, 2, '[0],[1],[2]', 1, '为用户重置密码', '/sysuser/pwd/reset', 28, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (31, 2, '[0],[1],[2]', 1, '判断用户是否使用默认密码', '/sysuser/pwd/isdefault', 29, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (32, 2, '[0],[1],[2]', 1, '修改用户密码', '/sysuser/pwd/change', 30, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (33, 2, '[0],[1],[2]', 1, '菜单栏数据接口(根据登录用户)', '/sysmenu/tree/user', 6, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (34, 2, '[0],[1],[2]', 1, '获取系统全局配置参数', '/sysconfig/all', 31, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (35, 2, '[0],[1],[2]', 1, '条件查询全局配置参数接口', '/sysconfig/query', 32, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (36, 2, '[0],[1],[2]', 1, '新增配置参数接口', '/sysconfig/add', 33, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (37, 2, '[0],[1],[2]', 1, '修改配置参数接口', '/sysconfig/update', 34, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (38, 2, '[0],[1],[2]', 1, '删除配置参数接口', '/sysconfig/delete', 35, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (39, 2, '[0],[1],[2]', 1, '配置参数从数据库刷新到内存', '/sysconfig/refresh', 36, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (40, 2, '[0],[1],[2]', 1, '数据字典数据加载接口', '/sysdict/all', 37, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (41, 2, '[0],[1],[2]', 1, '数据字典条件查询接口', '/sysdict/query', 38, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (42, 2, '[0],[1],[2]', 1, '数据字典数据新增接口', '/sysdict/add', 39, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (43, 2, '[0],[1],[2]', 1, '数据字典数据修改接口', '/sysdict/update', 40, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (44, 2, '[0],[1],[2]', 1, '数据字典数据删除接口', '/sysdict/delete', 41, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (1305351823497891842, 1, '[0],[1]', 0, '测试管理模块', 'test', 2, 2, 0, '', '2021-01-16 01:50:45', 'admin', '2021-01-24 16:09:16');
INSERT INTO `sys_api` VALUES (1305352353884409857, 1305351823497891842, '[0],[1],[1305351823497891842]', 1, '根据条件查询货物', '/afficegoods/query', 2, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (1305352533799079937, 1305351823497891842, '[0],[1],[1305351823497891842]', 1, '修改货物', '/afficegoods/update', 2, 3, 0, '', '2021-01-16 01:50:45', 'admin', '2021-01-25 09:16:44');
INSERT INTO `sys_api` VALUES (1305352644314796033, 1305351823497891842, '[0],[1],[1305351823497891842]', 1, '删除货物', '/afficegoods/delete', 1, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (1313305456969621506, 2, '[0],[1],[2]', 1, '用户管理-用户状态更新', '/sysuser/enabled/change', 28, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (1313751534453927938, 2, '[0],[1],[2]', 1, '接口管理-更新禁用状态', '/sysapi/status/change', 16, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (1313752151180193793, 2, '[0],[1],[2]', 1, '角色管理-更新禁用状态', '/sysrole/status/change', 22, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (1313752655025156098, 2, '[0],[1],[2]', 1, '组织管理-更新组织机构禁用状态', '/sysorg/status/change', 5, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (1313753498440970241, 2, '[0],[1],[2]', 1, '菜单管理-更新禁用状态', '/sysmenu/status/change', 10, 3, 0, '', '2021-01-16 01:50:45', '', '2021-01-16 01:50:45');
INSERT INTO `sys_api` VALUES (1353253517831827458, 1305351823497891842, '[0],[1],[1305351823497891842]', 1, '新增货物', '/afficegoods/add', 5, 3, 0, 'admin', '2021-01-24 16:09:16', 'admin', '2021-01-31 09:22:03');
INSERT INTO `sys_api` VALUES (1359280554647330818, 2, '[0],[1],[2]', 1, '菜单是否隐藏切换', '/sysmenu/hidden/change', 9, 3, 0, 'admin', '2021-02-10 07:18:33', 'admin', '2021-02-10 07:18:33');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `id` bigint(20) NOT NULL,
  `param_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '参数名称(中文)',
  `param_key` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '参数编码唯一标识(英文及数字)',
  `param_value` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '参数值',
  `param_desc` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数描述备注',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '本条记录创建人',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '本条记录创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '本条记录修改人',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '本条记录的修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `param_key`(`param_key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统全局配置参数' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '用户初始密码', 'user.init.password', 'abcd1234', '系统新增用户初始化密码（登录后会提示用户自行修改）', '', '2020-02-29 13:26:58', '', '2021-01-16 01:52:42');

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
  `id` bigint(20) NOT NULL,
  `group_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分组名称',
  `group_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分组编码',
  `item_name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典项名称',
  `item_value` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典项Value',
  `item_desc` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典项描述',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '本条记录创建人',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '本条记录创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '本条记录修改人',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '本条记录的修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '数据字典表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES (1, '是否禁用', 'common.status', '未禁用', 'false', '通用数据记录的禁用状态', '', '2021-01-16 01:58:25', '', '2021-01-16 01:58:25');
INSERT INTO `sys_dict` VALUES (2, '是否禁用', 'common.status', '已禁用', 'true', '通用数据记录的禁用状态', '', '2021-01-16 01:58:25', '', '2021-01-16 01:58:25');
INSERT INTO `sys_dict` VALUES (3, '用户状态', 'sysuser.enabled', '已激活', 'true', '用户状态', '', '2021-01-16 01:58:25', '', '2021-01-16 01:58:25');
INSERT INTO `sys_dict` VALUES (4, '用户状态', 'sysuser.enabled', '已禁用', 'false', '用户状态', '', '2021-01-16 01:58:25', '', '2021-01-16 01:58:25');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` bigint(20) NOT NULL,
  `menu_pid` bigint(20) NOT NULL COMMENT '父菜单ID',
  `menu_pids` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '当前菜单所有父菜单',
  `menu_name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
  `menu_sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `is_leaf` tinyint(1) NOT NULL COMMENT '0:不是叶子节点，1:是叶子节点',
  `url` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '跳转URL',
  `icon` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `level` int(11) NOT NULL COMMENT '菜单层级',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否禁用，0:启用(否）,1:禁用(是)',
  `hidden` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否隐藏，0:不隐藏，1:隐藏，某些页面入口不在菜单上显示',
  `view_import` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '前端路由组件页面文件import路径',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '本条记录创建人',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '本条记录创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '本条记录修改人',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '本条记录的修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统菜单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, 0, '[0]', '系统根目录', 1, 0, '', '', 1, 0, 0, '', '', '2021-01-16 02:02:59', 'admin', '2021-02-14 09:30:34');
INSERT INTO `sys_menu` VALUES (2, 1, '[0],[1]', '系统管理', 2, 0, '', 'el-icon-fa fa-cogs', 2, 0, 0, '', '', '2021-01-16 02:02:59', 'admin', '2021-02-14 09:30:47');
INSERT INTO `sys_menu` VALUES (3, 2, '[0],[1],[2]', '用户管理', 1, 1, '/home/sysuser', 'el-icon-fa fa-user', 3, 0, 0, 'system/SystemUser.vue', '', '2021-01-16 02:02:59', 'admin', '2021-02-12 12:57:40');
INSERT INTO `sys_menu` VALUES (4, 2, '[0],[1],[2]', '角色管理', 2, 1, '/home/sysrole', 'el-icon-fa fa-users', 3, 0, 0, 'system/SystemRole.vue', '', '2021-01-16 02:02:59', 'admin', '2021-02-12 10:34:41');
INSERT INTO `sys_menu` VALUES (5, 2, '[0],[1],[2]', '组织管理', 3, 1, '/home/sysorg', 'el-icon-fa fa-sitemap', 3, 0, 0, 'system/SystemOrg.vue', '', '2021-01-16 02:02:59', 'admin', '2021-02-12 10:34:44');
INSERT INTO `sys_menu` VALUES (6, 2, '[0],[1],[2]', '菜单管理', 4, 1, '/home/sysmenu', 'el-icon-fa fa-list-ul', 3, 0, 0, 'system/SystemMenu.vue', '', '2021-01-16 02:02:59', 'admin', '2021-02-12 10:34:47');
INSERT INTO `sys_menu` VALUES (7, 2, '[0],[1],[2]', '接口管理', 5, 1, '/home/sysapi', 'el-icon-fa fa-plug', 3, 0, 0, 'system/SystemApi.vue', '', '2021-01-16 02:02:59', 'admin', '2021-02-12 10:34:50');
INSERT INTO `sys_menu` VALUES (10, 1, '[0],[1]', '文档工具', 3, 0, '', 'el-icon-eleme', 2, 0, 0, '', '', '2021-01-16 02:02:59', 'admin', '2021-02-28 10:36:46');
INSERT INTO `sys_menu` VALUES (11, 10, '[0],[1],[10]', '数据库文档', 1, 1, '/home/dbdocument', 'el-icon-lock', 3, 0, 0, 'tools/DBDocument.vue', '', '2021-01-16 02:02:59', 'admin', '2021-02-12 10:34:53');
INSERT INTO `sys_menu` VALUES (12, 2, '[0],[1],[2]', '参数配置', 6, 1, '/home/sysconfig', 'el-icon-fa fa-cog', 3, 0, 0, 'system/SystemConfig.vue', '', '2021-01-16 02:02:59', 'admin', '2021-02-12 10:34:57');
INSERT INTO `sys_menu` VALUES (13, 2, '[0],[1],[2]', '数据字典', 7, 1, '/home/sysdict', 'el-icon-fa fa-list-ol', 3, 0, 0, 'system/SystemDict.vue', '', '2021-01-16 02:02:59', 'admin', '2021-02-12 10:35:01');
INSERT INTO `sys_menu` VALUES (1301717053454974978, 10, '[0],[1],[10]', '代码生成器', 2, 1, '/home/generator', 'el-icon-fa fa-list-ul', 3, 0, 0, 'tools/MyGenerator.vue', '', '2021-01-16 02:02:59', 'admin', '2021-02-12 10:35:06');
INSERT INTO `sys_menu` VALUES (1360763330525454338, 1, '[0],[1]', '非菜单路由页面(请隐藏)', 1, 0, '', 'el-icon-warning', 2, 0, 1, '', 'admin', '2021-02-14 09:30:34', 'admin', '2021-02-14 13:57:04');
INSERT INTO `sys_menu` VALUES (1360764106014515202, 1360763330525454338, '[0],[1],[1360763330525454338]', '首页', 1, 1, '/home/firstpage', 'el-icon-s-home', 3, 0, 1, 'system/FirstPage.vue', 'admin', '2021-02-14 09:33:39', 'admin', '2021-02-12 12:57:34');
INSERT INTO `sys_menu` VALUES (1360764611331678210, 1360763330525454338, '[0],[1],[1360763330525454338]', '个人中心', 1, 1, '/home/personal', 'el-icon-s-custom', 3, 0, 1, 'system/PersonalCenter.vue', 'admin', '2021-02-14 09:35:40', 'admin', '2021-02-12 10:35:18');
INSERT INTO `sys_menu` VALUES (1365853419727286273, 10, '[0],[1],[10]', 'Swagger接口', 3, 1, '/home/apidocument', 'el-icon-grape', 3, 0, 0, 'tools/APIDocument.vue', 'admin', '2021-02-28 10:36:46', 'admin', '2021-02-28 10:45:57');

-- ----------------------------
-- Table structure for sys_org
-- ----------------------------
DROP TABLE IF EXISTS `sys_org`;
CREATE TABLE `sys_org`  (
  `id` bigint(20) NOT NULL,
  `org_pid` bigint(20) NOT NULL COMMENT '上级组织编码',
  `org_pids` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所有的父节点id',
  `org_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '组织名',
  `org_sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `is_leaf` tinyint(1) NOT NULL COMMENT '0:不是叶子节点，1:是叶子节点',
  `address` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地址',
  `phone` varchar(13) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮件',
  `level` int(11) NOT NULL COMMENT '组织层级',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否禁用，0:启用(否）,1:禁用(是)',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '本条记录创建人',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '本条记录创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '本条记录修改人',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '本条记录的修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统组织结构表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_org
-- ----------------------------
INSERT INTO `sys_org` VALUES (1, 0, '[0]', 'DongTech', 1, 0, NULL, NULL, NULL, 1, 0, '', '2021-01-16 02:05:41', '', '2021-01-16 02:05:41');
INSERT INTO `sys_org` VALUES (1298067029349117953, 1, '[0],[1]', '西安分公司', 1, 0, NULL, '13215678932', '11111111@qq.com', 2, 0, '', '2021-01-24 15:56:09', 'admin', '2021-01-24 15:56:09');
INSERT INTO `sys_org` VALUES (1298067159791972353, 1298067029349117953, '[0],[1],[1298067029349117953]', '测试部一', 1, 1, NULL, '', '444444444@qq.com', 3, 0, '', '2021-01-24 15:55:07', 'admin', '2021-01-24 15:55:02');
INSERT INTO `sys_org` VALUES (1298067674592456706, 1, '[0],[1]', '上海分公司', 2, 0, NULL, '', '11111111@qq.com', 2, 0, '', '2021-01-16 02:05:41', '', '2021-01-16 02:05:41');
INSERT INTO `sys_org` VALUES (1298067729978241025, 1298067674592456706, '[0],[1],[1298067674592456706]', '运维部一', 1, 1, NULL, '', '11111111@qq.com', 3, 0, '', '2021-01-16 02:05:41', '', '2021-01-16 02:05:41');
INSERT INTO `sys_org` VALUES (1298067787712835585, 1298067674592456706, '[0],[1],[1298067674592456706]', '运维部二', 2, 1, NULL, '', '11111111@qq.com', 3, 0, '', '2021-01-16 02:05:41', '', '2021-01-16 02:05:41');
INSERT INTO `sys_org` VALUES (1298067843731959809, 1298067674592456706, '[0],[1],[1298067674592456706]', '运维部三', 3, 1, NULL, '', '11111111@qq.com', 3, 0, '', '2021-01-16 02:05:41', '', '2021-01-16 02:05:41');
INSERT INTO `sys_org` VALUES (1298068119314509825, 1298067029349117953, '[0],[1],[1298067029349117953]', '研发部一', 2, 1, NULL, '', '222222222@qq.com', 3, 0, '', '2021-01-24 15:46:03', 'admin', '2021-01-24 01:45:53');
INSERT INTO `sys_org` VALUES (1353250220777488385, 1298067029349117953, '[0],[1],[1298067029349117953]', '研发部二', 3, 1, NULL, '13678901234', '777777777@qq.com', 3, 0, 'admin', '2021-01-24 16:04:41', 'admin', '2021-01-25 09:15:20');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` bigint(20) NOT NULL,
  `role_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '角色名称(汉字)',
  `role_desc` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '角色描述',
  `role_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '角色的英文code.如：ADMIN',
  `role_sort` int(11) NOT NULL DEFAULT 0 COMMENT '角色顺序',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否禁用，0:启用(否）,1:禁用(是)',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '本条记录创建人',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '本条记录创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '本条记录修改人',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '本条记录的修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `role_code`(`role_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1298061556168273921, '管理员', '系统管理员', 'admin', 1, 0, '', '2021-01-10 20:51:09', '', '2021-01-10 20:51:09');
INSERT INTO `sys_role` VALUES (1298063367197437954, '普通用户', '普通用户', 'common', 2, 0, '', '2021-01-10 20:51:09', '', '2021-01-10 20:51:09');
INSERT INTO `sys_role` VALUES (1312962529638510594, '测试2', '测试2', 'ceshi2', 4, 0, '', '2021-01-16 04:53:20', 'admin', '2021-01-31 07:45:54');
INSERT INTO `sys_role` VALUES (1353244952249323521, '测试1', '测试1', 'ceshi1', 3, 0, 'admin', '2021-01-24 01:35:13', 'admin', '2021-01-24 01:35:13');

-- ----------------------------
-- Table structure for sys_role_api
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_api`;
CREATE TABLE `sys_role_api`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色id',
  `api_id` bigint(20) NOT NULL COMMENT '接口id',
  PRIMARY KEY (`role_id`, `api_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色接口权限关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_api
-- ----------------------------
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 1);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 2);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 3);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 4);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 5);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 6);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 7);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 8);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 9);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 10);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 11);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 12);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 13);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 14);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 15);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 16);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 17);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 18);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 19);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 20);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 21);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 22);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 23);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 24);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 25);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 26);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 27);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 28);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 29);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 30);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 31);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 32);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 33);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 34);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 35);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 36);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 37);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 38);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 39);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 40);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 41);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 42);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 43);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 44);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 1305351823497891842);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 1305352353884409857);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 1305352533799079937);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 1305352644314796033);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 1313305456969621506);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 1313751534453927938);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 1313752151180193793);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 1313752655025156098);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 1313753498440970241);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 1353253517831827458);
INSERT INTO `sys_role_api` VALUES (1298061556168273921, 1359280554647330818);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 1);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 2);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 3);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 4);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 5);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 6);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 7);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 8);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 9);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 10);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 11);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 12);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 13);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 14);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 15);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 16);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 17);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 18);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 19);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 20);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 21);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 22);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 23);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 24);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 25);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 26);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 27);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 28);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 29);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 30);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 31);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 32);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 33);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 34);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 35);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 36);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 37);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 38);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 39);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 40);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 41);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 42);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 43);
INSERT INTO `sys_role_api` VALUES (1298063367197437954, 44);
INSERT INTO `sys_role_api` VALUES (1312962529638510594, 1);
INSERT INTO `sys_role_api` VALUES (1312962529638510594, 2);
INSERT INTO `sys_role_api` VALUES (1312962529638510594, 3);
INSERT INTO `sys_role_api` VALUES (1312962529638510594, 4);
INSERT INTO `sys_role_api` VALUES (1312962529638510594, 5);
INSERT INTO `sys_role_api` VALUES (1312962529638510594, 6);
INSERT INTO `sys_role_api` VALUES (1312962529638510594, 8);
INSERT INTO `sys_role_api` VALUES (1312962529638510594, 26);
INSERT INTO `sys_role_api` VALUES (1312962529638510594, 27);
INSERT INTO `sys_role_api` VALUES (1312962529638510594, 28);
INSERT INTO `sys_role_api` VALUES (1312962529638510594, 29);
INSERT INTO `sys_role_api` VALUES (1312962529638510594, 30);
INSERT INTO `sys_role_api` VALUES (1312962529638510594, 31);
INSERT INTO `sys_role_api` VALUES (1312962529638510594, 32);
INSERT INTO `sys_role_api` VALUES (1312962529638510594, 33);
INSERT INTO `sys_role_api` VALUES (1312962529638510594, 34);
INSERT INTO `sys_role_api` VALUES (1312962529638510594, 35);
INSERT INTO `sys_role_api` VALUES (1312962529638510594, 39);
INSERT INTO `sys_role_api` VALUES (1312962529638510594, 40);
INSERT INTO `sys_role_api` VALUES (1312962529638510594, 41);
INSERT INTO `sys_role_api` VALUES (1312962529638510594, 1305351823497891842);
INSERT INTO `sys_role_api` VALUES (1312962529638510594, 1305352353884409857);
INSERT INTO `sys_role_api` VALUES (1312962529638510594, 1305352533799079937);
INSERT INTO `sys_role_api` VALUES (1312962529638510594, 1305352644314796033);
INSERT INTO `sys_role_api` VALUES (1312962529638510594, 1313305456969621506);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 1);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 2);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 3);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 4);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 8);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 12);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 13);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 14);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 15);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 16);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 17);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 18);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 19);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 20);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 21);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 22);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 23);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 24);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 25);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 26);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 27);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 28);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 29);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 30);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 31);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 32);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 33);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 34);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 35);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 39);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 40);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 41);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 1313305456969621506);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 1313751534453927938);
INSERT INTO `sys_role_api` VALUES (1353244952249323521, 1313752151180193793);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint(20) NOT NULL DEFAULT 0 COMMENT '角色id',
  `menu_id` bigint(20) NOT NULL DEFAULT 0 COMMENT '权限id',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色菜单权限关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1298061556168273921, 1);
INSERT INTO `sys_role_menu` VALUES (1298061556168273921, 2);
INSERT INTO `sys_role_menu` VALUES (1298061556168273921, 3);
INSERT INTO `sys_role_menu` VALUES (1298061556168273921, 4);
INSERT INTO `sys_role_menu` VALUES (1298061556168273921, 5);
INSERT INTO `sys_role_menu` VALUES (1298061556168273921, 6);
INSERT INTO `sys_role_menu` VALUES (1298061556168273921, 7);
INSERT INTO `sys_role_menu` VALUES (1298061556168273921, 10);
INSERT INTO `sys_role_menu` VALUES (1298061556168273921, 11);
INSERT INTO `sys_role_menu` VALUES (1298061556168273921, 12);
INSERT INTO `sys_role_menu` VALUES (1298061556168273921, 13);
INSERT INTO `sys_role_menu` VALUES (1298061556168273921, 1301717053454974978);
INSERT INTO `sys_role_menu` VALUES (1298061556168273921, 1360763330525454338);
INSERT INTO `sys_role_menu` VALUES (1298061556168273921, 1360764106014515202);
INSERT INTO `sys_role_menu` VALUES (1298061556168273921, 1360764611331678210);
INSERT INTO `sys_role_menu` VALUES (1298061556168273921, 1365853419727286273);
INSERT INTO `sys_role_menu` VALUES (1298063367197437954, 1);
INSERT INTO `sys_role_menu` VALUES (1298063367197437954, 2);
INSERT INTO `sys_role_menu` VALUES (1298063367197437954, 3);
INSERT INTO `sys_role_menu` VALUES (1298063367197437954, 5);
INSERT INTO `sys_role_menu` VALUES (1298063367197437954, 6);
INSERT INTO `sys_role_menu` VALUES (1298063367197437954, 7);
INSERT INTO `sys_role_menu` VALUES (1298063367197437954, 10);
INSERT INTO `sys_role_menu` VALUES (1298063367197437954, 11);
INSERT INTO `sys_role_menu` VALUES (1298063367197437954, 12);
INSERT INTO `sys_role_menu` VALUES (1298063367197437954, 13);
INSERT INTO `sys_role_menu` VALUES (1298063367197437954, 1360763330525454338);
INSERT INTO `sys_role_menu` VALUES (1298063367197437954, 1360764106014515202);
INSERT INTO `sys_role_menu` VALUES (1298063367197437954, 1360764611331678210);
INSERT INTO `sys_role_menu` VALUES (1312962529638510594, 1);
INSERT INTO `sys_role_menu` VALUES (1312962529638510594, 2);
INSERT INTO `sys_role_menu` VALUES (1312962529638510594, 3);
INSERT INTO `sys_role_menu` VALUES (1312962529638510594, 4);
INSERT INTO `sys_role_menu` VALUES (1312962529638510594, 5);
INSERT INTO `sys_role_menu` VALUES (1312962529638510594, 1360763330525454338);
INSERT INTO `sys_role_menu` VALUES (1312962529638510594, 1360764106014515202);
INSERT INTO `sys_role_menu` VALUES (1312962529638510594, 1360764611331678210);
INSERT INTO `sys_role_menu` VALUES (1353244952249323521, 1);
INSERT INTO `sys_role_menu` VALUES (1353244952249323521, 2);
INSERT INTO `sys_role_menu` VALUES (1353244952249323521, 3);
INSERT INTO `sys_role_menu` VALUES (1353244952249323521, 4);
INSERT INTO `sys_role_menu` VALUES (1353244952249323521, 5);
INSERT INTO `sys_role_menu` VALUES (1353244952249323521, 6);
INSERT INTO `sys_role_menu` VALUES (1353244952249323521, 7);
INSERT INTO `sys_role_menu` VALUES (1353244952249323521, 12);
INSERT INTO `sys_role_menu` VALUES (1353244952249323521, 13);
INSERT INTO `sys_role_menu` VALUES (1353244952249323521, 1360763330525454338);
INSERT INTO `sys_role_menu` VALUES (1353244952249323521, 1360764106014515202);
INSERT INTO `sys_role_menu` VALUES (1353244952249323521, 1360764611331678210);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint(20) NOT NULL,
  `username` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '用户名',
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '密码',
  `org_id` bigint(20) NOT NULL COMMENT '组织id',
  `enabled` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0禁用用户，1是激活用户',
  `account_non_locked` tinyint(1) NULL DEFAULT NULL COMMENT '0锁定用户，1正常用户',
  `phone` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `email` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'email',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '本条记录创建人',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '本条记录创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '本条记录修改人',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '本条记录的修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1297873308628307970, 'admin', '$2a$10$/yOSnA2NwMh4UwXK5K8gnOUI37y.Jl.eAwnXrfML6SXoTRwWThvN6', 1, 1, 1, '13214456784', 'hahaha1@163.com', '', '2020-10-06 10:32:22', 'admin', '2021-04-15 11:16:49');
INSERT INTO `sys_user` VALUES (1298090120930418690, 'yanfa1', '$2a$10$.Bj/zLMXc5RXzHadk2mbguHdHWdhSUSleDRhcf./SdxhlJyuYbvOe', 1, 1, 1, '13245678901', '', '', '2020-08-24 21:49:12', '', '2021-04-15 10:24:11');
INSERT INTO `sys_user` VALUES (1312546457345118209, 'nav', '$2a$10$dqFkbqOddDBGe28NqTb.NOkAOt64NJMEHxCZpxyn.LzNtoIu9S5P2', 1298067674592456706, 1, 1, '13214456789', '', '', '2020-10-03 19:13:56', '', '2021-04-15 10:24:12');
INSERT INTO `sys_user` VALUES (1353244456323207169, 'ccaa1', '$2a$10$A0OIoLpe6y5j76b1HdhZLONXZAc4uFjatP0EJvYuu2dvFTin8vrCu', 1298067029349117953, 1, 1, '13215556666', '', 'admin', '2021-01-24 01:33:15', 'admin', '2021-04-15 10:24:13');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `role_id` bigint(20) NOT NULL DEFAULT 0 COMMENT '角色自增id',
  `user_id` bigint(20) NOT NULL DEFAULT 0 COMMENT '用户自增id',
  PRIMARY KEY (`role_id`, `user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户角色关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1298061556168273921, 1297873308628307970);
INSERT INTO `sys_user_role` VALUES (1298063367197437954, 2);
INSERT INTO `sys_user_role` VALUES (1298063367197437954, 1298088185716301826);
INSERT INTO `sys_user_role` VALUES (1298063367197437954, 1298090120930418690);
INSERT INTO `sys_user_role` VALUES (1298063367197437954, 1312704409347657730);
INSERT INTO `sys_user_role` VALUES (1312962529638510594, 1);
INSERT INTO `sys_user_role` VALUES (1312962529638510594, 1312546457345118209);
INSERT INTO `sys_user_role` VALUES (1312962529638510594, 1313053560677601281);
INSERT INTO `sys_user_role` VALUES (1312962529638510594, 1354223802659696641);
INSERT INTO `sys_user_role` VALUES (1353244952249323521, 1353244456323207169);

SET FOREIGN_KEY_CHECKS = 1;
