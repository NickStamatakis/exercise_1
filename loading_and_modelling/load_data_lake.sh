wget http://s3.amazonaws.com/exercise1stamatakis/ReadmissionsandDeaths-Hospital.csv
wget http://s3.amazonaws.com/exercise1stamatakis/MeasureDates.csv
wget http://s3.amazonaws.com/exercise1stamatakis/TimelyandEffectiveCare-Hospital.csv
wget http://s3.amazonaws.com/exercise1stamatakis/hvbp_hcahps_05_28_2015.csv

tail -n +2 MeasureDates.csv > md.csv
tail -n +2 ReadmissionsandDeaths-Hospital.csv > rdh.csv
tail -n +2 TimelyandEffectiveCare-Hospital.csv > teh.csv
tail -n +2 hvbp_hcahps_05_28_2015.csv > pe.csv

sed -i 's/\,//g' md.csv
sed -i 's/""/,/g' md.csv
sed -i 's/\"//g' md.csv

sed -i 's/\,//g' rdh.csv
sed -i 's/""/,/g' rdh.csv
sed -i 's/\"//g' rdh.csv

sed -i 's/\,//g' teh.csv
sed -i 's/""/,/g' teh.csv
sed -i 's/\"//g' teh.csv

sed -i 's/\,//g' pe.csv
sed -i 's/""/,/g' pe.csv
sed -i 's/\"//g' pe.csv

hdfs dfs -mkdir /user/w205/hospital_compare/md
hdfs dfs -mkdir /user/w205/hospital_compare/rdh
hdfs dfs -mkdir /user/w205/hospital_compare/teh
hdfs dfs -mkdir /user/w205/hospital_compare/pe

hdfs dfs -put md.csv /user/w205/hospital_compare/md
hdfs dfs -put rdh.csv /user/w205/hospital_compare/rdh
hdfs dfs -put teh.csv /user/w205/hospital_compare/teh
hdfs dfs -put pe.csv /user/w205/hospital_compare/pe


