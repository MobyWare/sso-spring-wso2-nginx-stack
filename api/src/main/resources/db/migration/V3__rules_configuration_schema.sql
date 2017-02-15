-- ---------------------------------------------------------------------
-- Table `threepl`.`rule_category`
-- The rule_category table contains list of the categories 3pl system 
-- will support. category_type example - scheduling, picking.
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `threepl`.`rule_category` (
  `category_id` BIGINT NOT NULL AUTO_INCREMENT,
  `category_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------------
-- Table `threepl`.`organization`
-- The organization table contains information about all the 
-- organizations using 3PL system.
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS `threepl`.`organization` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `code` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- ---------------------------------------------------------------
-- Table `threepl`.`facility`
-- The facility table contains information about all the
-- facilities corresponsing to the organizations using 3PL system 
-- ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `threepl`.`facility` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `code` VARCHAR(45) NULL,
  `organization_id` BIGINT NOT NULL,
  `address` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `postal_code` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_facility_organization_id`
    FOREIGN KEY (`organization_id`)
    REFERENCES `threepl`.`organization` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- ----------------------------------------------------------------------------------
-- Table `threepl`.`rule`
-- The rule table contains all the confguration rules.
-- category_id represents the category_type in rule_category table.
-- created_date and updated_date both auto populate with the current 
-- timestamp on creation and update respectively.
-- created_version and updated_version gives the latest version info about the rule.
-- ----------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `threepl`.`rule` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `category_id` BIGINT NOT NULL,
  `creation_version` VARCHAR(45) NOT NULL,
  `creation_date` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_version` VARCHAR(45) NULL,
  `update_date` DATETIME ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_rules_category_id`
    FOREIGN KEY (`category_id`)
    REFERENCES `threepl`.`rule_category` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- --------------------------------------------------------------------------------------------------------------
-- Table `threepl`.`rule_value`
-- The rule_value table contains the data about the rule values for organizations and facilities.
-- level_type would define if the rule is applied at facility level or organization level or at 3PL system level.
-- level_id would be either organization_id(level_type = organization) or facility_id(level_type = facility) or 
-- null(level_type = system).
-- value would represent the choosen value for a particular rule.
-- unique key (level_id and level_type) is applied to eliminate redundant data.
-- created_date and updated_date both auto populate with the current 
-- timestamp on creation and update respectively.
-- --------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `threepl`.`rule_value` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `rule_id` BIGINT NOT NULL,
  `level_id` BIGINT,
  `level_type` VARCHAR(45) NOT NULL,
  `value` VARCHAR(45) NOT NULL,
  `creation_user` VARCHAR(45) NOT NULL,
  `creation_date` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_user` VARCHAR(45) NULL,
  `update_date` DATETIME ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `level_id_and_type` (`level_id`,  `level_type`),
  CONSTRAINT `fk_rule_value_rule_id`
     FOREIGN KEY (`rule_id`)
     REFERENCES `threepl`.`rule` (`id`)
     ON DELETE NO ACTION
     ON UPDATE NO ACTION)
ENGINE = InnoDB;