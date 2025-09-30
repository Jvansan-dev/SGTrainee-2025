//Joao Victor Teixeira Vansan
setmode (25,80)
set epoch to 1940
set date british
set scoreboard off
clear

// Variáveis para um único produto
cIdProduto := Space(8)
cDescricaoProduto := Space(30)
nQuantidadeProduto := 0
dDataCadastroProduto := CTOD('')
cProdutos := ""

do while .t.
    clear
    nMenu := 0
    
    // Menu Principal
    nLinha := 2
    @nLinha++,20 say "SISTEMA DE CONTROLE DE ESTOQUE"
    @nLinha++,02 say Replicate('=',79)
    @nLinha++,02 say "1 - CADASTRAR PRODUTOS"
    @nLinha++,02 say "2 - CONSULTAR PRODUTOS"
    @nLinha++,02 say "3 - DELETAR PRODUTOS"
    @nLinha++,02 say "4 - ENTRADA DE PRODUTOS"
    @nLinha++,02 say "5 - SAIDA DE PRODUTOS"
    @nLinha++,02 say "6 - LISTAR PRODUTOS CADASTRADOS"
    @nLinha++,02 say Replicate('=',79)
    @nLinha,02 say "Escolha uma opcao (1-6):"
    
    @nLinha,26 get nMenu picture "9" valid nMenu >= 1 .and. nMenu <= 6
    read
    
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
                cChar := SubStr(cId, nContador, 1)
                if cChar >= 'A' .and. cChar <= 'Z'
                    nLetras++
                elseif cChar >= '0' .and. cChar <= '9'
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
            
            // Verificar se já existe (comparação direta)
            if !Empty(cIdProduto) .and. AllTrim(cId) == AllTrim(cIdProduto)
                alert("Produto ja cadastrado!")
                loop
            endif
            
            lIdValido := .t.
            exit
        enddo
        
            if LastKey() == 27
            nOpcao := alert('Deseja sair do programa?', {'Sair', 'Continuar'})
             if nOpcao == 1
                exit
             else
                loop
             endif
            endif
        
        if lIdValido
            // Descrição
            do while .t.
                @05,13 get cDescricao picture "@!"
                read
                
            if LastKey() == 27
            nOpcao := alert('Deseja sair do programa?', {'Sair', 'Continuar'})
             if nOpcao == 1
                exit
             else
                loop
             endif
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
                // Salvar produto (já está em maiúsculo pelo picture "@!")
                cIdProduto := AllTrim(cId)
                cDescricaoProduto := AllTrim(cDescricao)
                nQuantidadeProduto := nQuantidade
                dDataCadastroProduto := dDataCadastro
                
                alert("Produto cadastrado com sucesso!")
            endif
        endif
        
        @10,02 say "Pressione qualquer tecla..."
        Inkey(0)
        
    elseif nMenu == 2
        // CONSULTAR PRODUTO
        clear
        cIdConsulta := Space(8)
        
        @02,20 say "CONSULTA DE PRODUTO"
        @04,02 say "Digite o ID do produto:"
        @04,25 get cIdConsulta picture "@!"
        read
        
        if LastKey() == 27
            loop
        endif
        
        if Empty(cIdProduto)
            alert("Nenhum produto cadastrado ainda!")
        elseif AllTrim(cIdConsulta) == AllTrim(cIdProduto)
            clear
            @02,20 say "DADOS DO PRODUTO"
            @04,02 say "ID............: " + cIdProduto
            @05,02 say "Descricao.....: " + cDescricaoProduto
            @06,02 say "Quantidade....: " + AllTrim(Str(nQuantidadeProduto))
            @07,02 say "Data Cadastro.: " + DToC(dDataCadastroProduto)
        else
            alert("Produto nao encontrado!")
        endif
        
        @08,02 say "Pressione qualquer tecla..."
        Inkey(0)
        
    elseif nMenu == 3
        // DELETAR PRODUTO
        clear
        cIdDelete := Space(8)
        
        @02,20 say "DELETAR PRODUTO"
        @04,02 say "Digite o ID do produto:"
        @04,25 get cIdDelete picture "@!"
        read
        
        if LastKey() == 27
            loop
        endif
        
        if Empty(cIdProduto)
            @06,02 say "Nenhum produto cadastrado!"
        elseif AllTrim(cIdDelete) == AllTrim(cIdProduto)
            cIdProduto := Space(8)
            cDescricaoProduto := Space(30)
            nQuantidadeProduto := 0
            dDataCadastroProduto := CTOD('')
            alert("Produto deletado com sucesso!")
        else
            alert("Produto nao encontrado!")
        endif
        
        @07,02 say "Pressione qualquer tecla..."
        Inkey(0)
        
    elseif nMenu == 4
        // ENTRADA DE PRODUTO
        clear
        cIdEntrada := Space(8)
        nQtdEntrada := 0
        dDataEntrada := date()
        
        @02,20 say "ENTRADA DE PRODUTO"
        @04,02 say "Digite o ID do produto:"
        @04,25 get cIdEntrada picture "@!"
        read
        
        if LastKey() == 27
            loop
        endif
        
        if Empty(cIdProduto)
            alert("Nenhum produto cadastrado!")
        elseif AllTrim(cIdEntrada) == AllTrim(cIdProduto)
            @05,02 say "Quantidade de entrada:"
            @05,25 get nQtdEntrada picture "9999" valid nQtdEntrada > 0
            read
            
            if LastKey() != 27
                @06,02 say "Data da entrada:"
                @06,20 get dDataEntrada
                read
                
                if LastKey() != 27
                    nQuantidadeProduto := nQuantidadeProduto + nQtdEntrada
                    @08,02 say "Nova quantidade: " + AllTrim(Str(nQuantidadeProduto))
                    alert("Entrada registrada com sucesso!")
                endif
            endif
        else
            alert("Produto nao encontrado!")
        endif
        
        @09,02 say "Pressione qualquer tecla..."
        Inkey(0)
        
    elseif nMenu == 5
        // SAIDA DE PRODUTO
        clear
        cIdSaida := Space(8)
        nQtdSaida := 0
        dDataSaida := date()
        
        @02,20 say "SAIDA DE PRODUTO"
        @04,02 say "Digite o ID do produto:"
        @04,25 get cIdSaida picture "@!"
        read
        
        if LastKey() == 27
            loop
        endif
        
        if Empty(cIdProduto)
            alert("Nenhum produto cadastrado!")
        elseif AllTrim(cIdSaida) == AllTrim(cIdProduto)
            @05,02 say "Quantidade de saida:"
            @05,25 get nQtdSaida picture "9999" valid nQtdSaida > 0
            read
            
            if LastKey() != 27
                if nQtdSaida > nQuantidadeProduto
                    @07,02 say "Erro: Estoque insuficiente!"
                    @08,02 say "Estoque atual: " + AllTrim(Str(nQuantidadeProduto))
                else
                    @06,02 say "Data da saida:"
                    @06,20 get dDataSaida
                    read
                    
                    if LastKey() != 27
                        nQuantidadeProduto := nQuantidadeProduto - nQtdSaida
                        @08,02 say "Saida registrada! Nova quantidade: " + AllTrim(Str(nQuantidadeProduto))
                    endif
                endif
            endif
        else
            alert("Produto nao encontrado!")
        endif
        
        @09,02 say "Pressione qualquer tecla..."
        Inkey(0)
        
     elseif nMenu == 6
        // LISTAR PRODUTOS CADASTRADOS
        clear
        @02,20 say "LISTA DE PRODUTOS CADASTRADOS"
        
        if Empty(cIdProduto)
            @06,02 say "Nenhum produto cadastrado no sistema."
        else
            @06,02 say "ID............: " + cIdProduto
            @07,02 say "Descricao.....: " + cDescricaoProduto
            @08,02 say "Quantidade....: " + AllTrim(Str(nQuantidadeProduto))
            @09,02 say "Data Cadastro.: " + DToC(dDataCadastroProduto)
            @10,02 say Replicate('-',50)
        endif
        
        @13,02 say "Pressione qualquer tecla para voltar..."
        Inkey(0)
    
    endif  // Fim do IF principal do menu
    
enddo

clear
alert("Programa finalizado!")
Inkey(0)