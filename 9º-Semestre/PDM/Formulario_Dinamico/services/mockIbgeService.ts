import { City, State } from "./ibgeService";

// Dados mock para desenvolvimento/fallback
export const MOCK_STATES: State[] = [
  { id: 35, sigla: "SP", nome: "São Paulo" },
  { id: 33, sigla: "RJ", nome: "Rio de Janeiro" },
  { id: 31, sigla: "MG", nome: "Minas Gerais" },
  { id: 41, sigla: "PR", nome: "Paraná" },
  { id: 43, sigla: "RS", nome: "Rio Grande do Sul" },
  { id: 42, sigla: "SC", nome: "Santa Catarina" },
  { id: 29, sigla: "BA", nome: "Bahia" },
  { id: 23, sigla: "CE", nome: "Ceará" },
  { id: 26, sigla: "PE", nome: "Pernambuco" },
  { id: 52, sigla: "GO", nome: "Goiás" },
  { id: 51, sigla: "MT", nome: "Mato Grosso" },
  { id: 50, sigla: "MS", nome: "Mato Grosso do Sul" },
  { id: 32, sigla: "ES", nome: "Espírito Santo" },
  { id: 15, sigla: "PA", nome: "Pará" },
  { id: 13, sigla: "AM", nome: "Amazonas" },
  { id: 21, sigla: "MA", nome: "Maranhão" },
  { id: 25, sigla: "PB", nome: "Paraíba" },
  { id: 24, sigla: "RN", nome: "Rio Grande do Norte" },
  { id: 27, sigla: "AL", nome: "Alagoas" },
  { id: 28, sigla: "SE", nome: "Sergipe" },
  { id: 22, sigla: "PI", nome: "Piauí" },
  { id: 12, sigla: "AC", nome: "Acre" },
  { id: 11, sigla: "RO", nome: "Rondônia" },
  { id: 14, sigla: "RR", nome: "Roraima" },
  { id: 16, sigla: "AP", nome: "Amapá" },
  { id: 17, sigla: "TO", nome: "Tocantins" },
  { id: 53, sigla: "DF", nome: "Distrito Federal" },
];

export const MOCK_CITIES: Record<string, City[]> = {
  "35": [
    // São Paulo
    { id: 3550308, nome: "São Paulo" },
    { id: 3509502, nome: "Campinas" },
    { id: 3518800, nome: "Guarulhos" },
    { id: 3552205, nome: "Santo André" },
    { id: 3548708, nome: "Ribeirão Preto" },
    { id: 3547809, nome: "Osasco" },
    { id: 3548906, nome: "São Bernardo do Campo" },
    { id: 3551009, nome: "Santos" },
    { id: 3549953, nome: "São José dos Campos" },
    { id: 3548708, nome: "Sorocaba" },
  ],
  "33": [
    // Rio de Janeiro
    { id: 3304557, nome: "Rio de Janeiro" },
    { id: 3302270, nome: "Niterói" },
    { id: 3301702, nome: "Duque de Caxias" },
    { id: 3303500, nome: "Nova Iguaçu" },
    { id: 3301900, nome: "Campos dos Goytacazes" },
    { id: 3303302, nome: "São Gonçalo" },
    { id: 3300456, nome: "Belford Roxo" },
    { id: 3303609, nome: "Petrópolis" },
    { id: 3302858, nome: "Magé" },
    { id: 3304904, nome: "Volta Redonda" },
  ],
  "31": [
    // Minas Gerais
    { id: 3106200, nome: "Belo Horizonte" },
    { id: 3170206, nome: "Uberlândia" },
    { id: 3106705, nome: "Contagem" },
    { id: 3136702, nome: "Juiz de Fora" },
    { id: 3106309, nome: "Betim" },
    { id: 3144805, nome: "Montes Claros" },
    { id: 3154606, nome: "Ribeirão das Neves" },
    { id: 3169307, nome: "Uberaba" },
    { id: 3118601, nome: "Governador Valadares" },
    { id: 3132404, nome: "Ipatinga" },
  ],
  "41": [
    // Paraná
    { id: 4106902, nome: "Curitiba" },
    { id: 4113700, nome: "Londrina" },
    { id: 4115200, nome: "Maringá" },
    { id: 4118402, nome: "Ponta Grossa" },
    { id: 4108304, nome: "Foz do Iguaçu" },
    { id: 4104808, nome: "Cascavel" },
    { id: 4125506, nome: "São José dos Pinhais" },
    { id: 4106803, nome: "Colombo" },
    { id: 4109401, nome: "Guarapuava" },
    { id: 4118204, nome: "Paranaguá" },
  ],
};

export class MockIBGEService {
  static async getStates(): Promise<State[]> {
    // Simula delay de rede
    await new Promise((resolve) => setTimeout(resolve, 500));
    return MOCK_STATES;
  }

  static async getCitiesByState(stateId: string): Promise<City[]> {
    // Simula delay de rede
    await new Promise((resolve) => setTimeout(resolve, 300));
    return MOCK_CITIES[stateId] || [];
  }
}
