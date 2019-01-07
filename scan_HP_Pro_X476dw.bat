REM 
REM Data: 07/01/2019
REM
REM Autor: Willyam Castro
REM
REM Corrige erros básicos de comunicação com o scaner da impressora HP OficeJet Pro X476dw
REM


@echo off

set file=%0
set tmpFile = %tmp%\file.txt
REM set nTask = 0

call:verificaHPCommunicator

pause



REM ########## ############ ############

:verificaHPCommunicator
echo "Verificando HPC" > log

	REM retorna quantidade de processos HPNetworkCommunicatorCom.
	tasklist | find /i "HPNetworkCommunicatorCom." | findstr /r /n "^" | find /C ":" > %tmp%\file.txt
	
echo "verificado qtd de processos" >> log
	
	REM Atribui o conteudo do arquivo na variável nTask
	for /f %%i in (%tmp%\file.txt) do set /a nTask = %%i
	echo

echo I = %%i >> log
echo nTask: %nTask% >> log

REM tasklist | find /i "HPNetworkCommunicatorCom." | findstr /r /n "^" | find /C ":"

	REM Se houver de um processo, todos são encerrados e um único processo é iniciado novamente
	if %nTask% GTR 1 (
		taskkill /f /im "HPNetworkCommunicatorCom.exe"
		
		REM Se finalizar um dos processos retorna 0
		if not %errorlevel% == 0 (
			REM echo ERRO = %errorlevel%
			echo "Erro ao finalizar HPNetworkCommunicatorCom.exe, contate os suporte"
			start http://meu.suporte.com.br
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
	
	"C:\Program Files\HP\HP Officejet Pro X476dw MFP\Bin\ScanToPCActivationApp.exe" -deviceID "CN455HJ07W:NW" -scfn "HP Officejet Pro X476dw MFP (NET)" -AutoStart 1 -installmode
PAUSE 