CREATE EXTERNAL TABLE meas(m string, mid string, msq string, msd string, meq string, med string) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE LOCATION '/user/w205/hospital_compare/md';

CREATE EXTERNAL TABLE pe(pid string,p string,x1 string,x2 string,State string,x3 string,x4 string,x5 string,x6 string,x7 string,x8 string,x9 string,x10 string,x11 string,x12 string,x13 string,x14 string,x15 string,x16 string,x17 string,x18 string,x19 string,x20 string,x21 string,x22 string,x23 string,x24 string,x25 string,x26 string,x27 string,x28 string,basescore int, constscore int) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE LOCATION '/user/w205/hospital_compare/pe';

CREATE EXTERNAL TABLE rdh(pid string,x1 string,x2 string,x3 string,x4 string,x5 string,x6 string,x7 string,x8 string,mid string,x10 string,denom string,score string,x11 string,x12 string,x13 string,x14 string,x15 string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE LOCATION '/user/w205/hospital_compare/rdh';

CREATE EXTERNAL TABLE teh (pid string,x1 string,x2 string,x3 string,x4 string,x5 string,x6 string,x7 string,x8 string,mid string,x9 string,score float,sample float,x10 string,x11 string,x12 string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE LOCATION '/user/w205/hospital_compare/teh';


