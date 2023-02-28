/*
 Navicat Premium Data Transfer

 Source Server         : swq
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : mydb

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 30/05/2020 18:21:39
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for post
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of post
-- ----------------------------
INSERT INTO `post` VALUES (1, '销售');
INSERT INTO `post` VALUES (2, '程序员');
INSERT INTO `post` VALUES (3, '会计');
INSERT INTO `post` VALUES (4, '实习生');

-- ----------------------------
-- Table structure for section
-- ----------------------------
DROP TABLE IF EXISTS `section`;
CREATE TABLE `section`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `super` int(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of section
-- ----------------------------
INSERT INTO `section` VALUES (1, '财务部', 0);
INSERT INTO `section` VALUES (2, '产品部', 0);
INSERT INTO `section` VALUES (3, '销售部', 0);
INSERT INTO `section` VALUES (4, '武汉财务部', 1);
INSERT INTO `section` VALUES (5, '徐州财务部', 1);
INSERT INTO `section` VALUES (6, '北京财务部', 1);
INSERT INTO `section` VALUES (7, '南昌产品部', 2);
INSERT INTO `section` VALUES (8, '西凉产品部', 2);
INSERT INTO `section` VALUES (9, '深圳销售部', 3);

-- ----------------------------
-- Table structure for staff
-- ----------------------------
DROP TABLE IF EXISTS `staff`;
CREATE TABLE `staff`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sex` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `birthday` date NULL DEFAULT NULL,
  `other` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `seid` int(11) NULL DEFAULT NULL,
  `poid` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 200529035 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of staff
-- ----------------------------
INSERT INTO `staff` VALUES (200529030, '123', '男', '2020-05-05', '123', 4, 2);
INSERT INTO `staff` VALUES (200529034, '马化腾', '男', '2014-05-12', '老板', 5, 4);
INSERT INTO `staff` VALUES (200529003, '刘备', '男', '1994-05-13', NULL, 5, 4);
INSERT INTO `staff` VALUES (200529032, '貂蝉', '女', '2015-06-02', '123', 5, 2);
INSERT INTO `staff` VALUES (200529005, '贾诩', '女', '1984-06-12', NULL, 6, 3);
INSERT INTO `staff` VALUES (200529007, '曹操', '男', '1987-01-07', NULL, 8, 2);
INSERT INTO `staff` VALUES (200529008, '小乔', '女', '1988-10-26', NULL, 8, 2);
INSERT INTO `staff` VALUES (200529009, '大乔', '女', '1999-11-04', NULL, 4, 1);
INSERT INTO `staff` VALUES (200529010, '孙尚香', '女', '2008-08-08', NULL, 9, 4);
INSERT INTO `staff` VALUES (200529011, '貂蝉', '女', '1945-11-30', NULL, 7, 1);
INSERT INTO `staff` VALUES (200529012, '孙万青', '男', '2020-05-06', '', 2, 4);
INSERT INTO `staff` VALUES (200529013, '鲁迅213', '女', '2020-05-25', '123', 4, 2);
INSERT INTO `staff` VALUES (200529014, '庞统', '男', '2013-03-19', '凤雏', 5, 3);
INSERT INTO `staff` VALUES (200529015, '周瑜', '女', '2009-05-11', '东风不与周郎便，铜雀春深锁二乔', 5, 4);
INSERT INTO `staff` VALUES (200529016, '码云', '男', '2020-05-26', '123', 5, 1);
INSERT INTO `staff` VALUES (200529017, '我没收到', '男', '2020-05-04', '123', 5, 2);
INSERT INTO `staff` VALUES (200529018, '免税店你', '男', '2020-05-05', '123', 4, 2);
INSERT INTO `staff` VALUES (200529019, '123213', '男', '2020-05-13', '123', 4, 2);
INSERT INTO `staff` VALUES (200529020, '什么大气', '男', '2020-05-05', '123', 5, 2);
INSERT INTO `staff` VALUES (200529021, '打磨按上面的', '女', '2020-05-04', '', 4, 2);
INSERT INTO `staff` VALUES (200529022, '打磨按上面的', '女', '2020-05-04', '', 4, 2);
INSERT INTO `staff` VALUES (200529023, '请问', '女', '2020-05-05', '', 5, 2);
INSERT INTO `staff` VALUES (200529024, '123123', '男', '2020-05-12', '', 4, 2);
INSERT INTO `staff` VALUES (200529025, '2131232', '男', '2020-05-12', '', 4, 2);
INSERT INTO `staff` VALUES (200529026, '年末文', '男', '2020-05-05', '123', 9, 1);
INSERT INTO `staff` VALUES (200529027, '13231232', '男', '2020-05-19', '2', 9, 3);
INSERT INTO `staff` VALUES (200529028, '13231232', '男', '2020-05-19', '2', 9, 3);
INSERT INTO `staff` VALUES (200529029, '马而我却二', '男', '2020-04-28', '', 6, 2);
INSERT INTO `staff` VALUES (200529033, '周杰伦', '女', '2020-05-05', '稻香', 5, 2);

SET FOREIGN_KEY_CHECKS = 1;
