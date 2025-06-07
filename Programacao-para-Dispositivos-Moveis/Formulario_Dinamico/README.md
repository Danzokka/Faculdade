# Formulário Dinâmico com React Native e Expo

Este projeto demonstra um exemplo completo de formulário dinâmico com as seguintes funcionalidades:

## 🚀 Funcionalidades

- **Formulário com validação Zod**: Validação de campos em tempo real
- **Integração com API do IBGE**: Carregamento dinâmico de estados e cidades
- **Seletor de imagem**: Captura de foto ou seleção da galeria
- **AsyncStorage**: Persistência de dados local
- **Lista de usuários**: Visualização dos dados salvos
- **Suporte a modo escuro/claro**: Interface adaptativa

## 📋 Campos do Formulário

- Nome (obrigatório)
- Email (obrigatório)
- Telefone (obrigatório)
- Estado (carregado da API do IBGE)
- Cidade (carregado dinamicamente baseado no estado)
- Foto do perfil (opcional)

## 🛠️ Tecnologias Utilizadas

- React Native com Expo
- TypeScript
- Zod para validação
- React Hook Form
- AsyncStorage
- Expo Image Picker
- API do IBGE para estados e cidades

## 📱 Como usar

1. **Aba Formulário**: Preencha os dados do usuário

   - Selecione um estado para carregar as cidades
   - Adicione uma foto clicando no placeholder
   - Os dados são salvos automaticamente no AsyncStorage

2. **Aba Usuários**: Visualize todos os usuários cadastrados
   - Lista com foto, dados pessoais e localização
   - Puxe para atualizar a lista

## 🔧 Como executar

```bash
npm install
npm start
```

## 📂 Estrutura do Projeto

```
components/
├── DynamicForm.tsx     # Formulário principal
├── UserList.tsx        # Lista de usuários
└── ui/                 # Componentes de UI

hooks/
├── useImagePicker.ts   # Hook para seleção de imagens
└── useThemeColor.ts    # Hook para cores do tema

schemas/
└── userSchema.ts       # Schema Zod para validação

services/
├── ibgeService.ts      # Serviço para API do IBGE
└── storageService.ts   # Serviço para AsyncStorage
```

## 🎨 Features Implementadas

- ✅ Formulário dinâmico com Zod
- ✅ Validação em tempo real
- ✅ Integração com API do IBGE
- ✅ Seleção de imagem (galeria/câmera)
- ✅ Conversão para base64
- ✅ Persistência com AsyncStorage
- ✅ Lista dinâmica de usuários
- ✅ Interface responsiva
- ✅ Suporte a modo escuro/claro
