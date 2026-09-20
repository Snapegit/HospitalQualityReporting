-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        5.7.26-log - MySQL Community Server (GPL)
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  11.1.0.6116
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- 导出 quality_control_platform 的数据库结构
CREATE DATABASE IF NOT EXISTS `quality_control_platform` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `quality_control_platform`;

-- 导出  表 quality_control_platform.data_classify 结构
CREATE TABLE IF NOT EXISTS `data_classify` (
  `classify_id` bigint(20) NOT NULL COMMENT '分类id',
  `classify_name` varchar(255) DEFAULT NULL COMMENT '分类名称',
  `superior_id` bigint(20) DEFAULT NULL COMMENT '上级分类id',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`classify_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据分类表';

-- 正在导出表  quality_control_platform.data_classify 的数据：~0 rows (大约)
DELETE FROM `data_classify`;
/*!40000 ALTER TABLE `data_classify` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_classify` ENABLE KEYS */;

-- 导出  表 quality_control_platform.gen_table 结构
CREATE TABLE IF NOT EXISTS `gen_table` (
  `table_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='代码生成业务表';

-- 正在导出表  quality_control_platform.gen_table 的数据：~0 rows (大约)
DELETE FROM `gen_table`;
/*!40000 ALTER TABLE `gen_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `gen_table` ENABLE KEYS */;

-- 导出  表 quality_control_platform.gen_table_column 结构
CREATE TABLE IF NOT EXISTS `gen_table_column` (
  `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` varchar(64) DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) DEFAULT '' COMMENT '字典类型',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8 COMMENT='代码生成业务表字段';

-- 正在导出表  quality_control_platform.gen_table_column 的数据：~0 rows (大约)
DELETE FROM `gen_table_column`;
/*!40000 ALTER TABLE `gen_table_column` DISABLE KEYS */;
/*!40000 ALTER TABLE `gen_table_column` ENABLE KEYS */;

-- 导出  表 quality_control_platform.medical_analysis 结构
CREATE TABLE IF NOT EXISTS `medical_analysis` (
  `analysis_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '分析id',
  `data_id` bigint(20) DEFAULT NULL COMMENT '数据id',
  `keywords` varchar(255) DEFAULT NULL COMMENT '关键词',
  `analysis_level` varchar(255) DEFAULT NULL COMMENT '抽取等级',
  `analysis_state` varchar(255) DEFAULT NULL COMMENT '分析状态',
  `reason` varchar(255) DEFAULT NULL COMMENT '分析未通过原因',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`analysis_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据分析表';

-- 正在导出表  quality_control_platform.medical_analysis 的数据：~0 rows (大约)
DELETE FROM `medical_analysis`;
/*!40000 ALTER TABLE `medical_analysis` DISABLE KEYS */;
/*!40000 ALTER TABLE `medical_analysis` ENABLE KEYS */;

-- 导出  表 quality_control_platform.medical_audit 结构
CREATE TABLE IF NOT EXISTS `medical_audit` (
  `audit_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '审计id',
  `data_id` bigint(20) DEFAULT NULL COMMENT '数据id',
  `audit_data_size` varchar(255) DEFAULT NULL COMMENT '审计数据量',
  `pass_data_size` varchar(255) DEFAULT NULL COMMENT '审计通过数据量',
  `not_pass_data_size` varchar(255) DEFAULT NULL COMMENT '审计未通过数据量',
  `audit_state` varchar(255) DEFAULT NULL COMMENT '审计状态',
  `reason` varchar(255) DEFAULT NULL COMMENT '审计未通过原因',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`audit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据审计表';

-- 正在导出表  quality_control_platform.medical_audit 的数据：~0 rows (大约)
DELETE FROM `medical_audit`;
/*!40000 ALTER TABLE `medical_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `medical_audit` ENABLE KEYS */;

-- 导出  表 quality_control_platform.medical_data 结构
CREATE TABLE IF NOT EXISTS `medical_data` (
  `data_id` bigint(20) NOT NULL COMMENT '数据id',
  `data_title` varchar(255) DEFAULT NULL COMMENT '数据标题',
  `data_content` varchar(255) DEFAULT NULL COMMENT '数据内容',
  `matching_state` varchar(255) DEFAULT NULL COMMENT '配对状态',
  `data_url` varchar(255) DEFAULT NULL COMMENT '数据地址',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`data_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='数据表';

-- 正在导出表  quality_control_platform.medical_data 的数据：~0 rows (大约)
DELETE FROM `medical_data`;
/*!40000 ALTER TABLE `medical_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `medical_data` ENABLE KEYS */;

-- 导出  表 quality_control_platform.medical_image_report 结构
CREATE TABLE IF NOT EXISTS `medical_image_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) DEFAULT NULL COMMENT '关联影像类别id',
  `image_title` varchar(50) DEFAULT NULL COMMENT '标题',
  `image_url` varchar(255) DEFAULT NULL COMMENT '图像路径',
  `final_score` varchar(50) DEFAULT NULL COMMENT '最终得分',
  `create_by` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` int(11) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='影像上报表';

-- 正在导出表  quality_control_platform.medical_image_report 的数据：~0 rows (大约)
DELETE FROM `medical_image_report`;
/*!40000 ALTER TABLE `medical_image_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `medical_image_report` ENABLE KEYS */;

-- 导出  表 quality_control_platform.medical_image_score 结构
CREATE TABLE IF NOT EXISTS `medical_image_score` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `report_id` int(11) DEFAULT NULL COMMENT '关联影像上报表id',
  `content_id` int(11) DEFAULT NULL COMMENT '关联模板内容表id',
  `score` int(11) DEFAULT NULL COMMENT '所得分数',
  `create_by` int(11) DEFAULT NULL COMMENT '评分人',
  `create_time` datetime DEFAULT NULL COMMENT '评分时间',
  `update_by` int(11) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='影像评分表';

-- 正在导出表  quality_control_platform.medical_image_score 的数据：~0 rows (大约)
DELETE FROM `medical_image_score`;
/*!40000 ALTER TABLE `medical_image_score` DISABLE KEYS */;
/*!40000 ALTER TABLE `medical_image_score` ENABLE KEYS */;

-- 导出  表 quality_control_platform.medical_image_template 结构
CREATE TABLE IF NOT EXISTS `medical_image_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NOT NULL COMMENT '关联影像类型id',
  `template_name` varchar(50) DEFAULT NULL COMMENT '模板名称',
  `create_by` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` int(11) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='医疗影像模板';

-- 正在导出表  quality_control_platform.medical_image_template 的数据：~0 rows (大约)
DELETE FROM `medical_image_template`;
/*!40000 ALTER TABLE `medical_image_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `medical_image_template` ENABLE KEYS */;

-- 导出  表 quality_control_platform.medical_image_template_content 结构
CREATE TABLE IF NOT EXISTS `medical_image_template_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `template_id` int(11) DEFAULT NULL COMMENT '关联所属影像模板id',
  `evaluation_criterion` varchar(50) DEFAULT NULL COMMENT '考核评价标准',
  `major_content` varchar(255) DEFAULT NULL COMMENT '考核主要内容',
  `score` int(11) DEFAULT NULL COMMENT '分值',
  `create_by` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` int(11) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='影像模板内容表';

-- 正在导出表  quality_control_platform.medical_image_template_content 的数据：~0 rows (大约)
DELETE FROM `medical_image_template_content`;
/*!40000 ALTER TABLE `medical_image_template_content` DISABLE KEYS */;
/*!40000 ALTER TABLE `medical_image_template_content` ENABLE KEYS */;

-- 导出  表 quality_control_platform.medical_image_type 结构
CREATE TABLE IF NOT EXISTS `medical_image_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(50) NOT NULL COMMENT '类型名称',
  `type_code` varchar(50) NOT NULL COMMENT '类型编码',
  `order` int(11) NOT NULL COMMENT '排序字段',
  `create_time` datetime DEFAULT NULL,
  `create_by` int(11) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_by` int(11) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='影像类型表';

-- 正在导出表  quality_control_platform.medical_image_type 的数据：~0 rows (大约)
DELETE FROM `medical_image_type`;
/*!40000 ALTER TABLE `medical_image_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `medical_image_type` ENABLE KEYS */;

-- 导出  表 quality_control_platform.qrtz_blob_triggers 结构
CREATE TABLE IF NOT EXISTS `qrtz_blob_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Blob类型的触发器表';

-- 正在导出表  quality_control_platform.qrtz_blob_triggers 的数据：~0 rows (大约)
DELETE FROM `qrtz_blob_triggers`;
/*!40000 ALTER TABLE `qrtz_blob_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_blob_triggers` ENABLE KEYS */;

-- 导出  表 quality_control_platform.qrtz_calendars 结构
CREATE TABLE IF NOT EXISTS `qrtz_calendars` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`,`calendar_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='日历信息表';

-- 正在导出表  quality_control_platform.qrtz_calendars 的数据：~0 rows (大约)
DELETE FROM `qrtz_calendars`;
/*!40000 ALTER TABLE `qrtz_calendars` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_calendars` ENABLE KEYS */;

-- 导出  表 quality_control_platform.qrtz_cron_triggers 结构
CREATE TABLE IF NOT EXISTS `qrtz_cron_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cron类型的触发器表';

-- 正在导出表  quality_control_platform.qrtz_cron_triggers 的数据：~0 rows (大约)
DELETE FROM `qrtz_cron_triggers`;
/*!40000 ALTER TABLE `qrtz_cron_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_cron_triggers` ENABLE KEYS */;

-- 导出  表 quality_control_platform.qrtz_fired_triggers 结构
CREATE TABLE IF NOT EXISTS `qrtz_fired_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint(13) NOT NULL COMMENT '触发的时间',
  `sched_time` bigint(13) NOT NULL COMMENT '定时器制定的时间',
  `priority` int(11) NOT NULL COMMENT '优先级',
  `state` varchar(16) NOT NULL COMMENT '状态',
  `job_name` varchar(200) DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`,`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='已触发的触发器表';

-- 正在导出表  quality_control_platform.qrtz_fired_triggers 的数据：~0 rows (大约)
DELETE FROM `qrtz_fired_triggers`;
/*!40000 ALTER TABLE `qrtz_fired_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_fired_triggers` ENABLE KEYS */;

-- 导出  表 quality_control_platform.qrtz_job_details 结构
CREATE TABLE IF NOT EXISTS `qrtz_job_details` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) NOT NULL COMMENT '任务组名',
  `description` varchar(250) DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`,`job_name`,`job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务详细信息表';

-- 正在导出表  quality_control_platform.qrtz_job_details 的数据：~0 rows (大约)
DELETE FROM `qrtz_job_details`;
/*!40000 ALTER TABLE `qrtz_job_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_job_details` ENABLE KEYS */;

-- 导出  表 quality_control_platform.qrtz_locks 结构
CREATE TABLE IF NOT EXISTS `qrtz_locks` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`,`lock_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='存储的悲观锁信息表';

-- 正在导出表  quality_control_platform.qrtz_locks 的数据：~0 rows (大约)
DELETE FROM `qrtz_locks`;
/*!40000 ALTER TABLE `qrtz_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_locks` ENABLE KEYS */;

-- 导出  表 quality_control_platform.qrtz_paused_trigger_grps 结构
CREATE TABLE IF NOT EXISTS `qrtz_paused_trigger_grps` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`,`trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='暂停的触发器表';

-- 正在导出表  quality_control_platform.qrtz_paused_trigger_grps 的数据：~0 rows (大约)
DELETE FROM `qrtz_paused_trigger_grps`;
/*!40000 ALTER TABLE `qrtz_paused_trigger_grps` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_paused_trigger_grps` ENABLE KEYS */;

-- 导出  表 quality_control_platform.qrtz_scheduler_state 结构
CREATE TABLE IF NOT EXISTS `qrtz_scheduler_state` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint(13) NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint(13) NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`,`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='调度器状态表';

-- 正在导出表  quality_control_platform.qrtz_scheduler_state 的数据：~0 rows (大约)
DELETE FROM `qrtz_scheduler_state`;
/*!40000 ALTER TABLE `qrtz_scheduler_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_scheduler_state` ENABLE KEYS */;

-- 导出  表 quality_control_platform.qrtz_simple_triggers 结构
CREATE TABLE IF NOT EXISTS `qrtz_simple_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint(7) NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint(12) NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint(10) NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='简单触发器的信息表';

-- 正在导出表  quality_control_platform.qrtz_simple_triggers 的数据：~0 rows (大约)
DELETE FROM `qrtz_simple_triggers`;
/*!40000 ALTER TABLE `qrtz_simple_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_simple_triggers` ENABLE KEYS */;

-- 导出  表 quality_control_platform.qrtz_simprop_triggers 结构
CREATE TABLE IF NOT EXISTS `qrtz_simprop_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int(11) DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int(11) DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint(20) DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint(20) DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='同步机制的行锁表';

-- 正在导出表  quality_control_platform.qrtz_simprop_triggers 的数据：~0 rows (大约)
DELETE FROM `qrtz_simprop_triggers`;
/*!40000 ALTER TABLE `qrtz_simprop_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_simprop_triggers` ENABLE KEYS */;

-- 导出  表 quality_control_platform.qrtz_triggers 结构
CREATE TABLE IF NOT EXISTS `qrtz_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint(13) DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint(13) DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int(11) DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) NOT NULL COMMENT '触发器的类型',
  `start_time` bigint(13) NOT NULL COMMENT '开始时间',
  `end_time` bigint(13) DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint(2) DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  KEY `sched_name` (`sched_name`,`job_name`,`job_group`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='触发器详细信息表';

-- 正在导出表  quality_control_platform.qrtz_triggers 的数据：~0 rows (大约)
DELETE FROM `qrtz_triggers`;
/*!40000 ALTER TABLE `qrtz_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_triggers` ENABLE KEYS */;

-- 导出  表 quality_control_platform.rep_classify 结构
CREATE TABLE IF NOT EXISTS `rep_classify` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `classify_name` varchar(50) DEFAULT NULL COMMENT '分类名称',
  `sort` int(11) DEFAULT NULL COMMENT '排序字段',
  `create_by` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` int(11) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `remark` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='上报分类表';

-- 正在导出表  quality_control_platform.rep_classify 的数据：~0 rows (大约)
DELETE FROM `rep_classify`;
/*!40000 ALTER TABLE `rep_classify` DISABLE KEYS */;
INSERT INTO `rep_classify` (`id`, `classify_name`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(12, '测试', 1, 1, '2024-05-28 19:35:51', NULL, NULL, NULL);
/*!40000 ALTER TABLE `rep_classify` ENABLE KEYS */;

-- 导出  表 quality_control_platform.rep_content 结构
CREATE TABLE IF NOT EXISTS `rep_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `report_title` varchar(50) DEFAULT NULL COMMENT '上报标题',
  `template_id` int(11) DEFAULT NULL COMMENT '关联上报模板表id',
  `content_json` longtext COMMENT '表单内容json',
  `create_by` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` int(11) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `remark` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2903 DEFAULT CHARSET=utf8 COMMENT='上报内容表';

-- 正在导出表  quality_control_platform.rep_content 的数据：~0 rows (大约)
DELETE FROM `rep_content`;
/*!40000 ALTER TABLE `rep_content` DISABLE KEYS */;
INSERT INTO `rep_content` (`id`, `report_title`, `template_id`, `content_json`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(2902, '测试标题', 138, '{"eug633b8f2mv":"111","v6y633b8f9ok":"1","amp633b8hew7":[],"rtb1oux4ccjua":"<p>11111<br/></p>"}', 1, '2024-05-28 19:36:29', NULL, NULL, '');
/*!40000 ALTER TABLE `rep_content` ENABLE KEYS */;

-- 导出  表 quality_control_platform.rep_template 结构
CREATE TABLE IF NOT EXISTS `rep_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `classify_id` int(11) NOT NULL COMMENT '关联上报分类表id',
  `template_name` varchar(50) NOT NULL COMMENT '模板名称',
  `report_num` tinyint(4) NOT NULL COMMENT '上报次数(0: 多次，1：一次)',
  `form_property` longtext COMMENT '表单属性',
  `unit_property` longtext COMMENT '组件属性',
  `create_by` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` int(11) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `remark` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8 COMMENT='上报模板表';

-- 正在导出表  quality_control_platform.rep_template 的数据：~0 rows (大约)
DELETE FROM `rep_template`;
/*!40000 ALTER TABLE `rep_template` DISABLE KEYS */;
INSERT INTO `rep_template` (`id`, `classify_id`, `template_name`, `report_num`, `form_property`, `unit_property`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(138, 12, '测试模版', 1, '[{"type":"input","field":"eug633b8f2mv","title":"输入框","info":"","_fc_drag_tag":"input","hidden":false,"display":true},{"type":"select","field":"v6y633b8f9ok","title":"选择器","info":"","effect":{"fetch":""},"options":[{"value":"1","label":"选项1"},{"value":"2","label":"选项2"}],"_fc_drag_tag":"select","hidden":false,"display":true},{"type":"upload","field":"amp633b8hew7","title":"上传","handleIcon":true,"withCredentials":true,"props":{"handleIcon":true,"action":"http://127.0.0.1:13576/wechat/upload","onHandle":"function handleFunc(files) {\\n        console.log(files);\\n      }","onSuccess":"function successFunc(res, file) {\\n        file.url = res.data.url || \\"\\";\\n      }"},"value":[]},{"type":"fc-editor","field":"rtb1oux4ccjua","title":"富文本框","info":"","_fc_drag_tag":"fc-editor","hidden":false,"display":true,"props":{"disabled":false}}]', '{"form":{"labelPosition":"right","size":"medium","labelWidth":"125px","hideRequiredAsterisk":false,"showMessage":true,"inlineMessage":false},"submitBtn":false,"resetBtn":false}', 1, '2024-05-28 19:36:06', NULL, NULL, NULL);
/*!40000 ALTER TABLE `rep_template` ENABLE KEYS */;

-- 导出  表 quality_control_platform.sys_config 结构
CREATE TABLE IF NOT EXISTS `sys_config` (
  `config_id` int(5) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COMMENT='参数配置表';

-- 正在导出表  quality_control_platform.sys_config 的数据：~0 rows (大约)
DELETE FROM `sys_config`;
/*!40000 ALTER TABLE `sys_config` DISABLE KEYS */;
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2022-08-17 14:35:39', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow'),
	(2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2022-08-17 14:35:39', '', NULL, '初始化密码 123456'),
	(3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2022-08-17 14:35:39', '', NULL, '深色主题theme-dark，浅色主题theme-light'),
	(4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2022-08-17 14:35:39', '', NULL, '是否开启验证码功能（true开启，false关闭）'),
	(5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2022-08-17 14:35:39', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
/*!40000 ALTER TABLE `sys_config` ENABLE KEYS */;

-- 导出  表 quality_control_platform.sys_dept 结构
CREATE TABLE IF NOT EXISTS `sys_dept` (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) DEFAULT '0' COMMENT '父部门id',
  `ancestors` varchar(50) DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) DEFAULT '' COMMENT '部门名称',
  `area_code` varchar(255) DEFAULT '' COMMENT '所属地区编码',
  `area_describe` varchar(255) DEFAULT '' COMMENT '所属地区描述',
  `position` varchar(255) DEFAULT '' COMMENT '位置（经纬度）',
  `position_describe` varchar(255) DEFAULT '' COMMENT '位置描述',
  `order_num` int(4) DEFAULT '0' COMMENT '显示顺序',
  `leader` varchar(20) DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `status` char(1) DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=217 DEFAULT CHARSET=utf8 COMMENT='部门表';

-- 正在导出表  quality_control_platform.sys_dept 的数据：~0 rows (大约)
DELETE FROM `sys_dept`;
/*!40000 ALTER TABLE `sys_dept` DISABLE KEYS */;
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `area_code`, `area_describe`, `position`, `position_describe`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES
	(100, 0, '0', '医院1', '220000,220100,220171', '吉林省长春市长春经济技术开发区', '125.379187,43.861582', '吉林省长春市南关区临河街道中日联谊医院', 0, 'ky', '15888888888', 'ky@qq.com', '0', '0', 'admin', '2022-09-19 14:25:38', 'admin', '2024-05-28 19:26:27'),
	(101, 100, '0,100', '下属医院', '220000,220100,220103', '吉林省长春市宽城区', '125.36455,43.856795', '吉林省长春市南关区临河街道韩大伟小炉子烧烤南关配电分公司建筑工程分公司', 1, 'ky', '15888888888', 'ky@qq.com', '0', '0', 'admin', '2022-08-17 14:35:38', 'admin', '2023-01-30 11:09:03');
/*!40000 ALTER TABLE `sys_dept` ENABLE KEYS */;

-- 导出  表 quality_control_platform.sys_dict_data 结构
CREATE TABLE IF NOT EXISTS `sys_dict_data` (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(4) DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8 COMMENT='字典数据表';

-- 正在导出表  quality_control_platform.sys_dict_data 的数据：~0 rows (大约)
DELETE FROM `sys_dict_data`;
/*!40000 ALTER TABLE `sys_dict_data` DISABLE KEYS */;
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '性别男'),
	(2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '性别女'),
	(3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '性别未知'),
	(4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '显示菜单'),
	(5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '隐藏菜单'),
	(6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '正常状态'),
	(7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '停用状态'),
	(8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '正常状态'),
	(9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '停用状态'),
	(10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '默认分组'),
	(11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '系统分组'),
	(12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '系统默认是'),
	(13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '系统默认否'),
	(14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '通知'),
	(15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '公告'),
	(16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '正常状态'),
	(17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '关闭状态'),
	(18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '其他操作'),
	(19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '新增操作'),
	(20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '修改操作'),
	(21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '删除操作'),
	(22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '授权操作'),
	(23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '导出操作'),
	(24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '导入操作'),
	(25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '强退操作'),
	(26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '生成操作'),
	(27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '清空操作'),
	(28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '正常状态'),
	(29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '停用状态'),
	(111, 1, '二级', '二级', 'hospital_level', NULL, 'default', 'N', '0', 'admin', '2023-01-28 14:33:30', '', NULL, NULL),
	(112, 2, '三级', '三级', 'hospital_level', NULL, 'default', 'N', '0', 'admin', '2023-01-28 14:33:43', '', NULL, NULL),
	(113, 3, '二甲', '二甲', 'hospital_level', NULL, 'default', 'N', '0', 'admin', '2023-01-28 14:34:03', '', NULL, NULL),
	(114, 4, '三甲', '三甲', 'hospital_level', NULL, 'default', 'N', '0', 'admin', '2023-01-28 14:34:12', '', NULL, NULL),
	(115, 5, '二乙', '二乙', 'hospital_level', NULL, 'default', 'N', '0', 'admin', '2023-01-28 14:34:39', '', NULL, NULL),
	(116, 6, '三乙', '三乙', 'hospital_level', NULL, 'default', 'N', '0', 'admin', '2023-01-28 14:34:53', '', NULL, NULL),
	(117, 7, '民营', '民营', 'hospital_level', NULL, 'default', 'N', '0', 'admin', '2023-01-28 14:35:28', '', NULL, NULL),
	(118, 8, '未定级', '未定级', 'hospital_level', NULL, 'default', 'N', '0', 'admin', '2023-01-28 14:35:52', 'admin', '2023-01-29 08:54:21', NULL),
	(119, 1, '白山', '白山', 'regin_area', NULL, 'default', 'N', '0', 'admin', '2023-01-31 15:13:57', '', NULL, NULL),
	(120, 2, '长白', '长白', 'regin_area', NULL, 'default', 'N', '0', 'admin', '2023-01-31 15:14:13', 'admin', '2023-01-31 15:14:17', NULL),
	(121, 3, '通化', '通化', 'regin_area', NULL, 'default', 'N', '0', 'admin', '2023-01-31 15:14:31', 'admin', '2023-01-31 15:55:20', NULL),
	(122, 4, '四平', '四平', 'regin_area', NULL, 'default', 'N', '0', 'admin', '2023-01-31 15:14:41', '', NULL, NULL),
	(123, 5, '延边', '延边', 'regin_area', NULL, 'default', 'N', '0', 'admin', '2023-01-31 15:14:57', '', NULL, NULL),
	(124, 6, '松原', '松原', 'regin_area', NULL, 'default', 'N', '0', 'admin', '2023-01-31 15:15:09', '', NULL, NULL),
	(125, 7, '长春', '长春', 'regin_area', NULL, 'default', 'N', '0', 'admin', '2023-01-31 15:15:19', '', NULL, NULL),
	(126, 8, '吉林', '吉林', 'regin_area', '', 'default', 'N', '0', 'admin', '2023-01-31 15:15:34', 'admin', '2023-01-31 15:15:57', NULL),
	(127, 9, '辽源', '辽源', 'regin_area', NULL, 'default', 'N', '0', 'admin', '2023-01-31 15:16:33', '', NULL, NULL),
	(128, 10, '公主岭', '公主岭', 'regin_area', NULL, 'default', 'N', '0', 'admin', '2023-01-31 15:16:45', '', NULL, NULL),
	(129, 11, '梅河口', '梅河口', 'regin_area', NULL, 'default', 'N', '0', 'admin', '2023-01-31 15:16:56', '', NULL, NULL),
	(130, 12, '白城', '白城', 'regin_area', NULL, 'default', 'N', '0', 'admin', '2023-01-31 15:17:10', '', NULL, NULL);
/*!40000 ALTER TABLE `sys_dict_data` ENABLE KEYS */;

-- 导出  表 quality_control_platform.sys_dict_type 结构
CREATE TABLE IF NOT EXISTS `sys_dict_type` (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`),
  UNIQUE KEY `dict_type` (`dict_type`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8 COMMENT='字典类型表';

-- 正在导出表  quality_control_platform.sys_dict_type 的数据：~0 rows (大约)
DELETE FROM `sys_dict_type`;
/*!40000 ALTER TABLE `sys_dict_type` DISABLE KEYS */;
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(1, '用户性别', 'sys_user_sex', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '用户性别列表'),
	(2, '菜单状态', 'sys_show_hide', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '菜单状态列表'),
	(3, '系统开关', 'sys_normal_disable', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '系统开关列表'),
	(4, '任务状态', 'sys_job_status', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '任务状态列表'),
	(5, '任务分组', 'sys_job_group', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '任务分组列表'),
	(6, '系统是否', 'sys_yes_no', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '系统是否列表'),
	(7, '通知类型', 'sys_notice_type', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '通知类型列表'),
	(8, '通知状态', 'sys_notice_status', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '通知状态列表'),
	(9, '操作类型', 'sys_oper_type', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '操作类型列表'),
	(10, '系统状态', 'sys_common_status', '0', 'admin', '2022-08-17 14:35:39', '', NULL, '登录状态列表'),
	(104, '医院级别', 'hospital_level', '0', 'admin', '2023-01-28 14:32:42', '', NULL, NULL),
	(105, '所属地区', 'regin_area', '0', 'admin', '2023-01-31 15:12:56', '', NULL, NULL);
/*!40000 ALTER TABLE `sys_dict_type` ENABLE KEYS */;

-- 导出  表 quality_control_platform.sys_job 结构
CREATE TABLE IF NOT EXISTS `sys_job` (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`,`job_name`,`job_group`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8 COMMENT='定时任务调度表';

-- 正在导出表  quality_control_platform.sys_job 的数据：~0 rows (大约)
DELETE FROM `sys_job`;
/*!40000 ALTER TABLE `sys_job` DISABLE KEYS */;
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2024-01-11 10:39:45', '', NULL, ''),
	(2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2024-01-11 10:39:45', '', NULL, ''),
	(3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2024-01-11 10:39:45', '', NULL, '');
/*!40000 ALTER TABLE `sys_job` ENABLE KEYS */;

-- 导出  表 quality_control_platform.sys_job_log 结构
CREATE TABLE IF NOT EXISTS `sys_job_log` (
  `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) DEFAULT NULL COMMENT '日志信息',
  `status` char(1) DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) DEFAULT '' COMMENT '异常信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='定时任务调度日志表';

-- 正在导出表  quality_control_platform.sys_job_log 的数据：~0 rows (大约)
DELETE FROM `sys_job_log`;
/*!40000 ALTER TABLE `sys_job_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_job_log` ENABLE KEYS */;

-- 导出  表 quality_control_platform.sys_logininfor 结构
CREATE TABLE IF NOT EXISTS `sys_logininfor` (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) DEFAULT '' COMMENT '操作系统',
  `status` char(1) DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) DEFAULT '' COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2156 DEFAULT CHARSET=utf8 COMMENT='系统访问记录';

-- 正在导出表  quality_control_platform.sys_logininfor 的数据：~0 rows (大约)
DELETE FROM `sys_logininfor`;
/*!40000 ALTER TABLE `sys_logininfor` DISABLE KEYS */;
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES
	(100, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2024-01-11 13:54:10'),
	(101, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '退出成功', '2024-01-11 14:40:57'),
	(102, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2024-01-11 14:41:07'),
	(103, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2024-01-11 16:06:00'),
	(104, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2024-01-12 10:34:21'),
	(105, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2024-01-12 13:15:56'),
	(106, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2024-01-12 14:53:30'),
	(2147, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2024-05-28 19:17:05'),
	(2148, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '退出成功', '2024-05-28 19:18:50'),
	(2149, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2024-05-28 19:19:03'),
	(2150, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '退出成功', '2024-05-28 19:19:43'),
	(2151, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2024-05-28 19:22:12'),
	(2152, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '退出成功', '2024-05-28 19:26:44'),
	(2153, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2024-05-28 19:33:02'),
	(2154, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '退出成功', '2024-05-28 19:34:05'),
	(2155, 'admin', '127.0.0.1', '内网IP', 'Firefox 12', 'Windows 10', '0', '登录成功', '2024-05-28 19:34:15');
/*!40000 ALTER TABLE `sys_logininfor` ENABLE KEYS */;

-- 导出  表 quality_control_platform.sys_menu 结构
CREATE TABLE IF NOT EXISTS `sys_menu` (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) DEFAULT '0' COMMENT '父菜单ID',
  `order_num` int(4) DEFAULT '0' COMMENT '显示顺序',
  `path` varchar(200) DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) DEFAULT NULL COMMENT '路由参数',
  `is_frame` int(1) DEFAULT '1' COMMENT '是否为外链（0是 1否）',
  `is_cache` int(1) DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2047 DEFAULT CHARSET=utf8 COMMENT='菜单权限表';

-- 正在导出表  quality_control_platform.sys_menu 的数据：~0 rows (大约)
DELETE FROM `sys_menu`;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(1, '系统管理', 0, 1, 'system', NULL, '', 1, 0, 'M', '0', '0', '', 'exit-fullscreen', 'admin', '2022-08-17 14:35:38', 'zrl', '2022-10-17 16:12:56', '系统管理目录'),
	(2, '系统监控', 0, 2, 'monitor', NULL, '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2022-08-17 14:35:38', '', NULL, '系统监控目录'),
	(3, '系统工具', 0, 3, 'tool', NULL, '', 1, 0, 'M', '0', '0', '', 'bug', 'admin', '2022-08-17 14:35:39', 'admin', '2022-11-03 13:47:08', '系统工具目录'),
	(100, '用户管理', 1, 1, 'user', 'system/user/index', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2022-08-17 14:35:39', '', NULL, '用户管理菜单'),
	(101, '角色管理', 1, 2, 'role', 'system/role/index', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2022-08-17 14:35:39', '', NULL, '角色管理菜单'),
	(102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2022-08-17 14:35:39', '', NULL, '菜单管理菜单'),
	(103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2022-08-17 14:35:39', '', NULL, '部门管理菜单'),
	(104, '岗位管理', 1, 5, 'post', 'system/post/index', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2022-08-17 14:35:39', '', NULL, '岗位管理菜单'),
	(105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2022-08-17 14:35:39', '', NULL, '字典管理菜单'),
	(106, '参数设置', 1, 7, 'config', 'system/config/index', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2022-08-17 14:35:39', '', NULL, '参数设置菜单'),
	(107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2022-08-17 14:35:39', '', NULL, '通知公告菜单'),
	(108, '日志管理', 1, 9, 'log', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2022-08-17 14:35:39', '', NULL, '日志管理菜单'),
	(109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2022-08-17 14:35:39', '', NULL, '在线用户菜单'),
	(110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2022-08-17 14:35:39', '', NULL, '定时任务菜单'),
	(111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2022-08-17 14:35:39', '', NULL, '数据监控菜单'),
	(112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2022-08-17 14:35:39', '', NULL, '服务监控菜单'),
	(113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2022-08-17 14:35:39', '', NULL, '缓存监控菜单'),
	(114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2022-08-17 14:35:39', '', NULL, '缓存列表菜单'),
	(115, '表单构建', 3, 1, 'build', 'tool/build/index', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2022-08-17 14:35:39', '', NULL, '表单构建菜单'),
	(116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2022-08-17 14:35:39', '', NULL, '代码生成菜单'),
	(117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2022-08-17 14:35:39', '', NULL, '系统接口菜单'),
	(500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2022-08-17 14:35:39', '', NULL, '操作日志菜单'),
	(501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2022-08-17 14:35:39', '', NULL, '登录日志菜单'),
	(1000, '用户查询', 100, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1001, '用户新增', 100, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1002, '用户修改', 100, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1003, '用户删除', 100, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1004, '用户导出', 100, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1005, '用户导入', 100, 6, '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1006, '重置密码', 100, 7, '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1007, '角色查询', 101, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1008, '角色新增', 101, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1009, '角色修改', 101, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1010, '角色删除', 101, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1011, '角色导出', 101, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1012, '菜单查询', 102, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1013, '菜单新增', 102, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1014, '菜单修改', 102, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1015, '菜单删除', 102, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1016, '部门查询', 103, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1017, '部门新增', 103, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1018, '部门修改', 103, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1019, '部门删除', 103, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1020, '岗位查询', 104, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1021, '岗位新增', 104, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1022, '岗位修改', 104, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1023, '岗位删除', 104, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1024, '岗位导出', 104, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1025, '字典查询', 105, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1026, '字典新增', 105, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1027, '字典修改', 105, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1028, '字典删除', 105, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1029, '字典导出', 105, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1030, '参数查询', 106, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1031, '参数新增', 106, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1032, '参数修改', 106, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1033, '参数删除', 106, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1034, '参数导出', 106, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1035, '公告查询', 107, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1036, '公告新增', 107, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1037, '公告修改', 107, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1038, '公告删除', 107, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1039, '操作查询', 500, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1040, '操作删除', 500, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1041, '日志导出', 500, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1042, '登录查询', 501, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1043, '登录删除', 501, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1044, '日志导出', 501, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1045, '账户解锁', 501, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1046, '在线查询', 109, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1047, '批量强退', 109, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1048, '单条强退', 109, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1049, '任务查询', 110, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1050, '任务新增', 110, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1051, '任务修改', 110, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1052, '任务删除', 110, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1053, '状态修改', 110, 5, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1054, '任务导出', 110, 6, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1055, '生成查询', 115, 1, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1056, '生成修改', 115, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1057, '生成删除', 115, 3, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1058, '导入代码', 115, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1059, '预览代码', 115, 4, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(1060, '生成代码', 115, 5, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2022-08-17 14:35:39', '', NULL, ''),
	(2000, '上报管理', 0, 4, 'reportManager', NULL, NULL, 1, 0, 'M', '0', '0', '', 'build', 'admin', '2022-09-14 09:32:21', 'admin', '2022-09-14 09:32:32', ''),
	(2001, '上报模板', 2000, 2, 'reportTemplate', 'report/template/index', NULL, 1, 0, 'C', '0', '0', 'report:template:list', 'build', 'admin', '2022-09-14 09:33:27', 'admin', '2022-09-16 08:32:50', ''),
	(2002, '上报类型', 2000, 1, 'classify', 'report/classify/index', NULL, 1, 0, 'C', '0', '0', 'report:classify:list', 'build', 'admin', '2022-09-14 14:30:26', 'admin', '2022-09-14 16:12:39', ''),
	(2003, '上报分类查询', 2002, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'report:classify:query', '#', 'admin', '2022-09-14 14:32:42', 'admin', '2022-09-14 14:33:09', ''),
	(2004, '上报分类新增', 2002, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'report:classify:add', '#', 'admin', '2022-09-14 14:32:42', 'admin', '2022-09-14 14:32:55', ''),
	(2005, '上报分类修改', 2002, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'report:classify:edit', '#', 'admin', '2022-09-14 14:32:42', 'admin', '2022-09-14 14:33:20', ''),
	(2006, '上报分类删除', 2002, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'report:classify:remove', '#', 'admin', '2022-09-14 14:32:42', 'admin', '2022-09-14 14:33:29', ''),
	(2007, '上报分类导出', 2002, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'report:classify:export', '#', 'admin', '2022-09-14 14:32:42', 'admin', '2022-09-14 14:33:38', ''),
	(2008, '上报模板查询', 2001, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'report:template:query', '#', 'admin', '2022-09-14 15:52:14', '', NULL, ''),
	(2009, '上报模板新增', 2001, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'report:template:add', '#', 'admin', '2022-09-14 15:52:14', '', NULL, ''),
	(2010, '上报模板修改', 2001, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'report:template:edit', '#', 'admin', '2022-09-14 15:52:14', '', NULL, ''),
	(2011, '上报模板删除', 2001, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'report:template:remove', '#', 'admin', '2022-09-14 15:52:14', '', NULL, ''),
	(2012, '上报模板导出', 2001, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'report:template:export', '#', 'admin', '2022-09-14 15:52:14', '', NULL, ''),
	(2013, '医院事件上报', 2000, 4, 'content', 'report/content/index', NULL, 1, 0, 'C', '0', '0', 'report:content:list', 'build', 'admin', '2022-09-14 16:11:14', 'admin', '2022-09-15 09:56:57', '医院事件上报菜单'),
	(2014, '医院事件上报查询', 2013, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'report:content:query', '#', 'admin', '2022-09-14 16:11:14', '', NULL, ''),
	(2015, '医院事件上报新增', 2013, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'report:content:add', '#', 'admin', '2022-09-14 16:11:14', '', NULL, ''),
	(2016, '医院事件上报修改', 2013, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'report:content:edit', '#', 'admin', '2022-09-14 16:11:14', '', NULL, ''),
	(2017, '医院事件上报删除', 2013, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'report:content:remove', '#', 'admin', '2022-09-14 16:11:14', '', NULL, ''),
	(2018, '医院事件上报导出', 2013, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'report:content:export', '#', 'admin', '2022-09-14 16:11:14', '', NULL, ''),
	(2019, '上报事件详情管理', 2000, 3, 'reportDetail', 'report/detail/index', NULL, 1, 0, 'C', '0', '0', 'report:content:list', 'build', 'admin', '2022-09-15 09:59:34', 'admin', '2022-09-16 08:33:18', ''),
	(2020, '上报事件详情管理查询', 2019, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'report:content:query', '#', 'admin', '2022-09-14 16:11:14', '', NULL, ''),
	(2021, '上报事件详情管理新增', 2019, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'report:content:add', '#', 'admin', '2022-09-14 16:11:14', '', NULL, ''),
	(2022, '上报事件详情管理修改', 2019, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'report:content:edit', '#', 'admin', '2022-09-14 16:11:14', '', NULL, ''),
	(2023, '上报事件详情管理删除', 2019, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'report:content:remove', '#', 'admin', '2022-09-14 16:11:14', '', NULL, ''),
	(2024, '上报事件详情管理导出', 2019, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'report:content:export', '#', 'admin', '2022-09-14 16:11:14', '', NULL, ''),
	(2033, '统计管理', 0, 5, 'chart', NULL, NULL, 1, 0, 'M', '0', '0', NULL, 'chart', 'admin', '2023-02-13 09:24:39', '', NULL, ''),
	(2034, '上报数量', 2033, 1, 'reportStatistics', 'system/reportStatistics', NULL, 1, 0, 'C', '0', '0', '', 'people', 'admin', '2023-02-13 09:26:07', 'admin', '2023-04-03 08:30:42', ''),
	(2043, '不良反应', 2033, 2, 'adverseReactions', 'system/adverseReactions', NULL, 1, 0, 'C', '0', '0', NULL, 'excel', 'admin', '2023-04-03 08:31:38', '', NULL, ''),
	(2044, '检查数量', 2033, 3, 'examineStatistics', 'system/examineStatistics', NULL, 1, 0, 'C', '0', '0', '', 'monitor', 'admin', '2023-04-30 14:18:38', 'admin', '2023-04-30 14:19:01', '');
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;

-- 导出  表 quality_control_platform.sys_notice 结构
CREATE TABLE IF NOT EXISTS `sys_notice` (
  `notice_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) NOT NULL COMMENT '公告标题',
  `notice_type` char(1) NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob COMMENT '公告内容',
  `status` char(1) DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='通知公告表';

-- 正在导出表  quality_control_platform.sys_notice 的数据：~0 rows (大约)
DELETE FROM `sys_notice`;
/*!40000 ALTER TABLE `sys_notice` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_notice` ENABLE KEYS */;

-- 导出  表 quality_control_platform.sys_oper_log 结构
CREATE TABLE IF NOT EXISTS `sys_oper_log` (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) DEFAULT '' COMMENT '模块标题',
  `business_type` int(2) DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) DEFAULT '' COMMENT '请求方式',
  `operator_type` int(1) DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) DEFAULT '' COMMENT '返回参数',
  `status` int(1) DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`oper_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1741 DEFAULT CHARSET=utf8 COMMENT='操作日志记录';

-- 正在导出表  quality_control_platform.sys_oper_log 的数据：~0 rows (大约)
DELETE FROM `sys_oper_log`;
/*!40000 ALTER TABLE `sys_oper_log` DISABLE KEYS */;
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`) VALUES
	(1737, '部门管理', 2, 'com.keyu.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', NULL, '/system/dept', '127.0.0.1', '内网IP', '{"ancestors":"0","areaCode":"220000,220100,220171","areaDescribe":"吉林省长春市长春经济技术开发区","children":[],"createBy":"admin","createTime":"2022-09-19 14:25:38","delFlag":"0","deptId":100,"deptName":"医院1","email":"ky@qq.com","leader":"ky","orderNum":0,"params":{},"parentId":0,"phone":"15888888888","position":"125.379187,43.861582","positionDescribe":"吉林省长春市南关区临河街道中日联谊医院","status":"0","updateBy":"admin"}', '{"msg":"操作成功","code":200}', 0, NULL, '2024-05-28 19:26:27'),
	(1738, '上报分类', 1, 'com.keyu.web.controller.report.RepClassifyController.add()', 'POST', 1, 'admin', NULL, '/report/classify', '127.0.0.1', '内网IP', '{"classifyName":"测试","createBy":"1","createTime":"2024-05-28T19:35:50.784+08:00","id":12,"params":{},"sort":1}', '{"msg":"操作成功","code":200}', 0, NULL, '2024-05-28 19:35:50'),
	(1739, '上报模板', 1, 'com.keyu.web.controller.report.RepTemplateController.add()', 'POST', 1, 'admin', NULL, '/report/template', '127.0.0.1', '内网IP', '{"classifyId":12,"createBy":"1","createTime":"2024-05-28T19:36:06.163+08:00","formProperty":"[{\\"type\\":\\"input\\",\\"field\\":\\"eug633b8f2mv\\",\\"title\\":\\"输入框\\",\\"info\\":\\"\\",\\"_fc_drag_tag\\":\\"input\\",\\"hidden\\":false,\\"display\\":true},{\\"type\\":\\"select\\",\\"field\\":\\"v6y633b8f9ok\\",\\"title\\":\\"选择器\\",\\"info\\":\\"\\",\\"effect\\":{\\"fetch\\":\\"\\"},\\"options\\":[{\\"value\\":\\"1\\",\\"label\\":\\"选项1\\"},{\\"value\\":\\"2\\",\\"label\\":\\"选项2\\"}],\\"_fc_drag_tag\\":\\"select\\",\\"hidden\\":false,\\"display\\":true},{\\"type\\":\\"upload\\",\\"field\\":\\"amp633b8hew7\\",\\"title\\":\\"上传\\",\\"handleIcon\\":true,\\"withCredentials\\":true,\\"props\\":{\\"handleIcon\\":true,\\"action\\":\\"http://127.0.0.1:13576/wechat/upload\\",\\"onHandle\\":\\"function handleFunc(files) {\\\\n        console.log(files);\\\\n      }\\",\\"onSuccess\\":\\"function successFunc(res, file) {\\\\n        file.url = res.data.url || \\\\\\"\\\\\\";\\\\n      }\\"},\\"value\\":[]},{\\"type\\":\\"fc-editor\\",\\"field\\":\\"rtb1oux4ccjua\\",\\"title\\":\\"富文本框\\",\\"info\\":\\"\\",\\"_fc_drag_tag\\":\\"fc-editor\\",\\"hidden\\":false,\\"display\\":true,\\"props\\":{\\"disabled\\":false}}]","id":138,"params":{},"reportNum":1,"templateName":"测试模版","unitProperty":"{\\"form\\":{\\"labelPosition\\":\\"right\\",\\"size\\":\\"medium\\",\\"labelWidth\\":\\"125px\\",\\"hideRequiredAsterisk\\":false,\\"showMessage\\":true,\\"inlineMessage\\":false},\\"submitBtn\\":false,\\"resetBtn\\":false}"}', '{"msg":"操作成功","code":200}', 0, NULL, '2024-05-28 19:36:06'),
	(1740, '医院事件上报', 1, 'com.keyu.web.controller.report.RepContentController.add()', 'POST', 1, 'admin', NULL, '/report/content', '127.0.0.1', '内网IP', '{"contentJson":"{\\"eug633b8f2mv\\":\\"111\\",\\"v6y633b8f9ok\\":\\"1\\",\\"amp633b8hew7\\":[],\\"rtb1oux4ccjua\\":\\"<p>11111<br/></p>\\"}","createBy":"1","createTime":"2024-05-28T19:36:29.391+08:00","id":2902,"params":{},"remark":"","reportTitle":"测试标题","templateId":138}', '{"msg":"操作成功","code":200}', 0, NULL, '2024-05-28 19:36:29');
/*!40000 ALTER TABLE `sys_oper_log` ENABLE KEYS */;

-- 导出  表 quality_control_platform.sys_people 结构
CREATE TABLE IF NOT EXISTS `sys_people` (
  `id` bigint(20) DEFAULT NULL COMMENT 'id',
  `sex` int(11) DEFAULT NULL COMMENT '1：男2：女',
  `name` varchar(255) DEFAULT NULL COMMENT '姓名',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='人员表';

-- 正在导出表  quality_control_platform.sys_people 的数据：~0 rows (大约)
DELETE FROM `sys_people`;
/*!40000 ALTER TABLE `sys_people` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_people` ENABLE KEYS */;

-- 导出  表 quality_control_platform.sys_post 结构
CREATE TABLE IF NOT EXISTS `sys_post` (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) NOT NULL COMMENT '岗位名称',
  `post_sort` int(4) NOT NULL COMMENT '显示顺序',
  `status` char(1) NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='岗位信息表';

-- 正在导出表  quality_control_platform.sys_post 的数据：~0 rows (大约)
DELETE FROM `sys_post`;
/*!40000 ALTER TABLE `sys_post` DISABLE KEYS */;
INSERT INTO `sys_post` (`post_id`, `post_code`, `post_name`, `post_sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(1, 'ceo', '董事长', 1, '0', 'admin', '2024-01-11 10:39:28', '', NULL, ''),
	(2, 'se', '项目经理', 2, '0', 'admin', '2024-01-11 10:39:29', '', NULL, ''),
	(3, 'hr', '人力资源', 3, '0', 'admin', '2024-01-11 10:39:29', '', NULL, ''),
	(4, 'user', '普通员工', 4, '0', 'admin', '2024-01-11 10:39:29', '', NULL, '');
/*!40000 ALTER TABLE `sys_post` ENABLE KEYS */;

-- 导出  表 quality_control_platform.sys_role 结构
CREATE TABLE IF NOT EXISTS `sys_role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(4) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT '部门树选择项是否关联显示',
  `status` char(1) NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8 COMMENT='角色信息表';

-- 正在导出表  quality_control_platform.sys_role 的数据：~0 rows (大约)
DELETE FROM `sys_role`;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2024-01-11 10:39:29', '', NULL, '超级管理员'),
	(2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2024-01-11 10:39:29', 'admin', '2024-01-11 13:55:04', '普通角色');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;

-- 导出  表 quality_control_platform.sys_role_dept 结构
CREATE TABLE IF NOT EXISTS `sys_role_dept` (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色和部门关联表';

-- 正在导出表  quality_control_platform.sys_role_dept 的数据：~0 rows (大约)
DELETE FROM `sys_role_dept`;
/*!40000 ALTER TABLE `sys_role_dept` DISABLE KEYS */;
INSERT INTO `sys_role_dept` (`role_id`, `dept_id`) VALUES
	(2, 100),
	(2, 101),
	(2, 105);
/*!40000 ALTER TABLE `sys_role_dept` ENABLE KEYS */;

-- 导出  表 quality_control_platform.sys_role_menu 结构
CREATE TABLE IF NOT EXISTS `sys_role_menu` (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色和菜单关联表';

-- 正在导出表  quality_control_platform.sys_role_menu 的数据：~0 rows (大约)
DELETE FROM `sys_role_menu`;
/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES
	(2, 1),
	(2, 2),
	(2, 3),
	(2, 100),
	(2, 101),
	(2, 102),
	(2, 103),
	(2, 104),
	(2, 105),
	(2, 106),
	(2, 107),
	(2, 108),
	(2, 109),
	(2, 110),
	(2, 111),
	(2, 112),
	(2, 113),
	(2, 114),
	(2, 115),
	(2, 116),
	(2, 117),
	(2, 500),
	(2, 501),
	(2, 1000),
	(2, 1001),
	(2, 1002),
	(2, 1003),
	(2, 1004),
	(2, 1005),
	(2, 1006),
	(2, 1007),
	(2, 1008),
	(2, 1009),
	(2, 1010),
	(2, 1011),
	(2, 1012),
	(2, 1013),
	(2, 1014),
	(2, 1015),
	(2, 1016),
	(2, 1017),
	(2, 1018),
	(2, 1019),
	(2, 1020),
	(2, 1021),
	(2, 1022),
	(2, 1023),
	(2, 1024),
	(2, 1025),
	(2, 1026),
	(2, 1027),
	(2, 1028),
	(2, 1029),
	(2, 1030),
	(2, 1031),
	(2, 1032),
	(2, 1033),
	(2, 1034),
	(2, 1035),
	(2, 1036),
	(2, 1037),
	(2, 1038),
	(2, 1039),
	(2, 1040),
	(2, 1041),
	(2, 1042),
	(2, 1043),
	(2, 1044),
	(2, 1045),
	(2, 1046),
	(2, 1047),
	(2, 1048),
	(2, 1049),
	(2, 1050),
	(2, 1051),
	(2, 1052),
	(2, 1053),
	(2, 1054),
	(2, 1055),
	(2, 1056),
	(2, 1057),
	(2, 1058),
	(2, 1059),
	(2, 1060);
/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;

-- 导出  表 quality_control_platform.sys_user 结构
CREATE TABLE IF NOT EXISTS `sys_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) NOT NULL COMMENT '用户昵称',
  `hospital_level` varchar(30) DEFAULT NULL COMMENT '医院级别',
  `regin_area` varchar(30) DEFAULT NULL COMMENT '所属地区',
  `user_type` varchar(2) DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) DEFAULT '' COMMENT '手机号码',
  `sex` char(1) DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(255) DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) DEFAULT '' COMMENT '密码',
  `position` varchar(255) DEFAULT '' COMMENT '位置经纬度',
  `position_describe` varchar(255) DEFAULT '' COMMENT '位置描述',
  `status` char(1) DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `openid` varchar(255) DEFAULT NULL COMMENT '微信openid',
  `sessionKey` varchar(255) DEFAULT NULL COMMENT '微信sessionKey',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3536 DEFAULT CHARSET=utf8 COMMENT='用户信息表';

-- 正在导出表  quality_control_platform.sys_user 的数据：~0 rows (大约)
DELETE FROM `sys_user`;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` (`user_id`, `dept_id`, `user_name`, `nick_name`, `hospital_level`, `regin_area`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `position`, `position_describe`, `status`, `del_flag`, `login_ip`, `login_date`, `openid`, `sessionKey`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
	(1, 100, 'admin', 'admin', NULL, NULL, '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '', '', '0', '0', '127.0.0.1', '2024-05-28 19:34:15', NULL, NULL, 'admin', '2024-01-11 10:39:28', '', '2024-05-28 19:34:15', '管理员'),
	(2, 100, 'ry', '测试', NULL, NULL, '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '', '', '0', '0', '127.0.0.1', '2024-01-11 10:39:28', NULL, NULL, 'admin', '2024-01-11 10:39:28', '', NULL, '测试员');
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;

-- 导出  表 quality_control_platform.sys_user_post 结构
CREATE TABLE IF NOT EXISTS `sys_user_post` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户与岗位关联表';

-- 正在导出表  quality_control_platform.sys_user_post 的数据：~0 rows (大约)
DELETE FROM `sys_user_post`;
/*!40000 ALTER TABLE `sys_user_post` DISABLE KEYS */;
INSERT INTO `sys_user_post` (`user_id`, `post_id`) VALUES
	(1, 1),
	(2, 2);
/*!40000 ALTER TABLE `sys_user_post` ENABLE KEYS */;

-- 导出  表 quality_control_platform.sys_user_role 结构
CREATE TABLE IF NOT EXISTS `sys_user_role` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户和角色关联表';

-- 正在导出表  quality_control_platform.sys_user_role 的数据：~0 rows (大约)
DELETE FROM `sys_user_role`;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES
	(1, 1),
	(2, 2);
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
