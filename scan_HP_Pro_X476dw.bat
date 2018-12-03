REM 
REM Descricao: Devido a falhas que ocorrem de comunicação com o scaner da impressora 
REM HP Officejet Pro X476dw MFP, foi criado esse pequeno bat para verificar a 
REM execucao dos softwares responsáveis pela execução do scan. Comandos gerados 
REM utilizando o ProcessExplorer.


@echo off

set file=%0
	
call:verificaHPCommunicator

pause



REM ########## ############ ############

:verificaHPCommunicator
	tasklist | find /i "HPNetworkCommunicatorCom"

	if %errorlevel% == 0 (
		call:verificaAppScan
	) else (
		call:iniciaHPCommunicator
	)


:iniciaHPCommunicator
	echo.
	echo.
	
	start cmd /k %file%
	
	echo       Iniciando HP Communicator, feche a janela
	
	"C:\Program Files\HP\HP Officejet Pro X476dw MFP\Bin\HPNetworkCommunicatorCom" -Embedding

	if %errorlevel% == 0 (
		call:verificaAppScan
	) else (
		call:iniciaHPCommunicator
	)


:verificaAppScan
	tasklist | find /i "ScanToPcActivationApp.exe"

	if %errorlevel% == 0 (
		taskkill /im "ScanToPcActivationApp.exe" /f && call:ativaAppScan
	) else (
		call::ativaAppScan
	)


:ativaAppScan
	REM timeout 2 /nobreak
	timeout 2

	echo.
	echo.
	echo.
	echo     Iniciando App Scan, feche esta janela...
	
	"C:\Program Files\HP\HP Officejet Pro X476dw MFP\Bin\ScanToPCActivationApp.exe" -deviceID "CN455HJ07W:NW" -scfn "HP Officejet Pro X476dw MFP (NET)" -AutoStart 1 -installmode
