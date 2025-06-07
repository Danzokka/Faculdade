export interface State {
  id: number;
  sigla: string;
  nome: string;
}

export interface City {
  id: number;
  nome: string;
}

export class IBGEService {
  private static readonly BASE_URL =
    "https://servicodados.ibge.gov.br/api/v1/localidades";
  private static readonly REQUEST_TIMEOUT = 10000; // 10 seconds

  private static async fetchWithTimeout(
    url: string,
    timeout = this.REQUEST_TIMEOUT
  ): Promise<Response> {
    const controller = new AbortController();
    const timeoutId = setTimeout(() => controller.abort(), timeout);

    try {
      const response = await fetch(url, {
        signal: controller.signal,
        headers: {
          Accept: "application/json",
          "Content-Type": "application/json",
        },
      });

      clearTimeout(timeoutId);
      return response;
    } catch (error) {
      clearTimeout(timeoutId);
      throw error;
    }
  }

  static async getStates(): Promise<State[]> {
    try {
      const response = await this.fetchWithTimeout(
        `${this.BASE_URL}/estados?orderBy=nome`
      );

      if (!response.ok) {
        throw new Error(
          `HTTP Error: ${response.status} - ${response.statusText}`
        );
      }

      const data = await response.json();
      console.log("Estados carregados:", data.length);
      return data;
    } catch (error) {
      console.error("Erro ao buscar estados:", error);
      throw new Error(
        "Falha ao carregar estados. Verifique sua conexão com a internet."
      );
    }
  }

  static async getCitiesByState(stateId: string): Promise<City[]> {
    if (!stateId) {
      throw new Error("ID do estado é obrigatório");
    }

    try {
      const response = await this.fetchWithTimeout(
        `${this.BASE_URL}/estados/${stateId}/municipios?orderBy=nome`
      );

      if (!response.ok) {
        throw new Error(
          `HTTP Error: ${response.status} - ${response.statusText}`
        );
      }

      const data = await response.json();
      console.log(`Cidades carregadas para estado ${stateId}:`, data.length);
      return data;
    } catch (error) {
      console.error("Erro ao buscar cidades:", error);
      throw new Error(
        "Falha ao carregar cidades. Verifique sua conexão com a internet."
      );
    }
  }
}
