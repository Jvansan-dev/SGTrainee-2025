set epoch to 1940 //utilizar ano acima de 2000
set date british //data modo britanico
set scoreboard off //corrige borda
clear //limpa tela
setmode (25,80)//ajusta tela

nNumeroA := 0
nNumeroB := 0
nNumeroC := 0
cResultado := ""

@01,00 to 08,32
@02,01 say "Digite o primeiro numero:"
@03,01 say "Digite o segundo numero.:"
@04,01 say "Digite o terceiro numero:"

@02,27 get nNumeroA picture "999" valid nNumeroA >=0 
@03,27 get nNumeroB picture "999" valid nNumeroB >=0
@04,27 get nNumeroC picture "999" valid nNumeroC >=0
read

nMaior := nNumeroA
if nMaior < nNumeroA
    nMaior := nNumeroB
    cResultado := "O primeiro numero e o maior"
endif
if nMaior < nNumeroC
    nMaior < nNumeroC
endif
    cResultado := "O segundo numero e o maior"
elseif nNumeroC > nNumeroA .and. nNumeroC > nNumeroB
    cResultado := "O terceiro numero e o maior"
endif 

@06,01 say cResultado
inkey(0)