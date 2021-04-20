--charges fee for curent balance that is greater then the limit
--fee is 10% of portion of credit card limit
--display name, fee chrged, new balance

CREATE OR REPLACE FUNCTION p7() RETURNS VOID AS $$
	DECLARE
		c1 CURSOR FOR
			select distinct Account, Cname, Cbalance, Crlimit
			from c
			order by Account;

		--declare variables
		newBalanceCust 	DECIMAL(6,2);
		balanceCust	 	DECIMAL(6,2);
		accCust 		CHAR(5);
		nameCust 		CHAR(25);
		limitCust	INTEGER;
		fee		DECIMAL(6,2);

	BEGIN
		open c1;
			raise notice 'Service fee for going over credit card limit.';
			raise notice '_____________________________________________';
			raise notice '';
		loop
			fetch c1 into accCust, nameCust, balanceCust, limitCust;
			exit when not found;

			--when the balance is greater then the limit then fee is calculated
			if (balanceCust > limitCust) then
				fee := (balanceCust - limitCust) * 0.10;
				newBalanceCust := balanceCust - fee;

				-- Update
				UPDATE 	c
				SET 	Cbalance = newBalanceCust
				WHERE	Account = accCust;

				--print info 
				raise notice 'Customer Name: %', nameCust;
				raise notice 'Fee Charged: %', fee;
				raise notice 'New Balance: %', newBalanceCust;
				raise notice '';
			end if;
		end loop;
		close c1;
	END;
$$ LANGUAGE plpgsql;
