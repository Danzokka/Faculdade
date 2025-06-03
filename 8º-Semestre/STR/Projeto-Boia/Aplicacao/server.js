const express = require('express');
const sqlite3 = require('better-sqlite3');
const cors = require('cors');

const app = express();
const port = 5000;

// Habilitar CORS para permitir requisições do frontend
app.use(cors());

// Conectar ao banco de dados SQLite
const db = new sqlite3('temperaturas.db');

// Função auxiliar para arredondar datas para o intervalo de 10 segundos
function roundTo10Seconds(date) {
  const seconds = date.getSeconds();
  const roundedSeconds = seconds < 10 ? 0 : 10;
  return new Date(date.setSeconds(roundedSeconds, 0));
}

// Rota para obter as médias de temperatura a cada 10 segundos do dia atual
app.get('/api/temperaturas', (req, res) => {
  try {
    const today = new Date().toISOString().split('T')[0]; // Data atual no formato YYYY-MM-DD
    const rows = db.prepare(`
      SELECT
        strftime('%Y-%m-%d %H:%M', timestamp) || ':' ||
        printf('%02d', (strftime('%S', timestamp) / 10) * 10) AS interval,
        AVG(temperatura_media) AS media_temperatura
      FROM temperaturas
      WHERE date(timestamp) = ?
      GROUP BY interval
      ORDER BY interval
    `).all(today);
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: 'Erro ao acessar o banco de dados' });
  }
});

// Rota para obter as médias de temperatura agregadas por minuto
app.get('/api/temperaturas/minuto', (req, res) => {
  try {
    const rows = db.prepare(`
      SELECT
        strftime('%Y-%m-%d %H:%M', timestamp) AS minuto,
        AVG(temperatura_media) AS media_temperatura
      FROM temperaturas
      GROUP BY minuto
      ORDER BY minuto
    `).all();
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: 'Erro ao acessar o banco de dados' });
  }
});

app.listen(port, () => {
  console.log(`Servidor rodando em http://localhost:${port}`);
});
