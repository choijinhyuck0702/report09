-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema management
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema management
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `management` DEFAULT CHARACTER SET utf8 ;
USE `management` ;

-- -----------------------------------------------------
-- Table `management`.`학과`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `management`.`학과` (
  `학과번호` VARCHAR(10) NOT NULL,
  `학과명` VARCHAR(20) NOT NULL,
  `학과전화번호` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`학과번호`),
  UNIQUE INDEX `학과번호_UNIQUE` (`학과번호` ASC) VISIBLE,
  UNIQUE INDEX `학과전화번호_UNIQUE` (`학과전화번호` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `management`.`학생`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `management`.`학생` (
  `학생번호` VARCHAR(10) NOT NULL,
  `학생이름` VARCHAR(20) NOT NULL,
  `학생주민번호` VARCHAR(14) NOT NULL,
  `학생주소` VARCHAR(100) NOT NULL,
  `학생전화번호` VARCHAR(14) NOT NULL,
  `학생이메일` VARCHAR(30) NOT NULL,
  `소속학과번호` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`학생번호`),
  UNIQUE INDEX `학생번호_UNIQUE` (`학생번호` ASC) VISIBLE,
  UNIQUE INDEX `학생주민번호_UNIQUE` (`학생주민번호` ASC) VISIBLE,
  UNIQUE INDEX `학생전화번호_UNIQUE` (`학생전화번호` ASC) VISIBLE,
  UNIQUE INDEX `학생이메일_UNIQUE` (`학생이메일` ASC) VISIBLE,
  INDEX `fk_학생_학과_idx` (`소속학과번호` ASC) VISIBLE,
  CONSTRAINT `fk_학생_학과`
    FOREIGN KEY (`소속학과번호`)
    REFERENCES `management`.`학과` (`학과번호`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `management`.`교수`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `management`.`교수` (
  `교수번호` VARCHAR(10) NOT NULL,
  `교수이름` VARCHAR(20) NOT NULL,
  `교수주민번호` VARCHAR(14) NOT NULL,
  `교수주소` VARCHAR(100) NOT NULL,
  `교수전화번호` VARCHAR(14) NOT NULL,
  `교수이메일` VARCHAR(30) NOT NULL,
  `소속학과번호` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`교수번호`),
  UNIQUE INDEX `교수번호_UNIQUE` (`교수번호` ASC) VISIBLE,
  UNIQUE INDEX `교수주민번호_UNIQUE` (`교수주민번호` ASC) VISIBLE,
  UNIQUE INDEX `교수전화번호_UNIQUE` (`교수전화번호` ASC) VISIBLE,
  UNIQUE INDEX `교수이메일_UNIQUE` (`교수이메일` ASC) VISIBLE,
  INDEX `fk_교수_학과1_idx` (`소속학과번호` ASC) VISIBLE,
  CONSTRAINT `fk_교수_학과1`
    FOREIGN KEY (`소속학과번호`)
    REFERENCES `management`.`학과` (`학과번호`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `management`.`담당`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `management`.`담당` (
  `학생번호` VARCHAR(10) NOT NULL,
  `교수번호` VARCHAR(10) NOT NULL,
  `학년 학기` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`학생번호`),
  INDEX `fk_담당_학생1_idx` (`학생번호` ASC) VISIBLE,
  INDEX `fk_담당_교수1_idx` (`교수번호` ASC) VISIBLE,
  UNIQUE INDEX `학생번호_UNIQUE` (`학생번호` ASC) VISIBLE,
  CONSTRAINT `fk_담당_학생1`
    FOREIGN KEY (`학생번호`)
    REFERENCES `management`.`학생` (`학생번호`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_담당_교수1`
    FOREIGN KEY (`교수번호`)
    REFERENCES `management`.`교수` (`교수번호`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `management`.`강좌`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `management`.`강좌` (
  `강좌번호` VARCHAR(10) NOT NULL,
  `교수번호` VARCHAR(10) NOT NULL,
  `강좌명` VARCHAR(45) NOT NULL,
  `취득학점` INT NOT NULL,
  `강의시간` INT NOT NULL,
  `강의실정보` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`강좌번호`, `교수번호`),
  UNIQUE INDEX `강좌번호_UNIQUE` (`강좌번호` ASC) VISIBLE,
  INDEX `fk_강좌_교수1_idx` (`교수번호` ASC) VISIBLE,
  UNIQUE INDEX `교수번호_UNIQUE` (`교수번호` ASC) VISIBLE,
  CONSTRAINT `fk_강좌_교수1`
    FOREIGN KEY (`교수번호`)
    REFERENCES `management`.`교수` (`교수번호`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `management`.`수강내역`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `management`.`수강내역` (
  `출석점수` INT NOT NULL,
  `중간고사점수` INT NOT NULL,
  `기말고사점수` INT NOT NULL,
  `기타점수` INT NOT NULL,
  `총점` INT NOT NULL,
  `평점` INT NOT NULL,
  `학생번호` VARCHAR(10) NOT NULL,
  `강좌번호` VARCHAR(10) NOT NULL,
  `교수번호` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`강좌번호`, `교수번호`, `학생번호`),
  INDEX `fk_수강내역_강좌1_idx` (`강좌번호` ASC, `교수번호` ASC) VISIBLE,
  CONSTRAINT `fk_수강내역_학생1`
    FOREIGN KEY (`학생번호`)
    REFERENCES `management`.`학생` (`학생번호`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_수강내역_강좌1`
    FOREIGN KEY (`강좌번호` , `교수번호`)
    REFERENCES `management`.`강좌` (`강좌번호` , `교수번호`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- 3.
INSERT INTO 학과 VALUES('1000', '컴퓨터학과', '032-123-4567'); -- 컴퓨터학과
INSERT INTO 학과 VALUES('1001', '경영학과', '032-231-5678'); -- 경영학과
INSERT INTO 학과 VALUES('1002', '디자인학과', '032-312-6756'); -- 디자인학과
INSERT INTO 학과 VALUES('1003', '체육교육학과', '032-444-4444'); -- 체육교육학과

-- SELECT * FROM 학과;

INSERT INTO 학생 VALUES('22010101', '홍길동', '123456-1234567', '인천시 서구 연희동 1-1', '010-1111-1111', 'hong@naver.com', '1000'); -- 컴퓨터학과
INSERT INTO 학생 VALUES('22010102', '최진혁', '950702-7654321', '인천시 부평구 부평동 180-10', '010-5216-8864', 'choijinhyuck0702@gmail.com', '1000'); -- 컴퓨터학과
INSERT INTO 학생 VALUES('22010103', '신동한', '234567-2345671', '인천시 남동구 구월동 10-1', '010-2222-2222', 'han@naver.com', '1001'); -- 경영학과
INSERT INTO 학생 VALUES('22010104', '이재경', '345671-3456712', '인천시 부평구 산곡동 11-1', '010-3333-3333', 'ljk@daum.net', '1002'); -- 디자인학과
INSERT INTO 학생 VALUES('22010105', '곽승혁', '456712-4567123', '인천시 부평구 십정동 12-1', '010-4444-4444', 'ksh@naver.com', '1003'); -- 체육교육학과

-- SELECT * FROM 학생;

INSERT INTO 교수 VALUES('001', '김교수', '567123-5671234', '인천시 서구 가좌동 13-1', '010-5555-5555', 'kim@naver.com', '1000'); -- 컴퓨터학과
INSERT INTO 교수 VALUES('002', '박교수', '557123-4671234', '인천시 서구 신현동 14-1', '010-6666-6666', 'park@naver.com', '1001'); -- 경영학과
INSERT INTO 교수 VALUES('003', '이교수', '547123-6671234', '인천시 서구 가정동 15-1', '010-7777-7777', 'lee@naver.com', '1002'); -- 디자인학과
INSERT INTO 교수 VALUES('004', '한교수', '537123-7671234', '인천시 서구 석남동 16-1', '010-8888-8888', 'han@naver.com', '1003'); -- 체육교육학과

-- SELECT * FROM 교수;

INSERT INTO 담당 VALUES('22010101', '001', '1학년/1학기'); -- 컴퓨터학과
INSERT INTO 담당 VALUES('22010102', '001', '1학년/2학기'); -- 컴퓨터학과
INSERT INTO 담당 VALUES('22010103', '002', '1학년/1학기'); -- 경영학과
INSERT INTO 담당 VALUES('22010104', '003', '1학년/1학기'); -- 디자인학과
INSERT INTO 담당 VALUES('22010105', '004', '1학년/1학기'); -- 체육교육학과

-- SELECT * FROM 담당;

INSERT INTO 강좌 VALUES('S01', '001', '컴퓨터공학개론', 4, 3, 'A동 301호'); -- 컴퓨터학과
INSERT INTO 강좌 VALUES('S02', '002', '경영학개론', 4, 3, 'B동 401호'); -- 경영학과
INSERT INTO 강좌 VALUES('S03', '003', '디자인학개론', 4, 3, 'C동 501호'); -- 디자인학과

-- SELECT * FROM 강좌;

INSERT INTO 수강내역 VALUES(50, 50, 50, 50, 200, 50, '22010101', 'S01', '001');
INSERT INTO 수강내역 VALUES(100, 100, 100, 100, 400, 100, '22010102', 'S01', '001');
INSERT INTO 수강내역 VALUES(80, 80, 80, 80, 320, 80, '22010103', 'S02', '002');
INSERT INTO 수강내역 VALUES(60, 60, 60, 60, 240, 60, '22010104', 'S03', '003');

-- SELECT * FROM 수강내역;

-- 4.
SELECT A.학생번호, A.학생이름 FROM 학생 A LEFT JOIN 수강내역 B ON A.학생번호 = B.학생번호 WHERE B.학생번호 IS NULL;

-- 5.
SELECT D.교수번호, D.교수이름, D.학생번호, C.학생이름 FROM 학생 C JOIN (SELECT A.교수번호, A.교수이름, B.학생번호 FROM 교수 A JOIN 담당 B ON A.교수번호 = B.교수번호) D ON C.학생번호 = D.학생번호;

-- 6.
SET FOREIGN_KEY_CHECKS = 0;
UPDATE 학과 SET 학과번호 = '0111' WHERE 학과번호 = '1000';
UPDATE 교수 SET 소속학과번호 = '0111' WHERE 소속학과번호 = '1000';
UPDATE 학생 SET 소속학과번호 = '0111' WHERE 소속학과번호 = '1000';
UPDATE 학과 SET 학과명 = '컴퓨터공학과' WHERE 학과번호 = '0111';
SET FOREIGN_KEY_CHECKS = 1;

-- SELECT * FROM 학생;
-- SELECT * FROM 교수;
-- SELECT * FROM 학과;

-- 7.
SELECT  A.교수번호, A.교수이름, A.소속학과번호 FROM 교수 A LEFT JOIN 강좌 B ON A.교수번호 = B.교수번호 WHERE B.교수번호 IS NULL;
SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM 교수 WHERE 교수번호 = '004';
DELETE FROM 담당 WHERE 교수번호 = '004';
SET FOREIGN_KEY_CHECKS = 1;