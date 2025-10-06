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

@01,01 say "Exercicio 08 - Calculo do valor total da compra"
@20,01 say "Tecle <ESC> para sair..."
@03,01 say "|  PRODUTO  |  PRECO  |  QUANTIDADE  |  TOTAL  |"
@04,01 say Replicate ("-",49)
@08,01 say Replicate ("-",49)
@05,01 say " Coca-cola " 
@06,01 say " Farinha "
@07,01 say " Arroz "
@05,37 say nProdutoA*nQuantidadeA picture "@E 9,999.99"
@09,27 say "SUBTOTAL:"
@09,37 say (nProdutoA*nQuantidadeA)+(nProdutoB*nQuantidadeB)+(nProdutoC*nQuantidadeC) picture "@E 9,999.99"

@05,14 get nProdutoA picture "@E 9999.99"
@05,27 get nQuantidadeA picture "999.99" valid nQuantidadeA >= 0
read

@01,01 say "Exercicio 08 - Calculo do valor total da compra"
@20,01 say "Tecle <ESC> para sair..."
@03,01 say "|  PRODUTO  |  PRECO  |  QUANTIDADE  |  TOTAL  |"
@04,01 say Replicate ("-",49)
@08,01 say Replicate ("-",49)
@05,01 say " Coca-cola " 
@06,01 say " Farinha "
@07,01 say " Arroz "
@05,37 say nProdutoA*nQuantidadeA picture "@E 9,999.99"
@06,37 say nProdutoB*nQuantidadeB picture "@E 9,999.99"
@09,27 say "SUBTOTAL"
@09,37 say (nProdutoA*nQuantidadeA)+(nProdutoB*nQuantidadeB)+(nProdutoC*nQuantidadeC) picture "@E 9,999.99"

@06,14 get nProdutoB picture "@E 9999.99"
@06,27 get nQuantidadeB picture "999.99" valid nQuantidadeB >= 0
read

@01,01 say "Exercicio 08 - Calculo do valor total da compra"
@20,01 say "Tecle <ESC> para sair..."
@03,01 say "|  PRODUTO  |  PRECO  |  QUANTIDADE  |  TOTAL  |"
@04,01 say Replicate ("-",49)
@08,01 say Replicate ("-",49)
@05,01 say " Coca-cola " 
@06,01 say " Farinha "
@07,01 say " Arroz "
@05,37 say nProdutoA*nQuantidadeA picture "@E 9,999.99"
@06,37 say nProdutoB*nQuantidadeB picture "@E 9,999.99"
@07,37 say nProdutoC*nQuantidadeC picture "@E 9,999.99"
@09,27 say "SUBTOTAL"
@09,37 say (nProdutoA*nQuantidadeA)+(nProdutoB*nQuantidadeB)+(nProdutoC*nQuantidadeC) picture "@E 9,999.99"

@07,14 get nProdutoC picture "@E 9999.99"
@07,27 get nQuantidadeC picture "999.99" valid nQuantidadeC >= 0
read

@05,37 say nProdutoA*nQuantidadeA picture "@E 9,999.99"
@06,37 say nProdutoB*nQuantidadeB picture "@E 9,999.99"
@07,37 say nProdutoC*nQuantidadeC picture "@E 9,999.99"
@08,01 say Replicate ("-",49)
@09,27 say "SUBTOTAL"
@09,37 say (nProdutoA*nQuantidadeA)+(nProdutoB*nQuantidadeB)+(nProdutoC*nQuantidadeC) picture "@E 9,999.99"
@10,20 say "TOTAL DA COMPRA:"
@10,37 say (nProdutoA*nQuantidadeA)+(nProdutoB*nQuantidadeB)+(nProdutoC*nQuantidadeC) picture "@E 9,999.99"
@15,01 say "  Compra Finalizada...  "






