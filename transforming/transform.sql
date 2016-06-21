
CREATE TABLE rhd_final row format delimited fields terminated by ',' STORED AS RCFile AS
SELECT pid, mid, cast(substr(score,2,length(score)-2) as float) as score, cast(substr(denom,2,length(denom)-2) as float) as sample FROM rdh WHERE
(denom LIKE "%1%" OR denom LIKE "%2%" OR denom LIKE "%3%" OR denom LIKE "%4%" OR denom LIKE "%5%" OR denom LIKE "%6%" OR denom LIKE "%7%" OR denom LIKE "%8%" OR denom LIKE "%9%") AND 
(score LIKE "%1%" OR score LIKE "%2%" OR score LIKE "%3%" OR score LIKE "%4%" OR score LIKE "%5%" OR score LIKE "%6%" OR score LIKE "%7%" OR score LIKE "%8%" OR score LIKE "%9%") AND
(denom NOT LIKE "%30-Day%");

CREATE TABLE teh_final row format delimited fields terminated by ',' STORED AS RCFile AS
SELECT pid, mid, score, sample FROM teh WHERE score is NOT NULL;

CREATE TABLE rhd_stat row format delimited fields terminated by ',' STORED AS RCFile AS
SELECT mid, avg(score) as avgscore, min(score) as minscore, max(score) as maxscore, 
avg(score) + stddev_pop(score)*2 as hirange, 
avg(score) - stddev_pop(score)*2 as lowrange, 
count(score) FROM rhd_final GROUP BY mid;

CREATE TABLE teh_stat row format delimited fields terminated by ',' STORED AS RCFile AS
SELECT mid, avg(score) as avgscore, min(score) as minscore, max(score) as maxscore, 
avg(score) + stddev_pop(score)*2 as hirange, 
avg(score) - stddev_pop(score)*2 as lowrange, 
count(score) FROM teh_final GROUP BY mid;

CREATE TABLE mid_qual (mid string, qual int)
row format delimited fields terminated by ',' 
STORED AS RCFile;

INSERT INTO TABLE mid_qual VALUES
("MORT_30_AMI",-1),
("MORT_30_CABG",-1),
("MORT_30_COPD",-1),
("MORT_30_HF",-1),
("MORT_30_PN",-1),
("MORT_30_STK",-1),
("READM_30_AMI",-1),
("READM_30_CABG",-1),
("READM_30_COPD",-1),
("READM_30_HF",-1),
("READM_30_HIP_KNEE",-1),
("READM_30_HOSP_WIDE",-1),
("READM_30_PN",-1),
("READM_30_STK",-1),
("AMI_10",1),
("AMI_2",1),
("AMI_7a",1),
("AMI_8a",1),
("CAC_1",1),
("CAC_2",1),
("CAC_3",1),
("ED_1b",-1),
("ED_2b",-1),
("HF_1",1),
("HF_2",1),
("HF_3",1),
("IMM_2",1),
("IMM_3_FAC_ADHPCT",1),
("OP_1",-1),
("OP_18b",-1),
("OP_2",-1),
("OP_20",-1),
("OP_21",-1),
("OP_22",-1),
("OP_23",-1),
("OP_3b",-1),
("OP_4",-1),
("OP_5",-1),
("OP_6",1),
("OP_7",1),
("PC_01",1),
("PN_6",1),
("SCIP_CARD_2",1),
("SCIP_INF_1",1),
("SCIP_INF_10",1),
("SCIP_INF_2",1),
("SCIP_INF_3",1),
("SCIP_INF_9",1),
("SCIP_VTE_2",1),
("STK_1",1),
("STK_10",1),
("STK_2",1),
("STK_3",1),
("STK_4",1),
("STK_5",1),
("STK_6",1),
("STK_8",1),
("VTE_1",1),
("VTE_2",1),
("VTE_3",1),
("VTE_4",1),
("VTE_5",1),
("VTE_6",1); 

CREATE TABLE final row format delimited fields terminated by ',' STORED AS RCFile AS
SELECT * FROM rhd_final UNION ALL SELECT * FROM teh_final; 

CREATE TABLE stat row format delimited fields terminated by ',' STORED AS RCFile AS
SELECT * FROM rhd_stat UNION ALL SELECT * FROM teh_stat; 

CREATE TABLE master_final row format delimited fields terminated by ',' STORED AS RCFile AS
SELECT a.pid, a.mid, a.score, b.qual, c.State, c.basescore, c.constscore, d.avgscore, d.minscore, d.maxscore,  
CASE WHEN a.score > d.hirange THEN 1 WHEN a.score < d.lowrange THEN 1 ELSE 0 END as variable, 
CASE WHEN b.qual = 1 AND NTILE(10) OVER (PARTITION BY a.mid ORDER BY a.score DESC) = 10 THEN 1 WHEN b.qual = -1 AND NTILE(10) OVER (PARTITION BY a.mid ORDER BY a.score DESC) = 1 THEN 1 ELSE 0 END as quality,
CASE WHEN b.qual = 1 THEN NTILE(10) OVER (PARTITION BY a.mid ORDER BY a.score DESC) WHEN b.qual = -1 THEN NTILE(10) OVER (PARTITION BY a.mid ORDER BY a.score DESC) END as decile
FROM final a 
INNER JOIN mid_qual b ON a.mid = b.mid
INNER JOIN pe c ON a.pid = c.pid
INNER JOIN stat d ON a.mid = d.mid;

