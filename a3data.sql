DROP TABLE v;
DROP TABLE c;
DROP TABLE t;

CREATE TABLE t
(
	Tno CHAR(25) NOT NULL PRIMARY KEY,
	Vno CHAR(25) NOT NULL,
	Account CHAR(25) NOT NULL,
	T_Date DATE,
	Amount INTEGER
);

CREATE TABLE v
(
	Vno CHAR(5) NOT NULL PRIMARY KEY,
	Vname CHAR(25) NOT NULL,
	City CHAR(25),
	Vbalance DECIMAL(6,2)
);

CREATE TABLE c
(
	Account CHAR(5) NOT NULL PRIMARY KEY,
	Cname CHAR(25) NOT NULL,
	Province CHAR(3),
	Cbalance DECIMAL(6,2),
	Crlimit INTEGER
);

INSERT INTO t VALUES
('T1', 'V2', 'A1', '2020-07-15', 1325.00),
('T2', 'V2', 'A3', '2019-12-16', 1900.00),
('T3', 'V3', 'A1', '2020-09-01', 2500.00),
('T4', 'V4', 'A2', '2020-03-20', 1614.00),
('T5', 'V4', 'A3', '2020-07-31', 3312.00);

INSERT INTO v VALUES
('V1', 'Sears', 'Toronto', 200.00),
('V2', 'Walmart', 'Waterloo', 671.05),
('V3', 'Esso', 'Windsor', 0.00),
('V4', 'Esso', 'Waterloo', 225.00);

INSERT INTO c VALUES
('A1', 'Smith', 'ONT', 2515.00, 2000),
('A2', 'Jones', 'BC', 2014.00, 2500),
('A3', 'Doc', 'ONT', 150.00, 1000);
