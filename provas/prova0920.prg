//João Victor Teixeira Vansan
//Prova09

Clear
set message to 24
set wrap on
set date to british
set epoch to 1940
set scoreboard off
setmode(25,80)

lSistema       := .t.
lMenu          := .t.
lMesaLivre1    := .t.
lMesaLivre2    := .t.

nTotalCompra1  := 0
nTotalCompra2  := 0
nMesaVez       := 0
nCancelaPag1   := 0
nCancelaPag2   := 0
nLinha         := 0
nCancela1      := 0
nCancela2      := 0
nTotalSemTaxa1 := 0
nTotalSemTaxa2 := 0
nTotalMesa1    := 0
nTotalMesa2    := 0
nAtendimentoMesa1 := 0
nAtendimentoMesa2 := 0

cCorMesa1      := 'N/G'
cCorMesa2      := 'N/G'

do while lMenu
   clear
   nCodAtendente := 0
   nCodMesa      := 0
   lFaturar      := .f.
   nOpcao        := 3
//menu
   @ 04,33 to 10,50 double
   @ 05,35 say "RESTAURANTE SG"
   @ 07,36 prompt '   MESAS   'message 'Ir para o modulo de mesas    ' 
   @ 08,36 prompt ' RELATORIO 'message 'Apresenta Relatorio          '
   @ 09,36 prompt '   SAIR    'message 'Sair do sistema              '
   menu to nOpcao
   
    if LastKey() == 27
         if nOpcao = 3
         else
            loop
    endif
        
    endif
    if nOpcao == 3
        exit
    endif


do while lSistema
   clear
   nCodAtendente := 0
   nCodMesa      := 0
   lFaturar      := .f.
   @ 01,00 to 04,21 double
   @ 02,01 say "Atendente:"
   @ 02,16 say "01" color cCorMesa1
   @ 02,19 say "02" color cCorMesa2
   @ 03,01 say "Mesa.....:"

   @ 02,13 get nCodAtendente valid nCodAtendente = 1 .or. nCodAtendente = 2 picture "9"
   @ 03,13 get nCodMesa      valid nCodMesa      = 1 .or. nCodMesa      = 2 picture "9"
   read
      if LastKey() == 27
         nOpcao := alert('Deseja sair do programa?' , { 'Sim' , 'Nao' })
         if nOpcao = 1
            lFinaliza := .t.
            exit
         else
            loop
         endif
      endif
//mesa 1
   if nCodMesa = 1
      nMesaVez = 1
      if lMesaLivre1 = .f.
         nOpcao := alert('Oque deseja fazer?' ,{'Digitar outra mesa' , 'Faturar atendimento' , 'Cancelar atendimento'})
         if nOpcao = 2 //faturar
            lFaturar   := .t.
            nTotalReal := nTotalCompra1
            nMesaVez   := 1
         elseif nOpcao = 3 //cancela mesa
            cCorMesa1     := 'N/G'
            lMesaLivre1   := .t.
            nTotalCompra1 := 0
            nCancela1++
            loop
         else
            loop
         endif
      endif
   //mesa 2
   else
      nMesaVez = 2
      if lMesaLivre2 = .f.
         nOpcao := alert('Oque deseja fazer?' ,{'Digitar outra mesa' , 'Faturar atendimento' , 'Cancelar atendimento'})
         if nOpcao = 2 //faturar
            lFaturar   := .t.
            nTotalReal := nTotalCompra2
            nMesaVez   := 2
         elseif nOpcao = 3 //cancela mesa
            cCorMesa2     := 'N/G'
            lMesaLivre2   := .t.
            nTotalCompra2 := 0
            nCancela2++
            loop
         else
            loop
         endif
      endif
   endif

//mesa livre
   @ 06,01 say '             PRODUTO           |QTD|PREC. UNIT|    VALOR '

   nLinha := 7
   nTemp  := 0
   do while !lFaturar
      @ nLinha,00 clear to nLinha,79
      cProduto      := Space(30)
      nQuantidade   := 0
      nPreco        := 0

      @ nLinha,01 get cProduto    valid !Empty(cProduto) picture "@!"
      @ nLinha,33 get nQuantidade valid nQuantidade > 0  picture "99"
      @ nLinha,38 get nPreco      valid nPreco > 0       picture "@E 999.99"
      read
      if LastKey() == 27
         nOpcao := alert('Oque deseja fazer?', { 'Produzir' , ' Continuar ' , 'Abandonar'})
         if nOpcao = 1     //Produz
            if nTemp = 0
               loop
            endif
            if nMesaVez = 1
               lMesaLivre1 := .f.
               cCorMesa1   := 'N/R'
            else
               lMesaLivre2 := .f.
               cCorMesa2   := 'N/R'
            endif
            exit
         elseif nOpcao = 2 //Retoma
            loop
         else              //Cancela
            if nMesaVez = 1
               nCancela1++
               nTotalCompra1 := 0
            else
               nCancela2++
               nTotalCompra2 := 0
            endif
            exit
         endif
      endif

      nValorTemp    := nQuantidade * nPreco
      if nMesaVez = 1
         nTotalCompra1 += nValorTemp
         nTemp := nTotalCompra1
      else
         nTotalCompra2 += nValorTemp
         nTemp := nTotalCompra2
      endif
      @ nLinha,49   say transform(nValorTemp,'@E 99,999.99')
      @ nLinha+2,49 say transform(nTemp,'@E 99,999.99')


      if ++nLinha > 20
         @ nLinha,00 clear to  nLinha,79
         @ nLinha,20 say 'precione um tecla para continuar...'
         inkey(0)

         nLinha := 7
         @ nLinha,00 clear  to 22,79
         @ nLinha+2,49 say transform(nTemp,'@E 99,999.99')
      endif
enddo
//faturar
    do while lFaturar
      @ nLinha,00 clear to nLinha,79
      nTemp      := 0
      cPagamento := ' '
      nPagamento := 0
      @ 06,00 clear to 24,79
      nOpcao := Alert('Aceita taxa de servico?' , {'Sim' , 'Nao'})
      if nOpcao = 1
         nTemp := nTotalReal * 0.10
      
      @ 06,38 say "Faturar"
      @ 07,10 say "[D]inheiro / [C]artao / Che[Q]ue:[ ]  "
      @ 08,10 say "Total pagar.....................: "+ transform(nTotalReal+nTemp,'@E 99,999.99')
      @ 09,10 say "Valor Recebido..................: "

      @ 07,45 get cPagamento valid !Empty (cPagamento)  picture "!@"
      @ 09,45 get nPagamento valid nPagamento >= 0      picture '@E 99,999.99'
      read
            if nPagamento == nTemp
        @ 11,10 say "Valor pago com sucesso! Obrigado, volte sempre!!"
      endif

      endif
      if LastKey() == 27
         nOpcao := alert('O que fazer?',{'Cancelar pagamento' , 'Recomecar pagamento'})
         if nOpcao = 1
            if nMesaVez = 1
               cCorMesa1     := 'N/G'
               lMesaLivre1   := .t.
               nTotalCompra1 := 0
               nCancelaPag1  += nTotalReal
               nCancela1++
               exit
            else
               cCorMesa2     := 'N/G'
               lMesaLivre2   := .t.
               nTotalCompra2 := 0
               nCancelaPag2  += nTotalReal
               nCancela2++
               exit
            endif
         endif
      endif
if nPagamento < nTotalReal+nTemp
         alert('Valor recebido MENOR que pagamento!',{'ok'})
         loop
      endif
      nValorTemp := nTotalReal + nTemp
      @ 10,10 say "Valor troco.....................:" + transform(nPagamento-nValorTemp,'@E 99,999.99')
      @ 11,10 say "Pagamento realizado com sucesso!"
      @ 12,10 say "Precione um tecla para continuar."
      if nMesaVez = 1
         cCorMesa1      := 'N/G'
         lMesaLivre1    := .t.
         nTotalCompra1  := 0
         nAtendimentoMesa1++
         nTotalMesa1    += nValorTemp
         nTotalSemTaxa1 += nTotalReal
      else
         cCorMesa2      := 'N/G'
         lMesaLivre2    := .t.
         nTotalCompra2  := 0
         nAtendimentoMesa2++
         nTotalMesa2    += nValorTemp
         nTotalSemTaxa2 += nTotalReal
      endif
      InKey(0)
      exit

     enddo
   enddo
enddo

/*relatorio final
@ 07,01 say '                                       MESA 1       MESA 2       GERAL'
@ 08,01 say 'Quantidade de atendimentos...........:' + transform(nAtendimentoMesa1,'999999')                      +"     "+ transform(nAtendimentoMesa2,'999999')                      +"     "+ transform(nAtendimentoMesa1+nAtendimentoMesa2,'999999')
@ 09,01 say 'Quantidade de atendimentos cancelados:' + transform(nCancela1,'999999')                              +'     '+ transform(nCancela2,'999999')                              +"     "+ transform(nCancela1+nCancela2,'999999')
@ 10,01 say 'Val. total de atendimentos...........:' + transform(nTotalMesa1,'@E 99,999.99')                      +'     '+ transform(nTotalMesa2,'@E 99,999.99')                      +'     '+ transform(nTotalMesa1+nTotalMesa2,'@E 99,999.99')
@ 11,01 say 'Val. total de atendimentos cancelados:' + transform(nCancelaPag1,'@E 99,999.99')                     +'     '+ transform(nCancelaPag2,'@E 99,999.99')                     +'     '+ transform(nCancelaPag1+nCancelaPag2,'@E 99,999.99')
@ 12,01 say 'Ticket medio.........................:' + transform(nTotalSemTaxa1/nAtendimentoMesa1,'@E 99,999.99') +'     '+ transform(nTotalSemTaxa2/nAtendimentoMesa2,'@E 99,999.99') +'     '+ transform((nTotalSemTaxa1+nTotalSemTaxa2)/(nAtendimentoMesa1+nAtendimentoMesa2),'@E 99,999.99')
InKey(0)



   