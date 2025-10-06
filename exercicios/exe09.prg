Clear
cLetra := Space (1)
dData := DATE()
nNumeroInteiro := 0
nNumeroDecimal := 0
cTexto := Space (20)

@01,01 say "Exercicio 09 - Letra, Data, Inteiro, Decimal, String"
@20,01 say "Tecle <ESC> para sair..."
@03,01 say "Digite uma letra:"
@04,01 say "Digite uma data:"
@05,01 say "Digite um numero inteiro:"
@06,01 say "Digite um numero decimal:"
@07,01 say "Digite um texto:"

@03,27 get cLetra         picture "@!"  valid !Empty(cLetra)
@04,27 get dData          picture "@D"  valid dData > CTOD("01/01/1900")
@05,27 get nNumeroInteiro picture "@E 9999"    
@06,27 get nNumeroDecimal picture "@E 9,999.99"
@07,27 get cTexto         picture "@!"  valid !Empty(cTexto)
read 

@09,01 say "Letra:" 
@10,01 say "Data:"
@11,01 say "Inteiro:"
@12,01 say "Decimal:"
@13,01 say "Texto:"
@09,10 say cLetra
@10,10 say Dtoc(dData)
@11,10 say nNumeroInteiro picture "@E 9999" 
@12,10 say nNumeroDecimal picture "@E 9,999.99"
@13,10 say cTexto
@20,01 say "Tecle <ESC> para sair..."
