set epoch to 1940 //utilizar ano acima de 2000
set date british //data modo britanico
set scoreboard off //corrige borda
clear //limpa tela
setmode (25,80)//ajusta tela

nCont      := 0
cNome      := Space(10)
cInvertido := ''

@ 01,01 say "Nome:"
@ 01,06 get cNome picture "@!" valid !Empty(cNome)
read

cNome := alltrim(cNome)
nTam  := len(cNome)

do while !Empty(nTam)
   cInvertido += substr(cNome, nTam-- ,1)
enddo

@ 04,00 say cInvertido


inkey(0)