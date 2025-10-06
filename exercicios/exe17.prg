set epoch to 1940 //utilizar ano acima de 2000
set date british //data modo britanico
set scoreboard off //corrige borda
clear //limpa tela
setmode (25,80)//ajusta tela
do while .t.

nCont      := 0
cNome      := Space(10)
cInvertido := ''

@ 00,00 to 06,18 double
@ 01,01 say "Nome:"
@ 01,06 get cNome picture "@!" valid !Empty(cNome)
read

cCor := "r/w"

 if LastKey() == 27
      nOpcao := alert('Deseja sair do programa?' , { 'Sair' , 'Continuar' }, cCor) 
      if nOpcao = 1
         exit
      else
         loop
      endif
   endif
cNome := (cNome)
nTam  := len(cNome)

 do while !Empty(nTam)
   cInvertido += substr(cNome, nTam-- ,1)
 enddo
 @ 04,01 say AllTrim(cInvertido)

enddo
