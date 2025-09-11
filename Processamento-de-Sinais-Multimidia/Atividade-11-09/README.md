# Atividade 11-09: Transformada de Wavelets para Suavização de Sinal

![MATLAB](https://go-skill-icons.vercel.app/api/icons?i=matlab)

## Descrição

Esta atividade demonstra o uso da transformada de wavelets para realizar a suavização de sinais ruidosos, aplicando o método para filtragem de ruído em sinais senoidais.

## Arquivos

- `atividade_completa.m` - **Arquivo principal completo** que executa todas as questões
- `main_atividade.m` - Arquivo principal das questões básicas (1-4)
- `etapa1_sinal_original.m` - Criação do sinal senoidal original
- `etapa2_adicionar_ruido.m` - Adição de ruído ao sinal
- `etapa3_filtragem_wavelet.m` - Aplicação da filtragem wavelet
- `etapa4_visualizacao_resultados.m` - Visualização e análise dos resultados
- `questao6_diferentes_ind.m` - Teste com diferentes valores de Ind
- `questao8_ruido_forte.m` - Teste com ruído de alta amplitude
- `questao10_comparacao_ruidos.m` - Comparação entre ruído baixo e forte
- `questao11_analise_completa.m` - Análise completa com diferentes Ind e ruídos

## Execução

Execute o arquivo principal completo:

```matlab
run('atividade_completa.m')
```

Ou execute apenas as questões básicas:

```matlab
run('main_atividade.m')
```

## Respostas das Questões

### Questão 1: Criação da Senoide

O código cria uma senoide de baixa frequência (2 Hz) com:

- Frequência de amostragem: 1000 Hz
- Duração: 1 segundo
- Amplitude: 1

### Questão 2: Adição de Ruído

Ruído gaussiano é adicionado com amplitude A = 0.1 (10% da amplitude do sinal), gerando uma versão ruidosa do sinal original.

### Questão 3: Filtragem com Wavelets

O procedimento utiliza:

- Wavelet Daubechies 4 ('db4')
- 5 níveis de decomposição
- Zeragem de coeficientes a partir do índice 35
- Reconstrução do sinal filtrado

### Questão 4: Gráfico Obtido

O gráfico mostra a comparação entre o sinal ruidoso (azul) e o sinal filtrado (vermelho), demonstrando a eficácia da filtragem wavelet na remoção do ruído.

### Questão 5: Explicação do Resultado

A transformada de wavelets funciona decompondo o sinal em diferentes escalas de frequência e tempo. Os coeficientes de alta frequência (que contêm principalmente ruído) são eliminados, enquanto os coeficientes de baixa frequência (que contêm o sinal útil) são preservados. Isso resulta em um sinal suavizado que mantém as características principais do sinal original.

### Questão 6: Diferentes Valores de Ind

**Resultado para Ind=50:**

- Maior preservação de coeficientes
- Filtragem menos agressiva
- Pode manter mais ruído residual

**Resultado para Ind=40:**

- Filtragem moderada
- Bom equilíbrio entre preservação do sinal e remoção de ruído

**Resultado para Ind=30:**

- Filtragem mais agressiva
- Melhor remoção de ruído, mas pode suavizar demais o sinal

**Resultado para Ind=20:**

- Filtragem muito agressiva
- Excelente remoção de ruído, mas com possível perda de detalhes

**Resultado para Ind=10:**

- Filtragem extremamente agressiva
- Máxima suavização, mas pode distorcer o sinal original

### Questão 7: Análise dos Resultados

À medida que o valor de Ind diminui, a filtragem torna-se mais agressiva:

- **Valores altos de Ind**: Preservam mais detalhes, mas mantêm mais ruído
- **Valores baixos de Ind**: Removem mais ruído, mas podem causar sobre-suavização
- **Valor ótimo**: Depende da relação sinal-ruído e da aplicação específica

### Questão 8: Ruído com Amplitude A = 0.3

Com amplitude de ruído aumentada para 0.3 (30% da amplitude do sinal):

- O ruído se torna mais significativo
- A filtragem wavelet ainda é eficaz, mas o sinal resultante pode ter mais distorção
- É necessário ajustar os parâmetros (como Ind) para otimizar a filtragem

### Questão 9: Gráfico com Ruído Forte

O gráfico demonstra que mesmo com ruído de alta amplitude, a filtragem wavelet consegue recuperar características importantes do sinal original, embora com menor fidelidade comparado ao caso de ruído baixo.

### Questão 10: Comparação entre Itens 4 e 9

Comparando os resultados entre ruído baixo (A=0.1) e ruído forte (A=0.3):

**Observações principais:**

- **Eficácia da filtragem**: Com ruído baixo, a filtragem é mais eficaz e preserva melhor a forma original do sinal
- **Ruído residual**: Com ruído forte, mesmo após a filtragem, permanece mais ruído residual no sinal
- **Distorção**: O ruído forte causa maior distorção no sinal filtrado, mas ainda mantém as características principais
- **SNR**: A melhoria na relação sinal-ruído é mais significativa no caso de ruído forte, mas o resultado absoluto é melhor com ruído baixo

### Questão 11: Análise com Diferentes Valores de Ind

Repetindo o procedimento com Ind = 50, 40, 30, 20, 10 para ambos os níveis de ruído:

**Resultado para Ind=50:**

- **Ruído baixo**: Filtragem suave, mantém detalhes mas preserva algum ruído
- **Ruído forte**: Insuficiente para remover ruído significativo

**Resultado para Ind=40:**

- **Ruído baixo**: Bom equilíbrio entre preservação e filtragem
- **Ruído forte**: Melhoria moderada, mas ainda com ruído visível

**Resultado para Ind=30:**

- **Ruído baixo**: Filtragem eficaz com boa preservação do sinal
- **Ruído forte**: Melhoria significativa na qualidade do sinal

**Resultado para Ind=20:**

- **Ruído baixo**: Filtragem agressiva, excelente remoção de ruído
- **Ruído forte**: Boa remoção de ruído, resultado aceitável

**Resultado para Ind=10:**

- **Ruído baixo**: Sobre-filtragem, pode suavizar demais o sinal
- **Ruído forte**: Filtragem extrema, mas pode distorcer características importantes

### Questão 12: Análise dos Resultados e Comparação

**Diferenças observadas conforme diminui o valor de Ind:**

1. **Agressividade da filtragem**: Valores menores de Ind resultam em filtragem mais agressiva
2. **Trade-off qualidade-preservação**: Existe um ponto ótimo que varia com o nível de ruído
3. **Adaptação ao ruído**: Para ruído forte, valores menores de Ind são necessários para obter resultados satisfatórios
4. **Padrão observado**: Similar ao item 6, mas com maior sensibilidade para ruído forte

**Justificativas:**

- **Valores altos de Ind** (50, 40): Adequados para ruído baixo, insuficientes para ruído alto
- **Valores médios de Ind** (30, 20): Versáteis, funcionam bem para ambos os casos
- **Valores baixos de Ind** (10): Necessários apenas para ruído muito alto, podem causar sobre-filtragem

**Recomendação:** O valor ótimo de Ind deve ser escolhido baseado na amplitude do ruído presente no sinal.

## Conclusões

1. A transformada de wavelets é uma ferramenta poderosa para filtragem de sinais
2. O parâmetro Ind controla o nível de filtragem aplicado
3. Existe um trade-off entre remoção de ruído e preservação do sinal
4. A técnica é robusta mesmo para níveis elevados de ruído
5. A escolha adequada dos parâmetros é crucial para otimizar os resultados
