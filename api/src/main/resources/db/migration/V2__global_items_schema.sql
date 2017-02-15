-- Make sure autocommit is off for transactions.
SET autocommit = 0;
-- The global_items table contains static, unchanging data and data that needs
-- no change-tracking for the items that we supply to the hostpials and maps
-- item_number and manufacturer_item_code to a global id. creation_date and
-- update_date both auto populate with the current timestamp on creation and
-- update respectively. item_number and manufacturer_item_code form an implicit
-- alternate key (though this is not enforced by the schema since it may need
-- to include organization at some point).
CREATE TABLE IF NOT EXISTS `threepl`.`global_items` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `item_number` VARCHAR(45) NOT NULL,
  `manufacturer_item_code` VARCHAR(45) NULL,
  `item_description` VARCHAR(1024) NULL,
  `short_item_description` VARCHAR(256) NULL,
  `stock_indicator` VARCHAR(45) NULL,
  `manufacturer_code` VARCHAR(45) NULL,
  `vendor_name` VARCHAR(45) NULL,
  `vendor_category_code` VARCHAR(45) NULL,
  `creation_date` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `creation_user` VARCHAR(45) NOT NULL,
  `update_date` DATETIME ON UPDATE CURRENT_TIMESTAMP,
  `update_user` VARCHAR(45) NULL,
  PRIMARY KEY (`id`)
)
ENGINE = InnoDB;
-- The item_details table contains all of the data that can change and that we
-- may want to track and report on. There are no updated fields because every
-- time there is an update to one of the fields in this table, we'll create a
-- new row. This provides the historical data for tracking and reporting over
-- time.
CREATE TABLE IF NOT EXISTS `threepl`.`item_details` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `global_id` BIGINT NOT NULL,
  `item_status` VARCHAR(9) NULL,
  `uom` VARCHAR(45) NULL,
  `units` INT NULL,
  -- DECIMAL(13,4) is compliant with GAAP,
  -- but the HL7 file has 5 decimal places, so DECIMAL(13,5)
  `cost` DECIMAL(13,5) NULL,
  `creation_date` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `creation_user` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`global_id`)
    REFERENCES `threepl`.`global_items`(`id`)
)
ENGINE = InnoDB
