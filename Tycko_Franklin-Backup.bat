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
set backupfldr="C:\Users\Administrator\Desktop\OpenEMR"

REM Path to OpenEMR data folder 
set datafldr="C:\xampp\mysql\data"

REM Database name 
set dbname="openemr"


REM Path to the 7-Zip executable file 
set zip="C:\Program Files (x86)\7-Zip\7zG.exe"

REM Set number of days to keep backup files 
set retaindays=5

REM Switch to data folder
pushd %datafldr%

REM Identify the database files and delete all SQL files that are not the openemr database
FOR /D %%F IN (*) DO (
 IF NOT [%%F]==["performance_schema mysql phpmyadmin test"] (
 SET %%F=!%%F:002d=-!
 %mysqldumpexe% --lock-tables=false --user=%dbuser% --password=%dbpass% --databases --routines %%F > "%backupfldr%%%F.sql"
 ) ELSE (
echo Skipping database backup for the other database folders
)
)
del %backupfldr%performance_schema.sql"
del %backupfldr%mysql.sql"
del %backupfldr%phpmyadmin.sql" 
del %backupfldr%test.sql"


REM Zip the OpenEMR files 
echo Zipping OpenEMR database files 
%zip% a -tzip "C:\Users\Administrator\Desktop\OpenEMR\OpenEMRFullBackup.zip" "C:\Users\Administrator\Desktop\OpenEMR\*.sql"

REM Clean up rogue .sql files 
del "%backupfldr%*.sql"

REM Remove files older than 5 days and display an error if no files are older than 5 days 
echo "Deleting zip archives older than 5 days" 
FORFILES -p %backupfldr% -s -m . -d -%retaindays% -X -c "cmd /c del /q @path"

