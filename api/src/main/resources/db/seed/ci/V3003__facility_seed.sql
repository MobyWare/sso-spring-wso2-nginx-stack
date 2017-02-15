-- -----------------------------------------------------
-- Data for table `threepl`.`facility`
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO `threepl`.`facility` (`name`, `code`, `organization_id`, `address`, `phone`, `city`, `state`, `postal_code`) VALUES ('Facility ABC 1', 'ABC_1_FAC', '1', 'Fake Facility Address 1', '5551234567', 'Pittsburgh', 'PA', '16046');
INSERT INTO `threepl`.`facility` (`name`, `code`, `organization_id`, `address`, `phone`, `city`, `state`, `postal_code`) VALUES ('Facility ABC 2', 'ABC_2_FAC', '1', 'Fake Facility Address 2', '5550987654', 'Altoona', 'PA', '77288');
INSERT INTO `threepl`.`facility` (`name`, `code`, `organization_id`, `address`, `phone`, `city`, `state`, `postal_code`) VALUES ('Facility XYZ 1', 'XYZ_1_FAC', '2', 'Fake Facility Address 3', '5552662878', 'Cleveland', 'OH', '15228');


COMMIT;