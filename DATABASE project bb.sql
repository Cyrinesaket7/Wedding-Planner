create database weddingPlanner;
use weddingPlanner;
Create schema weddingPlannerset;
Show databases;
##drop database weddingPlanner;
CREATE TABLE Customer (
  CustomerID INT PRIMARY KEY,
  FirstName VARCHAR(30),
  LastName VARCHAR(30)
); 
CREATE TABLE CustomerPhone (
  CustomerID INT,
  Phone VARCHAR(10) NOT NULL,
  PRIMARY KEY (CustomerID, Phone),
  FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);
 CREATE TABLE Venue (
  VenueID INT PRIMARY KEY,
  venue_Type VARCHAR(30),
  Capacity INT
); 
CREATE TABLE Supplier (
  SupplierID INT PRIMARY KEY,
  supplier_name VARCHAR(20),
  supplier_type VARCHAR(50),
  S_phone VARCHAR(10)
);
 CREATE TABLE Event (
  EventID INT PRIMARY KEY,
  event_date DATE,
  Budget DECIMAL(10,2),
  CustomerID INT,
  VenueID INT,
  FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
  FOREIGN KEY (VenueID) REFERENCES Venue(VenueID)
);
 CREATE TABLE EventSupplier (
  EventID INT,
  SupplierID INT,
  Price DECIMAL(10,2),
  Quantity INT,
  PRIMARY KEY (EventID, SupplierID),
  FOREIGN KEY (EventID) REFERENCES Event(EventID),
  FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);
 CREATE TABLE Payment (
  PaymentID INT PRIMARY KEY,
  Amount DECIMAL(10,2),
  Method VARCHAR(20) DEFAULT 'cash', 
  payment_date DATE,
  EventID INT,
  FOREIGN KEY (EventID) REFERENCES Event(EventID)
);

INSERT INTO Customer (CustomerID, FirstName, LastName)
VALUES
(1, 'Adam', 'Ibrahim'),
(2, 'Rahaf', 'Khaled'),
(3, 'Lina', 'Ahmad'),
(4, 'Omar', 'Saleh'),
(5, 'Sara', 'Youssef'),
(6, 'Kareem', 'Nasser');


INSERT INTO Venue (VenueID, Type, Capacity)
VALUES
(301, 'Hall', 300),
(302, 'Garden', 500),
(303, 'Hotel Ballroom', 1000),
(304, 'Beach Resort', 450),
(305, 'Hall', 350),
(306, 'Rooftop Venue', 250);


INSERT INTO Supplier (SupplierID, Name, Type, S_phone)
VALUES
(401, 'Blossom Design', 'Decoration', '0771112233'),
(402, 'Golden Touch', 'Catering', '0774445566'),
(403, 'Sky Lights', 'Lighting', '0795556677'),
(404, 'Melody Music', 'Entertainment', '0788889900'),
(405, 'Royal Flowers', 'Flowers', '0792223344'),
(406, 'Magic Studio', 'Photography', '0783332211');


INSERT INTO Event (EventID, Date, Budget, CustomerID, VenueID)
VALUES
(101, '2026-06-15', 5000, 1, 301),
(102, '2026-07-20', 8000, 2, 302),
(103, '2026-09-10', 12000, 3, 303),
(104, '2026-08-05', 6500, 4, 304),
(105, '2026-10-18', 7500, 5, 305),
(106, '2026-11-22', 9500, 6, 306);

 
INSERT INTO EventSupplier (EventID, SupplierID, Price, Quantity)
VALUES
(101, 401, 1000, 50),
(102, 402, 2000, 1),
(103, 403, 1500, 20),
(104, 404, 3000, 1),
(105, 405, 1200, 100),
(106, 406, 2500, 1);


INSERT INTO Payment (PaymentID, Amount, Method, Date, EventID)
VALUES
(201, 2000, 'Cash', '2026-05-01', 101),
(202, 3500, 'Credit Card', '2026-07-10', 102),
(203, 2500, 'CLIQ', '2026-08-25', 103),
(204, 5000, 'Cash', '2026-11-15', 104),
(205, 3000, 'Credit Card', '2026-09-20', 105),
(206, 4500, 'Bank Transfer', '2026-10-30', 106);


INSERT INTO CustomerPhone (CustomerID, Phone)
VALUES
(1, '0791234567'),
(2, '0789876543'),
(3, '0776543210'),
(4, '0795554433'),
(5, '0781122334'),
(6, '0779988776');

DESCRIBE Customer;
select*from customer;

UPDATE Event
SET budget = 10000,
    date = '2026-09-01'
WHERE event_id = 105;

UPDATE Payment
SET method = 'Bank Transfer'
WHERE amount > 3000;

select * from Customer;
DELETE FROM Event
WHERE date BETWEEN '2026-06-01' AND '2026-08-31';
