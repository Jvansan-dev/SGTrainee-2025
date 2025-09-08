Clear

nNumeroA := 0
nNumeroB := 0

@08,03 say "Exercicio 03 - Valor do produto"
@10,10 say "Digite o valor A:"
@11,10 say "Digite o valor B:"

@10,28 get nNumeroA picture "@E 999.99" valid nNumeroA >= 0
@11,28 get nNumeroB picture "@E 999.99"
read


@13,28 say nNumeroA * nNumeroB picture "@E 999.99"
@13,10 say "Valor do produto:"




