-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema seniorcare
-- -----------------------------------------------------
-- 시니어케어 

-- -----------------------------------------------------
-- Schema seniorcare
--
-- 시니어케어 
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `seniorcare` DEFAULT CHARACTER SET utf8 ;
USE `seniorcare` ;

-- -----------------------------------------------------
-- Table `seniorcare`.`tel_auth`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seniorcare`.`tel_auth` (
  `tel_number` VARCHAR(11) NOT NULL,
  `tel_auth` VARCHAR(4) NOT NULL,
  PRIMARY KEY (`tel_number`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `seniorcare`.`nurse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seniorcare`.`nurse` (
  `id` VARCHAR(20) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  `tel_number` VARCHAR(11) NOT NULL,
  `join_path` VARCHAR(5) NULL DEFAULT 'HOME',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `tel_number_UNIQUE` (`tel_number` ASC) VISIBLE,
  CONSTRAINT `tel_auth_fk`
    FOREIGN KEY (`tel_number`)
    REFERENCES `seniorcare`.`tel_auth` (`tel_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `seniorcare`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seniorcare`.`customer` (
  `customer_number` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `area` VARCHAR(30) NOT NULL,
  `charger` VARCHAR(20) NOT NULL,
  `profile_image` TEXT NULL,
  `birth` VARCHAR(6) NOT NULL,
  `address` TEXT NOT NULL COMMENT '주소',
  PRIMARY KEY (`customer_number`),
  INDEX `customer_fk_name` (`name` ASC) VISIBLE,
  CONSTRAINT `charger_fk`
    FOREIGN KEY (`charger`)
    REFERENCES `seniorcare`.`nurse` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '고객테이블';


-- -----------------------------------------------------
-- Table `seniorcare`.`goods`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seniorcare`.`goods` (
  `goods_number` INT NOT NULL AUTO_INCREMENT COMMENT '용품번호',
  `name` VARCHAR(100) NOT NULL COMMENT '용품 이름',
  `purpose` TEXT NOT NULL COMMENT '용품 용도',
  `count` INT NULL COMMENT '용품 개수\n',
  PRIMARY KEY (`goods_number`),
  INDEX `goods_name_idx` (`name` ASC) COMMENT '용품의 이름 조건에 따른 검색속도 향상을 위한 인덱스\n' VISIBLE)
ENGINE = InnoDB
COMMENT = '용품테이블\n';


-- -----------------------------------------------------
-- Table `seniorcare`.`customer_management`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seniorcare`.`customer_management` (
  `customer_number` INT NOT NULL COMMENT '고객번호\n',
  `manage_date` DATE NOT NULL COMMENT '관리날짜',
  `comment` TEXT NOT NULL COMMENT '관리 내용\n',
  `used_goods` INT NULL COMMENT '사용한 용품',
  `used_goods_count` INT NULL COMMENT '사용한 용품 갯수',
  PRIMARY KEY (`customer_number`, `manage_date`),
  INDEX `used_goods_fk_idx` (`used_goods` ASC) VISIBLE,
  CONSTRAINT `customer_fk`
    FOREIGN KEY (`customer_number`)
    REFERENCES `seniorcare`.`customer` (`customer_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `used_goods_fk`
    FOREIGN KEY (`used_goods`)
    REFERENCES `seniorcare`.`goods` (`goods_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '고객관리기록테이블';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
