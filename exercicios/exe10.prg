set epoch to 1940 //utilizar ano acima de 2000
set date british //data modo britanico
set scoreboard off //corrige borda
clear //limpa tela
setmode (25,80)//ajusta tela

dAtual := DATE()
nIdade := 0

@00,38 say dAtual 
@00,03 say "Exercicio 10 - Idade do Usuario - "
@01,03 say "Joao Victor Vansan"
@01,24 say "jv.vansan@gmail.com"
@01,46 say "(44)99964-0402"
//cabecalho

@05,01 say "Digite sua idade:"

@05,19 get nIdade picture "999"  valid nIdade >= 0
read

if nIdade >21
    @06,01 say "Voce e tem mais que 21 anos!" 
else
    @06,01 say "Voce tem menos que 21 anos!"   
endif
    

