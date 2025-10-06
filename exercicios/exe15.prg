set epoch to 1940 //utilizar ano acima de 2000
set date british //data modo britanico
set scoreboard off //corrige borda
clear //limpa tela
setmode (25,80)//ajusta tela

cNome := Space(10)
nInteracoes := 1

@01,01 say "Digite seu nome:"

@01,18 get cNome
read

nLinha := 2
do while nInteracoes <= 10
    @nLinha++,02 say AllTrim(Str(nInteracoes++)) + "- " + cNome
enddo