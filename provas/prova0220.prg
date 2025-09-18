//João Victor Teixeira Vansan
set epoch to 1940 //utilizar ano acima de 2000
set date british //data modo britanico
set scoreboard off //corrige borda
clear //limpa tela
setmode (25,80)//ajusta tela

cVendedor := Space(20)
dAtual := Date()
nAno := Year(dAtual)
nMes := Month(dAtual)
nDia := Day(dAtual)
nDiaSemana := DoW(dAtual)
cNome := Space(20)
nIdade := 0 
cSexo := Space(1) 
nPeso := 0
nAltura := 0
cFuma := Space(1)
cTipoPlano := Space(1)
cAbrangencia := Space(1)
nImc := 0
nValorBase1 := 300.00
nValorBase2 := 320.00

@00,00 to 02,79
@00,25 say "COTACAO DE PLANOS DE SAUDE"
@01,01 say "Vendedor:"
@01,45 say "Data da cotacao:"

nLinha := 1
@nLinha,11 get cVendedor  picture "@!" Valid !Empty(cVendedor)
@nLinha,70 get dAtual
read

nLinha := 4
@04,00 to 10,79
@nLinha++,30 say "DADOS PESSOAIS"
@nLinha,45 say "Idade:"
@nLinha++,01 say "Nome.........:"
@nLinha++,01 say "Sexo.........:  [M]asculino [F]eminino" 
@nLinha++,01 say "Peso (kg)....:"
@nLinha++,01 say "Altura (m)...:"
@nLinha++,01 say "Fumante?.....:  [S]im [N]ao"

nLinha := 5
@nLinha,16 get cNome       picture "@!" Valid !Empty(cNome)
@nLinha++,52 get nIdade    picture "@E 999"  
@nLinha++,16 get cSexo     picture "@!" Valid !Empty(cSexo)
@nLinha++,16 get nPeso     picture "@E 999.9"  
@nLinha++,16 get nAltura   picture "@E 9.99"  
@nLinha++,16 get cFuma     picture "@!" Valid !Empty(cFuma)
read

nLinha := 11
@11,00 to 14,79
@nLinha++,30 say "DADOS DO PLANO"
@nLinha++,01 say "Tipo de plano.....:   [E]nf [A]part [V]IP"
@nLinha++,01 say "Abrangencia.......:   [R]egional [N]acional"

nLinha := 12
@nLinha++,20 get cTipoPlano  picture "@!" Valid !Empty(cTipoPlano)
@nLinha,20 get cAbrangencia  picture "@!" Valid !Empty(cAbrangencia)
read

//CALCULO SAUDE TOTAL - Idade
nDescontoI := 0
nAcrescimoI := 0
if nIdade <= 30
    nDescontoI := -0.10
elseif nIdade >= 60
    nAcrescimoI := 0.20
endif

//CALCULO SAUDE TOTAL - Sexo
nDescontoS := 0
nAcrescimoS := 0
if cSexo == "M" 
    nAcrescimoS := 0.05
elseif cSexo == "F"
    nDescontoS := -0.05
endif

//CALCULO SAUDE TOTAL - IMC
nAcrescimoImc := 0
nImc := nPeso / (nAltura * nAltura)
if  nImc > 30
    nAcrescimoImc := 0.15
endif

//CALCULO SAUDE TOTAL - Fumante
nAcrescimoFuma := 0
if  cFuma == "S"
    nAcrescimoFuma := 0.20
endif


//CALCULO SAUDE TOTAL - Plano
nAcrescimoPlano := 0
if  cTipoPlano == "A"
    nAcrescimoPlano := 0.30
elseif TipoPlano == "V"
    nAcrescimoPlano := 0.50
endif

//CALCULO SAUDE TOTAL - Abrangencia
nAcrescimoAbrangencia := 0
if  cAbrangencia == "N"
    nAcrescimoAbrangencia := 0.15
endif

//CALCULO SAUDE TOTAL - Mes
nDescontoMes := 0
if  nMes = 5
    nDescontoMes := -0.10
endif

//-------------------------------------

//CALCULO VIDA PURA - Idade
nDescontoPuraI := 0
nAcrescimoPuraI := 0
if nIdade <= 25
    nDescontoPuraI := -0.15
elseif nIdade >= 65
    nAcrescimoPuraI := 0.25
endif

//CALCULO VIDA PURA - Sexo
nDescontoPuraS := 0
nAcrescimoPuraS := 0
if cSexo == "F" 
    nAcrescimoPuraS := 0.10
elseif cSexo == "M"
    nDescontoPuraS := -0.05
endif

//CALCULO VIDA PURA - Imc
nDescontoPuraImc := 0
nAcrescimoPuraImc := 0
nImc := nPeso / (nAltura * nAltura)
if  nImc > 25
    nAcrescimoPuraImc := 0.10
endif

//CALCULO VIDA PURA - Fumante
nAcrescimoPuraFuma := 0
if  cFuma == "S"
    nAcrescimoPuraFuma := 0.25
endif

//CALCULO VIDA PURA - Plano
nAcrescimoPuraPlano := 0
if  cTipoPlano == "A"
    nAcrescimoPuraPlano := 0.25
elseif TipoPlano == "V"
    nAcrescimoPuraPlano := 0.45
endif

//CALCULO VIDA PURA - Abrangencia
nAcrescimoPuraAbrangencia := 0
if  cAbrangencia == "N"
    nAcrescimoPuraAbrangencia := 0.15
endif

//CALCULO VIDA PURA - Mes
nDescontoPuraMes := 0
if  nMes = 10
    nDescontoPuraMes := -0.15
endif

//---------------------------------------

nValorBaseS1 := (nDescontoI+nAcrescimoI+nDescontoS+nAcrescimoS+nAcrescimoImc+nAcrescimoFuma+nAcrescimoPlano+nAcrescimoAbrangencia+nDescontoMes)
nTotal := (nValorBase1+nValorBaseS1)
cCor := "w/g"
nLinha := 16
@nLinha++,01 say "SAUDE TOTAL"    
@nLinha++,01 say Replicate("-",38) 
@nLinha,01 say "Mensal......:"  
@nLinha++,15 say nTotal         picture "@E 9999.99"
@nLinha,01 say "Trimestral..:"   
@nLinha++,15 say nTotal * 3     picture "@E 9999.99"
@nLinha,01 say "Anual.......:" 
@nLinha++,15 say nTotal * 12    picture "@E 9999.99"
@15,00 to 21,39 color cCor

nValorBaseS2 := (nDescontoPuraI+nAcrescimoPuraI+nDescontoPuraS+nAcrescimoPuraS+nAcrescimoPuraImc+nAcrescimoPuraFuma+nAcrescimoPuraPlano+nAcrescimoPuraAbrangencia+nDescontoPuraMes)
nTotal2 := (nValorBase2+nValorBaseS2)

cCor := "w/r"
nLinha := 16
@nLinha++,41 say "VIDA PURA"       
@nLinha++,41 say Replicate("-",38) 
@nLinha,41 say "Mensal......:"
@nLinha++,57 say nTotal2        picture "@E 9999.99"
@nLinha,41 say "Trimestral..:"
@nLinha++,57 say nTotal2 * 3    picture "@E 9999.99"
@nLinha,41 say "Anual.......:"
@nLinha++,57 say nTotal2  * 12  picture "@E 9999.99"
@15,40 to 21,79 color cCor



inkey(0)



