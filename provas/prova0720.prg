//Joao Victor Teixeira Vansan
//prova07
set message to 24 center
set wrap on
set date to british
set epoch to 1940
set scoreboard off
setmode(25,80)
clear

dHoje := date()
lSair := .f.
nOrdemServico := 1

do while !lSair
//login
   cUsuario := Space(15)
   cSenha   := Space(12)
   
   clear
   @ 07,24 to 12,63 double
   @ 08,25 say '*** SISTEMA DE ASSISTENCIA TECNICA ***'
   @ 10,25 say 'Usuario...:'
   @ 11,25 say 'Senha.....:'
   
   @ 10,37 get cUsuario valid !Empty(AllTrim(cUsuario)) picture '@!'
   @ 11,37 get cSenha   valid !Empty(AllTrim(cSenha)) color('w/w')
   read

   if LastKey() == 27
      nOpcao := alert('Deseja sair do programa?', {'Sim', 'Nao'})
      if nOpcao == 1
         exit
      else
         loop
      endif
   endif
   
   if !(AllTrim(cUsuario) == 'JOSE') .or. !(AllTrim(cSenha) == '432mudar123')
      alert('Usuario ou senha incorretos!', {'Ok'})
      loop
   endif 

//menu
   do while !lSair
      nOpcaoMenu := 0
      clear
      @ 05,30 say '*** MENU PRINCIPAL ***'
      @ 07,30 prompt '1. Efetuar Pedidos' message 'Efetuar um pedido'
      @ 08,30 prompt '2. Sair           ' message 'Sair do menu     '
      menu to nOpcaoMenu
      
      if nOpcaoMenu == 2
         exit
      endif
      
      if nOpcaoMenu == 0
         loop
      endif
//o.s.
      clear
      cNomeCliente      := Space(40)
      cTecnico          := Space(30)
      cEquipamento      := Space(40)
      dDataCompra       := CToD('  /  /  ')
      cEntregaDomicilio := Space(01)
      nLimiteCredito    := 0
      cEndereco         := Space(50)
      cBairro           := Space(30)
      cReferencia       := Space(50)
      cTelefone         := Space(15)
      
      @ 02,01 say 'Ordem de Servico...: ' + AllTrim(Str(nOrdemServico, 8))
      @ 03,01 say 'Nome do Cliente....:'
      @ 04,01 say 'Data O.S...........: ' + DToC(dHoje)
      @ 05,01 say 'Nome do Tecnico....:'
      @ 06,01 say 'Equipamento........:'
      @ 07,01 say 'Data da Compra.....:'
      @ 08,01 say 'Entrega Domicilio..:   (S/N)'
      @ 09,01 say 'Limite de Credito..:'
      
      @ 03,22 get cNomeCliente      valid !Empty(AllTrim(cNomeCliente))        picture '@!'
      @ 05,22 get cTecnico          valid !Empty(AllTrim(cTecnico))            picture '@!'
      @ 06,22 get cEquipamento      valid !Empty(AllTrim(cEquipamento))        picture '@!'
      @ 07,22 get dDataCompra       valid !Empty(dDataCompra)
      @ 08,22 get cEntregaDomicilio valid !Empty(AllTrim(cEntregaDomicilio))   picture '@!'
      @ 09,22 get nLimiteCredito    valid nLimiteCredito >= 0                  picture '@E 999,999.99'
      read
      
      if LastKey() == 27
         loop
      endif
//entrega
      lEntrega := (cEntregaDomicilio == 'S')
      if lEntrega

         @ 11,00 to 16,79 double
         @ 11,30 say 'DADOS PARA ENTREGA' color ('g/n')
         @ 12,01 say 'Endereco...........:'
         @ 13,01 say 'Bairro.............:'
         @ 14,01 say 'Referencia.........:'
         @ 15,01 say 'Telefone...........:'
         
         @ 12,22 get cEndereco   valid !Empty(AllTrim(cEndereco)) picture '@!'
         @ 13,22 get cBairro     valid !Empty(AllTrim(cBairro)) picture '@!'
         @ 14,22 get cReferencia picture '@!'
         @ 15,22 get cTelefone   picture '@!'
         read
         
         if LastKey() == 27
            lEntrega := .f.
            cEntregaDomicilio := 'N'
         endif
      endif
//controle
      nTotalOrdem     := 0
      nTotalComissao  := 0
      nLinha          := 3
      lFinalizarOS    := .f.
      lGarantia       := .f.
//garantia
        nDiasGarantia := (dHoje - dDataCompra)
        if nDiasGarantia <= 730  // 2 anos para produtos
        lGarantia := .t.
        @ 01,01 say '*** EQUIPAMENTO EM GARANTIA ***'
        endif
      
        @ 03,01 say 'Tipo| Descricao                   | Quant | Preco Unit | Desc% | Comis% | Total'
        nLinha++

      
//digitar pedido/servico
      do while !lFinalizarOS
        @04,00 clear to 24,80
         if nLinha >= 10
            nLinha := 03
            @ 03,01 say 'Tipo| Descricao                   | Quant | Preco Unit | Desc% | Comis% | Total'
            nLinha++
         endif
         
         cTipoItem      := 'P'
         cDescricao     := Space(30)
         nQuantidade    := 0
         nPrecoUnitario := 0
         nDesconto      := 0
         nComissao      := 0
         nValorItem     := 0
         
         @ nLinha,01 get cTipoItem valid !Empty(AllTrim(cTipoItem)) picture '@!'
         read
         
         if LastKey() == 27
            nOpcaoESC := alert('O que deseja fazer?', {'Finalizar OS', 'Cancelar OS', 'Continuar'})
            if nOpcaoESC == 1
               lFinalizarOS := .t.
               exit
            elseif nOpcaoESC == 2
               exit
            else
               loop
            endif
         endif
         
         if cTipoItem == 'P' 
            @ nLinha,06 get cDescricao     valid !Empty(AllTrim(cDescricao)) picture '@!'
            @ nLinha,37 get nQuantidade    valid nQuantidade > 0 picture '999.99'
            @ nLinha,45 get nPrecoUnitario valid nPrecoUnitario >= 0 picture '@E 9,999.99'
            @ nLinha,58 get nDesconto      valid nDesconto >= 0 .and. nDesconto <= 100 picture '999.99'
            read
            
            if LastKey() == 27
               loop
            endif
            nValorItem := nPrecoUnitario * nQuantidade
            nValorItem := nValorItem * (1 - (nDesconto / 100))
            
         else 
            @ nLinha,06 get cDescricao     valid !Empty(AllTrim(cDescricao)) picture '@!'
            @ nLinha,58 get nDesconto      valid nDesconto >= 0 .and. nDesconto <= 100 picture '999.99'
            @ nLinha,66 get nComissao      valid nComissao >= 0 .and. nComissao <= 100 picture '999.99'
            @ nLinha,74 get nPrecoUnitario valid nPrecoUnitario >= 0 picture '@E 99,999.99'
            read
            
            if LastKey() == 27
               loop
            endif

//item + comissao
            nValorItem := nPrecoUnitario * (1 - (nDesconto / 100))
            nComissaoItem := nValorItem * (nComissao / 100)
            nTotalComissao += nComissaoItem
         endif
         
//limite
         if (nTotalOrdem + nValorItem) > nLimiteCredito
            cSupervisor := Space(15)
            cSenhaSuper := Space(10)
            
            alert('Limite de credito ultrapassado! Solicite autorizacao do supervisor.', {'Ok'})
            
            @ 18,00 clear to 24,79
            @ 19,25 say '*** AUTORIZACAO SUPERVISOR ***'
            @ 20,25 say 'Supervisor..:'
            @ 21,25 say 'Senha.......:'
            
            @ 20,38 get cSupervisor valid !Empty(AllTrim(cSupervisor)) picture '@!'
            @ 21,38 get cSenhaSuper valid !Empty(AllTrim(cSenhaSuper)) color('w/w')
            read
            
            if !(AllTrim(cSupervisor) == 'SUPERVISOR') .or. !(AllTrim(cSenhaSuper) == 'autoriza99')
               alert('Autorizacao negada! Item nao sera adicionado.', {'Ok'})
               loop
            else
               alert('Autorizacao concedida! Continue a ordem de servico.', {'Ok'})
            endif
         endif
         
//garantia
         if lGarantia
            nValorItem := 0  
            if cTipoItem == 'S'
               nComissaoItem := 0
            endif
         endif
         
//atualiza total
         nTotalOrdem += nValorItem
         
//mostra valor
         @ nLinha,74 say Transform(nValorItem, '@E 99,999.99')
         
//total atualizado
         @ 23,01 say 'Total OS....: ' + Transform(nTotalOrdem, '@E 999,999.99')
         @ 23,40 say 'Comissao...: ' + Transform(nTotalComissao, '@E 999,999.99')
         if lGarantia
            @ 24,01 say '*** VALOR COBERTO PELA GARANTIA ***'
         endif
         
         nLinha++
      enddo
      
//pagamento
      if lFinalizarOS .and. nTotalOrdem >= 0
//tx entrega
         if lEntrega
            nTaxaEntrega := nTotalOrdem * 0.02
            nTotalOrdem += nTaxaEntrega
            @ 23,01 say 'Total OS....: ' + Transform(nTotalOrdem, '@E 999,999.99') + ' (+taxa entrega)'
         endif
//pagamento
         lDinheiroUsado := .f.
         lChequeUsado   := .f.
         lCartaoUsado   := .f.
         nValorRestante := nTotalOrdem
         
         do while nValorRestante > 0
            nFormaPagto := 0
            clear
            @ 05,25 say '*** FORMAS DE PAGAMENTO ***'
            @ 07,25 say 'Valor Total OS....: ' + Transform(nTotalOrdem, '@E 999,999.99')
            @ 08,25 say 'Valor Restante....: ' + Transform(nValorRestante, '@E 999,999.99')
            @ 10,25 say 'Formas disponiveis:'
            
            nOpcao := 1
            if !lDinheiroUsado
               @ 11 + nOpcao,30 prompt 'Dinheiro'
               nOpcao++
            endif
            if !lChequeUsado
               @ 11 + nOpcao,30 prompt 'Cheque'
               nOpcao++
            endif
            if !lCartaoUsado
               @ 11 + nOpcao,30 prompt 'Cartao'
               nOpcao++
            endif
            
            menu to nFormaPagto
            
               if nFormaPagto == 1 .and. !lDinheiroUsado
                  nValorDinheiro := 0
                  @ 15,25 say 'Valor em Dinheiro.:'
                  @ 15,45 get nValorDinheiro valid nValorDinheiro > 0 picture '@E 999,999.99'
                  read
                  
                  if nValorDinheiro <= nValorRestante
                     nValorRestante -= nValorDinheiro
                     lDinheiroUsado := .t.
                  else
                     nTroco := nValorDinheiro - nValorRestante
                     @ 16,25 say 'Troco............: ' + Transform(nTroco, '@E 999,999.99')
                     nValorRestante := 0
                     lDinheiroUsado := .t.
                     inkey(0)
                  endif
                endif
                  
               if nFormaPagto == 2 .and. !lChequeUsado
                  nValorCheque := 0
                  cBanco       := Space(20)
                  nNumCheque   := 0
                  
                  @ 15,25 say 'Banco............:'
                  @ 16,25 say 'Numero Cheque....:'
                  @ 17,25 say 'Valor Cheque.....:'
                  
                  @ 15,45 get cBanco       valid !Empty(AllTrim(cBanco)) picture '@!'
                  @ 16,45 get nNumCheque   valid nNumCheque > 0 picture '999999'
                  @ 17,45 get nValorCheque valid nValorCheque > 0 picture '@E 999,999.99'
                  read
                  
                  if nValorCheque <= nValorRestante
                     nValorRestante -= nValorCheque
                     lChequeUsado := .t.
                  else
                     alert('Valor do cheque maior que o restante!', {'Ok'})
                  endif
                endif
                  
               if nFormaPagto == 3 .and. !lCartaoUsado
                  nValorCartao := 0
                  nParcelas    := 1
                  cBandeira    := Space(15)
                  
                  @ 15,25 say 'Bandeira.........:'
                  @ 16,25 say 'Parcelas.........:'
                  @ 17,25 say 'Valor Cartao.....:'
                  
                  @ 15,45 get cBandeira    valid !Empty(AllTrim(cBandeira)) picture '@!'
                  @ 16,45 get nParcelas    valid nParcelas >= 1 .and. nParcelas <= 12 picture '99'
                  @ 17,45 get nValorCartao valid nValorCartao > 0 picture '@E 999,999.99'
                  read
                  
                  if nValorCartao <= nValorRestante
                     nValorRestante -= nValorCartao
                     lCartaoUsado := .t.
                  else
                     alert('Valor do cartao maior que o restante!', {'Ok'})
                  endif
                endif
         enddo
         
//valor 0 = garantia
         if nTotalOrdem == 0
            cCNPJ      := Space(14)
            cNumNota   := Space(10)
            dDataNota  := dHoje
            
            clear
            @ 05,25 say '*** NOTA FISCAL - GARANTIA ***'
            @ 07,25 say 'CNPJ da Empresa...:'
            @ 08,25 say 'Numero da Nota....:'
            @ 09,25 say 'Data da Nota......:'
            
            @ 07,45 get cCNPJ    valid !Empty(AllTrim(cCNPJ)) picture '99999999999999'
            @ 08,45 get cNumNota valid !Empty(AllTrim(cNumNota)) picture '9999999999'
            @ 09,45 get dDataNota
            read
         endif
         
//final
        clear
         @ 05,25 say '*** ORDEM DE SERVICO FINALIZADA ***'
         @ 07,25 say 'Numero OS........: ' + AllTrim(Str(nOrdemServico, 8))
         @ 08,25 say 'Cliente..........: ' + AllTrim(cNomeCliente)
         @ 09,25 say 'Tecnico..........: ' + AllTrim(cTecnico)
         @ 10,25 say 'Equipamento......: ' + AllTrim(cEquipamento)
         @ 11,25 say 'Total OS.........: ' + Transform(nTotalOrdem, '@E 999,999.99')
         @ 12,25 say 'Comissao Tecnico.: ' + Transform(nTotalComissao, '@E 999,999.99')
         
         if lGarantia
            @ 13,25 say '*** SERVICO COBERTO PELA GARANTIA ***'
         endif
         
         if lEntrega
            @ 14,25 say '*** ENTREGA DOMICILIAR AGENDADA ***'
         endif
         
         @ 16,25 say 'Pressione qualquer tecla para continuar...'
         inkey(0)
         
         nOrdemServico++
        endif
        enddo
    enddo

clear
@ 10,30 say 'Sistema encerrado. Obrigado!'
inkey(0)