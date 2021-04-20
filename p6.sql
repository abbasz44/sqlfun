--service fee of 4% of the balance make sure to subtract fee to amount
--display the name, fee, and new balance

CREATE OR REPLACE FUNCTION p6() RETURNS VOID AS $$
	DECLARE
		c1 CURSOR FOR
		  --order by ven num
			select distinct Vno, Vname, Vbalance
			from v
			order by Vno;

		--declare variables
		balanceVend	 	DECIMAL(6,2);
		newBalanceVend 	DECIMAL(6,2);
		numVend 		CHAR(5);
		nameVend 		CHAR(25);


	BEGIN
		open c1;
			raise notice '4%% service fee charged to all the Vendors';
			raise notice '__________________________________________';
			raise notice '';
		loop
			fetch c1 into numVend, nameVend, balanceVend;
			exit when not found;

			--4% fee put to new balance
			newBalanceVend := balanceVend * 0.04;

			-- Update
			UPDATE 	v
			SET 	Vbalance = Vbalance - newBalanceVend
			WHERE	Vno = numVend;

			--print info
			raise notice 'Vendor Name: %', nameVend;
			raise notice 'Fee Charged: %', newBalanceVend;
			raise notice 'New Balance: %', balanceVend - newBalanceVend;
			raise notice '';
		end loop;
		close c1;
	END;
$$ LANGUAGE plpgsql;
