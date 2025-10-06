set epoch to 1940 //utilizar ano acima de 2000
set date british //data modo britanico
set scoreboard off //corrige borda
clear //limpa tela
setmode (25,80)//ajusta tela

dAtual := DATE()
nIdade := 0
cNome := Space(15)
cCategoria := ""
cCor := ""

@00,40 say dAtual 
@00,03 say "Exercicio 11 - Variacoes na idade - " 
@01,03 say "Joao Victor Vansan"
@01,24 say "jv.vansan@gmail.com"
@01,46 say "(44)99964-0402"
//cabecalho

@05,01 say "Digite seu nome:"
@06,01 say "Digite sua idade:"
@04,00 to 10,35 double

@05,19 get cNome  picture "@!"   valid !Empty(cNome)   
@06,19 get nIdade picture "999"  valid nIdade >= 0
read

if nIdade >= 5 .and. nIdade <= 7 //entre 5 e 7
    cCategoria := "Sua categoria e: INFANTIL A"
    cCor := "g/n"
elseif nIdade >= 8 .and.  nIdade <= 10 //entre 8 e 10
    cCategoria := "Sua categoria e: INFANTIL B"
    cCor := "g/n"
elseif nIdade >= 11 .and. nIdade <= 13 //entre 11 e 13
    cCategoria := "Sua categoria e: JUVENIL A"
    cCor := "g/n"
elseif nIdade >= 14 .and. nIdade <= 17 //entre 5 e 7
    cCategoria := "Sua categoria e: JUVENIL B"
    cCor := "g/n"
elseif nIdade >= 18 //entre 5 e 7
    cCategoria := "Sua categoria e: SENIOR"
    cCor := "g/n"
elseif nIdade >= 1 .and.  nIdade <= 4 //entre 5 e 7
    cCategoria := "SEM CATEGORIA" 
    cCor := "r/n"
endif

@09,01 say cCategoria color cCor
Inkey(0) // Aguarda ate o usuário pressionar uma tecla


    

