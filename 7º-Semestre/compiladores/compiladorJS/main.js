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
        this.NUMERO_REGEX = /^[+-]?\d+/;
        this.OPERADOR_REGEX = /^=/;  // Operador de atribuição
        this.OPERADOR_MATEMATICO_REGEX = /^[+\-*/%]/;
        this.OPERADOR_CONDICIONAL_REGEX = /^(>=|<=|==|!=|>|<)/;  // Operadores relacionais e de igualdade
        this.ESPACO_REGEX = /^\s+/;
    }

    analise(linha) {
        let tokens = [];
        let isFirstToken = true;

        while (linha.length > 0) {
            if (isFirstToken && this.LINHA_REGEX.test(linha)) {
                tokens.push({ tipo: 'NUMERO_LINHA', value: linha.match(this.LINHA_REGEX)[0] });
                linha = linha.replace(this.LINHA_REGEX, '');
                isFirstToken = false;
            } else if (this.PALAVRA_REGEX.test(linha)) {
                let palavra = linha.match(this.PALAVRA_REGEX)[0];
                tokens.push({ tipo: 'PALAVRA', value: palavra });

                if (palavra === 'rem') {
                    return tokens;
                }

                linha = linha.replace(this.PALAVRA_REGEX, '');
            } else if (this.OPERADOR_REGEX.test(linha)) {
                let operador = linha.match(this.OPERADOR_REGEX)[0];
                tokens.push({ tipo: 'OPERADOR', value: operador });
                linha = linha.replace(this.OPERADOR_REGEX, '');
            } else if (this.OPERADOR_CONDICIONAL_REGEX.test(linha)) {
                let operadorCondicional = linha.match(this.OPERADOR_CONDICIONAL_REGEX)[0];
                tokens.push({ tipo: 'OPERADOR_CONDICIONAL', value: operadorCondicional });
                linha = linha.replace(this.OPERADOR_CONDICIONAL_REGEX, '');
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
            } else if (this.ESPACO_REGEX.test(linha)) {
                linha = linha.replace(this.ESPACO_REGEX, ''); 
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
        // Verifica se o identificador (variável) está presente
        if (tokens[index].tipo === "IDENTIFICADOR") {
            let variable = tokens[index].value; // A variável que está sendo atribuída
            index++;
    
            // Verifica se o próximo token é o operador de atribuição "="
            if (tokens[index].tipo === "OPERADOR" && tokens[index].value === "=") {
                index++;
    
                let expressao = [];
    
                // Aceita um operador de sinal (+ ou -) seguido de um número ou identificador
                if (tokens[index].tipo === "OPERADOR_MATEMATICO" && (tokens[index].value === "+" || tokens[index].value === "-")) {
                    // Se houver um sinal, verificamos se o próximo token é um número
                    let operadorSinal = tokens[index];
                    index++;
                    
                    if (tokens[index].tipo === "NUMERO") {
                        expressao.push({ tipo: "NUMERO", value: operadorSinal.value + tokens[index].value });
                        index++;
                    } else {
                        throw new Error("Erro sintático: Esperado número após o sinal.");
                    }
                } else if (tokens[index].tipo === "NUMERO" || tokens[index].tipo === "IDENTIFICADOR") {
                    // Sem sinal, apenas aceita número ou identificador
                    expressao.push(tokens[index]);
                    index++;
                } else {
                    throw new Error("Erro sintático: Esperado número ou identificador após '='.");
                }
    
                // Continua processando a expressão, se houver mais tokens (operadores matemáticos e operandos)
                while (index < tokens.length) {
                    let currentToken = tokens[index];
    
                    if (currentToken.tipo === "OPERADOR_MATEMATICO") {
                        // Certifica-se de que a expressão tenha um operando antes do operador
                        if (expressao.length === 0 || (expressao[expressao.length - 1].tipo === "OPERADOR_MATEMATICO")) {
                            throw new Error("Erro sintático: Operador sem operandos válidos.");
                        }
                        expressao.push(currentToken);
                    } else if (currentToken.tipo === "IDENTIFICADOR" || currentToken.tipo === "NUMERO") {
                        expressao.push(currentToken);
                    } else {
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
        // Verifica se há um operador condicional (relacional ou de igualdade)
        let condicionalIndex = tokens.findIndex(token => token.tipo === 'OPERADOR_CONDICIONAL');
        
        if (condicionalIndex === -1) {
            throw new Error("Erro sintático: Esperado um operador condicional na instrução IF.");
        }
    
        // Verifica os operandos da condição (antes e depois do operador condicional)
        let operandoEsquerda = tokens[condicionalIndex - 1];
        let operandoDireita = tokens[condicionalIndex + 1];
    
        if (!operandoEsquerda || !operandoDireita) {
            throw new Error("Erro sintático: Condição mal formada na instrução IF.");
        }
    
        // Certifica-se de que os operandos sejam números ou identificadores
        if (operandoEsquerda.tipo !== 'IDENTIFICADOR' && operandoEsquerda.tipo !== 'NUMERO') {
            throw new Error("Erro sintático: Operando inválido no lado esquerdo da condição.");
        }
    
        if (operandoDireita.tipo !== 'IDENTIFICADOR' && operandoDireita.tipo !== 'NUMERO') {
            throw new Error("Erro sintático: Operando inválido no lado direito da condição.");
        }
    
        // Verifica se o próximo token após a condição é GOTO
        const gotoIndex = condicionalIndex + 2; // Pula a condição (ex: a > 1)
        if (tokens[gotoIndex] && tokens[gotoIndex].value.toUpperCase() !== 'GOTO') {
            throw new Error("Erro sintático: Esperado GOTO após a condição.");
        }
    
        // Verifica a linha de destino após o GOTO
        const linhaGoto = tokens[gotoIndex + 1] ? parseInt(tokens[gotoIndex + 1].value) : null;
        if (!linhaGoto || !this.linhasValidas.includes(linhaGoto)) {
            throw new Error(`Erro sintático: A linha de destino ${linhaGoto} não existe.`);
        }
    
        // Retorna a análise da instrução IF com a condição e a linha de destino
        return {
            tipo: "IF",
            condicao: tokens.slice(index, gotoIndex),  // Captura a condição completa
            linhaGoto,
            linhaNumero
        };
    }

    _analisaGoto(tokens, index, linhaNumero) {
        // Verifica se há um número de linha após o GOTO
        if (tokens[index].tipo === "NUMERO") {
            const linhaGoto = parseInt(tokens[index].value); // Garante que o número seja convertido para inteiro
    
            // Verifica se a linha de destino existe na lista de linhas válidas
            if (!this.linhasValidas.includes(linhaGoto)) {
                throw new Error(`Erro sintático: A linha de destino ${linhaGoto} não existe.`);
            }
    
            // Retorna o AST da instrução GOTO
            return {
                tipo: "GOTO",
                linhaGoto,
                linhaNumero
            };
        } else {
            throw new Error("Erro sintático: Esperado número de linha após GOTO.");
        }
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
            case "IF":
                this._verificaCondicao(ast.condicao);  // Verifica os identificadores usados na condição
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

    _verificaCondicao(condicao) {
        // Verifica os operandos da condição no IF
        condicao.forEach(token => {
            if (token.tipo === 'IDENTIFICADOR' && !this.variaveis[token.value]) {
                throw new Error(`Erro semântico: A variável "${token.value}" usada na condição IF não foi definida.`);
            }
        });
    }
}


function formataTokens(tokens, linhaOriginal) {
    // Divide a linha original por qualquer espaço ou operadores (matemáticos e condicionais)
    const partesLinha = linhaOriginal.split(/([+\-*/%><=!]=?|==|\s+)/).filter(parte => parte.trim() !== '');

    // Inicializa um array para armazenar os tokens formatados
    const formattedTokens = [];

    // Controla se estamos após o operador de atribuição ou operadores condicionais
    let depoisDoOperador = false;

    // Percorre cada parte da linha original e encontra o token correspondente
    partesLinha.forEach(parte => {
        const tokenIndex = tokens.findIndex(token => token.value == parte);

        if (tokenIndex !== -1) {
            let token = tokens[tokenIndex];

            // Se encontrarmos o operador de atribuição "=" ou operador condicional, marcamos para verificar números posteriores
            if (token.tipo === 'OPERADOR' && token.value === '=' || token.tipo === 'OPERADOR_CONDICIONAL') {
                depoisDoOperador = true;
            }

            // Ajusta o tipo de número após o operador de atribuição ou condicional
            if (depoisDoOperador && token.tipo === 'NUMERO_LINHA') {
                token.tipo = 'NUMERO'; // Corrige o tipo de token para 'NUMERO'
            }

            formattedTokens.push(token);
        } else if (/^[+\-*/%><=!]=?|==/.test(parte)) {
            // Se for um operador matemático ou condicional que não foi capturado como token
            formattedTokens.push({ tipo: parte.length > 1 ? 'OPERADOR_CONDICIONAL' : 'OPERADOR_MATEMATICO', value: parte });
        }
    });

    return formattedTokens;
}

// Função principal que integra todas as fases
function compile(filename) {
    const lexer = new AnalisadorLexico();
    const linhasValidas = new Set(); // Conjunto para armazenar as linhas válidas
    const linhasProcessadas = new Set(); // Conjunto para rastrear linhas já usadas
    let ultimaLinha = 0; // Para rastrear a última linha lida
    let encontrouEnd = false; // Variável para garantir que o comando "end" esteja no final

    // 1ª Passagem: Apenas coleta as linhas válidas
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

        // Adiciona a linha ao conjunto de linhas processadas e linhas válidas
        linhasProcessadas.add(numeroLinha);
        linhasValidas.add(numeroLinha); // Agora temos todas as linhas válidas
        ultimaLinha = numeroLinha;

        // Verifica se esta linha contém o comando "end"
        if (tokens.some(token => token.tipo === 'PALAVRA' && token.value === 'end')) {
            encontrouEnd = true;
        } else if (encontrouEnd) {
            throw new Error(`Erro: O comando "end" deve ser a última linha do programa.`);
        }
    });

    // Verifica se o comando "end" foi encontrado no final do arquivo
    if (!encontrouEnd) {
        throw new Error(`Erro: O programa deve terminar com o comando "end".`);
    }

    const sintaxe = new AnalisadorSintatico([...linhasValidas]); // Passa as linhas válidas como array
    const semantico = new AnalisadorSemantico();

    // 2ª Passagem: Análise sintática e semântica
    lines.forEach(linha => {
        try {
            let tokens = formataTokens(lexer.analise(linha), linha);
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
