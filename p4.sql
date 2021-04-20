--program diplays the account number, customer name and account, vendor name
--when no account it should say "no transaction"
--displays most recent tranasaction transaction

CREATE OR REPLACE FUNCTION p4() RETURNS VOID AS $$
	DECLARE
		c1 CURSOR FOR
		--make sure order by acount
			select distinct Account
			from c
			order by Account;

--declare variables

		nameCust 		CHAR(25);
		nameVend		CHAR(25);
		amountTran 	INTEGER;
		accCust 		CHAR(5);


	BEGIN
		open c1;
			raise notice 'The Most Recent Transactions.';
			raise notice '_____________________________';
			raise notice '';
		loop
			fetch c1 into accCust;
			exit when not found;


			perform  * from t where t.Account = accCust;
			-- once I have gotten all transaction for current account Id put in the if else statment.

			--if it isnt there, should print the account number and no transaction
			if not found then
				raise notice 'The Account Number: %', accCust;
				raise notice 'no transaction';
				raise notice '';
			--if it is there
			else
				select  Cname, Amount, Vname
				into	nameCust, amountTran, nameVend
                  from    c,v,t
                  where   t.Vno = v.Vno AND
													t.Account = accCust AND
													--make sure to get min date
                          t.T_Date =
                                	(
                                        	SELECT min(T_Date)
                                        	FROM t b
                                        	WHERE t.Account = b.Account
                               	 	);

				--print info
				raise notice 'Account Number: %', accCust;
				raise notice 'Name: %', nameCust;
				raise notice 'Amount: %', amountTran;
				raise notice 'Vendor: %', nameVend;
				raise notice '';
			end if;
		end loop;
		close c1;
	END;
$$ LANGUAGE plpgsql;
