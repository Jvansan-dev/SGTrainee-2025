set epoch to 1940 //utilizar ano acima de 2000
set date british //data modo britanico
set scoreboard off //corrige borda
clear //limpa tela
setmode (25,80)//ajusta tela

nCodigo := 0
cClass := ""
cCor := ""

@01,01 say "CODIGO    CLASSIFICACAO"
@02,01 say Replicate("-",40)
@03,01 say "1         Alimento nao-perecivel"
@03,01 say "2 a 4     Alimento perecivel"
@04,01 say "5 e 6     Vestuario"
@05,01 say "7         Higiene pessoal"
@06,01 say "8 a 15    Limpeza e utensilios domesticos"
Inkey(2)
@08,01 say "Digite o codigo:"

@08,18 get nCodigo picture "99" valid nCodigo >= 0
read

if nCodigo = 1
    cClass := "Alimento nao-perecivel"
elseif nCodigo >= 2 .and. nCodigo <= 4
    cClass := "Alimento perecivel"
    cCor := "g/n"
elseif nCodigo >= 5 .and. nCodigo <= 6 
    cClass := "Vestuario"
    cCor := "g/n"
elseif nCodigo = 7
    cClass := "Higiene pessoal"
    cCor := "g/n"
elseif nCodigo >=8 .and. nCodigo <=15
    cClass := "Limpeza e utensilios domesticos"
    cCor := "g/n"
else 
    cClass := "Codigo invalido"
    cCor := "r/n"
endif

@10,01 say cClass color cCor
inkey(0)


