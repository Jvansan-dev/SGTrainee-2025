//João Victor Teixiera Vansan
//Prova08
set message to 24 center
set wrap on
set date to british
set epoch to 1940
set scoreboard off
setmode(25,80)
clear

lSair := .f.
//menu
do while !lSair
      nOpcaoMenu := 0
      cPalavraSecreta := Space(15)
      clear
      @ 07,00 prompt '                                    Jogar                                      'message 'Iniciar jogo                 '
      @ 08,00 prompt '                                  Configurar                                   'message 'Digite a palavra secreta     '
      @ 09,00 prompt '                                    Sair                                       'message 'Sair do sistema              '
      menu to nOpcaoMenu
      
    if nOpcaoMenu == 3
        exit
    endif
      
     if nOpcaoMenu == 2
        clear
         @02,30 say 'Termo:'

         @02,36 get cPalavraSecreta color ('w/w')
         read

         if LastKey() == 27
      nOpcao := alert('Deseja sair do programa?', {'Sim', 'Nao'})
      if nOpcao == 1
         exit
      else
         loop
      endif
   endif
        loop
     endif

      cDigitaPalavra := Space(15)
      if nOpcaoMenu == 1
        if cPalavraSecreta != cPalavraSecreta
        clear
        Alert('Termo ainda nao definido. Utilize a opcao "Configurar"! ')
      else
        clear
        @02,25 say 'Termo:'

        @02,32 get cDigitaPalavra
        read
        loop
      endif
      endif
enddo
