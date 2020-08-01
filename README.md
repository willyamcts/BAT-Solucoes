# Pequenas soluções em arquivos de lote

Pequenos batchs para solução de problemas do dia a dia.


- [Reset_and_Clear_Print_Spooler_Queue.bat](https://github.com/willyamcts/bat-solucoes/blob/master/Reset_and_Clear_Print_Spooler_Queue.bat): Para o serviço de spooler, deleta a fila de impressão e inicia o serviço novamente. Necessário previlégios Administrativos.

- [add_printers.bat](https://github.com/willyamcts/bat-solucoes/blob/master/add_printers.bat): Adiciona impressora local ou de rede (necessário driver instalado), basta @alterar o nome do computador (campo COMPUTERNAME) e o nome dado a impressora no computador que está comparilhando-a.

- [bat-solucoes/backup_files.bat](https://github.com/willyamcts/bat-solucoes/tree/master/backup_files.bat): Faz backup de arquivos mantendo apenas arquivos dos últimos 30 dias no diretório de destino.

- [check_file_exist.bat](https://github.com/willyamcts/bat-solucoes/blob/master/check_file_exist.bat): Verifica se um determinado arquivo existe. @ALTERAR variável "FILE"

- [scan_HP_Pro_X476dw.bat](https://github.com/willyamcts/bat-solucoes/blob/master/scan_HP_Pro_X476dw.bat): Corrige falhas de comuicação entre a máquina e a impressora HP. Encerra todos os  processo de comunicação ou inicializa o mesmo se não estiver em execução. @Alterar linhas que contenham "HPNetworkCommunicatorCom" se a sua impressora não for a HP OficeJet Pro X476dw e o caminho absoluto para esse arquivo (que pode variar x64 e x32). Outra linha a ser editada é a 59 que abre o navegador em uma página da internet para o usuário abrir um chamado, indicando que o script não foi eficaz no caso em questão.

- [bat-solucoes/net-snmp](https://github.com/willyamcts/bat-solucoes/tree/master/net-snmp): O script "countPagePrinted.bat" obtém a quantidade de páginas impressas de impressoras, com base em um arquivo TXT que deve conter alguns dados descrito no próprio script. A informação coletada via script pode não ser identica ao mostrado via relatório impresso, display do dispositivo ou página web. O diretório contém arquivos necessário para execução do script.

- [bat-solucoes/XAMPP batches - OCS Inventory](https://github.com/willyamcts/bat-solucoes/tree/master/XAMPP%20batches%20-%20OCS%20Inventory): Diversos scripts do XAMPP, sem alterações.
