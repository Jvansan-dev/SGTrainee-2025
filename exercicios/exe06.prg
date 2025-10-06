clear

nNumeroA := 0
nNumeroB := 0
nNumeroC := 0

@02,01 say "Exercicio 06 - Media de tres numeros"
@01,00 say Replicate ("_",79)
@11,01 say Replicate ("_",79)

@04,01 say "Digite o primeiro numero:"
@05,01 say "Digite o segundo  numero:"
@06,01 say "Digite o terceiro numero:"
@12,01 say "Tecle <ESC> para sair..."

@04,28 get nNumeroA picture "@E 999.99"
@05,28 get nNumeroB picture "@E 999.99"
@06,28 get nNumeroC picture "@E 999.99"
read


@10,12 say (nNumeroA+nNumeroB+nNumeroC)/3 picture "@E 999.99"
@10,01 say "A media e:"
@11,01 say Replicate ("_",79)



