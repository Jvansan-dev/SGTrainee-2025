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
        
        // Variáveis para armazenar tentativas
        cTentativa1 := Space(nTamanho)
        cTentativa2 := Space(nTamanho)
        cTentativa3 := Space(nTamanho)
        cTentativa4 := Space(nTamanho)
        cTentativa5 := Space(nTamanho)
        cCores1 := Space(nTamanho)
        cCores2 := Space(nTamanho)
        cCores3 := Space(nTamanho)
        cCores4 := Space(nTamanho)
        cCores5 := Space(nTamanho)

        do while nTentativa <= 5 .and. !lVenceu
            Clear
            
            // Mostra tentativas anteriores
            if nTentativa > 1
                // Tentativa 1
                if !Empty(cTentativa1)
                    @ 7, 20 say cTentativa1
                    i := 1
                    do while i <= nTamanho
                        cCor := SubStr(cCores1, i, 1)
                        if cCor == 'V'
                            @ 7, 19 + i say SubStr(cTentativa1, i, 1) color 'G/N'
                        elseif cCor == 'A'
                            @ 7, 19 + i say SubStr(cTentativa1, i, 1) color 'B/N'
                        else
                            @ 7, 19 + i say SubStr(cTentativa1, i, 1) color 'W/N'
                        endif
                        i++
                    enddo
                endif
                
                if nTentativa > 2
                    // Tentativa 2
                    if !Empty(cTentativa2)
                        @ 8, 20 say cTentativa2
                        i := 1
                        do while i <= nTamanho
                            cCor := SubStr(cCores2, i, 1)
                            if cCor == 'V'
                                @ 8, 19 + i say SubStr(cTentativa2, i, 1) color 'G/N'
                            elseif cCor == 'A'
                                @ 8, 19 + i say SubStr(cTentativa2, i, 1) color 'B/N'
                            else
                                @ 8, 19 + i say SubStr(cTentativa2, i, 1) color 'W/N'
                            endif
                            i++
                        enddo
                    endif
                endif
                
                if nTentativa > 3
                    // Tentativa 3
                    if !Empty(cTentativa3)
                        @ 9, 20 say cTentativa3
                        i := 1
                        do while i <= nTamanho
                            cCor := SubStr(cCores3, i, 1)
                            if cCor == 'V'
                                @ 9, 19 + i say SubStr(cTentativa3, i, 1) color 'G/N'
                            elseif cCor == 'A'
                                @ 9, 19 + i say SubStr(cTentativa3, i, 1) color 'B/N'
                            else
                                @ 9, 19 + i say SubStr(cTentativa3, i, 1) color 'W/N'
                            endif
                            i++
                        enddo
                    endif
                endif
                
                if nTentativa > 4
                    // Tentativa 4
                    if !Empty(cTentativa4)
                        @ 10, 20 say cTentativa4
                        i := 1
                        do while i <= nTamanho
                            cCor := SubStr(cCores4, i, 1)
                            if cCor == 'V'
                                @ 10, 19 + i say SubStr(cTentativa4, i, 1) color 'G/N'
                            elseif cCor == 'A'
                                @ 10, 19 + i say SubStr(cTentativa4, i, 1) color 'B/N'
                            else
                                @ 10, 19 + i say SubStr(cTentativa4, i, 1) color 'W/N'
                            endif
                            i++
                        enddo
                    endif
                endif
            endif
            
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
            
            // Processa cores para esta tentativa
            cCoresTentativa := Space(nTamanho)
            cPalavraTemp := cPalavraSecreta
            cPalavraUsada := Space(nTamanho)  // Para marcar letras já usadas
            
            // Primeira passada: verifica letras na posição correta (VERDE)
            i := 1
            do while i <= nTamanho
                if SubStr(cTermo, i, 1) == SubStr(cPalavraSecreta, i, 1)
                    // Constrói nova string para cCoresTentativa
                    if i == 1
                        cCoresTentativa := 'V' + SubStr(cCoresTentativa, 2)
                    elseif i == nTamanho
                        cCoresTentativa := SubStr(cCoresTentativa, 1, nTamanho - 1) + 'V'
                    else
                        cCoresTentativa := SubStr(cCoresTentativa, 1, i - 1) + 'V' + SubStr(cCoresTentativa, i + 1)
                    endif
                    
                    // Marca letra como usada em cPalavraUsada
                    if i == 1
                        cPalavraUsada := 'X' + SubStr(cPalavraUsada, 2)
                    elseif i == nTamanho
                        cPalavraUsada := SubStr(cPalavraUsada, 1, nTamanho - 1) + 'X'
                    else
                        cPalavraUsada := SubStr(cPalavraUsada, 1, i - 1) + 'X' + SubStr(cPalavraUsada, i + 1)
                    endif
                endif
                i++
            enddo
            
            // Segunda passada: verifica letras na posição errada (AZUL) e inexistentes (BRANCO)
            i := 1
            do while i <= nTamanho
                if SubStr(cCoresTentativa, i, 1) == ' '  // Não é verde
                    cLetra := SubStr(cTermo, i, 1)
                    lEncontrou := .f.
                    j := 1
                    
                    // Procura a letra na palavra secreta que não foi usada
                    do while j <= nTamanho .and. !lEncontrou
                        if SubStr(cPalavraSecreta, j, 1) == cLetra .and. SubStr(cPalavraUsada, j, 1) != 'X'
                            lEncontrou := .t.
                            // Marca como Azul
                            if i == 1
                                cCoresTentativa := 'A' + SubStr(cCoresTentativa, 2)
                            elseif i == nTamanho
                                cCoresTentativa := SubStr(cCoresTentativa, 1, nTamanho - 1) + 'A'
                            else
                                cCoresTentativa := SubStr(cCoresTentativa, 1, i - 1) + 'A' + SubStr(cCoresTentativa, i + 1)
                            endif
                            
                            // Marca letra como usada
                            if j == 1
                                cPalavraUsada := 'X' + SubStr(cPalavraUsada, 2)
                            elseif j == nTamanho
                                cPalavraUsada := SubStr(cPalavraUsada, 1, nTamanho - 1) + 'X'
                            else
                                cPalavraUsada := SubStr(cPalavraUsada, 1, j - 1) + 'X' + SubStr(cPalavraUsada, j + 1)
                            endif
                        endif
                        j++
                    enddo
                    
                    // Se não encontrou, marca como Branco
                    if !lEncontrou
                        if i == 1
                            cCoresTentativa := 'B' + SubStr(cCoresTentativa, 2)
                        elseif i == nTamanho
                            cCoresTentativa := SubStr(cCoresTentativa, 1, nTamanho - 1) + 'B'
                        else
                            cCoresTentativa := SubStr(cCoresTentativa, 1, i - 1) + 'B' + SubStr(cCoresTentativa, i + 1)
                        endif
                    endif
                endif
                i++
            enddo
            
            // Armazena tentativa atual
            if nTentativa == 1
                cTentativa1 := cTermo
                cCores1 := cCoresTentativa
            elseif nTentativa == 2
                cTentativa2 := cTermo
                cCores2 := cCoresTentativa
            elseif nTentativa == 3
                cTentativa3 := cTermo
                cCores3 := cCoresTentativa
            elseif nTentativa == 4
                cTentativa4 := cTermo
                cCores4 := cCoresTentativa
            elseif nTentativa == 5
                cTentativa5 := cTermo
                cCores5 := cCoresTentativa
            endif
            
            if cTermo == cPalavraSecreta
                lVenceu := .t.
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