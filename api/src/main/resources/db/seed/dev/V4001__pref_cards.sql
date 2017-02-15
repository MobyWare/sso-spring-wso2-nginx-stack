SELECT @first_facility := 1;
SELECT @second_facility := 2;

SELECT @first_pref_card := "9999";
SELECT @second_pref_card := "8888";

SELECT @first_item_id_1 := "98765_1";
SELECT @first_item_id_2 := "98765_2";
SELECT @first_item_number := "900";
SELECT @first_mfr_code := "9009";

SELECT @second_item_id_1 := "87654_1";
SELECT @second_item_id_2 := "87654_2";
SELECT @second_item_number := "800";
SELECT @second_mfr_code := "8008";

SELECT @third_item_id_1 := "76543_1";
SELECT @third_item_id_2 := "76543_2";
SELECT @third_item_number := "700";
SELECT @third_mfr_code := "7007";

INSERT INTO `threepl`.`pref_card` (
  id,
  procedure_code,
  description,
  surgeon_id,
  facility_id,
  surg_area,
  status,
  status_datetime,
  creation_user)
VALUES (
  @first_pref_card,
  "1234",
  "Operation description",
  "123",
  @first_facility,
  "HOSPRHNCOR",
  "A",
  NOW(),
  "a service"
);

INSERT INTO `threepl`.`pref_card_item` (
  id,
  pref_card_id,
  item_number,
  manufacturer_item_code,
  open_qty,
  hold_qty,
  fill_qty)
VALUES (
  @first_item_id_1,
  @first_pref_card,
  @first_item_number,
  @first_mfr_code,
  1,
  2,
  3);

INSERT INTO `threepl`.`pref_card_item` (
  id,
  pref_card_id,
  item_number,
  manufacturer_item_code,
  open_qty,
  hold_qty,
  fill_qty)
VALUES (
  @second_item_id_1,
  @first_pref_card,
  @second_item_number,
  @second_mfr_code,
  3,
  2,
  1);

INSERT INTO `threepl`.`pref_card_item` (
  id,
  pref_card_id,
  item_number,
  manufacturer_item_code,
  open_qty,
  hold_qty,
  fill_qty)
VALUES (
  @third_item_id_1,
  @first_pref_card,
  @third_item_number,
  @third_mfr_code,
  10,
  20,
  30);

INSERT INTO `threepl`.`pref_card_comment` (
  id,
  pref_card_id,
  description,
  text)
VALUES (
  "1313",
  @first_pref_card,
  "comment description",
  "Plain text text");

INSERT INTO `threepl`.`pref_card` (
  id,
  procedure_code,
  description,
  surgeon_id,
  facility_id,
  surg_area,
  status,
  status_datetime,
  creation_user)
VALUES (
  @second_pref_card,
  "5678",
  "Operation on a patient",
  "456",
  @second_facility,
  "HOSPRHNNOR",
  "I",
  NOW(),
  "a service"
);

INSERT INTO `threepl`.`pref_card_item` (
  id,
  pref_card_id,
  item_number,
  manufacturer_item_code,
  open_qty,
  hold_qty,
  fill_qty)
VALUES (
  @first_item_id_2,
  @second_pref_card,
  @first_item_number,
  @first_mfr_code,
  11,
  22,
  33);

INSERT INTO `threepl`.`pref_card_item` (
  id,
  pref_card_id,
  item_number,
  manufacturer_item_code,
  open_qty,
  hold_qty,
  fill_qty)
VALUES (
  @third_item_id_2,
  @second_pref_card,
  @third_item_number,
  @third_mfr_code,
  0,
  0,
  0);

INSERT INTO `threepl`.`pref_card_comment` (
  id,
  pref_card_id,
  description,
  rtf)
VALUES (
  "2424",
  @second_pref_card,
  "comment description",
  "{\rtf1\ansi\ansicpg1252\deff0\nouicompat\deflang1033{\fonttbl{\f0\fnil\fcharset0 Calibri;}}\n{\*\generator Riched20 10.0.10586}\viewkind4\uc1\n\pard\sa200\sl276\slmult1\f0\fs22\lang9 Rich-text text.\par\n}\n);")

