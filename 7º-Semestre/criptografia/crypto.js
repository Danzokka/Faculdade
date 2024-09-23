// Definir o alfabeto estendido incluindo letras, letras acentuadas, números e símbolos comuns
const alfabeto = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzÁáÀàÂâÃãÉéÊêÍíÓóÔôÕõÚúÜüÇç0123456789!@#$%^&*()-_=+[]{}|;:,.<>?/`~ ';

// Função utilitária para modular posições dentro do alfabeto estendido
function modulo(n, m) {
    return ((n % m) + m) % m;
}

// Função para calcular o valor numérico de um caractere com base no alfabeto estendido
function caractereParaNumero(caractere) {
    return alfabeto.indexOf(caractere);
}

// Função para converter o valor numérico de volta para o caractere
function numeroParaCaractere(numero) {
    return alfabeto[modulo(numero, alfabeto.length)];
}

// Função para calcular o valor acumulado da chave, somando os valores de todos os caracteres da chave
function valorAcumuladoChave(chave) {
    let valorTotal = 0;
    for (let i = 0; i < chave.length; i++) {
        valorTotal += caractereParaNumero(chave[i]);
    }
    return valorTotal;
}

// Função de Cifra de César para qualquer caractere dentro do alfabeto estendido
function cifraCesar(caractere, shift) {
    const numero = caractereParaNumero(caractere);
    return numeroParaCaractere(numero + shift);
}

// Função de Cifra de César inversa
function descriptografaCesar(caractere, shift) {
    const numero = caractereParaNumero(caractere);
    return numeroParaCaractere(numero - shift);
}

// Função de Cifra de Vigenère para qualquer caractere dentro do alfabeto estendido
function cifraVigenere(caractere, caractereChave) {
    const numeroCaractere = caractereParaNumero(caractere);
    const numeroChave = caractereParaNumero(caractereChave);
    return numeroParaCaractere(numeroCaractere + numeroChave);
}

// Função de Cifra de Vigenère inversa
function descriptografaVigenere(caractere, caractereChave) {
    const numeroCaractere = caractereParaNumero(caractere);
    const numeroChave = caractereParaNumero(caractereChave);
    return numeroParaCaractere(numeroCaractere - numeroChave);
}

// Função para determinar o número de fases com base na chave e na mensagem
function determinaFases(chave, mensagem) {
    return Math.max(Math.floor(chave.length / mensagem.length), Math.floor(mensagem.length / chave.length)) + 2;
}

// Função para calcular o deslocamento da Cifra de César com base no valor acumulado da chave
function deslocamentoCesar(valorAcumulado, index) {
    return (valorAcumulado + index) % alfabeto.length; // O deslocamento agora depende do valor acumulado da chave e do índice
}

// Função para encriptar uma mensagem com uma chave personalizada
function criptografa(mensagem, chave) {
    let textoCriptografado = mensagem;
    let fases = determinaFases(chave, mensagem); // Determina o número de fases baseado no comprimento da chave
    let valorAcumulado = valorAcumuladoChave(chave); // Calcula o valor acumulado da chave

    for (let fase = 0; fase < fases; fase++) {
        let resultado = '';

        // Alterna entre as cifras
        for (let i = 0; i < textoCriptografado.length; i++) {
            const caractere = textoCriptografado[i];
            const caractereChave = chave[i % chave.length];
            let shiftCesar = deslocamentoCesar(valorAcumulado, i); // Deslocamento baseado no valor acumulado da chave e índice

            // Usar César ou Vigenère de forma dinâmica com base no valor da chave
            if (i % 2 === 0) {
                // Posições pares (Cifra de César)
                resultado += cifraCesar(caractere, shiftCesar);
            } else {
                // Posições ímpares (Cifra de Vigenère)
                resultado += cifraVigenere(caractere, caractereChave);
            }
        }

        // Atualiza o texto cifrado para a próxima fase
        textoCriptografado = resultado;
    }
    return textoCriptografado;
}

// Função para decriptar a mensagem com a chave personalizada
function descriptografa(mensagemCriptografada, chave) {
    let textoDescriptografado = mensagemCriptografada;
    let fases = determinaFases(chave, mensagemCriptografada); // Determina o número de fases baseado no comprimento da chave
    let valorAcumulado = valorAcumuladoChave(chave); // Calcula o valor acumulado da chave

    // As fases de decriptação devem ser aplicadas de trás para frente
    for (let fase = fases - 1; fase >= 0; fase--) {
        let resultado = '';

        for (let i = 0; i < textoDescriptografado.length; i++) {
            const caractere = textoDescriptografado[i];
            const caractereChave = chave[i % chave.length];
            let shiftCesar = deslocamentoCesar(valorAcumulado, i); // Deslocamento baseado no valor acumulado da chave e índice

            // Usar César ou Vigenère de forma dinâmica com base no valor da chave
            if (i % 2 === 0) {
                // Posições pares (Cifra de César inversa)
                resultado += descriptografaCesar(caractere, shiftCesar);
            } else {
                // Posições ímpares (Cifra de Vigenère inversa)
                resultado += descriptografaVigenere(caractere, caractereChave);
            }
        }

        // Atualiza o texto decifrado para a próxima fase
        textoDescriptografado = resultado;
    }

    return textoDescriptografado;
}

// Exemplo de uso:
const mensagem = "Ola esta";
const chave = "ChaweSecreta123";

try {
    // Criptografar a mensagem
    console.time("Tempo de Criptografia");
    const criptografado = criptografa(mensagem, chave);
    console.log("Texto encriptado:", criptografado);
    console.timeEnd("Tempo de Criptografia");


    // Descriptografar a mensagem original
    console.time("Tempo de Descriptografia");
    const descriptografado = descriptografa(criptografado, chave);
    console.log("Texto decriptado:", descriptografado);
    console.timeEnd("Tempo de Descriptografia");
} catch (error) {
    console.error("Erro:", error.message);
}
