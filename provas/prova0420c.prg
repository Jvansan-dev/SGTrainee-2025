// Joao Victor Teixeira Vansan
setmode (25,80)
set message to 24 center //com center fica centralizado
set wrap on //faz com a navegacao das opcoes fique melhor
set epoch to 1940
set date british
set scoreboard off
clear


cProdutos := ""  
nTotalProdutos := 0

do while .t.
    clear
    nMenu := 0
    
    // Menu Principal
nLinha := 2
@nLinha++,25 say "SISTEMA DE CONTROLE DE ESTOQUE"
@nLinha++,30 say "<<Escolha uma opcao>>"
@nLinha++,30 prompt "CADASTRAR         " message "Cadastrar produto"
@nLinha++,30 prompt "CONSULTAR         " message "Consultar produto"
@nLinha++,30 prompt "DELETAR           " message "Deletar produto"
@nLinha++,30 prompt "ENTRADA DE PRODUTO" message "Dar entrada em um produto, para aumentar o estoque"
@nLinha++,30 prompt "SAIDA DE PRODUTO  " message "Dar saida em um produto, para diminuir o estoque"
@nLinha++,30 prompt "LISTAR PRODUTOS   " message "Listar produtos ja cadastrados"


menu to nMenu
    clear
    if LastKey() == 27
        nOpcao := alert('Deseja sair do programa?', {'Sair', 'Continuar'})
        if nOpcao == 1
            exit
        else
            loop
        endif
    endif
    
    if nMenu == 1
        // CADASTRAR PRODUTO
        clear
        cId := Space(8)
        cDescricao := Space(30)
        nQuantidade := 0
        dDataCadastro := date()
        lIdValido := .f.
        
        @02,20 say "CADASTRO DE PRODUTO"
        @04,02 say "ID (8 caracter - 4 letras + 4 numeros):"
        @05,02 say "Descricao:"
        @06,02 say "Quantidade inicial:"
        @07,02 say "Data de cadastro:"
        
        // Validação do ID
        do while .t.
            @04,41 get cId picture "@!" 
            read
            
            if LastKey() == 27
                nOpcao := alert('Deseja sair do programa?', {'Sair', 'Continuar'})
                if nOpcao == 1
                    exit
                else
                    loop
                endif
            endif
            
            if Empty(cId)
                alert("ID nao pode estar vazio!")
                loop
            endif
            
            if Len(AllTrim(cId)) != 8
                alert("ID deve ter 8 caracteres!")
                loop
            endif
            
            // Contar letras e números
            nLetras := 0
            nNumeros := 0
            lInvalido := .f.
            
            nContador := 1
            do while nContador <= 8
                cCarac := SubStr(cId, nContador, 1)
                if cCarac >= 'A' .and. cCarac <= 'Z'
                    nLetras++
                elseif cCarac >= '0' .and. cCarac <= '9'
                    nNumeros++
                else
                    lInvalido := .t.
                endif
                nContador++
            enddo
            
            if lInvalido
                alert("ID so pode ter letras e numeros!")
                loop
            endif
            
            if nLetras < 4
                alert("Precisa de pelo menos 4 letras!")
                loop
            endif
            
            if nNumeros < 4
                alert("Precisa de pelo menos 4 numeros!")
                loop
            endif
            
            // Verificar se já existe
            lJaExiste := .f.
            nBuscaPos := 1
            do while nBuscaPos <= Len(cProdutos)
                cIdExistente := SubStr(cProdutos, nBuscaPos, 8)  // 8 = tamanho do ID
                if AllTrim(cIdExistente) == AllTrim(cId)
                    lJaExiste := .t.
                    exit
                endif
                nBuscaPos += 50  // 50 = tamanho total do produto (8+30+4+8)
            enddo
            
            if lJaExiste
                alert("Produto ja cadastrado!")
                loop
            endif
            
            lIdValido := .t.
            exit
        enddo
        
        if lIdValido
            // Descrição
            do while .t.
                @05,13 get cDescricao picture "@!"
                read
                
                if LastKey() == 27
                    exit
                endif
                
                if Empty(cDescricao)
                    alert("Descricao nao pode estar vazia!")
                    loop
                endif
                exit
            enddo
            
            if LastKey() == 27
                loop
            endif
            
            // Quantidade
            do while .t.
                @06,22 get nQuantidade picture "9999"
                read
                
                if LastKey() == 27
                    exit
                endif
                
                if nQuantidade < 0
                    alert("Quantidade nao pode ser negativa!")
                    loop
                endif
                exit
            enddo
            
            if LastKey() == 27
                loop
            endif
            
            // Data
            @07,22 get dDataCadastro
            read
            
            if LastKey() != 27
                // Montar o produto: 8 chars ID + 30 chars Descrição + 4 chars Quantidade + 8 chars Data
                cProdutoNovo := PadR(AllTrim(cId), 8) + ;
                               PadR(AllTrim(cDescricao), 30) + ;
                               PadR(Str(nQuantidade, 4), 4) + ;
                               PadR(DToC(dDataCadastro), 8)
                
                // Adicionar ao final da string
                cProdutos += cProdutoNovo
                nTotalProdutos++
                
                alert("Produto cadastrado com sucesso! Total: " + AllTrim(Str(nTotalProdutos)))
            endif
        endif
        
        @10,02 say "Pressione qualquer tecla..."
        Inkey(0)
        
    elseif nMenu == 2
        // CONSULTAR PRODUTO
        clear
        cIdConsulta := Space(8)
        nPosEncontrado := 0
        
        @02,20 say "CONSULTA DE PRODUTO"
        @04,02 say "Digite o ID do produto:"
        @04,25 get cIdConsulta picture "@!"
        read
        
        if LastKey() == 27
            loop
        endif
        
        if nTotalProdutos == 0
            alert("Nenhum produto cadastrado ainda!")
        else
            // Buscar produto
            nPos := 1
            lEncontrou := .f.
            
            do while nPos <= Len(cProdutos)
                cIdAtual := SubStr(cProdutos, nPos, 8)  // Pega os primeiros 8 chars (ID)
                
                if AllTrim(cIdAtual) == AllTrim(cIdConsulta)
                    lEncontrou := .t.
                    nPosEncontrado := nPos
                    exit
                endif
                
                nPos += 50  // Pula para o próximo produto (50 chars cada)
            enddo
            
            if lEncontrou
                // Extrair dados do produto encontrado
                cDescricao := SubStr(cProdutos, nPosEncontrado + 8, 30)     // Descrição (pos 9-38)
                cQuantidade := SubStr(cProdutos, nPosEncontrado + 38, 4)    // Quantidade (pos 39-42)
                cData := SubStr(cProdutos, nPosEncontrado + 42, 8)          // Data (pos 43-50)
                
                clear
                @02,20 say "DADOS DO PRODUTO"
                @04,02 say "ID............: " + AllTrim(cIdAtual)
                @05,02 say "Descricao.....: " + AllTrim(cDescricao)
                @06,02 say "Quantidade....: " + AllTrim(cQuantidade)
                @07,02 say "Data Cadastro.: " + AllTrim(cData)
            else
                alert("Produto nao encontrado!")
            endif
        endif
        
        @08,02 say "Pressione qualquer tecla..."
        Inkey(0)
        
    elseif nMenu == 3
        // DELETAR PRODUTO
        clear
        cIdDelete := Space(8)
        nPosEncontrado := 0
        
        @02,20 say "DELETAR PRODUTO"
        @04,02 say "Digite o ID do produto:"
        @04,25 get cIdDelete picture "@!"
        read
        
        if LastKey() == 27
            loop
        endif
        
        if nTotalProdutos == 0
            alert("Nenhum produto cadastrado!")
        else
            // Buscar produto
            nPos := 1
            lEncontrou := .f.
            
            do while nPos <= Len(cProdutos)
                cIdAtual := SubStr(cProdutos, nPos, 8)
                
                if AllTrim(cIdAtual) == AllTrim(cIdDelete)
                    lEncontrou := .t.
                    nPosEncontrado := nPos
                    exit
                endif
                
                nPos += 50
            enddo
            
            if lEncontrou
                // Remover produto
                cParte1 := SubStr(cProdutos, 1, nPosEncontrado - 1)
                cParte2 := SubStr(cProdutos, nPosEncontrado + 50)
                cProdutos := cParte1 + cParte2
                nTotalProdutos--
                alert("Produto deletado com sucesso!")
            else
                alert("Produto nao encontrado!")
            endif
        endif
        
        @07,02 say "Pressione qualquer tecla..."
        Inkey(0)
        
    elseif nMenu == 4
        // ENTRADA DE PRODUTO
        clear
        cIdEntrada := Space(8)
        nQtdEntrada := 0
        dDataEntrada := date()
        nPosEncontrado := 0
        
        @02,20 say "ENTRADA DE PRODUTO"
        @04,02 say "Digite o ID do produto:"
        @04,25 get cIdEntrada picture "@!"
        read
        
        if LastKey() == 27
            loop
        endif
        
        if nTotalProdutos == 0
            alert("Nenhum produto cadastrado!")
        else
            // Buscar produto
            nPos := 1
            lEncontrou := .f.
            
            do while nPos <= Len(cProdutos)
                cIdAtual := SubStr(cProdutos, nPos, 8)
                
                if AllTrim(cIdAtual) == AllTrim(cIdEntrada)
                    lEncontrou := .t.
                    nPosEncontrado := nPos
                    exit
                endif
                
                nPos += 50
            enddo
            
            if lEncontrou
                @05,02 say "Quantidade de entrada:"
                @05,25 get nQtdEntrada picture "9999" valid nQtdEntrada > 0
                read
                
                if LastKey() != 27
                    // Recuperar quantidade atual
                    cQuantidadeAtual := SubStr(cProdutos, nPosEncontrado + 38, 4)
                    nQuantidadeAtual := Val(AllTrim(cQuantidadeAtual))
                    
                    // Calcular nova quantidade
                    nNovaQuantidade := nQuantidadeAtual + nQtdEntrada
                    
                    // Atualizar a string do produto
                    cParte1 := SubStr(cProdutos, 1, nPosEncontrado + 37)  // Até antes da quantidade
                    cParte2 := SubStr(cProdutos, nPosEncontrado + 42)     // Depois da quantidade
                    cNovaQuantidade := PadR(Str(nNovaQuantidade, 4), 4)
                    
                    cProdutos := cParte1 + cNovaQuantidade + cParte2
                    
                    alert("Entrada registrada com sucesso! Nova quantidade: " + AllTrim(Str(nNovaQuantidade)))
                endif
            else
                alert("Produto nao encontrado!")
            endif
        endif
        
        @09,02 say "Pressione qualquer tecla..."
        Inkey(0)
        
    elseif nMenu == 5
        // SAIDA DE PRODUTO
        clear
        cIdSaida := Space(8)
        nQtdSaida := 0
        dDataSaida := date()
        nPosEncontrado := 0
        
        @02,20 say "SAIDA DE PRODUTO"
        @04,02 say "Digite o ID do produto:"
        @04,25 get cIdSaida picture "@!"
        read
        
        if LastKey() == 27
            loop
        endif
        
        if nTotalProdutos == 0
            alert("Nenhum produto cadastrado!")
        else
            // Buscar produto
            nPos := 1
            lEncontrou := .f.
            
            do while nPos <= Len(cProdutos)
                cIdAtual := SubStr(cProdutos, nPos, 8)
                
                if AllTrim(cIdAtual) == AllTrim(cIdSaida)
                    lEncontrou := .t.
                    nPosEncontrado := nPos
                    exit
                endif
                
                nPos += 50
            enddo
            
            if lEncontrou
                @05,02 say "Quantidade de saida:"
                @05,25 get nQtdSaida picture "9999" valid nQtdSaida > 0
                read
                
                if LastKey() != 27
                    // Recuperar quantidade atual
                    cQuantidadeAtual := SubStr(cProdutos, nPosEncontrado + 38, 4)
                    nQuantidadeAtual := Val(AllTrim(cQuantidadeAtual))
                    
                    if nQtdSaida > nQuantidadeAtual
                        alert("Erro: Estoque insuficiente! Estoque atual: " + AllTrim(Str(nQuantidadeAtual)))
                    else
                        // Calcular nova quantidade
                        nNovaQuantidade := nQuantidadeAtual - nQtdSaida
                        
                        // Atualizar a string do produto
                        cParte1 := SubStr(cProdutos, 1, nPosEncontrado + 37)
                        cParte2 := SubStr(cProdutos, nPosEncontrado + 42)
                        cNovaQuantidade := PadR(Str(nNovaQuantidade, 4), 4)
                        
                        cProdutos := cParte1 + cNovaQuantidade + cParte2
                        
                        alert("Saida registrada! Nova quantidade: " + AllTrim(Str(nNovaQuantidade)))
                    endif
                endif
            else
                alert("Produto nao encontrado!")
            endif
        endif
        
        @09,02 say "Pressione qualquer tecla..."
        Inkey(0)
        
    elseif nMenu == 6
        // LISTAR PRODUTOS CADASTRADOS
        clear
        @02,20 say "LISTA DE PRODUTOS CADASTRADOS"
        
        if nTotalProdutos == 0
            @06,02 say "Nenhum produto cadastrado no sistema."
        else
            nLinha := 4
            nPos := 1
            nContador := 0
            
            @nLinha++,02 say "ID         DESCRICAO                     QUANT.  DATA     "
            @nLinha++,02 say Replicate('-', 60)
            
            do while nPos <= Len(cProdutos) .and. nLinha < 22
                cId := AllTrim(SubStr(cProdutos, nPos, 8))
                cDescricao := AllTrim(SubStr(cProdutos, nPos + 8, 30))
                cQuantidade := AllTrim(SubStr(cProdutos, nPos + 38, 4))
                cData := AllTrim(SubStr(cProdutos, nPos + 42, 8))
                
                @nLinha,02 say cId
                @nLinha,12 say cDescricao
                @nLinha,43 say cQuantidade
                @nLinha++,51 say cData

                nPos += 50
                nContador++
            enddo
            
            @nLinha++,02 say Replicate('-', 60)
            @nLinha++,02 say "Total de produtos: " + AllTrim(Str(nTotalProdutos))
        endif
        
        @23,02 say "Pressione qualquer tecla para voltar..."
        Inkey(0)
    
    endif  // Fim do IF principal do menu
    
enddo

clear
alert("Programa finalizado!")
Inkey(0)