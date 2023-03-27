/*
SQL ASSIGNMENT PART 3
*/

##############################################################################################################################################################
#QUESTION 1: . Write a stored procedure that accepts the month and year as inputs and prints the ordernumber, orderdate and status of the orders placed in that month. Example:  call order_status(2005, 11);
#ANSWER:

select * from orders;

delimiter $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `order_stacked`(month1 varchar(20), year1 int)
BEGIN
select orderNumber,orderDate, status 
from orders 
where year(orderdate)=year1 and left(monthname(orderdate),3)=month1;
END $$


call assignment.order_stacked('jan', 2003);

###################################################################################################################################################
#QUESTION 2: Write a stored procedure to insert a record into the cancellations table for all cancelled orders.

#QUESTION 2: a)	Create a table called cancellations with the following fields : id (primary key), customernumber (foreign key - Table customers), ordernumber (foreign key - Table Orders), comments. All values except id should be taken from the order table.

create table if not exists cancellations (ID int primary key auto_increment,
customernumber int,foreign key (customernumber) references customers (customernumber) on delete set null on update cascade,
ordernumber int,foreign key (ordernumber) references orders (ordernumber) on delete set null on update cascade,
Status varchar(15));


#QUESTION 2: b) Read through the orders table . If an order is cancelled, then put an entry in the cancellations table.

delimeter $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `cancelled_order`()
BEGIN
declare var_id int;
declare var_customernumber int; 
declare var_ordernumber int;
declare var_status varchar(15) ;

declare cancelled_order cursor for select customernumber, ordernumber,status from orders;

open cancelled_order;
myloop: loop
fetch cancelled_order into var_customernumber,var_ordernumber, var_status;
if var_status='cancelled' then
insert into cancellations values (var_id, var_customernumber,var_ordernumber,var_status);
end if;
end loop;
close canc_order;
END $$



###############################################################################################################################################

#QUESTION 3:a) Write function that takes the customernumber as input and returns the purchase_status based on the following criteria . [table:Payments]if the total purchase amount for the customer is < 25000 status = Silver, amount between 25000 and 50000, status = Gold , if amount > 50000 Platinum
#ANSWER;

delimiter $$
CREATE DEFINER=`root`@`localhost` FUNCTION `purchase_status`(cust_num bigint) RETURNS char(20) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE status_value CHAR(20);
    DECLARE total_amt numeric;
    SET total_amt = (select sum(Amount) from Payments where Customernumber = cust_num);

    IF (total_amt > 50000) THEN
        SET status_value = 'platinum';
    ELSEIF total_amt between 25000 and 50000 then
        set status_value='Gold';
	else
        SET status_value='silver';
        
    END IF;
    RETURN status_value;
END $$


select assignment.purchase_status(103);


#QUESTION 3:b) . Write a query that displays customerNumber, customername and purchase_status from customers table.

select  customernumber,  customername, (select assignment.purchase_status(customernumber)) as Purchase_Status from customers;

######################################################################################################################################################

#QUESTION 4: Replicate the functionality of 'on delete cascade' and 'on update cascade' using triggers on movies and rentals tables. Note: Both tables - movies and rentals - don't have primary or foreign keys. Use only triggers to implement the above.

SELECT * FROM MOVIES;
SELECT * FROM RENTALS;

DELIMITER $$
CREATE TRIGGER trg_movies_update
AFTER DELETE ON movies
FOR EACH ROW
BEGIN
    UPDATE rentals
    SET movieid = id
    WHERE movieid = OLD.id ;
END;

DELIMITER $$
CREATE TRIGGER trg_movies_delete 
AFTER DELETE ON movies 
FOR EACH ROW 
BEGIN
    DELETE FROM  rentals
    WHERE movieid 
    NOT IN (SELECT DISTINCT id FROM movies);
END;

################################################################################################################################################################

#QUESTION 5: Select the first name of the employee who gets the third highest salary. [table: employee]

SELECT * FROM EMPLOYEE;

SELECT 
    FNAME
FROM
    `employee`
ORDER BY `salary` DESC
LIMIT 1 OFFSET 2;
#####################################################################################################################################################

#QUESTION 6: Assign a rank to each employee  based on their salary. The person having the highest salary has rank 1. [table: employee]

SELECT FNAME,SALARY, row_number() OVER (order by salary desc) rownumber from employee;