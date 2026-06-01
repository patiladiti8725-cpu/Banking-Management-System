Create database if not exists BankSystem;
show databases;
use BankSystem;
show tables;

# Customers Table
Create table Customers(
customer_id Int Auto_increment primary key,
name varchar(100),
dob Date,
phone Varchar(15),
city Varchar(50)
);

# Account table
Create  table Accounts(
account_id Int Auto_increment Primary Key,
customer_id int,
account_type varchar(20),
balance decimal(10,2),
foreign key (customer_id) references Customers(customer_id)
);

# Transaction Table
Create table Transactions(
txn_id Int Auto_increment primary key,
account_id Int,
amount Decimal(10,2),
txn_type varchar(10),
txn_date datetime default current_timestamp,
foreign key (account_id) references Accounts(account_id)
);

# Customer Data
Insert into Customers(name,dob,phone,city)values
('Aditi Patil', '2000-05-10', '9876543210', 'Pune'),
('Rahul Sharma', '1998-08-20', '9123456780', 'Mumbai'),
('Priya Singh', '1999-03-15', '9876543211', 'Delhi'),
('Aman Verma', '2001-07-22', '9876543212', 'Pune'),
('Sneha Joshi', '1997-11-30', '9876543213', 'Mumbai');

# Account Data
Insert into Accounts(customer_id,account_type,balance)values
(1, 'Savings', 50000),
(2, 'Current', 75000),
(3, 'Savings', 30000),
(4, 'Current', 120000),
(5, 'Savings', 45000);

#  Transaction Data
Insert into Transactions(account_id,amount,txn_type,txn_date)values
(1, 10000, 'Deposit', NOW()),
(1, 5000, 'Withdraw', NOW()),
(2, 20000, 'Deposit', NOW()),
(3, 5000, 'Deposit', NOW()),
(3, 2000, 'Withdraw', NOW()),
(4, 50000, 'Deposit', NOW()),
(4, 10000, 'Withdraw', NOW()),
(5, 15000, 'Deposit', NOW()),
(5, 3000, 'Withdraw', NOW());

# 1.Check account balaance
select account_id,balance
From Accounts
Where account_id = 1;

# 2.Customer + Account details
select c.name, a.account_type, a.balance
From Customers c 
Join Accounts a 
On c.customer_id = a.customer_id;

# 3.Total balanace per customer
SELECT c.name,SUM(a.balance) AS total_balance
FROM Customers c
JOIN Accounts a
ON c.customer_id = a.customer_id
GROUP BY c.name;

# 4.Find customer with highest balaance
select c.name,a.balance
From Customers c 
Join Accounts a 
On c.customer_id = a.customer_id
Order by a.balance desc
Limit 1;

# 5.Total deposit amount
select sum(amount) As total_deposit
From Transactions
Where txn_type = "Deposit";

# 6.Total withdrawal amount
select sum(amount) As total_withdrawal
From Transactions
where txn_type = "Withdraw";

# 7.Transaction history with customer name
select c.name,t.amount,t.txn_type,t.txn_date
From Customers c 
Join Accounts a 
On c.customer_id = a.customer_id
Join Transactions t 
On a.account_id = t.account_id;

# 8. Find average account balance
select AVG(balance) AS average_balance
From Accounts;

# 9.Find customers in pune
select * from customers
Where city = "Pune";

# 10.Count Accounts by type
 Select account_type,Count(*) As total_accounts
 From Accounts
 Group by account_type;