# 💻 Sistemas Operacionais

![Linux](https://go-skill-icons.vercel.app/api/icons?i=linux&theme=light) ![C](https://go-skill-icons.vercel.app/api/icons?i=c&theme=light) ![Bash](https://go-skill-icons.vercel.app/api/icons?i=bash&theme=light) ![Assembly](https://go-skill-icons.vercel.app/api/icons?i=assembly&theme=light)

## 📖 Descrição

Esta disciplina aborda os conceitos fundamentais dos sistemas operacionais modernos, incluindo gerenciamento de processos, memória, sistemas de arquivos e entrada/saída. Estudamos tanto os aspectos teóricos quanto práticos através de implementações em C e shell scripting.

## 🎯 Objetivos de Aprendizagem

- Compreender a **arquitetura** de sistemas operacionais
- Implementar algoritmos de **escalonamento de processos**
- Estudar técnicas de **gerenciamento de memória**
- Desenvolver **programas concorrentes** com threads
- Aplicar conceitos de **sincronização** e exclusão mútua
- Analisar **sistemas de arquivos** e suas implementações

## 🏗️ Componentes do Sistema Operacional

### ⚙️ Kernel e Núcleo

- **Modo Kernel vs Modo Usuário**
- **System Calls (Chamadas de Sistema)**
- **Interrupts e Tratamento de Eventos**
- **Device Drivers**

### 🔄 Gerenciamento de Processos

```c
// Criação de processos com fork()
#include <unistd.h>
#include <sys/wait.h>

int main() {
    pid_t pid = fork();

    if (pid == 0) {
        // Processo filho
        printf("Processo filho: PID = %d\n", getpid());
        exec("/bin/ls", "ls", "-l", NULL);
    } else if (pid > 0) {
        // Processo pai
        wait(NULL);
        printf("Processo pai: Filho terminou\n");
    }

    return 0;
}
```

### 🧵 Threads e Concorrência

```c
#include <pthread.h>

void* thread_function(void* arg) {
    int thread_id = *(int*)arg;
    printf("Thread %d executando\n", thread_id);
    return NULL;
}

int main() {
    pthread_t threads[4];
    int ids[4];

    for (int i = 0; i < 4; i++) {
        ids[i] = i;
        pthread_create(&threads[i], NULL, thread_function, &ids[i]);
    }

    for (int i = 0; i < 4; i++) {
        pthread_join(threads[i], NULL);
    }

    return 0;
}
```

## 📅 Algoritmos de Escalonamento

### 🎯 Escalonamento de CPU

| Algoritmo            | Tipo           | Vantagens                  | Desvantagens               |
| -------------------- | -------------- | -------------------------- | -------------------------- |
| **FCFS**             | Não-preemptivo | Simples                    | Convoy effect              |
| **SJF**              | Não-preemptivo | Ótimo (menor waiting time) | Starvation                 |
| **Round Robin**      | Preemptivo     | Justo                      | Context switching overhead |
| **Priority**         | Preemptivo/Não | Flexível                   | Starvation                 |
| **Multilevel Queue** | Híbrido        | Categorização              | Complexo                   |

### ⏱️ Métricas de Performance

- **Throughput:** Processos por unidade de tempo
- **Turnaround Time:** Tempo total de execução
- **Waiting Time:** Tempo na fila de prontos
- **Response Time:** Tempo até primeira resposta

## 🧠 Gerenciamento de Memória

### 📊 Técnicas de Alocação

```c
// Algoritmos de alocação de memória
typedef enum {
    FIRST_FIT,
    BEST_FIT,
    WORST_FIT
} allocation_strategy_t;

void* allocate_memory(size_t size, allocation_strategy_t strategy) {
    // Implementação dos algoritmos de alocação
    switch (strategy) {
        case FIRST_FIT:
            return first_fit_allocation(size);
        case BEST_FIT:
            return best_fit_allocation(size);
        case WORST_FIT:
            return worst_fit_allocation(size);
    }
}
```

### 💾 Memória Virtual

- **Paginação:** Divisão em páginas fixas
- **Segmentação:** Divisão lógica por segmentos
- **Page Replacement:** LRU, FIFO, Optimal
- **TLB (Translation Lookaside Buffer)**

### 🔄 Algoritmos de Substituição

| Algoritmo   | Complexidade | Performance        | Implementação |
| ----------- | ------------ | ------------------ | ------------- |
| **FIFO**    | O(1)         | Anomalia de Belady | Simples       |
| **LRU**     | O(log n)     | Boa                | Complexa      |
| **Clock**   | O(1)         | Aproxima LRU       | Moderada      |
| **Optimal** | -            | Ótima (teórica)    | Impossível    |

## 🔐 Sincronização e Concorrência

### 🚦 Primitivas de Sincronização

```c
// Semáforos
#include <semaphore.h>

sem_t semaphore;

void* producer(void* arg) {
    // Produzir item
    sem_wait(&semaphore);
    // Seção crítica
    sem_post(&semaphore);
}

// Mutex
pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;

void critical_section() {
    pthread_mutex_lock(&mutex);
    // Seção crítica
    pthread_mutex_unlock(&mutex);
}
```

### 🔄 Problemas Clássicos

- **Produtor-Consumidor**
- **Leitores-Escritores**
- **Filósofos Jantando**
- **Barbeiro Dorminhoco**

## 📁 Sistemas de Arquivos

### 🗃️ Estruturas de Dados

```c
// Inode - Estrutura de metadados
typedef struct inode {
    mode_t mode;           // Permissões e tipo
    uid_t uid;             // User ID
    gid_t gid;             // Group ID
    off_t size;            // Tamanho do arquivo
    time_t atime, mtime;   // Timestamps
    blksize_t block_size;  // Tamanho do bloco
    blkcnt_t blocks;       // Número de blocos
    char data_blocks[12];  // Blocos diretos
    char indirect_block;   // Bloco indireto
} inode_t;
```

### 📂 Organização de Diretórios

- **Diretórios Lineares:** Busca sequencial
- **Hash Tables:** Acesso O(1)
- **B-Trees:** Balanceamento automático
- **Extents:** Alocação contígua

## 🖥️ Entrada/Saída (I/O)

### 🔌 Métodos de I/O

| Método         | Vantagens | Desvantagens               | Uso                  |
| -------------- | --------- | -------------------------- | -------------------- |
| **Polling**    | Simples   | CPU intensivo              | Dispositivos rápidos |
| **Interrupts** | Eficiente | Overhead de context switch | Dispositivos médios  |
| **DMA**        | CPU livre | Hardware complexo          | Dispositivos lentos  |

### 📡 Device Drivers

```c
// Estrutura básica de um driver
struct device_driver {
    int (*open)(struct device *dev);
    int (*close)(struct device *dev);
    ssize_t (*read)(struct device *dev, char *buffer, size_t len);
    ssize_t (*write)(struct device *dev, const char *buffer, size_t len);
    int (*ioctl)(struct device *dev, unsigned int cmd, unsigned long arg);
};
```

## 🛠️ Ferramentas e Comandos

### 📊 Monitoramento de Sistema

```bash
# Processos
ps aux                    # Lista processos
top / htop               # Monitor em tempo real
kill -9 PID              # Terminar processo

# Memória
free -h                  # Uso de memória
vmstat                   # Estatísticas de memória virtual

# Sistema de Arquivos
df -h                    # Espaço em disco
du -sh                   # Tamanho de diretórios
lsof                     # Arquivos abertos

# Rede
netstat -tulpn           # Conexões de rede
ss -tulpn                # Sockets
```

## 🔬 Laboratórios Práticos

- **Implementação de Shell:** Parser de comandos, pipes
- **Simulador de Escalonamento:** Algoritmos FCFS, SJF, RR
- **Gerenciador de Memória:** Paginação e substituição
- **Sistema de Arquivos:** FAT, EXT2 simplificado
- **Sincronização:** Soluções para problemas clássicos

## 📊 Performance e Otimização

- **Profiling:** `gprof`, `perf`, `valgrind`
- **Benchmarking:** Medição de throughput e latência
- **Tuning:** Ajuste de parâmetros do kernel
- **Análise:** Identificação de gargalos

## 🔗 Recursos Complementares

- [The Linux Programming Interface](https://man7.org/tlpi/)
- [Operating Systems: Three Easy Pieces](https://pages.cs.wisc.edu/~remzi/OSTEP/)
- [Linux Kernel Documentation](https://kernel.org/doc/)

---

_Esta disciplina fornece conhecimentos fundamentais sobre o funcionamento interno dos computadores e é essencial para desenvolvimento de software de sistema e otimização de aplicações._
