//Joao Victor Teixeira Vansan
setmode (25,80)//ajusta tela
set epoch to 1940 //utilizar ano acima de 2000
set date british //data modo britanico
set scoreboard off //corrige borda
clear //limpa tela

do while .t.
    clear
    dDataHoje := date()
    nDiaAtual := Day(dDataHoje)
    nMesAtual := Month(dDataHoje)
    nAnoAtual := Year(dDataHoje)
    cId := Space(8)
    cDescricao := Space(30)
    nQuantidadeEstoque := 0
    nInteracoes := 1
    nRepeticao := 0
    nMenu := 0
    nEntrada := 0
    nSaida := 0
    dDataEntrada := CTOD('')
    dDataSaida   := CTOD('')
    cIdConsulta := Space(8)
    lCad := .f.

    //Menu
    nLinha := 2
    @nLinha++,20 say "MENU PRINCIPAL"
    @nLinha++,02 say "1 - CADASTRAR PRODUTOS"
    @nLinha++,02 say "2 - CONSULTAR PRODUTOS"
    @nLinha++,02 say "3 - DELETAR PRODUTOS"
    @nLinha++,02 say "4 - ENTRADA DE PRODUTOS"
    @nLinha++,02 say "5 - SAIDA DE PRODUTOS"
    @nLinha++,02 say "6 - SAIR DO PROGRAMA"
    @nLinha,02 say "Escolha uma opcao:"

    @nLinha,20 get nMenu picture "9" valid nMenu >=0 .and. nMenu <=6
    read
    
    if LastKey() == 27
      nOpcao := alert('Deseja sair do programa?' , { 'Sair' , 'Menu' }) 
      if nOpcao = 1
         exit
      else
         loop
      endif
    endif

    if nMenu == 1
    clear
    //Cadastro
    @02,00 to 06,79
    nLinha := 2
    @nLinha++,30 say "CADASTRO DE PRODUTO"
    @nLinha,02   say "ID..........:"
    @nLinha++,25   say "DATA CADASTRO...:"
    @nLinha++,02 say "DESCRICAO...:"
    @nLinha,02   say "QUANTIDADE..:"
    
    nLinha :=3
    @nLinha,15   get cId                picture "@!"   valid !Empty(cId)
    @nLinha++,43 get dDataHoje
    @nLinha++,15 get cDescricao         picture "@!"   valid !Empty(cDescricao)
    @nLinha++,15 get nQuantidadeEstoque picture "9999" valid  nQuantidadeEstoque >= 0
    read
    if LastKey() == 27
      nOpcao := alert('Deseja sair do programa?' , { 'Sair' , 'Menu' }) 
      if nOpcao = 1
         exit
      else
         loop
      endif
    endif
    lCad := .t.
    @ 18,01 say 'Produto cadastrado com sucesso!'
    Inkey(0)

    endif

    //Consulta
    if nMenu == 2
    clear
    nLinha := 2
    @nLinha++,20 say "CONSULTA PRODUTO"
    @nLinha,05 say "Digite o ID:"

    @nLinha,18 get cId
    read
    endif

    if LastKey() == 27
      nOpcao := alert('Deseja sair do programa?' , { 'Sair' , 'Menu' }) 
      if nOpcao = 1
         exit
      else
         loop
      endif
    endif

   if cIdConsulta == cId .and. lCad
       Clear
       @ 12,01 say 'Produto encontrado:'
       @ 13,01 say 'ID: ' + AllTrim(cId)
       @ 14,01 say 'Descricao: ' + AllTrim(cDescricao)
       @ 15,01 say 'Quantidade: ' + AllTrim(Str(nQuantidadeEstoque))
       @ 16,01 say 'Data: ' + DTOC(dDataHoje)
       Inkey(0)
       exit
    endif

    if nMenu == 3
    clear
    nLinha := 2
    @nLinha++,20 say "DELETAR PRODUTO"
    @nLinha,05 say "Digite o ID:"

    @nLinha,18 get cId
    read
    endif

    if LastKey() == 27
      nOpcao := alert('Deseja sair do programa?' , { 'Sair' , 'Menu' }) 
      if nOpcao = 1
         exit
      else
         loop
      endif
    endif


    if nMenu == 4
    clear
    nLinha := 2
    @nLinha++,20 say "ENTRADA DE PRODUTO"
    @nLinha,05 say "Digite o ID:"

    @nLinha,18 get cId
    read
    endif

    if LastKey() == 27
      nOpcao := alert('Deseja sair do programa?' , { 'Sair' , 'Menu' }) 
      if nOpcao = 1
         exit
      else
         loop
      endif
    endif


    if nMenu == 5
    clear
    nLinha := 2
    @nLinha++,20 say "SAIDA DE PRODUTO"
    @nLinha,05 say "Digite o ID:"

    @nLinha,18 get cId
    read
    endif

    if LastKey() == 27
      nOpcao := alert('Deseja sair do programa?' , { 'Sair' , 'Menu' }) 
      if nOpcao = 1
         exit
      endif
        loop
    endif


    if nMenu == 6
        exit
    endif


enddo