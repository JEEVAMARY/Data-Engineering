#! /bin/bash



HOST=$HOSTNAME
SHORT_DATE=`date '+%Y-%m-%d'`
TIME=`date '+%H%M'`
SCRIPT_TYPE=`basename $0 | cut -d '.' -f1` ##(get the first line of the file )
filenametime1=$(date +"%m%d%Y%H%M%S")
filenametime2=$(date +"%Y-%m-%d %H:%M:%S")

export BASE_FOLDER='/home/dataeng/Data-Engineering-1/lab1'
export SCRIPTS_FOLDER='/home/dataeng/Data-Engineering-1/lab1/scripts'
export INPUT_FOLDER='/home/dataeng/Data-Engineering-1/lab1/input'
export OUTPUT_FOLDER='/home/dataeng/Data-Engineering-1/lab1/output'
export LOGDIR='/home/dataeng/Data-Engineering-1/lab1/logs'
export SHELL_SCRIPT_NAME='climate'
export LOG_FILE=${LOGDIR}/${SHELL_SCRIPT_NAME}_${filenametime1}.log


cd ${SCRIPTS_FOLDER}

exec > >(tee ${LOG_FILE}) 2>&1

echo "Start download data"

for year in {2020..2022}; # or use (seq 2019 2022)
do wget -N --content-disposition "https://climate.weather.gc.ca/climate_data/bulk_data_e.html?format=csv&stationID=48549&Year=${year}&Month=2&Day=14&timeframe=1&submit= Download+Data" -O ${INPUT_FOLDER}/${year}.csv;
done;


RC1=$?
if [ ${RC1} != 0 ]; then
	echo "DOWNLOAD DATA FAILED"
	echo "[ERROR:] RETURN CODE:  ${RC1}"
	echo "[ERROR:] REFER TO THE LOG FOR THE REASON FOR THE FAILURE."
	exit 1
fi

RC1=$?
if [ ${RC1} != 0 ]; then
	echo "PYTHON RUNNING FAILED"
	echo "[ERROR:] RETURN CODE:  ${RC1}"
	echo "[ERROR:] REFER TO THE LOG FOR THE REASON FOR THE FAILURE."
	exit 1
fi

echo "PROGRAM SUCCEEDED"

exit 0
