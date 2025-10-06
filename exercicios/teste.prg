

set date to british
set epoch to 1940
set scoreboard off
setmode(25,80)

dHoje     := date()
lSair     := .f.
nContador := 1

//Banana
nCodigoBanana          := 1500
nMaximoDescontoBanana  := 20
cDescricaoBanana       := 'Banana Prata'
nPrecoBanana           := 1.50
nEstoqueBanana         := 155.000

//Pera
nCodigoPera            := 2501
nMaximoDescontoPera    := 15
cDescricaoPera         := 'Pera Argentina'
nPrecoPera             := 9.00
nEstoquePera           := 117.500

//Batata
nCodigoBatata          := 3001
nMaximoDescontoBatata  := 10
cDescricaoBatata       := 'Batata Peruana'
nPrecoBatata           := 5.00
nEstoqueBatata         := 859.000

do while !lSair

//---------------login
   cUsuario := Space(8)
   cSenha   := Space(8)

   clear
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

   if !( 'ADMIN' $ AllTrim(cUsuario)) .or. !('teste123' $ AllTrim(cSenha))
      Alert('Dados Incorretos!',{'Ok'})
      loop
   endif


   nOpcao := 0
   @ 04,30 prompt 'Efetuar pedidos'
   @ 05,30 prompt 'Deslogar'
   menu to nOpcao
   if nOpcao = 2
      loop
   endif

//----------------cadastro
   do while !lSair
      @ 04,00 clear to 24,79

      cNome    := Space(20)
      nLimie   := 0
      dVenda   := CToD('')
      cEntrega := ' '

      @ 04,65 say 'Pedido:'+ AllTrim(Str(nContador))
      @ 04,01 say 'Nome......:'
      @ 04,40 say 'Limite....:'
      @ 05,01 say 'Data venda:'
      @ 05,40 say 'Entrega [ ] [S] [N]'

      @ 04,12 get cNome    valid !Empty(AllTrim(cNome))
      @ 04,51 get nLimie   valid nLimie > 0              picture '@E 9,999.99'
      @ 05,12 get dVenda   valid dVenda >= dHoje
      @ 05,49 get cEntrega valid cEntrega $ 'SN'         picture '@!'
      read
      if LastKey() == 27
         nOpcao := Alert('Oque deseja fazer?' , { 'Retornar login' , 'Continuar Digitando' })
         if nOpcao = 2
            loop
         else
            exit
         endif
      endif
      nLinhaPadrao := 6
      nEntrega     := 0
      if cEntrega == 'S'
         cEndereco    := Space(30)
         cBairro      := Space(30)
         cReferencia  := Space(20)
         cTelefone    := Space(14)
         nEntrega     += 5
         nLinhaPadrao += 2

         @ 06,01 say 'Endereco..:'
         @ 06,44 say 'Bairro..:'
         @ 07,01 say 'Referencia:'
         @ 07,44 say 'Telefone:'

         @ 06,12 get cEndereco   valid !Empty(AllTrim(cEndereco))
         @ 06,53 get cBairro     valid !Empty(AllTrim(cBairro))
         @ 07,12 get cReferencia valid !Empty(AllTrim(cReferencia))
         @ 07,53 get cTelefone   valid !Empty(AllTrim(cTelefone))
         read
         if LastKey() == 27
            nOpcao := Alert('Oque deseja fazer?' , { 'Retornar login' , 'Continuar Digitando' })
            if nOpcao = 2
               loop
            else
               exit
            endif
         endif
      endif

      @ nLinhaPadrao++,02 say 'Codigo | Descricao Prod | Quanti | Estoque | Desconto | Preco Un | Total Item '
      nLinha := nLinhaPadrao
      nTempEstoqueBanana := nEstoqueBanana
      nTempEstoquePera   := nEstoquePera
      nTempEstoqueBatata := nEstoqueBatata
      nTotalCompra       := 0
      nTotalParcial      := 0
      lCupom             := .f.
      //Vendas
      do while .t.
         nCodigoDigitado     := 0
         nDigitadoQuantidade := 0
         nDigitadoDesconto   := 0

         @ nLinha,03 get nCodigoDigitado valid nCodigoDigitado > 0 picture '9999'
         read
         if LastKey() == 27
            nOpcao := Alert('Oque deseja fazer?' , { 'Faturar venda' , 'Cancelar Venda' , 'Continuar Digitando' })
            
            if nOpcao == 1
               if nTotalCompra == 0
                  alert('Nao e possivel faturar SEM PRODUTO!',{'ok'})
                  loop
                  nLinha++
               endif
               lCupom := .t.
               exit

            elseif nOpcao == 2
               exit
            else
               loop
               nLinha++
            endif
         endif

         //verifica produto
         if nCodigoDigitado == nCodigoBanana
            cTempDescricao   := cDescricaoBanana
            nTempMaxDesconto := nMaximoDescontoBanana
            nTempPreco       := nPrecoBanana
            nTempEstoque     := nTempEstoqueBanana

         elseif nCodigoDigitado == nCodigoPera
            cTempDescricao   := cDescricaoPera
            nTempMaxDesconto := nMaximoDescontoPera
            nTempPreco       := nPrecoPera
            nTempEstoque     := nTempEstoquePera

         elseif nCodigoDigitado == nCodigoBatata
            cTempDescricao   := cDescricaoBatata
            nTempMaxDesconto := nMaximoDescontoBatata
            nTempPreco       := nPrecoBatata
            nTempEstoque     := nTempEstoqueBatata
         else
            alert('Codigo Invalido', {'ok'})
            loop
         endif

         @ nLinha,11 say AllTrim(cTempDescricao)
         @ nLinha,38 say AllTrim(Transform(nTempEstoque,'@E 999.999'))
         @ nLinha,52 say '%'
         @ nLinha,60 say AllTrim(Transform(nTempPreco,'@E9.99'))


         @ nLinha,28 get nDigitadoQuantidade valid nDigitadoQuantidade > 0  picture '@E 999.999'
         @ nLinha,50 get nDigitadoDesconto   valid nDigitadoDesconto  >= 0  picture '99'
         read
         if LastKey() == 27
            loop
         endif

         if nDigitadoQuantidade > nTempEstoque
            alert('Quantidade digitada MAIOR que estoque!',{'ok'})
            @ nLinha,00 clear to nLinha,79
            loop
         endif
         if nDigitadoDesconto > nTempMaxDesconto
            alert('Desconto MAIOR que permitido!',{'ok'})
            @ nLinha,00 clear to nLinha,79
            loop
         endif

         //valor venda
         nTotalParcial := nTempPreco * nDigitadoQuantidade * 0.01 * (100 - nDigitadoDesconto)

         if nTotalParcial > nLimie
            alert('Valor da compra Maior que limite do cliente!', {'ok'})
            @ nLinha,00 clear to nLinha,79
            loop
         endif
         nTotalCompra  += nTotalParcial

         //baixa estoque temp
         if nCodigoDigitado == nCodigoBanana
            nTempEstoqueBanana -= nDigitadoQuantidade
         elseif nCodigoDigitado == nCodigoPera
            nTempEstoquePera -= nDigitadoQuantidade
         else
            nTempEstoqueBatata -= nDigitadoQuantidade
         endif


         @ nLinha,70 say Transform(nTotalParcial ,'@E 9,999.99')
         @ 23    ,70 say Transform(nTotalCompra  ,'@E 9,999.99')

         //calcula linha
         nLinha++
         if nLinha = 22
            @ nLinhaPadrao,00 clear to 21,79
            nLinha := nLinhaPadrao
         endif
      enddo

      if !lCupom //cancela venda
         loop
      endif

      //faturar venda
      do while .t.
         nTotalCompra    += nEntrega
         cFormaPagamento := ' '
         @ --nLinhaPadrao,00 clear to 24,79
         @ ++nLinhaPadrao,25 say 'Valor da Compra de R$'+ AllTrim(Transform(nTotalCompra,'@E 9,999.99'))
         @ ++nLinhaPadrao,25 say 'Forma de pagamento [ ] [D]inheiro [C]artao'

         @ nLinhaPadrao,46 get cFormaPagamento valid cFormaPagamento $ 'DC' picture '@!'
         read
         if LastKey() == 27
            nOpcao := Alert('Oque deseja fazer?' , { 'Cancelar Venda' , 'Continuar Digitando' })
            if nOpcao == 1
               exit
            else
               nTotalCompra -= nEntrega
               loop
            endif
         endif
         nEstoqueBatata := nTempEstoqueBatata
         nEstoquePera   := nTempEstoquePera
         nEstoqueBanana := nTempEstoqueBanana
         nContador++

         @ ++nLinhaPadrao,25 say 'Venda realizada com sucesso!!'
         InKey(0)
         exit
      enddo





   enddo
enddo

