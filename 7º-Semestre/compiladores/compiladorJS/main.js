/*
Integrantes:
Rafael Dantas Boeira - 2122082004
João Víctor Alves Menezes - 2122082017
*/

const fs = require('fs');

class AnalisadorLexico {
    constructor() {
        this.LINHA_REGEX = /^\d+/;
        this.PALAVRA_REGEX = /\b(rem|input|let|if|goto|print|end)\b/;
        this.IDENTIFICADOR_REGEX = /[a-zA-ZçãõâêîôûáéíóúàèìòùÇÃÕÂÊÎÔÛÁÉÍÓÚÀÈÌÒÙ][a-zA-Z0-9çãõâêîôûáéíóúàèìòùÇÃÕÂÊÎÔÛÁÉÍÓÚÀÈÌÒÙ]*/;
        this.NUMERO_REGEX = /^\d+/;
        this.OPERADOR_REGEX = /^=/;  // Operador de atribuição
        this.OPERADOR_MATEMATICO_REGEX = /^[+\-*/%]/;  // Operadores matemáticos
        this.ESPACO_REGEX = /^\s+/;
    }

    analise(linha) {
        let tokens = [];
        let isFirstToken = true; // Controla se estamos no início da linha
        let esperaAtribuicao = false; // Controla quando esperar o operador de atribuição "="

        while (linha.length > 0) {
            if (isFirstToken && this.LINHA_REGEX.test(linha)) {
                // O primeiro número deve ser tratado como número de linha
                tokens.push({ tipo: 'NUMERO_LINHA', value: linha.match(this.LINHA_REGEX)[0] });
                linha = linha.replace(this.LINHA_REGEX, '');
                isFirstToken = false;
            } else if (this.PALAVRA_REGEX.test(linha)) {
                let palavra = linha.match(this.PALAVRA_REGEX)[0];
                tokens.push({ tipo: 'PALAVRA', value: palavra });

                // Se for um comentário (rem), ignorar o restante da linha
                if (palavra === 'rem') {
                    return tokens;  // Ignora o que vem depois de 'rem'
                }

                // Se for "let", espera o próximo token ser um identificador
                if (palavra === 'let') {
                    esperaAtribuicao = true;
                }

                linha = linha.replace(this.PALAVRA_REGEX, '');
            } else if (this.OPERADOR_REGEX.test(linha)) {
                let operador = linha.match(this.OPERADOR_REGEX)[0];
                tokens.push({ tipo: 'OPERADOR', value: operador });
                linha = linha.replace(this.OPERADOR_REGEX, '');
            } else if (this.OPERADOR_MATEMATICO_REGEX.test(linha)) {
                let operadorMatematico = linha.match(this.OPERADOR_MATEMATICO_REGEX)[0];
                tokens.push({ tipo: 'OPERADOR_MATEMATICO', value: operadorMatematico });
                linha = linha.replace(this.OPERADOR_MATEMATICO_REGEX, '');
            } else if (this.NUMERO_REGEX.test(linha)) {
                let numero = linha.match(this.NUMERO_REGEX)[0];
                tokens.push({ tipo: 'NUMERO', value: numero });
                linha = linha.replace(this.NUMERO_REGEX, '');
            } else if (this.IDENTIFICADOR_REGEX.test(linha)) {
                let identificador = linha.match(this.IDENTIFICADOR_REGEX)[0];
                tokens.push({ tipo: 'IDENTIFICADOR', value: identificador });
                linha = linha.replace(this.IDENTIFICADOR_REGEX, '');

                // Se estamos esperando um operador de atribuição após o identificador da variável
                if (esperaAtribuicao) {
                    if (tokens.length > 0 && tokens[tokens.length - 1].tipo === 'IDENTIFICADOR') {
                        esperaAtribuicao = false; // O identificador foi encontrado, agora esperamos o "="
                    }
                }
            } else if (this.ESPACO_REGEX.test(linha)) {
                linha = linha.replace(this.ESPACO_REGEX, ''); // Ignora os espaços
            } else {
                throw new Error(`Token não reconhecido na linha: ${linha}`);
            }
        }

        return tokens;
    }
}

class AnalisadorSintatico {
    constructor(linhasValidas) {
        this.stamentsValidos = ["REM", "INPUT", "LET", "IF", "GOTO", "PRINT", "END"];
        this.linhasValidas = linhasValidas;
    }

    analise(tokens) {
        let index = 0;
        const linhaNumero = tokens[index].value;
        index++;

        if (tokens[index].tipo === "PALAVRA" && this.stamentsValidos.includes(tokens[index].value.toUpperCase())) {
            return this._analisaStatement(tokens, index, linhaNumero);
        } else {
            throw new Error("Erro sintático: instrução inválida ou palavra-chave desconhecida.");
        }
    }

    _analisaStatement(tokens, index, linhaNumero) {
        const statement = tokens[index].value.toUpperCase();
        if (statement === "LET") {
            return this._analisaLet(tokens, index + 1, linhaNumero);
        } else if (statement === "IF") {
            return this._analisaIf(tokens, index + 1, linhaNumero);
        } else if (statement === "GOTO") {
            return this._analisaGoto(tokens, index + 1, linhaNumero);
        } else if (statement === "PRINT") {
            return this._analisaPrint(tokens, index + 1, linhaNumero);
        } else if (statement === "INPUT") {
            return this._analisaInput(tokens, index + 1, linhaNumero);
        } else if (statement === "REM" || statement === "END") {
            return { tipo: statement, linhaNumero };
        } else {
            throw new Error(`Erro sintático: Instrução "${statement}" não reconhecida.`);
        }
    }

    _analisaLet(tokens, index, linhaNumero) {
        console.log("Tokens recebidos para LET:", tokens);

        // Verifica se o identificador (variável) está presente
        if (tokens[index].tipo === "IDENTIFICADOR") {
            let variable = tokens[index].value; // A variável que está sendo atribuída
            index++;

            // Verifica se o próximo token é o operador de atribuição "="
            if (tokens[index].tipo === "OPERADOR" && tokens[index].value === "=") {
                index++;

                // Inicia o processamento da expressão após o operador "="
                let expressao = [];
                while (index < tokens.length) {
                    let currentToken = tokens[index];

                    // Verifica se o token é um identificador ou número
                    if (currentToken.tipo === "IDENTIFICADOR" || currentToken.tipo === "NUMERO") {
                        expressao.push(currentToken);
                    }
                    // Verifica se o token é um operador matemático
                    else if (currentToken.tipo === "OPERADOR_MATEMATICO") {
                        // Certifica-se de que a expressão tenha um operando antes do operador
                        if (expressao.length === 0 || (expressao[expressao.length - 1].tipo === "OPERADOR_MATEMATICO")) {
                            throw new Error("Erro sintático: Operador sem operandos válidos.");
                        }
                        expressao.push(currentToken);
                    }
                    // Se houver qualquer outro tipo de token, lança erro
                    else {
                        throw new Error("Erro sintático: Token inesperado na expressão LET.");
                    }

                    index++;
                }

                // Certifica-se de que a expressão termine com um operando
                if (expressao.length > 0 && expressao[expressao.length - 1].tipo === "OPERADOR_MATEMATICO") {
                    throw new Error("Erro sintático: Expressão não pode terminar com um operador.");
                }

                // Retorna o AST da instrução LET com a variável e a expressão
                return { tipo: "LET", identificador: variable, expressao, linhaNumero };
            } else {
                throw new Error("Erro sintático: Faltando operador '=' após a variável.");
            }
        } else {
            throw new Error("Erro sintático: Esperado identificador após LET.");
        }
    }

    _analisaIf(tokens, index, linhaNumero) {
        const thenIndex = tokens.findIndex((token, i) => token.value.toUpperCase() === "THEN" && i > index);
        if (thenIndex === -1) {
            throw new Error("Erro sintático: falta a palavra-chave THEN na instrução IF.");
        }
        const gotoLine = tokens[thenIndex + 1].value;
        if (!this.linhasValidas.includes(gotoLine)) {
            throw new Error(`Erro sintático: linha de destino ${gotoLine} não existe.`);
        }
        return { tipo: "IF", condition: tokens.slice(index, thenIndex), gotoLine, linhaNumero };
    }

    _analisaGoto(tokens, index, linhaNumero) {
        const gotoLine = tokens[index].value;
        if (!this.linhasValidas.includes(gotoLine)) {
            throw new Error(`Erro sintático: linha de destino ${gotoLine} não existe.`);
        }
        return { tipo: "GOTO", gotoLine, linhaNumero };
    }

    _analisaPrint(tokens, index, linhaNumero) {
        if (tokens[index].tipo === "IDENTIFICADOR") {
            return { tipo: "PRINT", identificador: tokens[index].value, linhaNumero };
        } else {
            throw new Error("Erro sintático na instrução PRINT.");
        }
    }

    _analisaInput(tokens, index, linhaNumero) {
        if (tokens[index].tipo === "IDENTIFICADOR") {
            return { tipo: "INPUT", identificador: tokens[index].value, linhaNumero };
        } else {
            throw new Error("Erro sintático na instrução INPUT.");
        }
    }
}

class AnalisadorSemantico {
    constructor() {
        this.variaveis = {};
    }

    analise(ast) {
        switch (ast.tipo) {
            case "LET":
                this._verificaExpressao(ast.expressao);  // Verifica se as variáveis usadas na expressão foram definidas
                this.variaveis[ast.identificador] = true;  // Marca a variável como definida
                return true;
            case "INPUT":
                this.variaveis[ast.identificador] = true;  // Marca a variável como recebida
                return true;
            case "PRINT":
                if (!this.variaveis[ast.identificador]) {
                    throw new Error(`Erro semântico: A variável "${ast.identificador}" não foi definida.`);
                }
                return true;
            default:
                return true;  // Nenhuma análise semântica complexa necessária para outras instruções
        }
    }

    _verificaExpressao(expressao) {
        expressao.forEach(token => {
            if (token.tipo === 'IDENTIFICADOR' && !this.variaveis[token.value]) {
                throw new Error(`Erro semântico: A variável "${token.value}" usada na expressão não foi definida.`);
            }
        });
    }
}

function formatarTokensLet(tokens, linhaOriginal) {
    // Verifica se os tokens contêm a palavra 'let'
    const letIndex = tokens.findIndex(token => token.tipo === 'PALAVRA' && token.value === 'let');
    if (letIndex === -1) {
        return tokens; // Se não contiver 'let', retorna os tokens sem alterações
    }

    // Divide a linha original em partes, ignorando espaços
    const partesLinha = linhaOriginal.split(/\s+/);

    // Inicializa um array para armazenar os tokens formatados
    const formattedTokens = [];

    // Percorre cada parte da linha original e encontra o token correspondente
    partesLinha.forEach(parte => {
        if (parte === '') {
            return; // Ignora partes vazias
        }
        const tokenIndex = tokens.findIndex(token => token.value == parte);
        if (tokenIndex !== -1) {
            formattedTokens.push(tokens[tokenIndex]);
        }
    });

    return formattedTokens;
}

// Função principal que integra todas as fases
function compile(filename) {
    const lexer = new AnalisadorLexico();
    const linhasValidas = [];
    const linhasProcessadas = new Set(); // Conjunto para rastrear linhas já usadas
    let ultimaLinha = 0; // Para rastrear a última linha lida
    let encontrouEnd = false; // Variável para garantir que o comando "end" esteja no final

    // Ler o arquivo linha por linha
    const lines = fs.readFileSync(filename, 'utf8').split('\n');
    lines.forEach((linha, index) => {
        // Verifica se a linha começa com um número
        if (!/^\d+/.test(linha.trim())) {
            throw new Error(`Erro: A linha ${index + 1} não começa com um número.`);
        }

        const tokens = lexer.analise(linha);
        const numeroLinha = parseInt(tokens[0].value); // Número da linha atual

        // Verifica se a linha já foi processada (duplicação)
        if (linhasProcessadas.has(numeroLinha)) {
            throw new Error(`Erro: A linha ${numeroLinha} já foi usada.`);
        }

        // Verifica se a linha atual é menor que a última processada (ordem incorreta)
        if (numeroLinha <= ultimaLinha) {
            throw new Error(`Erro: A linha ${numeroLinha} está fora de ordem. Deve ser maior que a linha ${ultimaLinha}.`);
        }

        // Adiciona a linha ao conjunto de linhas processadas e atualiza a última linha
        linhasProcessadas.add(numeroLinha);
        ultimaLinha = numeroLinha;

        // Verifica se esta linha contém o comando "end"
        if (tokens.some(token => token.tipo === 'PALAVRA' && token.value === 'end')) {
            encontrouEnd = true;
        } else if (encontrouEnd) {
            throw new Error(`Erro: O comando "end" deve ser a última linha do programa.`);
        }

        linhasValidas.push(numeroLinha); // Adiciona o número da linha à lista de linhas válidas
    });

    // Verifica se o comando "end" foi encontrado no final do arquivo
    if (!encontrouEnd) {
        throw new Error(`Erro: O programa deve terminar com o comando "end".`);
    }

    const sintaxe = new AnalisadorSintatico(linhasValidas);
    const semantico = new AnalisadorSemantico();

    // Segunda passagem para analisar sintaticamente e semanticamente
    lines.forEach(linha => {
        try {
            let tokens = lexer.analise(linha);
            if (tokens.some(token => token.tipo === 'PALAVRA' && token.value === 'let')) {
                tokens = formatarTokensLet(tokens, linha); // Formata os tokens da instrução LET
            }
            const ast = sintaxe.analise(tokens);
            semantico.analise(ast);
            console.log("Compilado:", ast);
        } catch (error) {
            console.error(error.message);
        }
    });
}


// Exemplo de uso:
compile('codigo.txt');
