import { z } from "zod";

export const userFormSchema = z.object({
  name: z.string().min(2, "Nome deve ter pelo menos 2 caracteres"),
  email: z.string().email("Email inválido"),
  phone: z.string().min(10, "Telefone deve ter pelo menos 10 dígitos"),
  state: z.string().min(1, "Selecione um estado"),
  city: z.string().min(1, "Selecione uma cidade"),
  image: z.string().optional(),
});

export type UserFormData = z.infer<typeof userFormSchema>;
