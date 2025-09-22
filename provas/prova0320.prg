//João Victor Teixeira Vansan
clear
setmode(25,80)
set date to british
set epoch to 1940
set scoreboard off
set color to n/w

dDataHoje    := date()
nDiaAtual    := Day(dDataHoje)
nMesAtual    := Month(dDataHoje)
nAnoAtual    := Year(dDataHoje)

do while .t.
   nRemuneracaoTotal       := 0
   nRemuneracaoHomem       := 0
   nRemuneracaoMulher      := 0
   nFuncionariosTotal      := 0
   nHomemAposentado        := 0
   nHomemAdmitidoAntes2006 := 0
   nHomensAdicional        := 0
   nHomemTotal             := 0
   nMulherAposentado       := 0
   nMulherMais85           := 0
   nMulherReducao          := 0
   nMulherTotal            := 0
   nContador               := 1
   lProcessar              := .t.
//quantidade funcionario
   nLinha := 1
   Clear
   @ 00,00 to 24,79 
   @ nLinha++,35 say 'I  N  S  S'
   @ nLinha,15 say 'Numero de funcionarios para analise:'
   @24,13 say "Tecle ESC para [C]Cancelar [R]Retornar ou [P]Processar?"

   @ nLinha,52 get nFuncionariosTotal  valid nFuncionariosTotal > 0  picture '9999'
   read

   cTeclaEsc := ""
   if LastKey() == 27
    if cTeclaEsc == "C"
         exit
    elseif cTeclaEsc == "R"
         loop
      endif
   endif

   do while nContador <= nFuncionariosTotal
      cFuncionarioNome                   := Space(25)
      cFuncionarioSexo                   := Space(1)
      dFuncionarioNascimento             := CToD('')
      dFuncionarioAdmissao               := CToD('')
      dFuncionarioDemissao               := CToD('')
      nFuncionarioSalarioBase            := 0
      nFuncionarioAdicionalNoturno       := 0
      nFuncionarioAdicionalInsalubridade := 0
      lFuncionarioAPosentado             := .f.
      nLinha                             := 3
//prencher informações
      @ nLinha,01 clear to 23,78
      @ nLinha,01 to nLinha++,78
      @ nLinha,60 say 'Contador:' + AllTrim(Str(nContador))
      @ nLinha++,01 say 'Nome......:'
      @ nLinha++,01 say 'Sexo......: [ ] [M]asculino [F]eminino'
      @ nLinha++,01 say 'Nascimento:'
      @ nLinha++,01 say 'Admissao..:'
      @ nLinha++,01 say 'Demissao..:'
      @ nLinha--,01 say 'Salario...:'
      @ nLinha++,50   say 'Adicional Insalubridade:  %'
      @ nLinha,50 say 'Adicional Noturno:  %'

      nLinha -= 5
      @ nLinha++,12   get cFuncionarioNome                   valid !Empty(cFuncionarioNome)                 picture '@!'
      @ nLinha++,14   get cFuncionarioSexo                   valid cFuncionarioSexo $ 'MF'                  picture '@!'
      @ nLinha++,12   get dFuncionarioNascimento             valid dFuncionarioNascimento < dDataHoje .and. !Empty(dFuncionarioNascimento)
      @ nLinha++,12   get dFuncionarioAdmissao               valid dFuncionarioAdmissao   > dFuncionarioNascimento + 5000 .and. dFuncionarioAdmissao <= dDataHoje
      @ nLinha++,12   get dFuncionarioDemissao               valid dFuncionarioDemissao   >= dFuncionarioAdmissao         .and. dFuncionarioDemissao <= dDataHoje
      @ nLinha--,12   get nFuncionarioSalarioBase            valid nFuncionarioSalarioBase > 0              picture '@E 999,999.99'
      @ nLinha++,74   get nFuncionarioAdicionalInsalubridade valid nFuncionarioAdicionalInsalubridade >= 0  picture '99'
      @ nLinha,68     get nFuncionarioAdicionalNoturno       valid nFuncionarioAdicionalNoturno       >= 0  picture '99'
      read
      //Idade
      nFuncionarioDiaNascimento    := Day(dFuncionarioNascimento)
      nFuncionarioMesNascimento    := Month(dFuncionarioNascimento)
      nFuncionarioAnoNascimento    := Year(dFuncionarioNascimento)

      nFuncionarioIdade  := nAnoAtual - nFuncionarioAnoNascimento
      if nMesAtual < nFuncionarioMesNascimento .or. (nMesAtual == nFuncionarioMesNascimento .and. nDiaAtual < nFuncionarioDiaNascimento)
         nFuncionarioIdade--
      endif
      //Anos de contribuicao
      nFuncionarioDiaAdmissao    := Day(dFuncionarioAdmissao)
      nFuncionarioMesAdmissao    := Month(dFuncionarioAdmissao)
      nFuncionarioAnoAdmissao    := Year(dFuncionarioAdmissao)
      nFuncionarioDiaDemissao    := Day(dFuncionarioDemissao)
      nFuncionarioMesDemissao    := Month(dFuncionarioDemissao)
      nFuncionarioAnoDemissao    := Year(dFuncionarioDemissao)

      nFuncionarioTempoContribuicao := nFuncionarioAnoDemissao - nFuncionarioAnoAdmissao
      if nFuncionarioMesDemissao < nFuncionarioMesAdmissao .or. (nFuncionarioMesDemissao == nFuncionarioMesAdmissao .and. nFuncionarioDiaDemissao < nFuncionarioDiaAdmissao)
         nFuncionarioTempoContribuicao--
      endif
      //direito aposentadoria
      if cFuncionarioSexo == 'M'
         nHomemTotal++
         if nFuncionarioAnoAdmissao < 2006
            nHomemAdmitidoAntes2006++
         endif
         if nFuncionarioIdade >= 59 .and. nFuncionarioTempoContribuicao >= 27
            lFuncionarioAPosentado := .t.
            nHomemAposentado++
         endif

      else
         nMulherTotal++
         if nFuncionarioIdade >= 55 .and. nFuncionarioTempoContribuicao >= 22
            lFuncionarioAPosentado := .t.
            nMulherAposentado++
         endif
         if nFuncionarioIdade > 85
            nMulherMais85++
         endif
      endif

      //Valor Aposentadoria
      if lFuncionarioAPosentado
         nAposentadoriaAdicional := 0
         nAposentadoriaReducao   := 0

         nAposentadoriaAdicional += nFuncionarioSalarioBase * (nFuncionarioAdicionalNoturno /100)
         nAposentadoriaAdicional += nFuncionarioSalarioBase * (nFuncionarioAdicionalInsalubridade /100)
         if nFuncionarioAnoAdmissao <= 2010 .and. nFuncionarioAnoDemissao >= 2015
            nAposentadoriaAdicional += nFuncionarioSalarioBase * 0.06
         endif
         if nFuncionarioAnoAdmissao  <= 2013 .and. nFuncionarioAnoDemissao >= 2019
            nAposentadoriaReducao += nFuncionarioSalarioBase * 0.02
         endif

         
         nTemp := nFuncionarioSalarioBase + nAposentadoriaAdicional - nAposentadoriaReducao
         nRemuneracaoTotal += nTemp

         //adicional e reducao
         if cFuncionarioSexo == 'M'
            nRemuneracaoHomem += nTemp
            if nAposentadoriaAdicional > 0
                nHomensAdicional++
            endif

         else
            nRemuneracaoMulher += nTemp
            if nAposentadoriaReducao > 0
                nMulherReducao++
            endif
         endif


      endif
      nContador++
 
   enddo

   //printa
   if lProcessar
      nLinha := 9
      nPorcentagemHomemAposentado  := nHomemAposentado  / nHomemTotal  * 100
      nPorcentagemMulherAposentado := nMulherAposentado / nMulherTotal * 100
      nPorcentagemAposentados      := (nHomemAposentado + nMulherAposentado) / (nHomemTotal + nMulherTotal) * 100
        
      @ nLinha,01 to nLinha,78
      @ nLinha++,35 say 'Relatorio'
      @ nLinha++,20 say 'Quantidade Digitado.............: '   + AllTrim(Str(nHomemTotal + nMulherTotal))
      @ nLinha++,20 say 'Quantidade de Homens............: '   + AllTrim(Str(nHomemTotal))
      @ nLinha++,20 say 'Quantidade de Mulheres..........: '   + AllTrim(Str(nMulherTotal))
      @ nLinha++,20 say 'Remuneracao total...............: R$' + Transform(nRemuneracaoTotal, '@E 99,999,999.99')
      @ nLinha++,20 say 'Remuneracao Homens..............: R$' + Transform(nRemuneracaoHomem, '@E 99,999,999.99')
      @ nLinha++,20 say 'Remuneracao Mulheres............: R$' + Transform(nRemuneracaoMulher,'@E 99,999,999.99')
      @ nLinha++,20 say 'Porcentagem de aposentados......: '   + Transform(nPorcentagemAposentados,     "@E 999.99")  + '%'
      @ nLinha++,20 say 'Porcentagem Homens Aposentados..: '   + Transform(nPorcentagemHomemAposentado, "@E 999.99")  + '%'
      @ nLinha++,20 say 'Porcentagem Mulheres Aposentados: '   + Transform(nPorcentagemMulherAposentado,"@E 999.99")  + '%'
      @ nLinha++,20 say 'Homens com adicional............: '   + AllTrim(Str(nHomensAdicional))
      @ nLinha++,20 say 'Mulheres com reducao............: '   + AllTrim(Str(nMulherReducao))
      @ nLinha++,20 say 'Homens admitidos antes 2006.....: '   + AllTrim(Str(nHomemAdmitidoAntes2006))
      @ nLinha++,20 say 'Mulheres com mais 85 anos.......: '   + AllTrim(Str(nMulherMais85))
      InKey(0)
   endif
enddo
//João Victor Teixeira Vansan