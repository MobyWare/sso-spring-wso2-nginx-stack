INSERT INTO global_item (
  item_number,
  manufacturer_item_code,
  item_description,
  short_item_description,
  stock_indicator,
  manufacturer_code,
  vendor_name,
  vendor_category_code,
  creation_user)
VALUES (
  "100",
  "wahoo1",
  "Special Bandage4",
  "Short special bandages",
  "(Y)",
  "jnj",
  "Johnson & Johnson",
  "ba1",
  "me")
ON DUPLICATE KEY UPDATE
  item_number = VALUES(item_number),
  manufacturer_item_code = VALUES(manufacturer_item_code),
  item_description = VALUES(item_description),
  short_item_description = VALUES(short_item_description),
  stock_indicator = VALUES(stock_indicator),
  manufacturer_code = VALUES(manufacturer_code),
  vendor_name = VALUES(vendor_name),
  vendor_category_code = VALUES(vendor_category_code),
  update_user = VALUES(creation_user);

SELECT @last_global_id := LAST_INSERT_ID();

INSERT INTO global_item_detail (
  global_id,
  item_status,
  uom,
  units,
  cost,
  creation_user)
VALUES (
  @last_global_id,
  "50 eaches",
  "I",
  2,
  0.52123,
  "you")
