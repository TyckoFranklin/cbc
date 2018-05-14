@echo off
REM Setting date variables: Retrieve the current date using 4 digits for year and 2 digits for month and day.
REM Setting time formats: Retrieve the current time using 2 digits.
set year=%DATE:~10,4%
set day=%DATE:~7,2%
set mnt=%DATE:~4,2%
set hr=%TIME:~0,2%
set min=%TIME:~3,2%

REM If current dates or times are fewer than 10 digits. include a leading zero in the display (June = 06)
REM LSS = Less Than
IF %day% LSS 10 SET day=0%day:~1,1%
IF %mnt% LSS 10 SET mnt=0%mnt:~1,1%
IF %hr% LSS 10 SET hr=0%hr:~1,1%
IF %min% LSS 10 SET min=0%min:~1,1%

REM Combine the variables to create a string value (backuptime).
REM Backuptime will display as Year-Month-Day-Hour:Min (2018-01-18-09.59)
set backuptime=%year%-%mnt%-%day%-%hr%.%min%

REM echo backuptime on screen to validate in debug mode
echo %backuptime%


REM PATHS AND SETTINGS
REM Database username and password ("" = no password)
set dbuser=root
set dbpass=""

REM MySql executable path for OpenEMR
set mysqldumpexe="C:\xampp\mysql\bin\mysqldump.exe"

REM Path to backup folder
set backupfldr="C:\Users\Administrator\Desktop\OpenEMR\"

REM Path to OpenEMR data folder
set datafldr="C:\xampp\mysql\data"

REM Database name
set dbname="openemr"
