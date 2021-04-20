--create a function calculate the transactions for every vendor
--add total + current balance
--displays vendor #, name, balance

CREATE OR REPLACE FUNCTION p5() RETURNS VOID AS $$
	DECLARE
		c1 CURSOR FOR
		--order by the vend num
			select distinct Vno, Vname, Vbalance
			from v
			order by Vno;

		--decalre variables
		balanceVend	 	DECIMAL(6,2);
		newBalanceVend 	INTEGER;
		numVend 		CHAR(5);
		nameVend 		CHAR(25);


	BEGIN
		open c1;
			raise notice 'The list of transactions have been updated from vendor balance.';
			raise notice '_______________________________________________________________';
			raise notice '';
		loop
			fetch c1 into numVend, nameVend, balanceVend;
			exit when not found;

			--make sure you get all the transactions
      --use the sum function and  put into new balance
			SELECT 	COALESCE(SUM(Amount), 0)
			INTO	newBalanceVend
			FROM 	t
			WHERE 	t.Vno = numVend;

			--updater
			UPDATE 	v
			SET 	Vbalance = Vbalance + newBalanceVend
			WHERE	Vno = numVend;

			--print info 
			raise notice 'Vendor Number: %', numVend;
			raise notice 'Vendor Name: %', nameVend;
			raise notice 'New Balance: %', balanceVend + newBalanceVend;
			raise notice '';
		end loop;
		close c1;
	END;
$$ LANGUAGE plpgsql;
