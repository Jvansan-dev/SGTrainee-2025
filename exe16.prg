set epoch to 1940 //utilizar ano acima de 2000
set date british //data modo britanico
set scoreboard off //corrige borda
clear //limpa tela
setmode (25,80)//ajusta tela

cNome := Space(10)
nRepeticao := 0
nInteracoes := 1
nLinha := 0
nColuna := 0


@01,01 say "Digite seu nome...:"
@02,01 say "Digite a repeticao:"

@01,18 get cNome                    valid !Empty(cNome)
@02,20 get nRepeticao picture "999" valid !Empty(nRepeticao)
read

clear

do while nInteracoes <= nRepeticao

  if nLinha >= 24
    nLinha := 0
    nColuna += 20
  endif

  if nColuna >= 70
    inkey(0)
    Clear
    nLinha := 0
    nColuna := 1
  endif

  @nLinha++,nColuna say AllTrim(Str(nInteracoes++)) + "- " + cNome
enddo

inkey(0)