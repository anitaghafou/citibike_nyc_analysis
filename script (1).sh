unzip 201601-citibike-tripdata.zip
unzip 201602-citibike-tripdata.zip
unzip 201603-citibike-tripdata.zip
unzip 201604-citibike-tripdata.zip
unzip 201605-citibike-tripdata.zip
unzip 201606-citibike-tripdata.zip
unzip 201607-citibike-tripdata.zip
unzip 201608-citibike-tripdata.zip
unzip 201609-citibike-tripdata.zip
unzip 201610-citibike-tripdata.zip
unzip 201611-citibike-tripdata.zip
unzip 201612-citibike-tripdata.zip
unzip 201701-citibike-tripdata.csv.zip
unzip 201702-citibike-tripdata.csv.zip
unzip 201703-citibike-tripdata.csv.zip
unzip 201704-citibike-tripdata.csv.zip
unzip 201705-citibike-tripdata.csv.zip
unzip 201706-citibike-tripdata.csv.zip
unzip 201707-citibike-tripdata.csv.zip
unzip 201708-citibike-tripdata.csv.zip
unzip 201709-citibike-tripdata.csv.zip
unzip 201710-citibike-tripdata.csv.zip
unzip 201711-citibike-tripdata.csv.zip
unzip 201712-citibike-tripdata.csv.zip
rm *.zip

sed -i '' 's|Industry City\,|Industry City|g' 201704-citibike-tripdata.csv 
sed -i '' 's|Industry City\,|Industry City|g' 201705-citibike-tripdata.csv 
sed -i '' 's|Industry City\,|Industry City|g' 201706-citibike-tripdata.csv 
sed -i '' 's|Industry City\,|Industry City|g' 201707-citibike-tripdata.csv 

sed -i '' 's|\"||g' 201704-citibike-tripdata.csv 
sed -i '' 's|\"||g' 201705-citibike-tripdata.csv 
sed -i '' 's|\"||g' 201706-citibike-tripdata.csv 
sed -i '' 's|\"||g' 201707-citibike-tripdata.csv 
sed -i '' 's|\"||g' 201708-citibike-tripdata.csv 
sed -i '' 's|\"||g' 201709-citibike-tripdata.csv 
sed -i '' 's|\"||g' 201710-citibike-tripdata.csv 
sed -i '' 's|\"||g' 201711-citibike-tripdata.csv 
sed -i '' 's|\"||g' 201712-citibike-tripdata.csv 
