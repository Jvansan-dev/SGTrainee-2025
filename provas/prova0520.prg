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
nPrecoUva          := 18.00
nMaximoDescontoUva   := 17
nEstoqueUva        := 198.50
//Pepino
nCodigoPepino           := 4445
cDescricaoPepino        := 'Pepino'
nPrecoPepino            := 23.99
nMaximoDescontoPepino   := 12
nEstoquePepino          := 345.00
//Morango
nCodigoMorango           := 6565
cDescricaoMorango       := 'Morango'
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
 do while .t.
      nTempEstoqueAmora   := nEstoqueAmora
      nTempEstoqueUva     := nEstoqueUva
      nTempEstoquePepino  := nEstoquePepino
      nTempEstoqueMorango := nEstoqueMorango
      nTotalCompra        := 0
      nTotalParcial       := 0
      nLinhaPadrao        := 7
      nLinha              += nLinhaPadrao
      @ nLinhaPadrao++,02 say 'Codigo | Descricao Prod | Quant | Estoque | Desc | Comi | Preco Un | Total Item'
//Pedido
         nCodigoDigitado     := 0
         nDigitadoQuantidade := 0
         nDigitadoDesconto   := 0
         nDigitadoComissao   := 0

         @ nLinhaPadrao++,03 get nCodigoDigitado valid nCodigoDigitado > 0 picture '9999'
         read
         if LastKey() == 27
            nOpcao := Alert('O que deseja fazer?' , { 'Finalizar venda' , 'Cancelar Venda' , 'Continuar Digitando' })
            if nOpcao == 1
               if nTotalCompra == 0
                  alert('Nao e possivel finalizar a venda SEM PRODUTO!',{'Inserir produtos'})
                  loop
               endif
               if nTotalCompra := nTotalCompra
                @ --nLinhaPadrao,00 clear to 24,79
                @ ++nLinhaPadrao,25 say 'Valor da Compra de R$'+ AllTrim(Transform(nTotalCompra,'@E 9,999.99'))
               endif
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
            @nLinha,11 say '-----------------------Codigo nao existe----------------------------'
            nLinha++
            loop
         endif

         @ nLinha,11 say AllTrim(cTempDescricao)
         @ nLinha,36 say AllTrim(Transform(nTempEstoque,'@E 999.999'))
         @ nLinha,49 say '%'
         @ nLinha,55 say '%'
         @ nLinha,62 say AllTrim(Transform(nTempPreco,'@E9.99'))

         @ nLinha,27 get nDigitadoQuantidade valid nDigitadoQuantidade > 0  picture '@E 999.999'
         @ nLinha,47 get nDigitadoDesconto   valid nDigitadoDesconto  >= 0  picture '99'
         @ nLinha,53 get nDigitadoComissao   valid nDigitadoComissao  >= 0  picture '99'
         read
         if LastKey() == 27
            loop
         endif
//validar desconto max
         if nDigitadoDesconto > nTempMaxDesconto
            alert('Desconto ultrapassou o maximo permitido',{'ok'})
            nLinha++
            loop
         endif
//validar estoque max
         if nDigitadoQuantidade >= nEstoqueAmora
            alert('A quantidade ultrapassou o estoque',{'ok'})
            nLinha++
            loop
            elseif nDigitadoQuantidade >= nEstoqueUva
            alert('A quantidade ultrapassou o estoque',{'ok'})
            nLinha++
            loop
            elseif nDigitadoQuantidade >= nEstoquePepino
            alert('A quantidade ultrapassou o estoque',{'ok'})
            nLinha++
            loop
            elseif nDigitadoQuantidade >= nEstoqueMorango
            alert('A quantidade ultrapassou o estoque',{'ok'})
            nLinha++
            loop    
         endif
//valor produto
         cSupervisor        := Space(8)
         cSenhaSupervisor   := Space(8)
         nTotalParcial := nTempPreco * nDigitadoQuantidade * 0.01 * (100 - nDigitadoDesconto)

         if nTotalParcial > nLimite
            alert('Valor da compra maior que LIMITE do cliente! Insira a senha de supervisor', {'ok'})
            
            @00,28 to 03,45
            @ 01,29 say 'Login:'
            @ 02,29 say 'Senha:'

            @ 01,35 get cSupervisor valid !Empty(AllTrim(cSupervisor)) picture '@!'
            @ 02,35 get cSenhaSupervisor   valid !Empty(AllTrim(cSenhaSupervisor))  color('w/w')
            read
            nLinha++
            loop
                if !( 'ADMIN' $ AllTrim(cSupervisor)) .or. !('admin123' $ AllTrim(cSenhaSupervisor))
      Alert('Dados Incorretos! Verifique',{'Ok'})
      loop
   endif
         endif
         nTotalCompra += nTotalParcial

     

//valor total

         nTotalParcial := nTempPreco * nDigitadoQuantidade * 0.01 * (100 - nDigitadoDesconto)

         if nTotalCompra > nLimite
            alert('Valor da compra maior que LIMITE do cliente! Insira a senha de supervisor', {'ok'})
            
            @nLinha,00 clear to nLinha,79
            @nLinha,11 say '-------------------Valor ultrapassou limite-------------------------'
            nLinha++
            loop
         endif
//baixa estoque temp
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
         @ 23    ,70 say Transform(nTotalCompra  ,'@E 9,999.99')

        enddo
    enddo
enddo