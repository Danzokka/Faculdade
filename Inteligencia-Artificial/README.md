# 🧠 Inteligência Artificial

![Python](https://go-skill-icons.vercel.app/api/icons?i=py&theme=light) ![TensorFlow](https://go-skill-icons.vercel.app/api/icons?i=tensorflow&theme=light) ![Jupyter](https://go-skill-icons.vercel.app/api/icons?i=jupyter&theme=light)

## 📖 Descrição

Esta disciplina explora os fundamentos da Inteligência Artificial e Machine Learning, abordando algoritmos de aprendizado supervisionado, não-supervisionado e por reforço. Desenvolvemos modelos práticos para solução de problemas reais usando Python e bibliotecas especializadas.

## 🎯 Objetivos de Aprendizagem

- Compreender **conceitos fundamentais** de IA e ML
- Implementar **algoritmos de aprendizado** supervisionado e não-supervisionado
- Aplicar **redes neurais** para problemas complexos
- Desenvolver **sistemas de recomendação** e classificação
- Analisar e **preprocessar dados** para modelos de ML
- Avaliar **performance de modelos** com métricas apropriadas

## 🧠 Fundamentos de Machine Learning

### 📊 Tipos de Aprendizado

```python
# Aprendizado Supervisionado
from sklearn.linear_model import LinearRegression
from sklearn.ensemble import RandomForestClassifier

# Regressão Linear
model = LinearRegression()
model.fit(X_train, y_train)
predictions = model.predict(X_test)

# Classificação com Random Forest
classifier = RandomForestClassifier(n_estimators=100)
classifier.fit(X_train, y_train)
accuracy = classifier.score(X_test, y_test)
```

### 🔍 Aprendizado Não-Supervisionado

```python
# Clustering com K-Means
from sklearn.cluster import KMeans
from sklearn.decomposition import PCA

# Agrupamento
kmeans = KMeans(n_clusters=3)
clusters = kmeans.fit_predict(data)

# Redução de Dimensionalidade
pca = PCA(n_components=2)
reduced_data = pca.fit_transform(data)
```

## 🤖 Algoritmos Implementados

### 🔮 Algoritmos Supervisionados

| Algoritmo               | Tipo          | Complexidade   | Aplicação             |
| ----------------------- | ------------- | -------------- | --------------------- |
| **Linear Regression**   | Regressão     | O(n³)          | Predição contínua     |
| **Logistic Regression** | Classificação | O(n²k)         | Classificação binária |
| **Decision Trees**      | Ambos         | O(n log n)     | Interpretabilidade    |
| **Random Forest**       | Ambos         | O(n log n × k) | Alta performance      |
| **SVM**                 | Ambos         | O(n²)          | Margem máxima         |
| **Neural Networks**     | Ambos         | O(n × layers)  | Problemas complexos   |

### 🎯 Algoritmos Não-Supervisionados

```python
# K-Means Clustering
def kmeans_manual(data, k, max_iters=100):
    centroids = initialize_centroids(data, k)

    for _ in range(max_iters):
        # Atribuir pontos aos clusters
        clusters = assign_clusters(data, centroids)

        # Atualizar centroides
        new_centroids = update_centroids(data, clusters, k)

        # Verificar convergência
        if converged(centroids, new_centroids):
            break

        centroids = new_centroids

    return centroids, clusters
```

## 🧮 Redes Neurais

### 🌐 Perceptron Simples

```python
import numpy as np

class Perceptron:
    def __init__(self, learning_rate=0.01, n_iterations=1000):
        self.learning_rate = learning_rate
        self.n_iterations = n_iterations

    def fit(self, X, y):
        # Inicializar pesos
        self.weights = np.zeros(1 + X.shape[1])

        for _ in range(self.n_iterations):
            for xi, target in zip(X, y):
                update = self.learning_rate * (target - self.predict(xi))
                self.weights[1:] += update * xi
                self.weights[0] += update

    def predict(self, X):
        return np.where(self.net_input(X) >= 0.0, 1, -1)

    def net_input(self, X):
        return np.dot(X, self.weights[1:]) + self.weights[0]
```

### 🔥 Rede Neural Multi-Layer

```python
import tensorflow as tf
from tensorflow.keras import layers

# Construção do modelo
model = tf.keras.Sequential([
    layers.Dense(128, activation='relu', input_shape=(input_dim,)),
    layers.Dropout(0.2),
    layers.Dense(64, activation='relu'),
    layers.Dropout(0.2),
    layers.Dense(32, activation='relu'),
    layers.Dense(num_classes, activation='softmax')
])

# Compilação
model.compile(
    optimizer='adam',
    loss='categorical_crossentropy',
    metrics=['accuracy']
)

# Treinamento
history = model.fit(
    X_train, y_train,
    batch_size=32,
    epochs=100,
    validation_data=(X_val, y_val),
    callbacks=[early_stopping]
)
```

## 📊 Processamento de Dados

### 🧹 Pré-processamento

```python
import pandas as pd
from sklearn.preprocessing import StandardScaler, LabelEncoder
from sklearn.model_selection import train_test_split

# Carregamento de dados
data = pd.read_csv('dataset.csv')

# Tratamento de valores faltantes
data.fillna(data.mean(), inplace=True)

# Encoding de variáveis categóricas
le = LabelEncoder()
data['category'] = le.fit_transform(data['category'])

# Normalização
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)

# Divisão train/test
X_train, X_test, y_train, y_test = train_test_split(
    X_scaled, y, test_size=0.2, random_state=42
)
```

### 📈 Análise Exploratória

```python
import matplotlib.pyplot as plt
import seaborn as sns

# Estatísticas descritivas
print(data.describe())

# Correlação entre variáveis
correlation_matrix = data.corr()
sns.heatmap(correlation_matrix, annot=True, cmap='coolwarm')

# Distribuição de classes
sns.countplot(data['target'])
plt.title('Distribuição das Classes')
plt.show()
```

## 🎯 Projetos Desenvolvidos

### 💰 Predição de Preços

- **Objetivo:** Prever preços de imóveis
- **Algoritmo:** Regressão Linear + Random Forest
- **Features:** Localização, tamanho, quartos, etc.
- **Métricas:** MAE, RMSE, R²

### 🔍 Sistema de Recomendação

- **Técnica:** Collaborative Filtering
- **Dataset:** Ratings de usuários
- **Algoritmo:** Matrix Factorization
- **Avaliação:** Precision@K, Recall@K

### 📸 Classificação de Imagens

- **Arquitetura:** CNN (Convolutional Neural Network)
- **Framework:** TensorFlow/Keras
- **Dataset:** CIFAR-10 ou custom
- **Técnicas:** Data Augmentation, Transfer Learning

## 📊 Métricas de Avaliação

### 🎯 Classificação

```python
from sklearn.metrics import accuracy_score, precision_recall_fscore_support, confusion_matrix

# Métricas básicas
accuracy = accuracy_score(y_true, y_pred)
precision, recall, f1, _ = precision_recall_fscore_support(y_true, y_pred)

# Matriz de Confusão
cm = confusion_matrix(y_true, y_pred)
sns.heatmap(cm, annot=True, fmt='d')
```

### 📈 Regressão

```python
from sklearn.metrics import mean_absolute_error, mean_squared_error, r2_score

# Métricas de regressão
mae = mean_absolute_error(y_true, y_pred)
rmse = np.sqrt(mean_squared_error(y_true, y_pred))
r2 = r2_score(y_true, y_pred)

print(f"MAE: {mae:.4f}")
print(f"RMSE: {rmse:.4f}")
print(f"R²: {r2:.4f}")
```

## 🛠️ Ferramentas e Bibliotecas

### 📚 Principais Bibliotecas

- **Scikit-learn:** Algoritmos clássicos de ML
- **TensorFlow/Keras:** Deep Learning
- **PyTorch:** Pesquisa em Deep Learning
- **Pandas:** Manipulação de dados
- **NumPy:** Computação numérica
- **Matplotlib/Seaborn:** Visualização

### 🔧 Ambiente de Desenvolvimento

```bash
# Instalação de dependências
pip install scikit-learn tensorflow pandas numpy matplotlib seaborn

# Jupyter Notebook
pip install jupyter
jupyter notebook

# Ambiente conda
conda create -n ml-env python=3.8
conda activate ml-env
conda install scikit-learn tensorflow
```

## 🧠 Conceitos Avançados

- **Deep Learning:** Redes neurais profundas
- **Computer Vision:** Processamento de imagens
- **Natural Language Processing:** Análise de texto
- **Reinforcement Learning:** Aprendizado por reforço
- **Transfer Learning:** Reutilização de modelos
- **Ensemble Methods:** Combinação de modelos

## 🔗 Recursos Complementares

- [Coursera - Machine Learning by Andrew Ng](https://www.coursera.org/learn/machine-learning)
- [Fast.ai - Practical Deep Learning](https://www.fast.ai/)
- [Kaggle Courses](https://www.kaggle.com/learn)
- [Papers With Code](https://paperswithcode.com/)

---

_Esta disciplina fornece as bases para compreender e aplicar técnicas de Inteligência Artificial em problemas reais, preparando para áreas como Data Science, Machine Learning Engineering e AI Research._
