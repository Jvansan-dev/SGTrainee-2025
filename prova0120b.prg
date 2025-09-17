//João Victor Teixeira Vansan
set epoch to 1940 //utilizar ano acima de 2000
set date british //data modo britanico
set scoreboard off //corrige borda
clear //limpa tela
setmode (25,80)//ajusta tela

cNome := Space(15)
cCurso := Space(15)
cCorA := ""
cCorB := ""
cCorC := ""
nSerie := 0
nMensalidade := 0
nMedia := 0
nFaltaTotal := 0
dDataNasc := CToD("")
cResultadoA := ""
cResultadoB := ""
cResultadoC := ""
cDiciplinaA := Space(12)
cDiciplinaB := Space(12)
cDiciplinaC := Space(12)
cFinalA := ""
cFinalB := ""
cFinalC := ""



nNotaA1 := 0
nNotaA2 := 0
nNotaA3 := 0
nNotaA4 := 0
nNotaB1 := 0
nNotaB2 := 0
nNotaB3 := 0
nNotaB4 := 0
nNotaC1 := 0
nNotaC2 := 0
nNotaC3 := 0
nNotaC4 := 0

nFaltaA1 := 0
nFaltaA2 := 0
nFaltaA3 := 0
nFaltaA4 := 0
nFaltaB1 := 0
nFaltaB2 := 0
nFaltaB3 := 0
nFaltaB4 := 0
nFaltaC1 := 0
nFaltaC2 := 0
nFaltaC3 := 0
nFaltaC4 := 0

@01,15 say "Colegio Esperanca"
@02,01 say "Nome..............:"
@03,01 say "Data de nascimento:"
@04,01 say "Curso.............:"
@05,01 say "Serie.............:"
@05,23 say "(1 a 8)             "
@06,01 say "Mensalidade.......:"

@02,21 get cNome        picture "@!"   valid !Empty(cNome)  
@03,21 get dDataNasc
@04,21 get cCurso       picture "@!"   valid !Empty(cCurso)
@05,21 get nSerie       picture "9" valid nSerie >= 1 .and. nSerie <= 8
@06,21 get nMensalidade picture "999.99"
read

if nSerie <= 4
   nMedia := 60
elseif nSerie > 4 .and. nSerie < 9
    nMedia := 70
endif

if nSerie <= 3
    nFaltaTotal := 6
elseif nSerie > 3 .and. nSerie <= 8
    nFaltaTotal := 8
endif

@08,53 say nFaltaTotal
@08,47 say nMedia

@08,01 say "| DISCIPLINA |  1B   |  2B   |  3B   |  4B   | MEDIA"
@09,01 say "|            | N - F | N - F | N - F | N - F | N - F |"
@10,01 say "|            |   -   |   -   |   -   |   -   |   -   |"
@11,01 say "|            |   -   |   -   |   -   |   -   |   -   |"
@12,01 say "|            |   -   |   -   |   -   |   -   |   -   |"

@10,02 get cDiciplinaA //1B
@10,15 get nNotaA1         picture "999" valid nNotaA1 >= 0 .and.  nNotaA1 <= 100
@10,19 get nFaltaA1        picture "999" valid nFaltaA1 >= 0 .and. nFaltaA1 <= 364
@10,23 get nNotaA2         picture "999" valid nNotaA2 >= 0 .and.  nNotaA2 <= 100
@10,27 get nFaltaA2        picture "999" valid nFaltaA2 >= 0 .and. nFaltaA2 <= 364
@10,31 get nNotaA3         picture "999" valid nNotaA3 >= 0 .and.  nNotaA3 <= 100
@10,35 get nFaltaA3        picture "999" valid nFaltaA3 >= 0 .and. nFaltaA3 <= 364
@10,39 get nNotaA4         picture "999" valid nNotaA4 >= 0 .and.  nNotaA4 <= 100
@10,43 get nFaltaA4        picture "999" valid nFaltaA4 >= 0 .and. nFaltaA4 <= 364
@11,02 get cDiciplinaB //2B
@11,15 get nNotaB1         picture "999" valid nNotaB1 >= 0 .and.  nNotaB1 <= 100
@11,19 get nFaltaB1        picture "999" valid nFaltaB1 >= 0 .and. nFaltaB1 <= 364
@11,23 get nNotaB2         picture "999" valid nNotaB2 >= 0 .and.  nNotaB2 <= 100
@11,27 get nFaltaB2        picture "999" valid nFaltaB2 >= 0 .and. nFaltaB2 <= 364
@11,31 get nNotaB3         picture "999" valid nNotaB3 >= 0 .and.  nNotaB3 <= 100
@11,35 get nFaltaB3        picture "999" valid nFaltaB3 >= 0 .and. nFaltaB3 <= 364
@11,39 get nNotaB4         picture "999" valid nNotaB4 >= 0 .and.  nNotaB4 <= 100
@11,43 get nFaltaB4        picture "999" valid nFaltaB4 >= 0 .and. nFaltaB4 <= 364
@12,02 get cDiciplinaC//3B
@12,15 get nNotaC1         picture "999" valid nNotaC1 >= 0 .and.  nNotaC1 <= 100
@12,19 get nFaltaC1        picture "999" valid nFaltaC1 >= 0 .and. nFaltaC1 <= 364
@12,23 get nNotaC2         picture "999" valid nNotaC2 >= 0 .and.  nNotaC2 <= 100
@12,27 get nFaltaC2        picture "999" valid nFaltaC2 >= 0 .and. nFaltaC2 <= 364
@12,31 get nNotaC3         picture "999" valid nNotaC3 >= 0 .and.  nNotaC3 <= 100
@12,35 get nFaltaC3        picture "999" valid nFaltaC3 >= 0 .and. nFaltaC3 <= 364
@12,39 get nNotaC4         picture "999" valid nNotaC4 >= 0 .and.  nNotaC4 <= 100
@12,43 get nFaltaC4        picture "999" valid nFaltaC4 >= 0 .and. nFaltaC4 <= 364
read

nResultadoA := (nNotaA1+nNotaA2+nNotaA3+nNotaA4) /4
nDpA := (nFaltaA1+nFaltaA2+nFaltaA3+nFaltaA4)
nResultadoB := (nNotaB1+nNotaB2+nNotaB3+nNotaB4) /4
nDpB := (nFaltaB1+nFaltaB2+nFaltaB3+nFaltaB4)
nResultadoC := (nNotaC1+nNotaC2+nNotaC3+nNotaC4) /4
nDpC := (nFaltaC1+nFaltaC2+nFaltaC3+nFaltaC4)


if nResultadoA >= nMedia 
    cCorA := "g/n"
else
    cCorA := "r/n"
endif

if nResultadoB >= nMedia 
    cCorB := "g/n"
else
    cCorB :="r/n"
endif

if nResultadoC >= nMedia 
    cCorC := "g/n"
else
    cCorC :="r/n"
endif

@10,47 say nResultadoA color cCorA           picture "999"  
@10,51 say nDpA                              picture "999" 
@11,47 say nResultadoB color cCorB           picture "999"  
@11,51 say nDpB                              picture "999" 
@12,47 say nResultadoC color cCorC           picture "999"  
@12,51 say nDpC                              picture "999" 

nResultadoA := (nNotaA1+nNotaA2+nNotaA3+nNotaA4) /4
nResultadoB := (nNotaB1+nNotaB2+nNotaB3+nNotaB4) /4
nResultadoC := (nNotaC1+nNotaC2+nNotaB3+nNotaC4) /4
nDpA := (nFaltaA1+nFaltaA2+nFaltaA3+nFaltaA4)
nDpB := (nFaltaB1+nFaltaB2+nFaltaB3+nFaltaB4)
nDpC := (nFaltaC1+nFaltaC2+nFaltaC3+nFaltaC4)

if nResultadoA >= nMedia .and. nDpA <= nFaltaTotal
    cResultadoA := "Aluno aprovado na materia.:"
else
    cResultadoA := "Aluno reprovado na materia:"
endif

if nResultadoB >= nMedia .and. nDpB <= nFaltaTotal
    cResultadoB := "Aluno aprovado na materia.:"
else
    cResultadoB := "Aluno reprovado na materia:"
endif

if nResultadoC >= nMedia .and. nDpC <= nFaltaTotal
    cResultadoC := "Aluno aprovado na materia.:"
else
    cResultadoC := "Aluno reprovado na materia:"
endif

@15,02 say cResultadoA+cDiciplinaA
@16,02 say cResultadoB+cDiciplinaB
@17,02 say cResultadoC+cDiciplinaC

inkey(0)

if cResultadoA == "Aluno reprovado na materia:"
    cFinalA := "Aluno em dp na materia:" + AllTrim(cDiciplinaA)
endif

if cResultadoB == "Aluno reprovado na materia:"
    cFinalB := "Aluno em dp na materia:" + AllTrim(cDiciplinaB)
endif

if cResultadoC == "Aluno reprovado na materia:"
    cFinalC := "Aluno em dp na materia:" + AllTrim(cDiciplinaC)    
endif

@20,02 say cFinalA
@21,02 say cFinalB
@22,02 say cFinalC

inkey(0)




