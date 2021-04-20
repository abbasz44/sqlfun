--info all transactions from a customer
--TODO dislay the date, cust_name and amount with the paramater
--of the customer name.


CREATE OR REPLACE FUNCTION p1(cust_name CHAR) RETURNS VOID AS $$
	DECLARE
		c1 CURSOR FOR
			SELECT 	Vname, T_Date, Amount
			FROM 	v,c,t
			--restrictions
			WHERE	c.Cname = cust_name AND
				t.Vno = v.Vno AND
				c.Account = t.Account;

		--declare variables
		nameVend CHAR(25);
		amTran INTEGER;
		dateTran DATE;

	BEGIN
		open c1;
			raise notice 'Customer Transactions for: %', cust_name;
			raise notice '_______________________________________';
			raise notice '';
		loop
		--print inforamtion
			fetch c1 into nameVend, dateTran, amTran;
			exit when not found;
			raise notice 'Vendor Name: %', nameVend;
			raise notice 'Date: %', dateTran;
			raise notice 'Amount: %', amTran;
			raise notice '';
		end loop;
		close c1;
	END;
$$ LANGUAGE plpgsql;
