<script setup>
import { ref, onMounted, onUnmounted } from "vue";
import LineChart from "./components/LineChart.vue";
import DataTable from "./components/DataTable.vue";

const mediaTemperatura = ref([]);
const mediaPorMinuto = ref([]);
const lastUpdateTime = ref(""); // Variável para armazenar a última atualização

async function fetchData() {
  try {
    const response = await fetch("http://localhost:5000/api/temperaturas");
    if (!response.ok) throw new Error("API request failed");

    const data = await response.json();
    mediaTemperatura.value = data;

    // Atualiza a hora da última atualização
    lastUpdateTime.value = new Date().toLocaleString();
  } catch (error) {
    console.error("Failed to fetch data:", error);
    mediaTemperatura.value = []; // Limpar dados se falhar
    lastUpdateTime.value = ""; // Limpa a hora se falhar
  }

  lineChartData.value = {
    labels: mediaTemperatura.value.map((item) => item.interval),
    datasets: [
      {
        label: "Média de Temperatura",
        data: mediaTemperatura.value.map((item) => item.media_temperatura),
        fill: false,
        borderColor: "rgb(75, 192, 192)",
        tension: 0.1,
      },
    ],
  };

  calculateAveragePerMinute();
}

function calculateAveragePerMinute() {
  const groupedData = {};
  mediaTemperatura.value.forEach((item) => {
    const minute = item.interval.split(":")[1];
    if (!groupedData[minute]) {
      groupedData[minute] = [];
    }
    groupedData[minute].push(item.media_temperatura);
  });

  mediaPorMinuto.value = Object.keys(groupedData).map((minute) => {
    const temperatures = groupedData[minute];
    const average =
      temperatures.reduce((sum, temp) => sum + parseFloat(temp), 0) /
      temperatures.length;
    return { Minute: minute, AverageTemperature: average.toFixed(2) };
  });

  // Populate tableData with the calculated averages
  tableData.value = mediaPorMinuto.value;
}

const lineChartData = ref(null);
const lineChartOptions = ref({
  responsive: true,
  plugins: {
    legend: {
      display: true,
      position: "top",
    },
    tooltip: {
      enabled: true,
    },
  },
  scales: {
    y: {
      beginAtZero: true,
    },
  },
});

const tableColumns = ref(["Minute", "AverageTemperature"]);
const tableData = ref([]);

onMounted(() => {
  fetchData();
  const intervalId = setInterval(fetchData, 10000);

  onUnmounted(() => {
    clearInterval(intervalId);
  });
});
</script>

<template>
  <div class="min-h-screen bg-[#F7FFFE]">
    <!-- Header with Decorative Background -->
    <header class="relative bg-[#F7FFFE] py-10 px-6">
      <div class="decorative-circle circle-1"></div>
      <div class="decorative-circle circle-2"></div>
      <div class="decorative-circle circle-3"></div>
      <!-- Title with higher z-index -->
      <h1
        class="relative z-10 text-4xl md:text-5xl font-bold text-[#0C4C82] text-center"
      >
        Boia-estação de Aferição de Qualidade da Água
      </h1>
    </header>

    <!-- Dashboard Content -->
    <main class="p-6 space-y-6 relative z-10">
      <!-- Row of Cards -->
      <section class="grid grid-cols-1 md:grid-cols-3 gap-6">
        <!-- Card 1: Temperatura Atual -->
        <div class="bg-white rounded-lg shadow p-6">
          <h2 class="text-xl font-semibold text-gray-700 mb-2">
            Temperatura Atual
          </h2>
          <p class="text-3xl font-bold text-[#0C4C82]">
            {{
              mediaTemperatura.length
                ? mediaTemperatura[0].media_temperatura
                : "---"
            }}°C
          </p>
        </div>
        <!-- Card 2: Média de Temperatura por Minuto -->
        <div class="bg-white rounded-lg shadow p-6">
          <h2 class="text-xl font-semibold text-gray-700 mb-2">
            Média de Temperatura por Minuto
          </h2>
          <p class="text-3xl font-bold text-[#0C4C82]">
            {{
              mediaPorMinuto.length
                ? mediaPorMinuto[0].AverageTemperature
                : "---"
            }}°C
          </p>
        </div>

        <!-- Card 3: Última Atualização -->
        <div class="bg-white rounded-lg shadow p-6">
          <h2 class="text-xl font-semibold text-gray-700 mb-2">
            Última Atualização
          </h2>

          <p class="text-lg font-medium text-gray-600">
            {{ lastUpdateTime || "Nenhuma atualização ainda" }}
          </p>
        </div>
      </section>

      <!-- Line Chart Section -->
      <section
        class="bg-white flex flex-col items-center rounded-lg shadow p-6 relative z-10"
      >
        <h2 class="text-xl font-semibold text-gray-700 mb-4">
          Gráfico de Temperatura por Segundo
        </h2>
        <LineChart
          class="flex justify-center items-center"
          v-if="lineChartData"
          :chart-data="lineChartData"
          :chart-options="lineChartOptions"
        />
      </section>

      <!-- Data Table Section -->
      <section class="bg-white rounded-lg shadow p-6 relative z-10">
        <h2 class="text-xl font-semibold text-gray-700 mb-4">
          Tabela de Média de Temperatura por Minuto
        </h2>
        <div class="overflow-x-auto">
          <DataTable :columns="tableColumns" :data="tableData" />
          <!-- Bind tableData here -->
        </div>
      </section>
    </main>
  </div>
</template>

<style scoped>
/* Configurações para as esferas coloridas */
.decorative-circle {
  position: absolute;
  border-radius: 50%;
  z-index: 0;
}

.circle-1 {
  background-color: #88e2e0; /* cor turquesa */
  width: 150px;
  height: 150px;
  top: 20px;
  left: 10px;
}

.circle-2 {
  background-color: #003366; /* azul escuro */
  width: 200px;
  height: 200px;
  bottom: 30px;
  right: 20px;
}

.circle-3 {
  background-color: #cceef4; /* azul claro */
  width: 120px;
  height: 120px;
  top: 60px;
  right: 100px;
}
</style>
