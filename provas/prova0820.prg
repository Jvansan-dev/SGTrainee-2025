//João Victor Teixeira Vansan
//Prova 08
Clear
set message to 24
set wrap on
set date to british
set epoch to 1940
set scoreboard off
setmode(25,80)

cPalavraSecreta := Space(15)
lJogoAtivo      := .f.
nTentativaAtual := 1

do while .t.
    Clear
    @ 05,30 say '=== JOGO TERMO ==='
    
//menu
    nOpcao := 0
      @ 07,00 prompt '                                    Jogar                                      'message 'Iniciar jogo                 '
      @ 08,00 prompt '                                  Configurar                                   'message 'Digite o termo, para jogar   '
      @ 09,00 prompt '                                    Sair                                       'message 'Sair do sistema              '
      menu to nOpcao
    
    if nOpcao == 1
        if !lJogoAtivo .or. Empty(cPalavraSecreta)
            Alert('Termo ainda nao definido. Utilize a opcao Configurar!')
            loop
        endif
        
        nTamanho   := Len(cPalavraSecreta)
        lVenceu    := .f.
        nTentativa := 1
        nLinha     := 7
        cCorVerde  := ('g/n')
        cCorAzul   := ('b/n')
        cCorBranco := ('w/n')

        do while nTentativa <= 5 .and. !lVenceu
            Clear
            @ 22,01 say 'VERDE.: Letra correta na posicao correta'
            @ 23,01 say 'AZUL..: Letra correta na posicao errada ' 
            @ 24,01 say 'BRANCO: Letra nao existe na palavra     '
            
            cTermo := Space(nTamanho)
            @ 05,20 say 'Termo:'
            @ 05,26 get cTermo picture '@!' valid Len(AllTrim(cTermo)) == nTamanho
            read

            if LastKey() == 27
                nOpcaoESC := Alert('Deseja abandonar o jogo?', {'Continuar', 'Abandonar'})
                if nOpcaoESC == 2
                    exit
                else
                    loop
                endif
            endif

            cTermo := AllTrim(cTermo)
            if cTermo == cPalavraSecreta
                lVenceu := .t.
                @nLinha,20 say cTermo
                nLinha++
                Alert('Parabens, voce venceu!')
                exit
            endif
            nTentativa++
        enddo
        
        if !lVenceu .and. nTentativa > 5
            Alert('Voce perdeu! A palavra era: ' + cPalavraSecreta)
        endif
        
        nTentativaAtual := 1
        inkey(0)
        
    elseif nOpcao == 2
        Clear
        @ 05,25 say 'Termo:'
        @ 05,31 get cPalavraSecreta picture '@!' Valid !Empty(cPalavraSecreta) color ('w/w')
        read
        
        cPalavraSecreta := AllTrim(cPalavraSecreta)
        lJogoAtivo := .t.
        
        @ 10,01 say 'Termo configurada com sucesso, agora voce pode jogar!'
        @ 11,01 say 'Pressione qualquer tecla para continuar...'
        inkey(0)
        
    elseif nOpcao == 3
        exit
    endif
enddo