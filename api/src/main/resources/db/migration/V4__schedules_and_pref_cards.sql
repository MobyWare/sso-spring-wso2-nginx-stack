--Making table names consistant and adding columns and keys to global_item
RENAME TABLE `threepl`.`global_items` TO `threepl`.`global_item`, `threepl`.`item_details` TO `threepl`.`global_item_detail`;
ALTER TABLE `threepl`.`global_item` ADD COLUMN `supply_class` VARCHAR(45) NULL;

SELECT * from global_item;

CREATE TABLE IF NOT EXISTS `threepl`.`schedule_status` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,

  PRIMARY KEY (`id`)
)
ENGINE = InnoDB;

INSERT INTO `threepl`.`schedule_status`
  (id, name)
VALUES
  (0, "Unknown"),
  (5, "Cancelled"),
  (10, "Scheduled"),
  (20, "Picking"),
  (30, "Shipping"),
  (40, "Delivered"),
  (50, "Completed");

CREATE TABLE IF NOT EXISTS `threepl`.`schedule` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `case_number` VARCHAR(255) UNIQUE NOT NULL,
  `facility_id` BIGINT NULL,
  `surg_area` VARCHAR(255) NULL,
  `surg_or` VARCHAR(255) NULL,
  `pre_op_diagnosis` TEXT NULL,
  `procedure_desc` TEXT NULL,
  `procedure_date` DATETIME NOT NULL,
  `status` INT NULL DEFAULT 0,
  `status_reason` TEXT NULL,
  `primary_surgeon_id` VARCHAR(45) NULL,
  `primary_surgeon_name` TEXT NULL,
  `patient_name` TEXT NULL,
  `patient_dob` DATE NULL,
  `patient_age` VARCHAR(45) NULL,
  `patient_fin` VARCHAR(45) NULL,
  `patient_mrn` VARCHAR(45) NULL,

  `creation_date` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `creation_user` VARCHAR(45) NOT NULL,
  `update_date` DATETIME ON UPDATE CURRENT_TIMESTAMP,
  `update_user` VARCHAR(45) NULL,
  `cancelled_user` VARCHAR(127) NULL,
  `cancelled_date` DATETIME NULL,

  PRIMARY KEY (`id`),
  FOREIGN KEY (`status`)
    REFERENCES `threepl`.`schedule_status`(`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  FOREIGN KEY (`facility_id`)
    REFERENCES `threepl`.`facility`(`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `threepl`.`pref_card` (
  `id` VARCHAR(45) NOT NULL,
  `procedure_code` VARCHAR(45) NULL,
  `description` TEXT NULL,
  `surgeon_id` VARCHAR(45) NULL,
  `facility_id` BIGINT NULL,
  `surg_area` VARCHAR(255) NULL,
  `status` VARCHAR(9) NULL,
  `status_datetime` DATETIME NULL,

  `creation_date` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `creation_user` VARCHAR(45) NOT NULL,
  `update_date` DATETIME ON UPDATE CURRENT_TIMESTAMP,
  `update_user` VARCHAR(45) NULL,

  PRIMARY KEY (`id`),
  FOREIGN KEY (`facility_id`)
    REFERENCES `threepl`.`facility`(`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `threepl`.`pref_card_item` (
  `id` VARCHAR(45) NOT NULL,
  `pref_card_id` VARCHAR(45) NOT NULL,
  `item_number` VARCHAR(45) NULL,
  `manufacturer_item_code` VARCHAR(45) NULL,
  `open_qty` INT NOT NULL DEFAULT 0,
  `hold_qty` INT NOT NULL DEFAULT 0,
  `fill_qty` INT NOT NULL DEFAULT 0,

  PRIMARY KEY (`id`),
  FOREIGN KEY (`pref_card_id`)
    REFERENCES `threepl`.`pref_card`(`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `threepl`.`pref_card_comment` (
  `id` VARCHAR(45) NOT NULL,
  `pref_card_id` VARCHAR(45) NOT NULL,
  `description` TEXT NULL,
  `text` TEXT NULL,
  `rtf` TEXT NULL,

  PRIMARY KEY (`id`),
  FOREIGN KEY (`pref_card_id`)
    REFERENCES `threepl`.`pref_card`(`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;

