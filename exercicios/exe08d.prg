set epoch to 1940 //utilizar ano acima de 2000
set date british //data modo britanico
set scoreboard off //corrige borda
clear //limpa tela
setmode (25,80)//ajusta tela

cNomeMercado := "MERCADO BARATAO SG"
nCupom       := 0
nProdutoA    := 0
nProdutoB    := 0
nProdutoC    := 0
nQuantidadeA := 0
nQuantidadeB := 0
nQuantidadeC := 0
nLimite      := 0
nTaxa        := 6.99
cNomeA       := Space (10)
cNomeB       := Space (10)
cNomeC       := Space (10)
cNomeCliente := Space (20)
cEndereco    := Space (20)
cCor         := ""
dAtual       := Date()
dCompra      := CToD("")
dEntrega     := CToD("")

@00,01 say "Exercicio 08 - Calculo do valor total da compra"
@02,15 say "DADOS CADASTRAIS"
@04,02 say "Nome........:"
@05,02 say "Data........:"
@06,02 say "Endereco....:"
@07,02 say "Data entrega:"
@08,02 say "Limite......:"
@23,02 say "Tecle <ESC> para sair..."
@03,00 to 09,40
//to do cadastro

@04,16 get cNomeCliente picture "@!"        Valid !Empty(cNomeCliente)
@05,16 get dCompra  
@06,16 get cEndereco    picture "@!"        Valid !Empty(cEndereco)
@07,16 get dEntrega                         Valid dAtual <= dEntrega +3
@08,16 get nLimite      picture "@E 999.99" Valid nLimite >= 0
read//PRIMEIRO READ
@01,00 clear to 09,40//limpar campo

@05,01 to 07,48 double
@07,01 to 12,48 double
@06,13 to 11,13
@06,01 to 11,01
@06,23 to 11,23
@06,38 to 11,38
@06,48 to 11,48
//to da venda

@06,02 say "  PRODUTO     PRECO     QUANTIDADE    TOTAL"
@08,39 say (nProdutoA*nQuantidadeA)  color cCor                                                     picture "@E 9,999.99"
@13,27 say "SUBTOTAL:"
@13,39 say (nProdutoA*nQuantidadeA)+(nProdutoB*nQuantidadeB)+(nProdutoC*nQuantidadeC) color cCor    picture "@E 9,999.99"
@16,02 say "LIMITE:"
@16,10 say nLimite                                                                                  picture "@E 999.99"

@08,02 get cNomeA       picture "@!"          Valid !Empty(cNomeA)
@08,14 get nProdutoA    picture "@E 9999.99"  
@08,27 get nQuantidadeA picture "999.99"      Valid nQuantidadeA >= 0 
read//SEGUNDO READ

nSubTotal := (nProdutoA*nQuantidadeA)

if nSubTotal >= nLimite
    cCor := "w/r"
    @17,01 say "!!!O VALOR DA COMPRA PASSOU DO LIMITE!!!" color "w/r"
elseif nSubTotal < nLimite
    cCor := "w/g"
endif 

nTotal := (nProdutoA*nQuantidadeA)+(nProdutoB*nQuantidadeB)+(nProdutoC*nQuantidadeC)

if nTotal >= nLimite
    cCor := "w/r"
    @17,01 say "!!!O VALOR DA COMPRA PASSOU DO LIMITE!!!" color "w/r"
elseif nTotal < nLimite
    cCor := "w/g"
endif 

@08,39 say (nProdutoA*nQuantidadeA) color cCor                                                    picture "@E 9,999.99"
@13,39 say (nProdutoA*nQuantidadeA)+(nProdutoB*nQuantidadeB)+(nProdutoC*nQuantidadeC) color cCor  picture "@E 9,999.99"

@09,02 get cNomeB       picture "@!"     Valid !Empty(cNomeB)
@09,14 get nProdutoB    picture "@E 9999.99"
@09,27 get nQuantidadeB picture "999.99" Valid nQuantidadeB >= 0
read//TERCEIRO READ

nSubTotal := (nProdutoB*nQuantidadeB)

if nSubTotal >= nLimite
    cCor := "w/r"
    @17,01 say "!!!O VALOR DA COMPRA PASSOU DO LIMITE!!!" color "w/r"
elseif nSubTotal < nLimite
    cCor := "w/g"
endif 

nTotal := (nProdutoA*nQuantidadeA)+(nProdutoB*nQuantidadeB)+(nProdutoC*nQuantidadeC)

if nTotal >= nLimite
    cCor := "w/r"
    @17,01 say "!!!O VALOR DA COMPRA PASSOU DO LIMITE!!!" color "w/r"
elseif nTotal < nLimite
    cCor := "w/g"
endif 

@09,39 say (nProdutoB*nQuantidadeB) color cCor                                                   picture "@E 9,999.99"
@13,39 say (nProdutoA*nQuantidadeA)+(nProdutoB*nQuantidadeB)+(nProdutoC*nQuantidadeC) color cCor picture "@E 9,999.99"

@10,02 get cNomeC       picture "@!"     Valid !Empty(cNomeC)
@10,14 get nProdutoC    picture "@E 9999.99" 
@10,27 get nQuantidadeC picture "999.99" Valid nQuantidadeC >= 0
read//QUARTO READ

nSubTotal := (nProdutoC*nQuantidadeC)

if nSubTotal >= nLimite
    cCor := "w/r"
    @17,01 say "!!!O VALOR DA COMPRA PASSOU DO LIMITE!!!" color "w/r"
elseif nSubTotal < nLimite
    cCor := "w/g"
endif 

nTotal := (nProdutoA*nQuantidadeA)+(nProdutoB*nQuantidadeB)+(nProdutoC*nQuantidadeC)

if nTotal >= nLimite
    cCor := "w/r"
    @17,01 say "!!!O VALOR DA COMPRA PASSOU DO LIMITE!!!" color "w/r"
elseif nTotal < nLimite
    cCor := "w/g"
endif  

@10,39 say (nProdutoC*nQuantidadeC) color cCor                                                   picture "@E 9,999.99"
@13,39 say (nProdutoA*nQuantidadeA)+(nProdutoB*nQuantidadeB)+(nProdutoC*nQuantidadeC) color cCor picture "@E 9,999.99" 
@14,20 say "TOTAL DA COMPRA:"
@14,39 say (nProdutoA*nQuantidadeA)+(nProdutoB*nQuantidadeB)+(nProdutoC*nQuantidadeC) color cCor picture "@E 9,999.99" 
@23,02 say "  Tecle <ENTER> para emitir o cupom fiscal..."

nTotal := (nProdutoA*nQuantidadeA)+(nProdutoB*nQuantidadeB)+(nProdutoC*nQuantidadeC)

if nTotal >= nLimite
    cCor := "w/r"
    @17,01 say "!!!O VALOR DA COMPRA PASSOU DO LIMITE!!!" color "w/r"
elseif nTotal < nLimite
    cCor := "w/g"
endif 
Inkey(0) // Aguarda até o usuário pressionar uma tecla

@02,01 clear to 24,50

@04,18 say "CUPOM FISCAL"
@05,02 say "Descricao"
@05,15 say "Quantidade"
@05,35 say "Valor"
@07,02 say cNomeA
@08,02 say cNomeB
@09,02 say cNomeC
@07,16 say nQuantidadeA               picture "@E 999.99"
@08,16 say nQuantidadeB               picture "@E 999.99"
@09,16 say nQuantidadeC               picture "@E 999.99"
@07,31 say (nProdutoA * nQuantidadeA) picture "@E 9,999.99"
@08,31 say (nProdutoB * nQuantidadeB) picture "@E 9,999.99"
@09,31 say (nProdutoC * nQuantidadeC) picture "@E 9,999.99" 
@11,02 say "Total da compra:" 
@11,31 say (nProdutoA * nQuantidadeA) + (nProdutoB * nQuantidadeB) + (nProdutoC * nQuantidadeC) + nTaxa picture "@E 9,999.99"
@13,02 say "---------AGRADECEMOS A PREFERENCIA---------"
@15,14 say cNomeMercado
@16,02 say "ENDERECO:"
@16,12 say cEndereco
@17,02 say "CUPOM:"
@17,09 say nCupom picture "9999"
@18,02 say "CLIENTE:"
@18,11 say cNomeCliente 
@19,02 say "DATA DA VENDA: "     + Dtoc(dCompra)
@20,02 say "DATA DA ENTREGA: "   + Dtoc(dEntrega)
@21,02 say "TAXA DE ENTREGA:"
@21,19 say nTaxa                      picture "@E 99.99"
@22,02 say "---------------VOLTE SEMPRE----------------"
@03,01 to 23,45 double
Inkey(0) // Aguarda até o usuário pressionar uma tecla




