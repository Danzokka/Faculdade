# Atividade 04 - Denoising de 2ª Geração

![MATLAB](https://go-skill-icons.vercel.app/api/icons?i=matlab)

## Descrição

Esta atividade implementa e compara métodos de denoising (remoção de ruído) utilizando a Transformada Wavelet Discreta (DWT). O foco principal é o método de denoising de 2ª geração, que utiliza deslocamentos circulares para melhorar a qualidade da filtragem em comparação com o método tradicional de 1ª geração.

## Arquivos

- `main_atividade4.m` - **Arquivo principal** que executa toda a atividade
- `atividade4_init.m` - Inicialização e carregamento dos dados
- `denoising_1G.m` - Implementação do denoising de 1ª geração
- `denoising_2G.m` - Implementação do denoising de 2ª geração
- `analise_parametros.m` - Análise de sensibilidade dos parâmetros
- `denoising_sinais_mat.m` - Implementação específica para o arquivo sinais.mat
- `sinais.mat` - Arquivo de dados com sinais para processamento

## Execução

Execute o arquivo principal:

```matlab
run('main_atividade4.m')
```

Para usar especificamente o arquivo sinais.mat:

```matlab
run('denoising_sinais_mat.m')
```

## Fundamentos Teóricos

### Denoising de 1ª Geração (1G)

O método tradicional de denoising por wavelets funciona através dos seguintes passos:

1. **Decomposição**: O sinal ruidoso é decompostosem coeficientes wavelet
2. **Thresholding**: Coeficientes pequenos (considerados ruído) são zerados ou reduzidos
3. **Reconstrução**: O sinal é reconstruído a partir dos coeficientes modificados

**Limitações do 1G:**

- Dependente da fase do sinal
- Pode introduzir artefatos devido à falta de translação invariante
- Oscilações espúrias próximas a descontinuidades

### Denoising de 2ª Geração (2G)

O método de 2ª geração resolve as limitações do 1G através do **deslocamento circular**:

1. **Múltiplas versões**: Cria várias versões do sinal com diferentes deslocamentos
2. **Processamento independente**: Aplica denoising 1G em cada versão
3. **Reversão dos deslocamentos**: Retorna cada versão à posição original
4. **Média das versões**: Combina todas as versões processadas

**Vantagens do 2G:**

- Reduz artefatos de translação
- Melhora a qualidade da reconstrução
- Maior robustez a diferentes tipos de ruído
- Preserva melhor as características do sinal original

## Questões Discursivas

### 1. Diferenças Fundamentais entre 1G e 2G

**Denoising 1G:**

- Processo direto: decomposição → threshold → reconstrução
- Dependente da posição/fase do sinal
- Pode criar oscilações espúrias (Gibbs-like artifacts)
- Computacionalmente mais eficiente

**Denoising 2G:**

- Processo múltiplo com deslocamentos circulares
- Invariante à translação (aproximadamente)
- Reduz significativamente os artefatos
- Maior custo computacional, mas melhor qualidade

### 2. Papel dos Deslocamentos Circulares

Os deslocamentos circulares (`circshift`) são fundamentais porque:

- **Quebram a dependência da fase**: Cada deslocamento apresenta o sinal de uma perspectiva diferente para a wavelet
- **Reduzem artefatos**: As oscilações espúrias aparecem em posições diferentes em cada versão
- **Melhoram a média**: A combinação das versões suaviza os artefatos residuais
- **Preservam informação**: Nenhuma informação é perdida no processo

### 3. Escolha dos Parâmetros

**Valores de k (deslocamentos):**

- Valores pequenos (0,1,2,3): Adequados para a maioria dos casos
- Muitos valores: Melhora a qualidade mas aumenta o custo computacional
- Valores espaçados: Podem ser suficientes dependendo do sinal

**Threshold:**

- Muito baixo: Mantém ruído residual
- Muito alto: Remove informação útil do sinal
- Valor ótimo: Compromisso entre remoção de ruído e preservação do sinal

### 4. Métricas de Avaliação

**SNR (Signal-to-Noise Ratio):**

```
SNR = 10 * log10(var(sinal_original) / var(erro))
```

**MSE (Mean Squared Error):**

```
MSE = mean((sinal_original - sinal_processado)^2)
```

**Ganho de SNR:**

```
Ganho = SNR_após - SNR_antes
```

### 5. Aplicações Práticas

O denoising de 2ª geração é especialmente útil em:

- **Processamento de imagens médicas**: Onde artefatos podem ser críticos
- **Análise de sinais biomédicos**: ECG, EEG, onde a forma do sinal é importante
- **Processamento de áudio**: Remoção de ruído preservando qualidade
- **Análise de sinais sísmicos**: Detecção de eventos em dados ruidosos

## Conclusões

1. **Eficácia Superior**: O método 2G consistentemente supera o 1G em termos de qualidade
2. **Trade-off Computacional**: Maior custo computacional compensado pela melhor qualidade
3. **Robustez**: Menos sensível aos parâmetros e tipo de sinal
4. **Versatilidade**: Aplicável a diversos tipos de sinais e níveis de ruído

## Resultados Esperados

- **Melhoria típica do SNR**: 2-5 dB do 2G sobre o 1G
- **Redução de artefatos**: Visível especialmente em sinais com descontinuidades
- **Preservação de características**: Melhor manutenção da forma original do sinal
