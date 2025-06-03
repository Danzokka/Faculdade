import { IBGEService } from "@/services/ibgeService";
import { useQuery } from "@tanstack/react-query";

// Hook para buscar estados
export const useStates = () => {
  return useQuery({
    queryKey: ["states"],
    queryFn: IBGEService.getStates,
    staleTime: 24 * 60 * 60 * 1000, // 24 hours - estados raramente mudam
    gcTime: 24 * 60 * 60 * 1000, // 24 hours
    retry: 3,
    retryDelay: (attemptIndex) => Math.min(1000 * 2 ** attemptIndex, 30000),
  });
};

// Hook para buscar cidades por estado
export const useCities = (stateId: string | undefined) => {
  return useQuery({
    queryKey: ["cities", stateId],
    queryFn: () => IBGEService.getCitiesByState(stateId!),
    enabled: !!stateId, // Só executa se tiver stateId
    staleTime: 24 * 60 * 60 * 1000, // 24 hours - cidades raramente mudam
    gcTime: 24 * 60 * 60 * 1000, // 24 hours
    retry: 3,
    retryDelay: (attemptIndex) => Math.min(1000 * 2 ** attemptIndex, 30000),
  });
};
