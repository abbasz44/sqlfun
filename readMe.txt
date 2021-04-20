Zachery Abbas
1019463
due: 2020-11-12

First: When running the a3data.sql if the tables are not created it will give an error just because I have drop statments
in the code. so just run it twice so it can drop the first tables saved to the DB then it work with no errors.

Example if there are not tables saved in the DB:
./i a3data.sql
 will say that there are no tables to drop
 ./i a3data.sql
 will work with no errors

Second: For p8 I was having trouble generateing a new tno so my functions first paramter will take in a new TNO an example to run it is below have to make sure the tno hasn't been used before 

example:

select p8('T10','V3','A1',2000); 


