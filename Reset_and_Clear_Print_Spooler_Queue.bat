:: Created by: Shawn Brink
:: http://www.sevenforums.com
:: Tutorial:  http://www.sevenforums.com/tutorials/89483-print-spooler-queue-clear-reset.html


net stop spooler
del /F /Q %systemroot%\System32\spool\PRINTERS\*
net start spooler


