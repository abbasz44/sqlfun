--this function takes the paramters c_acc, c_name, c_prov, and c_limit,
-- it inserts a new cusotmer record
--balance = 0.00

CREATE OR REPLACE FUNCTION p3( c_acc CHAR,c_name CHAR, c_prov CHAR, c_limit INTEGER) RETURNS VOID AS $$
	DECLARE
		c1 CURSOR FOR
		--go through all customer info
			SELECT 	*
			FROM c;

		balanceCust 	DECIMAL(6,2);
		provCust 	CHAR(3);
		limCust 	INTEGER;
		accCust 	CHAR(5);
		nameCust 	CHAR(25);

	BEGIN
		INSERT INTO c VALUES
		--make sure balance set too 0.00
		(c_acc, c_name, c_prov, 0.00, c_limit);

		open c1;

		loop
		--print out info
			fetch c1 into accCust, nameCust, provCust, balanceCust, limCust;
			exit when not found;
			raise notice 'Customer Number: %', accCust;
			raise notice 'Name: %', nameCust;
			raise notice 'Province: %', provCust;
			raise notice 'Balance: %', balanceCust;
			raise notice 'Credit Limit: %', limCust;
			raise notice '';
		end loop;
		close c1;
	END;
$$ LANGUAGE plpgsql;
