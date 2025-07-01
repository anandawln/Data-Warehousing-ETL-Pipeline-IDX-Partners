CREATE DATABASE DWH;

USE DWH;

-- Tabel DimCustomer
CREATE TABLE DimCustomer (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50) NOT NULL,
    Address VARCHAR(255),
    CityName VARCHAR(50),
    StateName VARCHAR(50),
    Age INT,
    Gender VARCHAR(10),
    Email VARCHAR(50)
);

-- Tabel DimAccount
CREATE TABLE DimAccount (
    AccountID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    AccountType VARCHAR(10),
    Balance INT,
    DateOpened DATETIME,
    Status VARCHAR(10),
    FOREIGN KEY (CustomerID) REFERENCES DimCustomer(CustomerID)
);

-- Tabel DimBranch
CREATE TABLE DimBranch (
    BranchID INT PRIMARY KEY,
    BranchName VARCHAR(50),
    BranchLocation VARCHAR(50)
);

-- Tabel FactTransaction
CREATE TABLE FactTransaction (
    TransactionID INT PRIMARY KEY,
    AccountID INT NOT NULL,
    BranchID INT NOT NULL,
    TransactionDate DATE,
    Amount INT,
    TransactionType VARCHAR(50),
    FOREIGN KEY (AccountID) REFERENCES DimAccount(AccountID),
    FOREIGN KEY (BranchID) REFERENCES DimBranch(BranchID)
);

SELECT * FROM DimAccount;

DROP DATABASE DWH;

USE sample;
GO

