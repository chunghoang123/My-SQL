/* ================================
   1. DATABASE
================================ */
DROP DATABASE IF EXISTS bai8;
CREATE DATABASE bai8;
USE bai8;

/* ================================
   2. CUSTOMER – Khách hàng
================================ */
CREATE TABLE Customer (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    CCCD VARCHAR(12) NOT NULL UNIQUE,
    Phone VARCHAR(15) NOT NULL UNIQUE,
    Email VARCHAR(100),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

/* ================================
   3. ACCOUNT – Tài khoản VPBank
================================ */
CREATE TABLE Account (
    AccountID INT AUTO_INCREMENT PRIMARY KEY,
    AccountNumber VARCHAR(20) NOT NULL UNIQUE,
    CustomerID INT NOT NULL,
    Balance DECIMAL(15,2) NOT NULL DEFAULT 0,

    CONSTRAINT CK_Account_Balance
        CHECK (Balance >= 0),

    CONSTRAINT FK_Account_Customer
        FOREIGN KEY (CustomerID)
        REFERENCES Customer(CustomerID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/* ================================
   4. PARTNER – Đối tác (Rikkei, mở rộng)
================================ */
CREATE TABLE Partner (
    PartnerID INT AUTO_INCREMENT PRIMARY KEY,
    PartnerName VARCHAR(100) NOT NULL UNIQUE,
    BankAccount VARCHAR(30) NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

/* ================================
   5. TUITION BILL – Hóa đơn học phí
================================ */
CREATE TABLE TuitionBill (
    BillID INT AUTO_INCREMENT PRIMARY KEY,
    PartnerID INT NOT NULL,
    StudentCode VARCHAR(20) NOT NULL,
    Amount DECIMAL(15,2) NOT NULL,
    Status VARCHAR(20) NOT NULL DEFAULT 'Unpaid',
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT CK_TuitionBill_Amount
        CHECK (Amount > 0),

    CONSTRAINT FK_TuitionBill_Partner
        FOREIGN KEY (PartnerID)
        REFERENCES Partner(PartnerID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/* ================================
   6. TRANSACTION – Lịch sử giao dịch
================================ */
CREATE TABLE Transaction (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,
    AccountID INT NOT NULL,
    BillID INT NOT NULL UNIQUE,
    Amount DECIMAL(15,2) NOT NULL,
    Status VARCHAR(20) NOT NULL DEFAULT 'Pending',
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT CK_Transaction_Amount
        CHECK (Amount > 0),

    CONSTRAINT FK_Transaction_Account
        FOREIGN KEY (AccountID)
        REFERENCES Account(AccountID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT FK_Transaction_Bill
        FOREIGN KEY (BillID)
        REFERENCES TuitionBill(BillID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);
