@echo off

REM 
REM Data: 01/08/2020 (atualizado -)
REM
REM Autor: Willyam Castro
REM
REM Faz cópia de arquivos de um diretório para outro, mantendo apenas os arquivos dos
REM 	últimos 30 dias no diretório de destino. A finalidade é realizar backup de 
REM 	arquivos em sistemas que geram arquivos ou databases em períodos específicos.
REM 
REM REQUERIMENTOS: Nenhum
REM
REM
REM
REM 	GET data e hora formatada:
REM 		echo Current date/time: %DATE% %TIME%
REM			for %%I in ("%~f0") do echo Batch file time:   %%~tI
REM
REM		GET hora formatada:
REM			set HOUR=%time:~0,8%
REM			echo Current date is %DATE% and time is %HOUR%
REM
REM



REM
REM Alterar origem e destino
set SOURCE="C:\Users\Usuario\Documents\Backup\A\*"
set DESTINATION="C:\Users\Usuario\Documents\Backup\B"
set LIMIT_FILES=30

REM GET data por parte
for /F "Tokens=1 delims=/" %%a in ('date /t') do set DAY=%%a
for /F "Tokens=2 delims=/" %%a in ('date /t') do set MONTH=%%a
for /F "Tokens=3 delims=/" %%a in ('date /t') do set YEAR=%%a


REM call:echoVariables

call:copyFiles

call:verifyOldFiles

REM pause


goto:eof





:copyFiles

	REM Copia arquivos alterados na data definida (ou posterior) 
	REM		no parâmetro /D 
	xcopy %SOURCE% %DESTINATION% /D:%MONTH%-%DAY%-%YEAR% /Y

goto:eof



:verifyOldFiles

	REM Lista arquivos com última modificação anterior ou igual a 30 dias
	forfiles /P %DESTINATION% /D -%LIMIT_FILES% > %tmp%\oldfiles.tmp
	
	cd %DESTINATION%
	
	REM Varre arquivo que contém nome dos arquivos antigos/a apagar
	for /F "Tokens=*" %%f in (%tmp%\oldfiles.tmp) do (		
		del %%f
	)
	
goto:eof



:echoVariables

	echo source: %SOURCE% dest: %DESTINATION%
	echo day: %DAY% month: %MONTH% year: %YEAR%

goto:eof
