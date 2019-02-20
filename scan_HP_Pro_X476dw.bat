@echo off

REM 
REM Data: 07/01/2019 (atualizado 11/02/2019)
REM
REM Autor: Willyam Castro
REM
REM Corrige erros básicos de comunicação com o scaner da impressora HP OficeJet Pro X476dw
REM



set file=%0
set tmpFile = %tmp%\file.txt
REM set nTask = 0

call:verificaHPCommunicator

pause



REM ########## ############ ############

:verificaHPCommunicator
REM echo "Verificando HPC" > log

	REM retorna quantidade de processos HPNetworkCommunicatorCom.
	tasklist | find /i "HPNetworkCommunicatorCom." | findstr /r /n "^" | find /C ":" > %tmp%\file.txt
	
echo. >> log_execucao
echo. >> log_execucao
echo. >> log_execucao
echo %computername%:%username% - %date%:%time% >> log_execucao
	
	REM Atribui o conteudo do arquivo na variável nTask
	for /f %%i in (%tmp%\file.txt) do set /a nTask = %%i
	echo

REM echo I = %%i >> log
REM echo nTask: %nTask% >> log

REM tasklist | find /i "HPNetworkCommunicatorCom." | findstr /r /n "^" | find /C ":"

	REM Se houver de um processo, todos são encerrados e um único processo é iniciado novamente
	if %nTask% GTR 1 (
	
echo       Mais de um processo HPNetworkCommunicatorCom em execução; >> log_execucao

		taskkill /f /im "HPNetworkCommunicatorCom.exe"
		
		REM Se finalizar um dos processos retorna 0
		if not %errorlevel% == 0 (
			REM echo ERRO = %errorlevel%
			echo "Erro ao finalizar HPNetworkCommunicatorCom.exe, contate o suporte"
			
			echo Erro ao finalizar HPNetworkCommunicatorCom.exe, contate o suporte; >> log_execucao

			start http://meusite.com.br
		)
		
		pause
		call:iniciaHPCommunicator	
	) else (
		call:verificaAppScan
	)

REM	if %errorlevel% == 0 (
REM		call:verificaAppScan
REM	) else (
REM		call:iniciaHPCommunicator
REM	)


:iniciaHPCommunicator
	echo
echo "INICIANDO HPCOMMUNICATOR"
	echo.
	echo.
	
	start cmd /k %file%
	
	echo       Iniciando HP Communicator, feche a janela
	
echo          HPCOMMUNICATOR foi iniciado; >> log_execucao
	
	("C:\Program Files\HP\HP Officejet Pro X476dw MFP\Bin\HPNetworkCommunicatorComa" -Embedding)

	if %errorlevel% == 0 || %errorlevel% == 1 (
		call:verificaAppScan
	) else (
		call:iniciaHPCommunicator
	)


:verificaAppScan
	echo
echo "VERIFICANDO SCAN"
	tasklist | find /i "ScanToPcActivationApp.exe"

	if %errorlevel% == 0 (
		
echo          ScanToPCActivationApp em execução, reiniciando; >> log_execucao
	
		taskkill /im "ScanToPcActivationApp.exe" /f && call:ativaAppScan
	) else (
		call::ativaAppScan
	)


:ativaAppScan
	echo
echo "Executando AppScan"
	REM timeout 2 /nobreak
	timeout 2

	echo.
	echo.
	echo.
	echo     Iniciando App Scan, feche esta janela...
	
echo          Iniciando AppScan; >> log_execucao
	
	"C:\Program Files\HP\HP Officejet Pro X476dw MFP\Bin\ScanToPCActivationApp.exe" -deviceID "CN455HJ07W:NW" -scfn "HP Officejet Pro X476dw MFP (NET)" -AutoStart 1 -installmode
PAUSE 