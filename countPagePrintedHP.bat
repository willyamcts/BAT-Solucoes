@echo off

REM 
REM Data: 12/11/2019 (atualizado ***)
REM
REM Autor: 
REM
REM Obtém contagem de páginas impressas e modelo do dispositivo, exportando para um TXT
REM 
REM Requer instalação de Net-SNMP - http://www.net-snmp.org/
REM

REM arquivo atual: %%"<"%~f0%%

REM http://batchscript.blogspot.com/2012/12/aprenda-o-for-de-uma-vez-por-todas.html





set tmpFile = %tmp%\snmpwalk_return.txt


call:getFileAddress

call:outputFile
	
goto:eof



REM ============= // ======== Functions ========= // ==================

REM Lê arquivo que contém HOSTNAME + IP da impressora
:getFileAddress

	for /f "Tokens=1,2 delims=-" %%a in (ip_impressoras.txt) do (
		echo %%b %TAB% %%a

		call:getDataSNMP %%a
	)	

	goto:eof



REM Obtém dados via SNMP
:getDataSNMP

	REM Modelo do equipamento
	snmpwalk -Cc -v 1 -c public %1 1.3.6.1.2.1.25.3.2.1.3.1 >> walk.txt
	
	REM Qtd de páginas impressas
	snmpwalk -Cc -v 1 -c public %1 1.3.6.1.2.1.43.10.2.1.4 >> walk.txt

	goto:eof


REM Cria arquivo de saída com dados úteis
:outputFile

	echo SAIDAS FINAIS: 

	for /f "Tokens=3 delims=:"  %%b in (walk.txt) do (
	
		echo TOKEN:%%b
	)
	
	del walk.txt
	
	goto:eof

REM // Fazer a leitura do arquivo criado em getDataSNMP e filtrar o conteúdo útil > Exportar para outro arquivo de forma organizada;
REM Usar o delimitador " : " 
