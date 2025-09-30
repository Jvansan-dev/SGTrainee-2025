set message to 20 center
clear

nOpcao := 1

nLinha := 2
@nLinha++,20 say "SISTEMA DE CONTROLE DE ESTOQUE"
@nLinha++,02 say Replicate('=',79)
@nLinha++,02 prompt "CADASTRAR         " message "Cadastrar produto"
@nLinha++,02 prompt "CONSULTAR         " message "Consultar produto"
@nLinha++,02 prompt "DELETAR           " message "Deletar produto"
@nLinha++,02 prompt "ENTRADA DE PRODUTO" message "Dar entrada em um produto, para aumentar o estoque"
@nLinha++,02 prompt "SAIDA DE PRODUTO  " message "Dar saida em um produto, para diminuir o estoque"
@nLinha++,02 prompt "LISTAR PRODUTOS   " message "Listar produtos ja cadastrados"
@nLinha++,02 say Replicate('=',79)

menu to nOpcao
