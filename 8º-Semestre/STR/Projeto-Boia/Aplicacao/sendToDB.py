import serial
import sqlite3
from datetime import datetime

# Configuração da conexão com o SQLite
sqlite_connection = sqlite3.connect('temperaturas.db')
cursor = sqlite_connection.cursor()

# Criação da tabela no SQLite (se não existir)
cursor.execute('''
    CREATE TABLE IF NOT EXISTS temperaturas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        temperatura_media REAL NOT NULL,
        timestamp TEXT NOT NULL
    )
''')
sqlite_connection.commit()

# Configuração da porta serial
# Ajuste 'COM3' para a porta correta (no Linux pode ser algo como '/dev/ttyUSB0')
port = serial.Serial('COM3', baudrate=9600, timeout=1)

temperaturas = []  # Lista para armazenar as leituras

try:
    while True:
        data = port.readline().decode('utf-8').strip()
        
        # Verificar se o dado contém a informação de temperatura
        if "Temperatura =" in data:
            try:
                temperatura = float(data.split('=')[1].strip())
                temperaturas.append(temperatura)
                print(temperatura)

                # Se já tivermos 10 leituras, calcular a média e inserir no banco de dados
                if len(temperaturas) == 5:
                    temperatura_media = sum(temperaturas) / len(temperaturas)
                    timestamp = datetime.now().isoformat()

                    # Inserir a média e a data no SQLite
                    cursor.execute('''
                        INSERT INTO temperaturas (temperatura_media, timestamp)
                        VALUES (?, ?)
                    ''', (temperatura_media, timestamp))
                    sqlite_connection.commit()
                    
                    print(f"Média dos últimos 5 valores ({temperatura_media:.2f}°C) registrada no SQLite com timestamp {timestamp}")

                    # Limpar a lista para as próximas 10 leituras
                    temperaturas = []
            except ValueError:
                print("Erro ao converter a leitura para número.")
except KeyboardInterrupt:
    print("Leitura interrompida pelo usuário.")
finally:
    # Fechar a conexão serial e do banco de dados
    port.close()
    sqlite_connection.close()
