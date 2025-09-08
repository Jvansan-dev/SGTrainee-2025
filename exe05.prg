Clear

nNumeroA := 0
nNumeroB := 0

@02,01 say "Exercicio 05 - Trocando Variaveis"
@01,00 say Replicate ("_",79)
@10,00 say Replicate ("_",79)
@04,10 say "antigo numero de A:"
@05,10 say "antigo numero de B:"
@11,01 say "Tecle <ESC> para sair..."

@04,30 get nNumeroA picture "@E 999.99"
@05,30 get nNumeroB picture "@E 999.99"
read

nTroca := nNumeroA
nNumeroA := nNumeroB
nNumeroB := nTroca

@07,10 say "O novo numero de A:" 
@07,30 say nNumeroA picture "@E 999.99"
@08,10 say "O novo numero de B:" 
@08,30 say nNumeroB picture "@E 999.99"
@10,00 say Replicate ("_",79)