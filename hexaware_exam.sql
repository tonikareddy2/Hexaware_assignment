-- VEHICLE TABLE
CREATE TABLE Vehicle (
    vehicleID INT PRIMARY KEY,
    make VARCHAR(50),
    model VARCHAR(50),
    year INT,
    dailyRate DECIMAL(10, 2),
    status Varchar(50),
    passengerCapacity INT,
    engineCapacity INT
);

-- CUSTOMER TABLE
CREATE TABLE Customer (
    customerID INT PRIMARY KEY,
    firstName VARCHAR(50),
    lastName VARCHAR(50),
    email VARCHAR(100),
    phoneNumber VARCHAR(20)
);

-- LEASE TABLE
CREATE TABLE Lease (
    leaseID INT PRIMARY KEY,
    vehicleID INT,
    customerID INT,
    startDate DATE,
    endDate DATE,
    type Varchar(50),
    FOREIGN KEY (vehicleID) REFERENCES Vehicle(vehicleID),
    FOREIGN KEY (customerID) REFERENCES Customer(customerID)
);

-- PAYMENT TABLE
CREATE TABLE Payment (
    paymentID INT PRIMARY KEY,
    leaseID INT,
    paymentDate DATE,
    amount DECIMAL(10, 2),
    FOREIGN KEY (leaseID) REFERENCES Lease(leaseID)
);

-- INSERTING DATA
-- VEHICLE TABLE

INSERT INTO Vehicle(vehicleID, make, model, year, dailyRate, status, passengerCapacity, engineCapacity)
VALUES (1, 'Toyota', 'Camry', 2022, 50.00, 'Available', 4, 1450),
       (2, 'Honda', 'Civic', 2023, 45.00, 'Available', 7, 1500),
       (3, 'Ford', 'Focus', 2022, 48.00, 'Unavailable', 4, 1400),
       (4, 'Nissan', 'Altima', 2023, 52.00, 'Available', 7, 1200),
       (5, 'Chevrolet', 'Malibu', 2022, 47.00, 'Available', 4, 1800),
       (6, 'Hyundai', 'Sonata', 2023, 49.00, 'Unavailable', 7, 1400),
       (7, 'BMW', '3 Series', 2023, 60.00, 'Available', 7, 2499),
       (8, 'Mercedes', 'C-Class', 2022, 58.00, 'Available', 8, 2599),
       (9, 'Audi', 'A4', 2022, 55.00, 'Unavailable', 4, 2500),
       (10, 'Lexus', 'ES', 2023, 54.00, 'Available', 4, 2500);

-- CUSTOMER TABLE
Insert into customer(customerID,firstName,lastName,email,phoneNumber)
values (1, 'John','Doe','johndoe@example.com','555-555-5555'),
       (2, 'Jane', 'Smith', 'janesmith@example.com', '555-123-4567'),
	   (3, 'Robert','Johnson', 'robert@example.com', '555-789-1234'),
	   (4, 'Sarah','Brown', 'sarah@example.com', '555-456-7890'),
	   (5, 'David','Lee', 'david@example.com', '555-987-6543'),
	   (6, 'Laura','Hall', 'laura@example.com', '555-234-5678'),
	   (7, 'Michael','Davis', 'michael@example.com', '555-876-5432'),
	   (8, 'Emma','Wilson', 'emma@example.com', '555-432-1098'),
	   (9, 'William','Taylor', 'william@example.com', '555-321-6547'),
	   (10, 'Olivia','Adams', 'olivia@example.com', '555-765-4321');

-- LEASE TABLE
Insert Into Lease (leaseID,vehicleID,customerID,startDate,endDate,Type)
Values (1, 1, 1, '2023-01-01', '2023-01-05', 'Daily'),
       (2, 2, 2, '2023-02-15', '2023-02-28', 'Monthly'),
       (3, 3, 3, '2023-03-10', '2023-03-15', 'Daily'),
       (4, 4, 4, '2023-04-20', '2023-04-30', 'Monthly'),
       (5, 5, 5, '2023-05-05', '2023-05-10', 'Daily'),
       (6, 4, 3, '2023-06-15', '2023-06-30', 'Monthly'),
       (7, 7, 7, '2023-07-01', '2023-07-10', 'Daily'),
       (8, 8, 8, '2023-08-12', '2023-08-15', 'Monthly'),
       (9, 3, 3, '2023-09-07', '2023-09-10', 'Daily'),
       (10, 10, 10, '2023-10-10', '2023-10-31', 'Monthly');

-- PAYMENT TABLE
insert into Payment(paymentID,leaseID,paymentDate,amount)
values (1, 1, '2023-01-03', 200.00),
       (2, 2, '2023-02-20', 1000.00),
       (3, 3, '2023-03-12', 75.00),
	   (4, 4, '2023-04-25', 900.00),
       (5, 5, '2023-05-07', 60.00),
       (6, 6, '2023-06-18', 1200.00),
       (7, 7, '2023-07-03', 40.00),
       (8, 8, '2023-08-14', 1100.00),
       (9, 9, '2023-09-09', 80.00),
       (10, 10, '2023-10-25', 1500.00);

select * from Customer;
select * from Lease;
select * from Vehicle;
select * from Payment;
-----------------------------------------------------------------------

-- 1. Update the daily rate for a Mercedes car to 68.
update Vehicle
set dailyRate=68.00
where make='mercedes';

-- 2. Delete a specific customer and all associated leases and payments.delete from paymentwhere leaseID = (select leaseID                  from Lease				 where customerID=10)-- 3. Rename the "paymentDate" column in the Payment table to "transactionDate"

-- 4. Find a specific customer by email.
select * 
from Customer 
where email='sarah@example.com';

-- 5. Get active leases for a specific customer.
select *
from Lease
where customerID=3 and endDate>=GETDATE();

-- 6. Find all payments made by a customer with a specific phone number
select P.*
from Payment P
join Lease L on P.leaseID = L.leaseID
JOIN Customer C on L.customerID = C.customerID
where C.phoneNumber = '555-555-5555';

-- 7. Calculate the average daily rate of all available cars.
select avg(dailyrate) as average_daily_rate  
from Vehicle
where status='available';

-- 8. Find the car with the highest daily rate.
select *
from vehicle
order by dailyRate DESC
offset 0 rows fetch next 1 row only;

-- 9. Retrieve all cars leased by a specific customer.
select V.*
from Vehicle V
where V.vehicleID IN (
    select L.vehicleID
    from Lease L
    where L.customerID = 3 
);

-- 10. Find the details of the most recent lease
select *
from Lease
order by endDate desc
offset 0 rows fetch next 1 row only;

-- 11. List all payments made in the year 2023
select *
from payment
where year(paymentDate)= 2023;

-- 12. Retrieve customers who have not made any payments
select *
from customer
where customerId not in (select customerId from lease);

-- 13. Retrieve Car Details and Their Total Payments.
select V.vehicleID,V.make,V.model, SUM(P.amount)
from Vehicle V
join Lease L on V.vehicleID = L.vehicleID
join Payment P on L.leaseID = P.leaseID
group by V.vehicleID,V.make,V.model;

-- 14. Calculate Total Payments for Each Customer
select c.customerId,c.firstname,c.lastname,c.email,sum(p.amount)
from customer c
join Lease L on c.customerID = L.vehicleID
join Payment P on L.leaseID = P.leaseID
group by c.customerID,c.firstName,c.lastName,c.email;

-- 15. List Car Details for Each Lease
select l.*, v.make,v.model
from lease l
inner join vehicle v on l.vehicleID=v.vehicleID;

-- 16. Retrieve Details of Active Leases with Customer and Car Information.
select L.*, V.make, V.model, C.firstName, C.lastName
from Lease L
join Vehicle V on L.vehicleID = V.vehicleID
join Customer C ON L.customerID = C.customerID
where L.endDate >= GETDATE();

-- 17. Find the Customer Who Has Spent the Most on Leases.
select c.*, p.amount
from Customer c
join Lease l on l.customerID = c.customerID
join Payment p on p.leaseID = l.leaseID
Order by p.amount desc
offset 0 rows fetch next 1 row only;

-- 18. List All Cars with Their Current Lease Information.
select *
from lease l
inner join vehicle v on v.vehicleID= l.vehicleID; 