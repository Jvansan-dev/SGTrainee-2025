set epoch to 1940 //utilizar ano acima de 2000
set date british //data modo britanico
set scoreboard off //corrige borda
clear //limpa tela
setmode (25,80)//ajusta tela

cTexto := "SGTrainee - Harbour"
nTamanho := Len(cTexto) //Len pra texto
cTexto := SubStr(cTexto,13)

@01,01 say cTexto
Inkey(0)



