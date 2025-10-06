clear

nNumeroA := 0
nNumeroB := 0

@02,01 say "Exercicio 07 - Soma, Multiplicacao, Divisao e Subtracao"
@04,02 say "Digite o primeiro valor:"
@05,02 say "Digite o segundo  valor:"
@01,00 say Replicate ("_",79)
@14,01 say Replicate ("_",79)
@15,01 say "Tecle <ESC> para sair..."

@04,28 get nNumeroA picture "@E 999.99" valid nNumeroA >= 0 
@05,28 get nNumeroB picture "@E 999.99" valid nNumeroB >= 0
read

@07,02 say "A soma e:"
@07,35 say nNumeroA + nNumeroB picture "@E 9999.99"
@09,02 say "A multiplicacao e:"
@09,35 say nNumeroA * nNumeroB picture "@E 9999.99"
@11,02 say "A divisao e:"
@11,35 say nNumeroA / nNumeroB picture "@E 9999.99"
@13,02 say "A subtracao e:"
@13,35 say nNumeroA - nNumeroB picture "@E 9999.99"
@14,01 say Replicate ("_",79)
