-- MySQL dump 10.13  Distrib 8.0.35-27, for Linux (x86_64)
--
-- Host: localhost    Database: mgsv_server
-- ------------------------------------------------------
-- Server version	8.0.35-27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*!50717 SELECT COUNT(*) INTO @rocksdb_has_p_s_session_variables FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'performance_schema' AND TABLE_NAME = 'session_variables' */;
/*!50717 SET @rocksdb_get_is_supported = IF (@rocksdb_has_p_s_session_variables, 'SELECT COUNT(*) INTO @rocksdb_is_supported FROM performance_schema.session_variables WHERE VARIABLE_NAME=\'rocksdb_bulk_load\'', 'SELECT 0') */;
/*!50717 PREPARE s FROM @rocksdb_get_is_supported */;
/*!50717 EXECUTE s */;
/*!50717 DEALLOCATE PREPARE s */;
/*!50717 SET @rocksdb_enable_bulk_load = IF (@rocksdb_is_supported, 'SET SESSION rocksdb_bulk_load = 1', 'SET @rocksdb_dummy_bulk_load = 0') */;
/*!50717 PREPARE s FROM @rocksdb_enable_bulk_load */;
/*!50717 EXECUTE s */;
/*!50717 DEALLOCATE PREPARE s */;

--
-- Table structure for table `avatar`
--

DROP TABLE IF EXISTS `avatar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avatar` (
  `avatar_id` int NOT NULL AUTO_INCREMENT,
  `avatar_index` int DEFAULT NULL,
  `character_id` int DEFAULT NULL,
  `accessory_flags` int DEFAULT NULL,
  `beard_length` int DEFAULT NULL,
  `beard_style` int DEFAULT NULL,
  `eyebrow_style` int DEFAULT NULL,
  `eyebrow_width` int DEFAULT NULL,
  `face_color` int DEFAULT NULL,
  `face_race` int DEFAULT NULL,
  `face_type` int DEFAULT NULL,
  `face_variation` int DEFAULT NULL,
  `gash_or_tattoo_variation` int DEFAULT NULL,
  `hair_color` int DEFAULT NULL,
  `hair_style` int DEFAULT NULL,
  `left_eye_brightness` int DEFAULT NULL,
  `left_eye_color` int DEFAULT NULL,
  `right_eye_brightness` int DEFAULT NULL,
  `right_eye_color` int DEFAULT NULL,
  `tattoo_color` int DEFAULT NULL,
  `voice` int DEFAULT NULL,
  PRIMARY KEY (`avatar_id`),
  KEY `character_id` (`character_id`),
  CONSTRAINT `avatar_ibfk_1` FOREIGN KEY (`character_id`) REFERENCES `player_character` (`character_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avatar`
--

LOCK TABLES `avatar` WRITE;
/*!40000 ALTER TABLE `avatar` DISABLE KEYS */;
/*!40000 ALTER TABLE `avatar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `challenge_task_reward`
--

DROP TABLE IF EXISTS `challenge_task_reward`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `challenge_task_reward` (
  `id` int NOT NULL,
  `bottom_type` int DEFAULT NULL,
  `rate` int DEFAULT NULL,
  `section` int DEFAULT NULL,
  `reward_type` int DEFAULT NULL,
  `reward_value` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `challenge_task_reward`
--

LOCK TABLES `challenge_task_reward` WRITE;
/*!40000 ALTER TABLE `challenge_task_reward` DISABLE KEYS */;
/*!40000 ALTER TABLE `challenge_task_reward` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cluster_build_costs`
--

DROP TABLE IF EXISTS `cluster_build_costs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cluster_build_costs` (
  `id` int NOT NULL,
  `gmp` int DEFAULT NULL,
  `resource_a_count` int DEFAULT NULL,
  `resource_a_id` int DEFAULT NULL,
  `resource_b_count` int DEFAULT NULL,
  `resource_b_id` int DEFAULT NULL,
  `time_minute` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `resource_a_id` (`resource_a_id`),
  KEY `resource_b_id` (`resource_b_id`),
  CONSTRAINT `cluster_build_costs_ibfk_1` FOREIGN KEY (`resource_a_id`) REFERENCES `tpp_resource` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cluster_build_costs_ibfk_2` FOREIGN KEY (`resource_b_id`) REFERENCES `tpp_resource` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cluster_build_costs`
--

LOCK TABLES `cluster_build_costs` WRITE;
/*!40000 ALTER TABLE `cluster_build_costs` DISABLE KEYS */;
/*!40000 ALTER TABLE `cluster_build_costs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cluster_params`
--

DROP TABLE IF EXISTS `cluster_params`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cluster_params` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cluster_id` int NOT NULL,
  `build` int DEFAULT NULL,
  `cluster_security` int DEFAULT NULL,
  `soldier_rank` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cluster_id` (`cluster_id`),
  CONSTRAINT `cluster_params_ibfk_1` FOREIGN KEY (`cluster_id`) REFERENCES `fob_cluster` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cluster_params`
--

LOCK TABLES `cluster_params` WRITE;
/*!40000 ALTER TABLE `cluster_params` DISABLE KEYS */;
/*!40000 ALTER TABLE `cluster_params` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `color`
--

DROP TABLE IF EXISTS `color`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `color` (
  `color_id` int NOT NULL AUTO_INCREMENT,
  `color_value` int DEFAULT NULL,
  `loadout_id` int DEFAULT NULL,
  PRIMARY KEY (`color_id`),
  KEY `loadout_id` (`loadout_id`),
  CONSTRAINT `color_ibfk_1` FOREIGN KEY (`loadout_id`) REFERENCES `loadout` (`loadout_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `color`
--

LOCK TABLES `color` WRITE;
/*!40000 ALTER TABLE `color` DISABLE KEYS */;
/*!40000 ALTER TABLE `color` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `common_security`
--

DROP TABLE IF EXISTS `common_security`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `common_security` (
  `id` int NOT NULL,
  `cluster_params_id` int NOT NULL,
  `antitheft` int DEFAULT NULL,
  `camera` int DEFAULT NULL,
  `caution_area` int DEFAULT NULL,
  `decoy` int DEFAULT NULL,
  `ir_sensor` int DEFAULT NULL,
  `mine` int DEFAULT NULL,
  `soldier` int DEFAULT NULL,
  `uav` int DEFAULT NULL,
  `voluntary_coord_camera_count` int DEFAULT NULL,
  `voluntary_coord_mine_count` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cluster_params_id` (`cluster_params_id`),
  CONSTRAINT `common_security_ibfk_1` FOREIGN KEY (`cluster_params_id`) REFERENCES `cluster_params` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `common_security`
--

LOCK TABLES `common_security` WRITE;
/*!40000 ALTER TABLE `common_security` DISABLE KEYS */;
/*!40000 ALTER TABLE `common_security` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fob_cluster`
--

DROP TABLE IF EXISTS `fob_cluster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fob_cluster` (
  `id` int NOT NULL AUTO_INCREMENT,
  `area_id` int DEFAULT '0',
  `construct_param` int DEFAULT NULL,
  `fob_index` int DEFAULT NULL,
  `mother_base_id` int DEFAULT NULL,
  `platform_count` int DEFAULT NULL,
  `price` int DEFAULT NULL,
  `security_rank` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fob_cluster`
--

LOCK TABLES `fob_cluster` WRITE;
/*!40000 ALTER TABLE `fob_cluster` DISABLE KEYS */;
/*!40000 ALTER TABLE `fob_cluster` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fob_event_task`
--

DROP TABLE IF EXISTS `fob_event_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fob_event_task` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reward` int DEFAULT NULL,
  `task_type_id` int DEFAULT NULL,
  `threshold` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `task_type_id` (`task_type_id`),
  CONSTRAINT `fob_event_task_ibfk_1` FOREIGN KEY (`task_type_id`) REFERENCES `fob_event_task_type` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fob_event_task`
--

LOCK TABLES `fob_event_task` WRITE;
/*!40000 ALTER TABLE `fob_event_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `fob_event_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fob_event_task_type`
--

DROP TABLE IF EXISTS `fob_event_task_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fob_event_task_type` (
  `id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fob_event_task_type`
--

LOCK TABLES `fob_event_task_type` WRITE;
/*!40000 ALTER TABLE `fob_event_task_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `fob_event_task_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gear`
--

DROP TABLE IF EXISTS `gear`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gear` (
  `gear_id` int NOT NULL AUTO_INCREMENT,
  `loadout_id` int DEFAULT NULL,
  `id` int DEFAULT NULL,
  `model` bigint DEFAULT NULL,
  `color_list` text,
  PRIMARY KEY (`gear_id`),
  KEY `loadout_id` (`loadout_id`),
  CONSTRAINT `gear_ibfk_1` FOREIGN KEY (`loadout_id`) REFERENCES `loadout` (`loadout_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gear`
--

LOCK TABLES `gear` WRITE;
/*!40000 ALTER TABLE `gear` DISABLE KEYS */;
/*!40000 ALTER TABLE `gear` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item` (
  `item_id` int NOT NULL AUTO_INCREMENT,
  `slot` int DEFAULT NULL,
  `loadout_id` int DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  KEY `loadout_id` (`loadout_id`),
  CONSTRAINT `item_ibfk_1` FOREIGN KEY (`loadout_id`) REFERENCES `loadout` (`loadout_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loadout`
--

DROP TABLE IF EXISTS `loadout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loadout` (
  `loadout_id` int NOT NULL AUTO_INCREMENT,
  `character_id` int DEFAULT NULL,
  `custom_name` varchar(255) DEFAULT NULL,
  `loadout_version` bigint DEFAULT NULL,
  PRIMARY KEY (`loadout_id`),
  KEY `character_id` (`character_id`),
  CONSTRAINT `loadout_ibfk_1` FOREIGN KEY (`character_id`) REFERENCES `player_character` (`character_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loadout`
--

LOCK TABLES `loadout` WRITE;
/*!40000 ALTER TABLE `loadout` DISABLE KEYS */;
/*!40000 ALTER TABLE `loadout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `match_info`
--

DROP TABLE IF EXISTS `match_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `match_info` (
  `match_id` int NOT NULL AUTO_INCREMENT,
  `character_id` int DEFAULT NULL,
  `auto_leave` int DEFAULT NULL,
  `briefing_time` int DEFAULT NULL,
  `host_comment` int DEFAULT NULL,
  `max_capacity` int DEFAULT NULL,
  `mission_slot_count` int DEFAULT NULL,
  `player_num` int DEFAULT NULL,
  PRIMARY KEY (`match_id`),
  KEY `character_id` (`character_id`),
  CONSTRAINT `match_info_ibfk_1` FOREIGN KEY (`character_id`) REFERENCES `player_character` (`character_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `match_info`
--

LOCK TABLES `match_info` WRITE;
/*!40000 ALTER TABLE `match_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `match_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mission`
--

DROP TABLE IF EXISTS `mission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mission` (
  `id` int NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mission`
--

LOCK TABLES `mission` WRITE;
/*!40000 ALTER TABLE `mission` DISABLE KEYS */;
/*!40000 ALTER TABLE `mission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mission_slot`
--

DROP TABLE IF EXISTS `mission_slot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mission_slot` (
  `mission_slot_id` int NOT NULL AUTO_INCREMENT,
  `match_id` int DEFAULT NULL,
  `flags` int DEFAULT NULL,
  `map` int DEFAULT NULL,
  `night` int DEFAULT NULL,
  `rule` int DEFAULT NULL,
  `rush` int DEFAULT NULL,
  `ticket` int DEFAULT NULL,
  `duration` int DEFAULT NULL,
  `unique_character` int DEFAULT NULL,
  `weather` int DEFAULT NULL,
  PRIMARY KEY (`mission_slot_id`),
  KEY `match_id` (`match_id`),
  CONSTRAINT `mission_slot_ibfk_1` FOREIGN KEY (`match_id`) REFERENCES `match_info` (`match_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mission_slot`
--

LOCK TABLES `mission_slot` WRITE;
/*!40000 ALTER TABLE `mission_slot` DISABLE KEYS */;
/*!40000 ALTER TABLE `mission_slot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `motion_frame`
--

DROP TABLE IF EXISTS `motion_frame`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `motion_frame` (
  `motion_frame_id` int NOT NULL AUTO_INCREMENT,
  `avatar_id` int DEFAULT NULL,
  `frame_value` int DEFAULT NULL,
  PRIMARY KEY (`motion_frame_id`),
  KEY `avatar_id` (`avatar_id`),
  CONSTRAINT `motion_frame_ibfk_1` FOREIGN KEY (`avatar_id`) REFERENCES `avatar` (`avatar_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `motion_frame`
--

LOCK TABLES `motion_frame` WRITE;
/*!40000 ALTER TABLE `motion_frame` DISABLE KEYS */;
/*!40000 ALTER TABLE `motion_frame` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `name_plate`
--

DROP TABLE IF EXISTS `name_plate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `name_plate` (
  `id` int NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `name_plate`
--

LOCK TABLES `name_plate` WRITE;
/*!40000 ALTER TABLE `name_plate` DISABLE KEYS */;
/*!40000 ALTER TABLE `name_plate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `online_challenge_task`
--

DROP TABLE IF EXISTS `online_challenge_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `online_challenge_task` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mission_id` int DEFAULT NULL,
  `reward_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mission_id` (`mission_id`),
  KEY `reward_id` (`reward_id`),
  CONSTRAINT `online_challenge_task_ibfk_1` FOREIGN KEY (`mission_id`) REFERENCES `mission` (`id`) ON DELETE CASCADE,
  CONSTRAINT `online_challenge_task_ibfk_2` FOREIGN KEY (`reward_id`) REFERENCES `challenge_task_reward` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `online_challenge_task`
--

LOCK TABLES `online_challenge_task` WRITE;
/*!40000 ALTER TABLE `online_challenge_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `online_challenge_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permanent_unlock`
--

DROP TABLE IF EXISTS `permanent_unlock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permanent_unlock` (
  `permanent_unlock_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `unlock_value` bigint DEFAULT NULL,
  PRIMARY KEY (`permanent_unlock_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `permanent_unlock_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `server_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permanent_unlock`
--

LOCK TABLES `permanent_unlock` WRITE;
/*!40000 ALTER TABLE `permanent_unlock` DISABLE KEYS */;
/*!40000 ALTER TABLE `permanent_unlock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player`
--

DROP TABLE IF EXISTS `player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player` (
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player`
--

LOCK TABLES `player` WRITE;
/*!40000 ALTER TABLE `player` DISABLE KEYS */;
/*!40000 ALTER TABLE `player` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_character`
--

DROP TABLE IF EXISTS `player_character`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player_character` (
  `character_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `custom_name` varchar(255) DEFAULT NULL,
  `player_class` int DEFAULT NULL,
  `player_type` int DEFAULT NULL,
  `last_loadout` int DEFAULT NULL,
  `last_active` int DEFAULT NULL,
  `selected_bgm` int DEFAULT NULL,
  `_version_` bigint DEFAULT NULL,
  PRIMARY KEY (`character_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `player_character_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `server_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_character`
--

LOCK TABLES `player_character` WRITE;
/*!40000 ALTER TABLE `player_character` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_character` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_session`
--

DROP TABLE IF EXISTS `player_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player_session` (
  `id` int NOT NULL AUTO_INCREMENT,
  `session_hash` varchar(50) DEFAULT NULL,
  `player_id` int NOT NULL,
  `last_access` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `player_id` (`player_id`),
  CONSTRAINT `player_session_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `player` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_session`
--

LOCK TABLES `player_session` WRITE;
/*!40000 ALTER TABLE `player_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_vars`
--

DROP TABLE IF EXISTS `player_vars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player_vars` (
  `id` int NOT NULL AUTO_INCREMENT,
  `player_id` int NOT NULL,
  `espionage_lose` int DEFAULT NULL,
  `espionage_win` int DEFAULT NULL,
  `fob_grade` int DEFAULT NULL,
  `fob_point` int DEFAULT NULL,
  `fob_rank` int DEFAULT NULL,
  `is_insurance` int DEFAULT NULL,
  `league_grade` int DEFAULT NULL,
  `league_rank` int DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `playtime` int DEFAULT NULL,
  `point` int DEFAULT NULL,
  `event_point` int DEFAULT NULL,
  `player_num` int DEFAULT NULL,
  `mother_base_num` int DEFAULT NULL,
  `mother_base_data` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `player_id` (`player_id`),
  CONSTRAINT `player_vars_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `player` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_vars`
--

LOCK TABLES `player_vars` WRITE;
/*!40000 ALTER TABLE `player_vars` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_vars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `preset_radio_rule`
--

DROP TABLE IF EXISTS `preset_radio_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `preset_radio_rule` (
  `preset_radio_rule_id` int NOT NULL AUTO_INCREMENT,
  `character_id` int DEFAULT NULL,
  `preset_radio_id_list` text,
  PRIMARY KEY (`preset_radio_rule_id`),
  KEY `character_id` (`character_id`),
  CONSTRAINT `preset_radio_rule_ibfk_1` FOREIGN KEY (`character_id`) REFERENCES `player_character` (`character_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preset_radio_rule`
--

LOCK TABLES `preset_radio_rule` WRITE;
/*!40000 ALTER TABLE `preset_radio_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `preset_radio_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server_product_param`
--

DROP TABLE IF EXISTS `server_product_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `server_product_param` (
  `id` int NOT NULL,
  `dev_coin` int DEFAULT NULL,
  `dev_gmp` int DEFAULT NULL,
  `dev_item_1` int DEFAULT NULL,
  `dev_item_2` int DEFAULT NULL,
  `dev_platlv01` int DEFAULT NULL,
  `dev_platlv02` int DEFAULT NULL,
  `dev_platlv03` int DEFAULT NULL,
  `dev_platlv04` int DEFAULT NULL,
  `dev_platlv05` int DEFAULT NULL,
  `dev_platlv06` int DEFAULT NULL,
  `dev_platlv07` int DEFAULT NULL,
  `dev_rescount01_value` int DEFAULT NULL,
  `dev_rescount02_value` int DEFAULT NULL,
  `dev_resource01_id` int DEFAULT NULL,
  `dev_resource02_id` int DEFAULT NULL,
  `dev_skil` int DEFAULT NULL,
  `dev_special` int DEFAULT NULL,
  `dev_time` int DEFAULT NULL,
  `open` tinyint(1) DEFAULT NULL,
  `product_type` int DEFAULT NULL,
  `use_gmp` int DEFAULT NULL,
  `use_rescount01_value` int DEFAULT NULL,
  `use_rescount02_value` int DEFAULT NULL,
  `use_resource01_id` int DEFAULT NULL,
  `use_resource02_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dev_resource01_id` (`dev_resource01_id`),
  KEY `dev_resource02_id` (`dev_resource02_id`),
  KEY `use_resource01_id` (`use_resource01_id`),
  KEY `use_resource02_id` (`use_resource02_id`),
  CONSTRAINT `server_product_param_ibfk_1` FOREIGN KEY (`dev_resource01_id`) REFERENCES `tpp_resource` (`id`) ON DELETE CASCADE,
  CONSTRAINT `server_product_param_ibfk_2` FOREIGN KEY (`dev_resource02_id`) REFERENCES `tpp_resource` (`id`) ON DELETE CASCADE,
  CONSTRAINT `server_product_param_ibfk_3` FOREIGN KEY (`use_resource01_id`) REFERENCES `tpp_resource` (`id`) ON DELETE CASCADE,
  CONSTRAINT `server_product_param_ibfk_4` FOREIGN KEY (`use_resource02_id`) REFERENCES `tpp_resource` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server_product_param`
--

LOCK TABLES `server_product_param` WRITE;
/*!40000 ALTER TABLE `server_product_param` DISABLE KEYS */;
/*!40000 ALTER TABLE `server_product_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server_state`
--

DROP TABLE IF EXISTS `server_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `server_state` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nuke_num` int DEFAULT NULL,
  `nuke_max` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  `abolition_count` int DEFAULT NULL,
  `notes` varchar(500) DEFAULT NULL,
  `hero_threshold_point` int DEFAULT NULL,
  `not_hero_threshold_point` int DEFAULT NULL,
  `is_able_to_buy_fob4` tinyint(1) DEFAULT NULL,
  `is_stuck_rescue` tinyint(1) DEFAULT NULL,
  `online_challenge_task_end_date` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server_state`
--

LOCK TABLES `server_state` WRITE;
/*!40000 ALTER TABLE `server_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `server_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server_text`
--

DROP TABLE IF EXISTS `server_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `server_text` (
  `identifier` varchar(100) NOT NULL,
  `language` varchar(4) NOT NULL,
  `text` text,
  PRIMARY KEY (`identifier`,`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server_text`
--

LOCK TABLES `server_text` WRITE;
/*!40000 ALTER TABLE `server_text` DISABLE KEYS */;
/*!40000 ALTER TABLE `server_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server_user`
--

DROP TABLE IF EXISTS `server_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `server_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `steam_id` varchar(17) DEFAULT NULL,
  `currency` varchar(4) DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL,
  `smart_device_id` varchar(128) DEFAULT NULL,
  `magic_hash` varchar(32) DEFAULT NULL,
  `crypto_key` varchar(32) DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `last_command` datetime DEFAULT NULL,
  `session_id` varchar(32) DEFAULT NULL,
  `client_ip` varchar(16) DEFAULT NULL,
  `ex_ip` varchar(16) DEFAULT NULL,
  `ex_port` varchar(7) DEFAULT NULL,
  `in_ip` varchar(16) DEFAULT NULL,
  `in_port` varchar(7) DEFAULT NULL,
  `nat` varchar(48) DEFAULT NULL,
  `xnaddr` varchar(48) DEFAULT NULL,
  `country` varchar(5) DEFAULT NULL,
  `lang` varchar(5) DEFAULT NULL,
  `region` int DEFAULT NULL,
  `character_json` json DEFAULT NULL,
  `loadout_json` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server_user`
--

LOCK TABLES `server_user` WRITE;
/*!40000 ALTER TABLE `server_user` DISABLE KEYS */;
INSERT INTO `server_user` VALUES (1,'00000000000000000','USD','password','sMaRtDeViCeId',NULL,'MyCoolCryptoKeyAAAAAAA==',NULL,NULL,'11111111111111111111111111111111','192.168.0.10','192.168.0.10','5733','192.168.0.10','5733','OPEN_INTERNET',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `server_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES (1,'base_url','http://192.168.0.10/');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skill`
--

DROP TABLE IF EXISTS `skill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skill` (
  `skill_id` int NOT NULL AUTO_INCREMENT,
  `slot` int DEFAULT NULL,
  `loadout_id` int DEFAULT NULL,
  PRIMARY KEY (`skill_id`),
  KEY `loadout_id` (`loadout_id`),
  CONSTRAINT `skill_ibfk_1` FOREIGN KEY (`loadout_id`) REFERENCES `loadout` (`loadout_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skill`
--

LOCK TABLES `skill` WRITE;
/*!40000 ALTER TABLE `skill` DISABLE KEYS */;
/*!40000 ALTER TABLE `skill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff_rank_bonus_rate`
--

DROP TABLE IF EXISTS `staff_rank_bonus_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff_rank_bonus_rate` (
  `id` int NOT NULL AUTO_INCREMENT,
  `p1` int DEFAULT NULL,
  `p2` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_rank_bonus_rate`
--

LOCK TABLES `staff_rank_bonus_rate` WRITE;
/*!40000 ALTER TABLE `staff_rank_bonus_rate` DISABLE KEYS */;
/*!40000 ALTER TABLE `staff_rank_bonus_rate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `support_weapon`
--

DROP TABLE IF EXISTS `support_weapon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `support_weapon` (
  `support_weapon_id` int NOT NULL AUTO_INCREMENT,
  `slot` int DEFAULT NULL,
  `loadout_id` int DEFAULT NULL,
  PRIMARY KEY (`support_weapon_id`),
  KEY `loadout_id` (`loadout_id`),
  CONSTRAINT `support_weapon_ibfk_1` FOREIGN KEY (`loadout_id`) REFERENCES `loadout` (`loadout_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `support_weapon`
--

LOCK TABLES `support_weapon` WRITE;
/*!40000 ALTER TABLE `support_weapon` DISABLE KEYS */;
/*!40000 ALTER TABLE `support_weapon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tpp_resource`
--

DROP TABLE IF EXISTS `tpp_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tpp_resource` (
  `id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tpp_resource`
--

LOCK TABLES `tpp_resource` WRITE;
/*!40000 ALTER TABLE `tpp_resource` DISABLE KEYS */;
/*!40000 ALTER TABLE `tpp_resource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `url`
--

DROP TABLE IF EXISTS `url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `url` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url_type` varchar(20) DEFAULT NULL,
  `url_version` int DEFAULT NULL,
  `url_link` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `url`
--

LOCK TABLES `url` WRITE;
/*!40000 ALTER TABLE `url` DISABLE KEYS */;
INSERT INTO `url` VALUES (1,'HEATMAP',0,'tppstmweb/heatmap'),(2,'DEVICE',0,'tppstm/main'),(3,'GATE',14,'mgostm/gate'),(4,'WEB',14,'mgostm/main'),(5,'EULA',6,'tppstmweb/eula/eula.var'),(6,'EULA_COIN',1,'tppstmweb/coin/coin.var'),(7,'POLICY_GDPR',1,'tppstmweb/gdpr/privacy.var'),(8,'POLICY_JP',2,'tppstmweb/privacy_jp/privacy.var'),(9,'POLICY_ELSE',1,'tppstmweb/privacy/privacy.var'),(10,'POLICY_CCPA',1,'tppstmweb/privacy_ccpa/privacy.var'),(11,'LEGAL',1,'legal'),(12,'EULA_TEXT',1,'legal/mgsvtpp/terms/'),(13,'EULA_COIN_TEXT',1,'legal/mgsvtpp/terms/currency/'),(14,'POLICY_GDPR_TEXT',1,'legal/mgsvtpp/'),(15,'POLICY_JP_TEXT',2,'legal/privacy/view/'),(16,'POLICY_ELSE_TEXT',1,'legal/privacy/view/'),(17,'POLICY_CCPA_TEXT',1,'legal/mgsvtpp/ppa4ca/'),(18,'PERMISSION',1,'permission');
/*!40000 ALTER TABLE `url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weapon`
--

DROP TABLE IF EXISTS `weapon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `weapon` (
  `weapon_id` int NOT NULL AUTO_INCREMENT,
  `slot` int DEFAULT NULL,
  `loadout_id` int DEFAULT NULL,
  PRIMARY KEY (`weapon_id`),
  KEY `loadout_id` (`loadout_id`),
  CONSTRAINT `weapon_ibfk_1` FOREIGN KEY (`loadout_id`) REFERENCES `loadout` (`loadout_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weapon`
--

LOCK TABLES `weapon` WRITE;
/*!40000 ALTER TABLE `weapon` DISABLE KEYS */;
/*!40000 ALTER TABLE `weapon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weapon_part`
--

DROP TABLE IF EXISTS `weapon_part`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `weapon_part` (
  `weapon_part_id` int NOT NULL AUTO_INCREMENT,
  `weapon_id` int DEFAULT NULL,
  `part_id` int DEFAULT NULL,
  PRIMARY KEY (`weapon_part_id`),
  KEY `weapon_id` (`weapon_id`),
  CONSTRAINT `weapon_part_ibfk_1` FOREIGN KEY (`weapon_id`) REFERENCES `weapon` (`weapon_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weapon_part`
--

LOCK TABLES `weapon_part` WRITE;
/*!40000 ALTER TABLE `weapon_part` DISABLE KEYS */;
/*!40000 ALTER TABLE `weapon_part` ENABLE KEYS */;
UNLOCK TABLES;
/*!50112 SET @disable_bulk_load = IF (@is_rocksdb_supported, 'SET SESSION rocksdb_bulk_load = @old_rocksdb_bulk_load', 'SET @dummy_rocksdb_bulk_load = 0') */;
/*!50112 PREPARE s FROM @disable_bulk_load */;
/*!50112 EXECUTE s */;
/*!50112 DEALLOCATE PREPARE s */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-26  7:20:30
