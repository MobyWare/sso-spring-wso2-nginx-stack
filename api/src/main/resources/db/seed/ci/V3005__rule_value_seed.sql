-- -----------------------------------------------------
-- Data for table `threepl`.`rule_value`
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO `threepl`.`rule_value` (`rule_id`, `level_id`, `level_type`, `value`, `creation_user`) VALUES (1, 2, 'organization', 'Value for Rule1 for XYZ Hospitals', '3pl_admin');
INSERT INTO `threepl`.`rule_value` (`rule_id`, `level_id`, `level_type`, `value`, `creation_user`) VALUES (1, 1, 'facility', 'Rule1 value for Facility ABC 1', '3pl_admin');
INSERT INTO `threepl`.`rule_value` (`rule_id`, `level_id`, `level_type`, `value`, `creation_user`) VALUES (1, null, 'system', 'Default Rule1 value for 3PL system', '3pl_admin');
INSERT INTO `threepl`.`rule_value` (`rule_id`, `level_id`, `level_type`, `value`, `creation_user`) VALUES (2, 2, 'facility', 'Rule2 value for Facility ABC 2', '3pl_admin');

COMMIT;
