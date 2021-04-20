--create a function that takes in a vend_name and returns account num, name, and prov
CREATE OR REPLACE FUNCTION p2(vend_name CHAR) RETURNS VOID AS $$
	DECLARE
		c1 CURSOR FOR
			SELECT 	c.Account, Cname, Province
			FROM 	v,c,t
			--restriction
			WHERE 	v.Vname = vend_name AND
				t.Account = c.Account AND
				v.Vno = t.Vno;

		--declare variables
		accCust CHAR(25);
		provCust CHAR(3);
		nameCust CHAR(25);

	BEGIN
		open c1;
			raise notice 'Vendor inforamtion for: %', vend_name;
			raise notice '_____________________________________';
			raise notice '';
		loop
		--print out inforamtion
			fetch c1 into accCust, nameCust, provCust;
			exit when not found;
			raise notice 'Customer Number: %', accCust;
			raise notice 'Name: %', nameCust;
			raise notice 'Province: %', provCust;
			raise notice '';
		end loop;
		close c1;
	END;
$$ LANGUAGE plpgsql;
