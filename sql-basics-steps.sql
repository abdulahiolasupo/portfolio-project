#USE sql_store;

SELECT name, unit_price, (unit_price * 1.1) AS new_price
FROM products;

SELECT * FROM customers
WHERE points > 3000;

SELECT * FROM customers
WHERE state = 'VA';

SELECT * FROM customers
WHERE state <> 'va';

SELECT * FROM customers
WHERE birth_date > '1990-01-01';

SELECT * FROM orders
WHERE order_date = '2019-01-30';

SELECT * FROM customers
WHERE birth_date > '1990-01-01' AND points > 1000;

SELECT * FROM customers
WHERE birth_date > '1990-01-01' OR 
points > 1000 AND state = 'va';

SELECT * FROM customers
WHERE NOT (birth_date > '1990-01-01' OR 
points > 1000);

SELECT * FROM customers
WHERE birth_date <= '1990-01-01' AND points <= 1000;

SELECT order_id, unit_price, quantity, (quantity * unit_price) AS total_price,
product_id
FROM order_items
WHERE order_id = '6' AND (quantity * unit_price) > 30;

SELECT * FROM customers
WHERE state IN ('VA','FL','GA');


SELECT * FROM customers
WHERE state NOT IN ('VA','FL','GA');

DELETE FROM customers
WHERE customer_id IN (23,24,25,26,27);

SELECT * FROM products
WHERE quantity_in_stock IN (49, 38, 72);

SELECT * FROM customers
WHERE points BETWEEN 1000 AND 3000;

SELECT * FROM customers
WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01';

SELECT * FROM customers
WHERE last_name LIKE 'BETCH%';

####### TO GET A CUSTOMER WHERE B IS ANYWHERE IN THE LASTNAME ######
SELECT * FROM customers
WHERE last_name LIKE '%b%';

####### TO GET A CUSTOMER WHERE THE LASTNAME END WITH Y ######
SELECT * FROM customers
WHERE last_name LIKE '%Y';

####### TO GET A CUSTOMER WHERE THE LASTNAME END WITH Y AND IT HAS TO BE CHAR(6) ######
SELECT * FROM customers
WHERE last_name LIKE '_____Y';

SELECT * FROM customers
WHERE last_name LIKE 'b____Y';

SELECT * FROM customers
WHERE address LIKE '%TRAIL%';

SELECT * FROM customers
WHERE address LIKE '%AVENUE%';

SELECT * FROM customers
WHERE phone LIKE '%9';

SELECT * FROM customers
WHERE address LIKE '%TRAIL%' OR address LIKE '%AVENUE%';

SELECT * FROM customers
WHERE phone NOT LIKE '%9';


################ REGEXP  ##############

SELECT * FROM customers
WHERE last_name REGEXP 'GAY';

SELECT * FROM customers
WHERE last_name REGEXP 'RUM';

SELECT * FROM customers
WHERE address REGEXP 'TRAIL' OR address REGEXP 'AVENUE';

####### REGEXP LASTWORD ALONG WITH DOLLAR SIGN "$"  ######

SELECT * FROM customers
WHERE last_name REGEXP 'NETT$';

####### REGEXP FIRSTWORD ALONG WITH SIGN.  "^" INFRONT  ######

SELECT * FROM customers
WHERE last_name REGEXP '^BRUSH' OR last_name REGEXP '^ROSE';

##### REGEXP ALONG WITH PIPE "|" ##########$$$$

SELECT * FROM customers
WHERE address REGEXP 'trail|avenue';

#SELECT * FROM customers
#WHERE first_name REGEXP 'ROM|CLEM|FRED'

SELECT * FROM customers
WHERE first_name REGEXP 'CHER$|CLEM|FRED|ROM';

SELECT * FROM customers
WHERE last_name REGEXP '[sdlg]e';

SELECT * FROM customers
WHERE first_name REGEXP '[oea]m';

SELECT * FROM customers
WHERE last_name REGEXP 'o[asw]';

SELECT * FROM customers
WHERE last_name REGEXP '[a-k]e';

SELECT * FROM customers
WHERE first_name REGEXP '[a-r]e';

# ^ to search for beginning of a string
# $ to search for end of a string
# | logical or to search for multiple string
# [abcbd] to match any single character listed in the bracket
# [a-g] to search for range of the character in the bracket

SELECT * FROM customers
WHERE first_name REGEXP 'ELKA|AMBUR';

SELECT * FROM customers
#WHERE last_name LIKE '%EY' OR last_name LIKE '%ON'
WHERE last_name REGEXP 'EY$|ON$';


SELECT * FROM customers
WHERE last_name REGEXP '^MY|SE';

SELECT * FROM customers
WHERE last_name REGEXP 'b[ru]';

SELECT * FROM customers
WHERE last_name REGEXP 'br|bu';


###### HOW TO GET A RECORD WITH MISSING VALUES ###### "IS NULL" OPERATOR ######


#### TO SEARCH FOR ALL THE CUSTOMERS THAT DOES NOT HAVE PHONE NO IN THE DATABASE ####
## "IS NULL"OPERATOR CAN BE USED ###

SELECT * FROM customers
WHERE phone IS NULL;

SELECT * FROM customers
WHERE phone IS NOT NULL;

SELECT * FROM orders
WHERE shipped_date IS NULL;

####### "ORDER BY" OPERATOR ######## "ORDER BY" IS USE FOR SORTING DATA ###

SELECT * FROM customers
ORDER BY first_name;

SELECT * FROM customers
ORDER BY first_name DESC;

SELECT * FROM customers
ORDER BY state,first_name;

SELECT first_name, last_name, birth_date
FROM customers
ORDER BY birth_date;

SELECT first_name, last_name, 10 AS points
FROM customers
ORDER BY points,first_name;

SELECT *, quantity * unit_price AS total_price
FROM order_items
WHERE order_id = 2
ORDER BY total_price DESC;

##### HOW TO "LIMIT" THE NUMBER OF RETURNS FROM THE QUERIES

SELECT * FROM customers
LIMIT 3;

SELECT * FROM customers
LIMIT 300;

SELECT * FROM customers
LIMIT 6, 3;            #### it means skip row 1 - 6 and return the next three rows


SELECT * FROM customers
LIMIT 8, 2;          #### it means skip row 1 - 8 and return the next two rows


### GET TOP THREE LOYAL CUSTOMERS THAT HAS MORE POINTS THAN ANYONE ELSE

SELECT * FROM customers
ORDER BY points DESC
LIMIT 3;

#### PAY ATTENTION WHEN WRITING YOUR QUERIES AND FOLLOW THE ORDER OTHERWISE THERE WILL BE ERROR ###

#SELECT
#FROM
#WHERE
#ORDER BY
#LIMIT

######## INNER JOINS  #####

SELECT * 
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id;

SELECT order_id, first_name, last_name
FROM orders JOIN customers ON orders.customer_id = customers.customer_id;


SELECT order_id, orders.customer_id, first_name, last_name
FROM orders 
JOIN customers ON orders.customer_id = customers.customer_id;


SELECT order_id, o.customer_id, first_name, last_name
FROM orders o JOIN customers c ON o.customer_id = c.customer_id;

# TASK

SELECT order_id, oi.product_id, quantity, oi.unit_price
FROM order_items oi 
JOIN products pr ON oi.product_id = pr.product_id;


###### JOINING TABLES ACROSS DATABASES ######

SELECT * 
FROM order_items oi
JOIN sql_inventory.products pr 
ON oi.product_id = pr.product_id;


#USE sql_inventory;

SELECT *
FROM sql_store.order_items oi 
JOIN products pr ON oi.product_id = pr.product_id;


##### SELF JOIN (TABLE CAN BE JOIN WITH ITSELF) IN SQL ######

SELECT e.employee_id, e.first_name, e.last_name, m.first_name as mamager
FROM employees e
JOIN employees m 
ON e.reports_to = m.employee_id;


##### SELF JOIN (TABLE CAN BE JOIN WITH ITSELF) IN SQL ######

#USE sql_store;

SELECT cu.customer_id, cu.first_name, cu.city, cust.phone AS mobile
FROM customers cu
JOIN customers cust 
ON cu.customer_id = cust.customer_id;

#########$$$$$  JOINING MULTIPLE TABLES  ######$$$$$$$$

#USE sql_store;

SELECT o.order_id, o.order_date, c.first_name, c.last_name, os.name AS status
FROM orders o 
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_statuses os ON o.status = os.order_status_id;


SELECT oi.product_id, oi.order_id, quantity_in_stock, 
name AS product_name, note AS consignment
FROM products pr
JOIN order_items oi 
ON pr.product_id = oi.product_id
JOIN order_item_notes oin 
ON oi.order_id = oin.order_id;

#USE sql_invoicing;
SELECT date, p.client_id,c.name, amount, pm.name AS payments_method, invoice_id
FROM payments p JOIN clients c
ON p.client_id = c.client_id
JOIN payment_methods pm 
ON p.payment_id = pm.payment_method_id;


#####$$$$$$$$ COMPOUND JOIN CONDITIONS i.e multiple conditions to JOIN TABLE USING "AND" #######$$$$$$$$

SELECT * 
FROM order_items oi
JOIN order_item_notes oin 
ON oi.order_id = oin.order_Id
AND oi.product_id = oin.product_id;


###$$$ EXPLICIT JOIN SYNTAX ###$

SELECT *
FROM orders o 
JOIN customers c 
ON o.customer_id = c.customer_id;

##$$$ BELOW QUERIE IS "IMPLICIT JOIN SYNTAX" AND IT'S THE SAME WITH ABOVE QUERIES ####$$$
###$$$ BUT PREVIOUS METHOD(EXPLICIT) IS BETTER ###$$$

####$$ "IMPLICIT JOIN SYNTAX" ##$$$
SELECT *
FROM orders o, customers c
WHERE o.customer_id = c.customer_id;


########$$$$$$$ OUTER JOINS ######$$$$$
SELECT c.customer_id, c.first_name, 
o.order_id 
FROM customers c
JOIN orders o 
ON c.customer_id = o.customer_id
ORDER BY customer_id;

SELECT c.customer_id, c.first_name, 
o.order_id 
FROM customers c
LEFT JOIN orders o 
ON c.customer_id = o.customer_id
ORDER BY customer_id;

SELECT c.customer_id, c.first_name, 
o.order_id 
FROM customers c
RIGHT JOIN orders o 
ON c.customer_id = o.customer_id
ORDER BY customer_id;

###$$ Above query shows only customers that order ####$
###$$ Now To see all the customers, you need to swift the table as below ####$$$


SELECT c.customer_id, c.first_name, 
o.order_id 
FROM orders o
RIGHT JOIN customers c 
ON o.customer_id = c.customer_id
ORDER BY customer_id;


SELECT pr.product_id, name, oi.quantity 
FROM order_items oi
RIGHT JOIN products pr
ON oi.product_id = pr.product_id;

      ## OR ## ## WHICH EVER WAY YOU WANT ####
      
SELECT pr.product_id, name, oi.quantity 
FROM products pr
LEFT JOIN order_items oi
ON pr.product_id = oi.product_id;


#####$$$$$ OUTER JOINS BETWEEN MULTIPLE TABLES  #####$$$$
### NOW LET'S JOIN THE 'orders table' WITH THE 'shippers table' ###$$$$
### NOTE AS BEST PRACTICE AVOID USING RIGHT JOIN ###$$$

SELECT c.customer_id, c.first_name, 
o.order_id, sh.name AS shipper 
FROM customers c
LEFT JOIN orders o 
ON c.customer_id = o.customer_id
LEFT JOIN shippers sh ON o.shipper_id = sh.shipper_id
ORDER BY customer_id;

### TASK #####

SELECT order_date, order_id, first_name, sh.name AS shipper, os.name AS status
FROM orders o 
LEFT JOIN customers c  
ON o.customer_id = c.customer_id
LEFT JOIN shippers sh 
ON o.shipper_id = sh.shipper_id
LEFT JOIN order_statuses os 
ON o.status = os.order_status_id;


#####$$$$$$ SELF OUTER JOINS  ####$$$$$

SELECT e.employee_id, e.first_name, m.first_name AS manager
FROM employees e 
LEFT JOIN employees m 
ON e.reports_to = m.employee_id;


######$$$$$ "USING" CLAUSE #####$$$
## NOTE "USING" FUNCTION ONLY WORKS IF THE COLUMN NAME IS EXACTLY THE SAME ACROSS DIFFERENT TABLES ##$$

SELECT o.order_id, c.first_name, sh.name AS shipper
FROM orders o 
JOIN customers c 
USING(customer_id)
LEFT JOIN shippers sh 
USING(shipper_id);

###$$ TASK TO JOIN 'order_items TABLE' THAT HAVE TWO "PRIMARY KEY" WITH "order_item_notes TABLE" ##
### NOTE THE COLUMN NAME OF THESE TABLES ARE EXACTLY THE SAME AND IT'S REQUIRE TWO CONDITIONS ###

SELECT *
FROM order_items oi
JOIN order_item_notes oin
USING(order_id, product_id);


SELECT date,client_id, amount, name 
FROM payments p 
LEFT JOIN payment_methods pm
ON p.payment_id = pm.payment_method_id;

#### OR #####

SELECT date, c.name AS client, amount, pm.name AS payment_method
FROM payments p 
JOIN clients c 
USING(client_id)
LEFT JOIN payment_methods pm
ON p.payment_method = pm.payment_method_id;


#####$$$$$ NATURAL JOINS (BUT IT'S NOT SOMETHING RECOMENDABLE) COS IT'S NOT ACCURATE ######$$$
###$$$ IT'S LOOK EASY BUT MIGHT BE INACCURATE BECOS YOU ARE ALLOWING DATABASE ENGINE GUESS JOIN $$##

SELECT o.order_id, c.first_name
FROM orders o 
NATURAL JOIN customers c 
ORDER BY order_id;


####$$$$ CROSS JOIN: IT'S USE TO COMBINE/JOIN EVERY RECORDS FROM THE FIRST TABLE WITH EVERY RECORDS IN THE SECOND TABLE ####$$$
## TYPICAL EX. OF WHERE TO USE CROSS JOIN(small/medium sizes of table,and table of colors, red,blue,green..and NEED TO COMBINE ALL THE SIZES WITH ALL THE COLORS)

SELECT c.first_name AS customer, p.name AS product
FROM customers c 
CROSS JOIN products p 
ORDER BY c.first_name;

#### THIS IS EXPLICIT SYNTAX ##
SELECT sh.name AS shipper, p.name AS product
FROM products p 
CROSS JOIN shippers sh 
ORDER BY sh.name;


#### THIS IS IMPLICIT SYNTAX ### BUT INSTRUCTOR SUGGEST EXPLICIT METHOD ######
SELECT sh.name AS shipper, p.name AS product
FROM products p, shippers sh 
ORDER BY sh.name;


####$$# UNION ##### BUT REMEMBER THAT OUTPUT OF THE 2 TABLES YOU'RE UNION MUST BE SAME COLUMN ##$$$
### OTHERWISE IT WILL RETURN ERROR $$### ALSO NOTE THAT WHATEVER NAME WE HAVE IN THE FIRST QUERIES ##
### WILL DETERMIN OUTPUT COLUMN NAME ##

SELECT customer_id, order_date, 'Active' AS status
FROM orders o 
WHERE order_date >= '2019-01-01'

UNION

SELECT customer_id, order_date, 'Archives' AS status
FROM orders o
WHERE order_date < '2019-01-01';


SELECT customer_id, first_name, points, 'Bronze' AS type
FROM customers c 
WHERE points < 2000  
UNION

SELECT customer_id, first_name, points, 'Silver' AS type
FROM customers c 
WHERE points BETWEEN  2000 AND 3000  
UNION

SELECT customer_id, first_name, points, 'Gold' AS type
FROM customers c 
WHERE points > 3000
ORDER BY first_name;

####$$$ COLUMN ATTRIBUTES (INSERT, UPDATES AND DELETE DATA)  ###$$$
###$$$ INSERTING A SINGLE ROW ###$$$

INSERT INTO customers(first_name, last_name, 
birth_date, phone, address, 
city, state, points)

VALUES('John', 'Smith', '1990-01-01', '055-432-6345', '13B','Rashidiyah', 'Du', '2500'



);

#####$$ INSERTING MULTIPLE ROWS ####$$$

INSERT INTO shippers(name)
VALUES('John'), ('Smith'),('Lyle');


INSERT INTO order_items(quantity, unit_price, product_id, order_id)
VALUES('4','3.45', '4',8),('6','2.76','3',9);

#INSERT INTO products(name, quantity_in_stock, unit_price)
#VALUES('Mango', '60', '3.47'), ('Orange', '52', '1.23'), ('Carrot', '72','3.78')


##$$$ INSERTING HIERARCHICAL ROWS(INSERT DATA INTO MULTIPLE TABLES) ###$$
##VALID 'customer_id' and 'order_id' IS MUST ###$$

INSERT INTO orders(customer_id, order_date, status)
VALUES(1, '2019-01-01', 1);

INSERT INTO order_items
VALUES
(LAST_INSERT_ID(),1,3,3.16), (LAST_INSERT_ID(),2,6,3.16), (LAST_INSERT_ID(),3,10,3.16);


####$$$ CREATING A COPY OF A TABLE(HOW TO COPY DATA FROM ONE TABLE TO ANOTHER) #####$$

CREATE TABLE orders_archived AS
SELECT * FROM orders;

INSERT INTO orders_archived
SELECT * FROM orders
WHERE order_date < '2019-01-05';


CREATE TABLE invoices_archived AS
SELECT 
i.invoice_id, number, c.name AS client, invoice_total, payment_total, invoice_date, due_date, payment_date
FROM invoices i 
JOIN clients c 
USING(client_id)
WHERE payment_date IS NOT NULL;


###$$$  UPDATING A SINGLE ROW (HOW TO UPDATE DATA IN SQL) ###$$$$    

UPDATE invoices
SET payment_total = 50, payment_date = '2019-03-02'
WHERE invoice_id = 1;

###$$$ ASSUMING YOU UPDATED WRONG ROW, WE CAN GO BACK TO THE QUIERY AND CORRECT MISTAKES AS BELOW ###$
## CHECK  TABEL IN DESIGN MODE TO SEE COLUMN THAT ACCEPT 'NULL', 'DEFAULT' 'VARCHAR' AND 'INT'##$$$

UPDATE invoices
SET payment_total = 0, payment_date = NULL
WHERE invoice_id = 1;


###$$$ ASSUMING CLIENT PAID 50% of the 'payment_total' %%%$

UPDATE invoices
SET payment_total = invoice_total * 0.5, 
payment_date = due_date
WHERE invoice_id = 1;



###$$$  UPDATING MULTIPLE ROW (HOW TO UPDATE DATA IN SQL) ###$$$$    
### FOR THIS TABLE, 'client_id' will be used as CONDITIONAL STATEMENT SINCE THEY ARE MORE THAN ONE##$$

UPDATE invoices
SET payment_total = invoice_total * 0.5, 
payment_date = due_date
WHERE client_id = 3;
### ALL THE CLIENT 3 INVOICES HAS BEEN UPDATED $$$


###$$ ASSUMING YOU WANT TO UPDATE ALL THE INVOICES FOR CLIENT 2  AND 5, 'IN' OPERATOR WILL BE USED ##$$

UPDATE invoices
SET payment_total = invoice_total * 0.4,
payment_date = due_date
WHERE client_id IN (2,5);


###$$ ASSUMING YOU WANT TO UPDATE ALL THE RECORDS IN A TABLE, YOU CAN INGNORE WHERE CLAUSE ##$$

# Que. UPDATE ALL CUSTPMERS BORN BEFORE 1990 WITH 50 POINTS EXTRA ###
UPDATE customers
SET points = points + 50
WHERE birth_date < '1990-01-01';


### USING SUBQUERIES IN UPDATE (SUBQUERIES IS A SELECT STATEMENT THAT IS WITHIN ANOTHER SQL STATEMENT) ##$$
UPDATE invoices
SET payment_total = invoice_total * 0.5, 
payment_date = due_date
WHERE client_id = 
      (SELECT client_id
      FROM clients
      WHERE name = 'Myworks');    


#ASSUMIN WE DON'T HAVE IDEA OF CLIENT_ID, WE HAVE NAME ONLY#
## NOW TO FIND CLIENT_ID ###
SELECT client_id
FROM clients
WHERE name = 'Myworks';     ##### OR IF IT IS STATE/ -- WHERE state = 'NY' ####$$


###$$ ASSUMING WE WANT TO UPDATE FOR ALL CLIENT LOCATED IN CALIFONIA (CA) AND NEWYORK(NY) $$$##
UPDATE invoices
SET payment_total = invoice_total * 0.5, 
payment_date = due_date
WHERE client_id IN               
      (SELECT client_id
      FROM clients
      WHERE state IN ('CA', 'NY'));
      


###$$ BEST PRACTISE, UPDATE SUBQUIRIES BEFORE UPDATING THE MAIN RECORD TO SEE WHAT EXACTLY YOU ARE UPDATING ##$$
###NOTE, EVEN IF WE DON'T HAVE SUBQUERIES, WE CAN STILL QUIERIE THE RECORD WE WANT TO UPDATE ####

### ASSUMING WE WANT TO UPDATE ALL THE INVOICES WHERE 'payment_date' IS NULL.
UPDATE invoices
SET payment_total = invoice_total * 0.5, 
payment_date = due_date
WHERE payment_date IS NULL;


#TASK: update comments column for orders table for customers who have more than 3000 points, find their orders,
#update comments column and set it to gold customer. 


SELECT customer_id
FROM customers
WHERE points > 3000;          ##then use this select satement as a subqueries in update statement ##

UPDATE orders
SET comments = 'gold_customer'
WHERE customer_id IN              
      (SELECT customer_id
      FROM customers
      WHERE points > 3000);


## DELETING ROWS $$$##$$$$$

DELETE FROM invoices
WHERE client_id = (

SELECT *
FROM clients
WHERE name = 'Kwedio' 

)

;