//Joao Victor Teixeira Vansan
//Prova05
set message to 24 center //com center fica centralizado
set wrap on //faz com a navegacao das opcoes fique melhor
set date to british
set epoch to 1940
set scoreboard off
setmode(25,80)

dHoje     := date()
lSair     := .f.
nContador := 1

//Amora Preta
nCodigoAmora           := 5500
cDescricaoAmora        := 'Amora Preta'
nPrecoAmora            := 7.50
nMaximoDescontoAmora   := 14
nEstoqueAmora          := 210.00
//Uva Rubi
nCodigoUva           := 7744
cDescricaoUva        := 'Uva Rubi'
nPrecoUva            := 18.00
nMaximoDescontoUva   := 17
nEstoqueUva          := 198.50
//Pepino
nCodigoPepino           := 4445
cDescricaoPepino        := 'Pepino'
nPrecoPepino            := 23.99
nMaximoDescontoPepino   := 12
nEstoquePepino          := 345.00
//Morango
nCodigoMorango           := 6565
cDescricaoMorango        := 'Morango'
nPrecoMorango           := 5.49
nMaximoDescontoMorango  := 4
nEstoqueMorango         := 210.00

do while !lSair
//Login
   cUsuario := Space(8)
   cSenha   := Space(8)

   clear
   nLinha := 1
   @ 01,29 say 'Login:'
   @ 02,29 say 'Senha:'

   @ 01,35 get cUsuario valid !Empty(AllTrim(cUsuario)) picture '@!'
   @ 02,35 get cSenha   valid !Empty(AllTrim(cSenha))  color('w/w')
   read
   if LastKey() == 27
      nOpcao := alert('Deseja sair do programa?' , { 'Sim' , 'Nao' })
      if nOpcao = 1
         exit
      else
         loop
      endif
   endif

   if !( 'ROOT' $ AllTrim(cUsuario)) .or. !('teste' $ AllTrim(cSenha))
      Alert('Dados Incorretos! Verifique',{'Ok'})
      loop
   endif
    
    nOpcao := 0
    clear
   @ 02,30 prompt 'Efetuar pedidos' message "Efetuar um pedido"
   @ 03,30 prompt 'Deslogar'        message "Sair do sistema"
   menu to nOpcao

   if nOpcao = 2
      loop
   endif

//Cadastrar
   do while !lSair
      @ 00,00 clear to 24,79

      cNome    := Space(20)
      nLimite   := 0
      dPedido   := CToD('')

      @ 04,65 say 'Pedido:'+ AllTrim(Str(nContador))
      @ 04,01 say 'Nome.......:' 
      @ 04,40 say 'Limite.....:'
      @ 05,01 say 'Data pedido:'

      @ 04,13 get cNome     valid !Empty(AllTrim(cNome))   picture '@!'
      @ 04,52 get nLimite   valid nLimite > 0              picture '@E 9,999.99'
      @ 05,13 get dPedido   valid dPedido >= dHoje
      read
      if LastKey() == 27
         nOpcao := Alert('Oque deseja fazer?' , { 'Retornar login' , 'Continuar Digitando' })
         if nOpcao = 2
            loop
         else
            exit
         endif
      endif

      nTempEstoqueAmora   := nEstoqueAmora
      nTempEstoqueUva     := nEstoqueUva
      nTempEstoquePepino  := nEstoquePepino
      nTempEstoqueMorango := nEstoqueMorango
      nTotalCompra        := 0
      nTotalParcial       := 0
      nLinha              := 7
      nLinhaInicial       := nLinha
      lFinalizarVenda     := .f.

      @ nLinha++,02 say 'Codigo | Descricao Prod | Quant | Estoque | Desc | Comi | Preco Un | Total Item'
      
      //Loop para digitar produtos
      do while !lFinalizarVenda
         //Limpa tela quando chegar na linha 22
         if nLinha >= 22
            @ nLinhaInicial,00 clear to 23,79
            nLinha := nLinhaInicial
            @ nLinha++,02 say 'Codigo | Descricao Prod | Quant | Estoque | Desc | Comi | Preco Un | Total Item'
         endif

         nCodigoDigitado     := 0
         nDigitadoQuantidade := 0
         nDigitadoDesconto   := 0
         nDigitadoComissao   := 0

         @ nLinha,03 get nCodigoDigitado valid nCodigoDigitado > 0 picture '9999'
         read
         
         if LastKey() == 27
            nOpcao := Alert('O que deseja fazer?' , { 'Finalizar venda' , 'Cancelar Venda' , 'Continuar Digitando' })
            if nOpcao == 1
               if nTotalCompra == 0
                  alert('Nao e possivel finalizar a venda SEM PRODUTO!',{'Inserir produtos'})
                  loop
               endif
               lFinalizarVenda := .t.
               exit
            elseif nOpcao == 2
               exit
            else
               loop
            endif
         endif
      
         //verifica produto
         if nCodigoDigitado == nCodigoAmora
            cTempDescricao   := cDescricaoAmora
            nTempMaxDesconto := nMaximoDescontoAmora
            nTempPreco       := nPrecoAmora
            nTempEstoque     := nTempEstoqueAmora
         elseif nCodigoDigitado == nCodigoUva
            cTempDescricao   := cDescricaoUva
            nTempMaxDesconto := nMaximoDescontoUva
            nTempPreco       := nPrecoUva
            nTempEstoque     := nTempEstoqueUva
         elseif nCodigoDigitado == nCodigoPepino
            cTempDescricao   := cDescricaoPepino
            nTempMaxDesconto := nMaximoDescontoPepino
            nTempPreco       := nPrecoPepino
            nTempEstoque     := nTempEstoquePepino
         elseif nCodigoDigitado == nCodigoMorango
            cTempDescricao   := cDescricaoMorango
            nTempMaxDesconto := nMaximoDescontoMorango
            nTempPreco       := nPrecoMorango
            nTempEstoque     := nTempEstoqueMorango
         else
            alert('Codigo nao existe', {'ok'})
            @ nLinha,11 say '-----------------------Codigo nao existe----------------------------'
            nLinha++
            loop
         endif

         @ nLinha,11 say AllTrim(cTempDescricao)
         @ nLinha,36 say AllTrim(Transform(nTempEstoque,'@E 999.999'))
         @ nLinha,49 say '%'
         @ nLinha,55 say '%'
         @ nLinha,62 say AllTrim(Transform(nTempPreco,'@E9.99'))

         @ nLinha,27 get nDigitadoQuantidade valid nDigitadoQuantidade > 0  picture '@E 999.999'
         @ nLinha,47 get nDigitadoDesconto   valid nDigitadoDesconto  >= 0 .and. nDigitadoDesconto <= nTempMaxDesconto  picture '99'
         @ nLinha,53 get nDigitadoComissao   valid nDigitadoComissao  >= 0  picture '99'
         read
         
         if LastKey() == 27
            loop
         endif

         //validar estoque
         if nDigitadoQuantidade > nTempEstoque
            alert('A quantidade ultrapassou o estoque disponivel!',{'ok'})
            nLinha++
            loop
         endif

         //valor produto
         nTotalParcial := nTempPreco * nDigitadoQuantidade * 0.01 * (100 - nDigitadoDesconto)

         //Verificar se ultrapassou o limite
         if (nTotalCompra + nTotalParcial) > nLimite
            cSupervisor      := Space(8)
            cSenhaSupervisor := Space(8)
            
            alert('Valor da compra maior que LIMITE do cliente! Insira a senha de supervisor', {'ok'})
            
            @ 18,00 clear to 23,79
            @ 19,25 say '*** AUTORIZACAO SUPERVISOR ***'
            @ 20,25 say 'Usuario...:'
            @ 21,25 say 'Senha.....:'

            @ 20,37 get cSupervisor valid !Empty(AllTrim(cSupervisor)) picture '@!'
            @ 21,37 get cSenhaSupervisor valid !Empty(AllTrim(cSenhaSupervisor)) color('w/w')
            read
            
            if !( 'ADMIN' $ AllTrim(cSupervisor)) .or. !('admin123' $ AllTrim(cSenhaSupervisor))
               Alert('Dados Incorretos! Venda cancelada.',{'Ok'})
               exit
            else
               alert('Autorizacao concedida! Continue a venda.',{'Ok'})
            endif
         endif

         //Calcular comissão
         nValorComissao := (nTotalParcial * nDigitadoComissao) / 100
         //Atualizar totais
         nTotalCompra += nTotalParcial

         //baixa estoque 
         if nCodigoDigitado == nCodigoAmora
            nTempEstoqueAmora -= nDigitadoQuantidade
         elseif nCodigoDigitado == nCodigoUva
            nTempEstoqueUva -= nDigitadoQuantidade
         elseif nCodigoDigitado == nCodigoPepino
            nTempEstoquePepino -= nDigitadoQuantidade
         else
            nTempEstoqueMorango -= nDigitadoQuantidade
         endif

         @ nLinha,70 say Transform(nTotalParcial ,'@E 9,999.99')
         @ 23,55 say 'Total Compra: ' + Transform(nTotalCompra, '@E 9,999.99')
         @ 24,55 say 'Comissao....: ' + Transform(nValorComissao, '@E 9,999.99')

         nLinha++
        enddo
        do while lFinalizarVenda
      //Tela de pagamento (apenas se finalizou a venda)
      if lFinalizarVenda
         nOpcao := 0
         nValorPagar := 0
         nFormaPagamento := 0
         nValorComissao := (nTotalCompra * nDigitadoComissao) / 100
         clear
         @ 05,25 say '*** FORMA DE PAGAMENTO ***'
         @ 07,25 say 'Valor Total......: ' + Transform(nTotalCompra, '@E 9,999.99')
         @ 08,25 say 'Valor Comissao...: ' + Transform(nValorComissao, '@E 9,999.99')
         @ 10,25 prompt 'Dinheiro'
         @ 11,25 prompt 'Cartao'
         @ 12,25 prompt 'Cheque'
         menu to nFormaPagamento

          if nFormaPagamento = 1
            clear
            @ 12,25 say 'Cliente: ' + AllTrim(cNome)
            @ 13,25 say 'Total..: ' + Transform(nTotalCompra, '@E 9,999.99')
            @ 15,25 say 'Digite o valor a pagar:' 

            @ 15,50 get nValorPagar valid nValorPagar > 0  picture '@E 999.999'
            read
            clear

            nTroco      := (nValorPagar - nTotalCompra)
            nFaltaPagar := (nValorPagar - nTotalCompra)
            if nValorPagar = nTotalCompra
            @ 10,25 say '*** COMPRA FINALIZADA ***'
            @ 11,25 say 'Obrigado pela preferencia!'
            inkey(0)
            if nValorPagar > nTotalCompra
            @ 10,25 say '*** COMPRA FINALIZADA ***'
            @ 11,25 say 'Obrigado pela preferencia!'
            @ 12,25 say 'Seu troco é de:' + Transform(nTroco, '@E 9,999.99')
            inkey(0)
            if nValorPagar < nTotalCompra
            @ 10,25 say 'Falta pagar:' + Transform(nFaltaPagar, '@E9,999.99')
            inkey(0)

            
            if nFormaPagamento = 2
            clear
            @ 07,25 say 'Dejesa parcelar?'
            @ 08,30 prompt 'Sim'
            @ 09,30 prompt 'Nao'
            menu to nOpcao
            elseif nOpcao == 1
            @ 12,25 say 'Escolha em quantas vezes quer parcelar'
            @ 13,30 prompt '1x'
            @ 14,30 prompt '2x'
            @ 15,30 prompt '3x'
            @ 16,30 prompt '4x'
            @ 17,30 prompt '5x'
            @ 18,30 prompt '6x'
            @ 19,30 prompt '7x'
            @ 20,30 prompt '8x'
            @ 21,30 prompt '9x'
            @ 22,30 prompt '10x'
            @ 23,30 prompt '11x'
            @ 24,30 prompt '12x'                                                
            menu to nOpcao
            clear

            //Atualizar estoques definitivos
            nEstoqueAmora   := nTempEstoqueAmora
            nEstoqueUva     := nTempEstoqueUva
            nEstoquePepino  := nTempEstoquePepino
            nEstoqueMorango := nTempEstoqueMorango
            
            nContador++
            
                endif
              endif
            endif
         endif
        endif
      endif
    enddo
   enddo
enddo