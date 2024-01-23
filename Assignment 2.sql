/* CREATE TABLE salesman (
    salesman_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    commission DECIMAL(4,2)
);

INSERT INTO salesman (salesman_id, name, city, commission) VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5007, 'Paul Adam', 'Rome', 0.13),
(5003, 'Lauson Hen', 'San Jose', 0.12); 


CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(50),
    city VARCHAR(50),
    grade INT,
    salesman_id INT,
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);

INSERT INTO customer (customer_id, cust_name, city, grade, salesman_id) VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3008, 'Julian Green', 'London', 300, 5002),
(3004, 'Fabian Johnson', 'Paris', 300, 5006),
(3009, 'Geoff Cameron', 'Berlin', 100, 5003),
(3003, 'Jozy Altidor', 'Moscow', 200, 5007),
(3001, 'Brad Guzan', 'London', NULL, 5005); 

CREATE TABLE orders1 (
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(8,2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);

INSERT INTO orders1 (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
(70001, 150.5, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760, '2012-09-10', 3002, 5001),
(70010, 1983.43, '2012-10-10', 3004, 5006),
(70003, 2480.4, '2012-10-10', 3009, 5003),
(70012, 250.45, '2012-06-27', 3008, 5002),
(70011, 75.29, '2012-08-17', 3003, 5007),
(70013, 3045.6, '2012-04-25', 3002, 5001); */

  
/* 1. write a SQL query to find the salesperson and customer who reside in the same city. 
Return Salesman, cust_name and city */

Select customer.cust_name, customer.city, salesman.name 
From salesman 
INNER JOIN customer ON customer.salesman_id = salesman.salesman_id 
WHERE customer.city = salesman.city;


/* 2. write a SQL query to find those orders where the order amount exists between 500 
and 2000. Return ord_no, purch_amt, cust_name, city */

Select orders1.ord_no, orders1.purch_amt, customer.cust_name, customer.city 
From orders1 
INNER JOIN customer on customer.customer_id=orders1.customer_id 
Where orders1.purch_amt BETWEEN 500.00 AND 2000.00;


/* 3. write a SQL query to find the salesperson(s) and the customer(s) he represents. 
Return Customer Name, city, Salesman, commission */

select c.cust_name ,  c.city , s.name, s.commission 
FROM customer as c 
INNER JOIN salesman as s ON c.salesman_id = s.salesman_id;


/* 4. write a SQL query to find salespeople who received commissions of more than 12 
percent from the company. Return Customer Name, customer city, Salesman, 
commission. */

select c.cust_name ,  c.city , s.name, s.commission 
FROM customer as c 
INNER JOIN salesman as s ON c.salesman_id = s.salesman_id 
WHERE commission > 0.12;


/* 5. write a SQL query to locate those salespeople who do not live in the same city where 
their customers live and have received a commission of more than 12% from the 
company. Return Customer Name, customer city, Salesman, salesman city, 
commission */

Select c.cust_name, c.city, s.name, s.city, s.commission 
From salesman as s 
INNER JOIN customer as c ON c.salesman_id = s.salesman_id 
WHERE c.city != s.city AND commission > 0.12;


/* 6. write a SQL query to find the details of an order. Return ord_no, ord_date, 
purch_amt, Customer Name, grade, Salesman, commission */

select o.ord_no, o.ord_date, o.purch_amt, c.cust_name, c.grade, s.name, s.commission 
From orders1 as o 
INNER JOIN customer as c ON o.customer_id=c.customer_id 
INNER JOIN salesman as s ON s.salesman_id = c.salesman_id


/* 7. Write a SQL statement to join the tables salesman, customer and orders so that the 
same column of each table appears once and only the relational rows are returned. */

select o.ord_no, o.purch_amt, o.ord_date, o.customer_id, c.cust_name as "Customer name", c.grade, c.salesman_id, s.name as "salesman name", s.commission 
From orders1 as o 
INNER JOIN customer as c ON o.customer_id=c.customer_id 
INNER JOIN salesman as s ON s.salesman_id = c.salesman_id


/* 8. write a SQL query to display the customer name, customer city, grade, salesman, 
salesman city. The results should be sorted by ascending customer_id. */

select c.cust_name, c.city as "customer city", c.grade, s.name, s.city as "Salesman city" 
from customer as c 
LEFT JOIN salesman as s ON s.salesman_id=c.salesman_id 
ORDER BY c.customer_id ;  


/* 9. write a SQL query to find those customers with a grade less than 300. Return 
cust_name, customer city, grade, Salesman, salesmancity. The result should be 
ordered by ascending customer_id.  */

select c.cust_name, c.city as "customer city", c.grade, s.name, s.city as "Salesman city" 
from customer as c 
LEFT JOIN salesman as s ON s.salesman_id=c.salesman_id 
WHERE c.grade < 300 
ORDER BY c.customer_id ;  


/* 10. Write a SQL statement to make a report with customer name, city, order number, 
order date, and order amount in ascending order according to the order date to 
determine whether any of the existing customers have placed an order or not */

SELECT c.cust_name, c.city as "customer city",  o.ord_no, o.ord_date,  o.purch_amt FROM customer as c 
LEFT JOIN orders1 as o ON o.customer_id = c.customer_id 
ORDER BY o.ord_date;


/* 11. Write a SQL statement to generate a report with customer name, city, order number, 
order date, order amount, salesperson name, and commission to determine if any of 
the existing customers have not placed orders or if they have placed orders through 
their salesman or by themselves */

SELECT c.cust_name, c.city as "customer city",  o.ord_no, o.ord_date,  o.purch_amt, s.name, s.commission 
FROM customer as c 
LEFT JOIN orders1 as o ON o.customer_id = c.customer_id 
LEFT JOIN salesman as s ON o.salesman_id = s.salesman_id 
ORDER BY o.ord_date;


/* 12. Write a SQL statement to generate a list in ascending order of salespersons who 
work either for one or more customers or have not yet joined any of the customers */

select  s.salesman_id, s.name, s.city as "Salesman city", c.cust_name, c.city as "customer city", c.grade 
from customer as c 
RIGHT JOIN salesman as s ON s.salesman_id=c.salesman_id  
ORDER BY s.salesman_id ; 
 

/* 13. write a SQL query to list all salespersons along with customer name, city, grade, 
order number, date, and amount. */

SELECT s.salesman_id, s.name, c.cust_name, c.city as "customer city",  o.ord_no, o.ord_date,  o.purch_amt, s.name, s.commission 
FROM customer as c 
LEFT JOIN orders1 as o ON o.customer_id = c.customer_id 
LEFT JOIN salesman as s ON o.salesman_id = s.salesman_id AND c.salesman_id = s.salesman_id
ORDER BY s.salesman_id


/* 14. Write a SQL statement to make a list for the salesmen who either work for one or 
more customers or yet to join any of the customers. The customer may have placed, 
either one or more orders on or above order amount 2000 and must have a grade, or 
he may not have placed any order to the associated supplier. */

SELECT salesman.salesman_id, salesman.name, salesman.city, customer.customer_id, orders1.purch_amt
FROM salesman
LEFT JOIN customer ON salesman.salesman_id = customer.salesman_id
LEFT JOIN orders1 ON customer.customer_id = orders1.customer_id
WHERE 
  (
    orders1.purch_amt >= 2000 OR orders1.purch_amt IS NULL
  )
  AND customer.grade IS NOT NULL;


/* 15. Write a SQL statement to generate a list of all the salesmen who either work for one 
or more customers or have yet to join any of them. The customer may have placed 
one or more orders at or above order amount 2000, and must have a grade, or he 
may not have placed any orders to the associated supplier. */

SELECT salesman.salesman_id, salesman.name, salesman.city, customer.customer_id, orders1.purch_amt
FROM salesman
LEFT JOIN customer ON salesman.salesman_id = customer.salesman_id
LEFT JOIN orders1 ON customer.customer_id = orders1.customer_id
WHERE 
  (
    orders1.purch_amt >= 2000 OR orders1.purch_amt IS NULL
  )
  AND customer.grade IS NOT NULL;


/* 16. Write a SQL statement to generate a report with the customer name, city, order no. 
order date, purchase amount for only those customers on the list who must have a 
grade and placed one or more orders or which order(s) have been placed by the 
customer who neither is on the list nor has a grade. */

select c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt 
From customer as c LEFT JOIN orders1 as o 
ON c.customer_id = o.customer_id 
WHERE 
	(c.grade IS NOT NULL AND o.ord_no IS NOT NULL) 
	OR (c.grade IS NULL AND o.ord_no IS NOT NULL); 


/* 17. Write a SQL query to combine each row of the salesman table with each row of the 
customer table */
Select * from salesman FULL JOIN Customer ON customer.salesman_id = salesman.salesman_id;


/* 18. Write a SQL statement to create a Cartesian product between salesperson and 
customer, i.e. each salesperson will appear for all customers and vice versa for that 
salesperson who belongs to that city */

Select * From salesman CROSS JOIN customer WHERE salesman.city IS NOT NULL;


/* 19. Write a SQL statement to create a Cartesian product between salesperson and 
customer, i.e. each salesperson will appear for every customer and vice versa for 
those salesmen who belong to a city and customers who require a grade */

Select * From salesman CROSS JOIN customer WHERE salesman.city IS NOT NULL AND customer.grade IS NOT NULL;


/* 20. Write a SQL statement to make a Cartesian product between salesman and 
customer i.e. each salesman will appear for all customers and vice versa for those 
salesmen who must belong to a city which is not the same as his customer and the 
customers should have their own grade */Select * From salesman CROSS JOIN customer WHERE salesman.city!=customer.city AND customer.grade IS NOT NULL;

