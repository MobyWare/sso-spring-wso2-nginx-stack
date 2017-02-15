drop database if exists threepl;
create database threepl;
use threepl;

drop table if exists sample;

CREATE TABLE IF NOT EXISTS sample (
  sample_id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(45) DEFAULT NULL,
  start_date DATE DEFAULT NULL,
  end_date DATE DEFAULT NULL,
  description VARCHAR(200) DEFAULT NULL,
  PRIMARY KEY (sample_id)
) ENGINE=InnoDB;

insert into sample (name, description) values ("foo", "The foo item");
insert into sample (name, description) values ("bar", "The bar item");
insert into sample (name, description) values ("baz", "The baz item");
