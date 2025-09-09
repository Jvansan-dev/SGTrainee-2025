set scoreboard off
clear

nProdutoA := 0
nProdutoB := 0
nProdutoC := 0
nQuantidadeA := 0
nQuantidadeB := 0
nQuantidadeC := 0
cNomeA := Space (10)
cNomeB := Space (10)
cNomeC := Space (10)
cNomeCliente := Space (20)
dData := DATE()

@01,01 say "Exercicio 08 - Calculo do valor total da compra"
@23,02 say "Tecle <ESC> para sair..."
@03,01 say "Nome do cliente:"
@05,01 to 07,48 double
@07,01 to 12,48 double
@06,13 to 11,13
@06,01 to 11,01
@06,23 to 11,23
@06,38 to 11,38
@06,48 to 11,48
@06,02 say "  PRODUTO     PRECO     QUANTIDADE    TOTAL"
@08,39 say nProdutoA*nQuantidadeA picture "@E 9,999.99"
@13,27 say "SUBTOTAL:"
@13,39 say (nProdutoA*nQuantidadeA)+(nProdutoB*nQuantidadeB)+(nProdutoC*nQuantidadeC) picture "@E 9,999.99"

@03,18 get cNomeCliente picture "@!"     Valid !Empty(cNomeCliente)
@08,02 get cNomeA       picture "@!"     Valid !Empty(cNomeA)
@08,14 get nProdutoA    picture "@E 9999.99"  
@08,27 get nQuantidadeA picture "999.99" Valid nQuantidadeA >= 0
read

@08,39 say (nProdutoA*nQuantidadeA) picture "@E 9,999.99"
@13,39 say (nProdutoA*nQuantidadeA)+(nProdutoB*nQuantidadeB)+(nProdutoC*nQuantidadeC) picture "@E 9,999.99"

@09,02 get cNomeB       picture "@!"     Valid !Empty(cNomeB)
@09,14 get nProdutoB    picture "@E 9999.99"
@09,27 get nQuantidadeB picture "999.99" Valid nQuantidadeB >= 0
read

@09,39 say (nProdutoB*nQuantidadeB) picture "@E 9,999.99"
@13,39 say (nProdutoA*nQuantidadeA)+(nProdutoB*nQuantidadeB)+(nProdutoC*nQuantidadeC) picture "@E 9,999.99"

@10,02 get cNomeC       picture "@!"     Valid !Empty(cNomeC)
@10,14 get nProdutoC    picture "@E 9999.99" 
@10,27 get nQuantidadeC picture "999.99" Valid nQuantidadeC >= 0
read

@10,39 say (nProdutoC*nQuantidadeC) picture "@E 9,999.99"
@13,39 say (nProdutoA*nQuantidadeA)+(nProdutoB*nQuantidadeB)+(nProdutoC*nQuantidadeC) picture "@E 9,999.99" 
@14,20 say "TOTAL DA COMPRA:"
@14,39 say (nProdutoA*nQuantidadeA)+(nProdutoB*nQuantidadeB)+(nProdutoC*nQuantidadeC) picture "@E 9,999.99" 
@23,02 say "  Tecle <ENTER> para emitir o cupom fiscal..."
nTecla := Inkey(0) // Aguarda até o usuário pressionar uma tecla

@02,01 clear to 24,50

@04,18 say "CUPOM FISCAL"
@05,02 say "Descricao"
@05,15 say "Quantidade"
@05,35 say "Valor"
@07,02 say cNomeA
@08,02 say cNomeB
@09,02 say cNomeC
@07,16 say nQuantidadeA picture "@E 999.99"
@08,16 say nQuantidadeB picture "@E 999.99"
@09,16 say nQuantidadeC picture "@E 999.99"
@07,31 say (nProdutoA * nQuantidadeA) picture "@E 9,999.99"
@08,31 say (nProdutoB * nQuantidadeB) picture "@E 9,999.99"
@09,31 say (nProdutoC * nQuantidadeC) picture "@E 9,999.99" 
@11,02 say "Total da compra:" 
@11,31 say (nProdutoA * nQuantidadeA) + (nProdutoB * nQuantidadeB) + (nProdutoC * nQuantidadeC) picture "@E 9,999.99"
@13,02 say "---------AGRADECEMOS A PREFERENCIA---------"
@15,02 say "MERCADO BEM BARATO"
@16,02 say "ENDERECO XXXX"
@17,02 say "CUPOM XXXXX"
@18,02 say "CLIENTE:"
@18,11 say cNomeCliente 
@03,01 to 21,45 double
@20,02 say "---------------VOLTE SEMPRE----------------"
@23,02 say "  DATA: " + Dtoc(dData)




