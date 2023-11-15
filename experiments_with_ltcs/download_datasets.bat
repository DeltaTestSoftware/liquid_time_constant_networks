@echo off
setlocal
pushd %~dp0

if not exist data mkdir data

echo har
call :download_zip https://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%%%%20HAR%%%%20Dataset.zip har

echo gesture
call :download_zip https://archive.ics.uci.edu/ml/machine-learning-databases/00302/gesture_phase_dataset.zip gesture

echo occupancy
call :download_zip https://archive.ics.uci.edu/ml/machine-learning-databases/00357/occupancy_data.zip occupancy

echo traffic
if not exist data\traffic mkdir data\traffic
call :download https://archive.ics.uci.edu/ml/machine-learning-databases/00492/Metro_Interstate_Traffic_Volume.csv.gz traffic.gz
7z x traffic.gz -odata\traffic\
del traffic.gz

echo ozone
if not exist data\ozone mkdir data\ozone
call :download https://archive.ics.uci.edu/ml/machine-learning-databases/ozone/eighthr.data data\ozone\eighthr.data

echo power
call :download_zip https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip power

echo person
if not exist data\person mkdir data\person
call :download https://archive.ics.uci.edu/ml/machine-learning-databases/00196/ConfLongDemo_JSI.txt data\person\ConfLongDemo_JSI.txt

popd

exit /b 0

:download
powershell -command "(New-Object System.Net.WebClient).DownloadFile(""""%~1"""", """"%~2"""")"
exit /b 0

:download_zip
powershell -command "(New-Object System.Net.WebClient).DownloadFile(""""%~1"""", """"temp.zip"""")"
powershell -command "Expand-Archive temp.zip data/%~2"
del temp.zip
exit /b 0
