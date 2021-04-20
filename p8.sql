--adds new transaction
-- the paramaters are a vendor number, an account number, and an amount from the user.
--make sure to check validity of vend and account num
--display new transaction and updated customer and vend records

CREATE OR REPLACE FUNCTION p8(t_tno CHAR, t_vno CHAR, t_acc CHAR, t_amount INTEGER) RETURNS VOID AS $$
	DECLARE
	--create three cursers
		c1 CURSOR for SELECT * FROM t where Tno = t_tno;
		c2 CURSOR for SELECT * FROM c where Account = t_acc;
		c3 CURSOR for SELECT * FROM v where Vno = t_vno;


		--declare variables
		numTrans		CHAR(5);
		numAmmount		INTEGER;
		dateTrans		DATE;
		nameVend		CHAR(25);
		cityVend		CHAR(25);
		balanceVend	 	DECIMAL(6,2);
		numVend		CHAR(5);
		provCust		CHAR(3);
		balanceCust		DECIMAL(6,2);
		limitCust	INTEGER;
		accountCust	CHAR(5);
		accountName		CHAR(25);


	BEGIN
		raise notice 'Adding new transaction.';
		raise notice '_______________________';
		raise notice '';

		open c2;
		fetch c2 into accountCust, accountName, provCust, balanceCust, limitCust;
		if (balanceCust < t_amount) then
			raise notice 'DECLINED Has: %, needs: %.', balanceCust, t_amount;
		else

			INSERT INTO t VALUES
			(t_tno, t_vno, t_acc, current_date, t_amount);

			--update v
		--add balances
			UPDATE v
			SET Vbalance = Vbalance + t_amount
			WHERE Vno = t_vno;

			--update c
      --must do balance - amount
			UPDATE 	c
			SET 	Cbalance = Cbalance - t_amount
			WHERE	Account = t_acc;


			open c1;
			open c3;

                	fetch c1 into numTrans, numVend, accountCust, dateTrans, numAmmount;
                	fetch c3 into numVend, nameVend, cityVend, balanceVend;
			--print information

			raise notice 'Transaction:';
			raise notice 'Transaction No.: %', numTrans;
			raise notice 'Vendor No.: %', numVend;
			raise notice 'Account: %', accountCust;
			raise notice 'Date: %', dateTrans;
			raise notice 'Amount: %', numAmmount;
			raise notice '';


			raise notice 'Updated Customer:';
			raise notice 'Account: %', accountCust;
			raise notice 'Name: %', accountName;
			raise notice 'Province: %', provCust;
			raise notice 'Balance: %', balanceCust;
			raise notice 'CrLimit: %', limitCust;
			raise notice '';

			raise notice 'Updated Vendor:';
			raise notice 'Vendor No.: %', numVend;
			raise notice 'Vendor: %', nameVend;
			raise notice 'City: %', cityVend;
			raise notice 'Balance: %', balanceVend;
			close c1;
			close c3;
		end if;
		close c2;
	END;
$$ LANGUAGE plpgsql;
