set epoch to 1940 //utilizar ano acima de 2000
set date british //data modo britanico
set scoreboard off //corrige borda
clear //limpa tela
setmode (25,80)//ajusta tela

do while .t.
    cCor := "r/w"
    cNome := Space (20)
    nIdade := 0
    cProduto := Space(10)
    nQuantidadeProduto := 0
    nPrecoProduto := 0

    @02,02 say "Nome........:"
    @03,02 say "Idade.......:"

    @02,15 get cNome    picture "@!"      Valid !Empty(cNome)  
    @03,15 get nIdade   picture "99"      Valid nIdade >= 0 
    read

     if LastKey() == 27
      nOpcao := alert('Deseja sair do programa?' , { 'Sair' , 'Continuar' }, cCor) 
      if nOpcao = 1
         exit
      else
         loop
      endif
   endif

   nLinha := 8
    do while .t.
    @05,01 to 07,48 
    @07,01 to 24,48 
    @06,13 to 24,13
    @06,01 to 24,01
    @06,23 to 24,23
    @06,38 to 24,38
    @06,48 to 24,48
    @06,02 say "  PRODUTO     PRECO     QUANTIDADE    TOTAL"
    @24,50 say "SUBTOTAL:" + AllTrim(Str(nSubTotal))

    cNomeProduto := Space (10)
    nPrecoProduto := 0
    nQuantidadeProduto := 0

    @nLinha,02 get cNomeProduto         picture "@!"          Valid !Empty(cNomeProduto)
    @nLinha,14 get nPrecoProduto        picture "@E 9999.99"
    @nLinha,27 get nQuantidadeProduto   picture "999.99"      Valid nQuantidadeProduto >= 0 
    read
    @nLinha++,39 say nPrecoProduto*nQuantidadeProduto   picture "@E 9,999.99"

    if LastKey() == 27
      nOpcao := alert('Deseja sair do programa?' , { 'Abandonar' , 'Continuar', 'Finalizar' }, cCor) 
      if nOpcao = 1
         exit
      endif
      if nOpcao = 2
        loop
      else
        loop
      endif  
   endif
    enddo
enddo