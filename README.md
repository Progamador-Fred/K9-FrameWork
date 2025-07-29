# 🦘 K9-FrameWork - Auto JJs Script

Script modular, personalizável e compatível com múltiplos jogos para contar JJ's automaticamente no chat.

**Criado por K9zzzzz**

## 📁 Estrutura do Projeto

```
K9-FrameWork/
├── 📄 Main.lua              # Arquivo principal (execução)
├── 📄 AutoJJs.lua           # Core do script
├── 📄 UI.lua                # Interface gráfica
├── 📄 Numbers.lua           # Números por extenso
├── 📄 Notification.lua      # Sistema de notificações
├── 📄 LICENSE               # Licença MIT
├── 📄 README.md             # Este arquivo
├── 📁 Modules/              # Módulos do sistema
│   └── ChatAdapter.lua      # Sistema de adaptação de chat
└── 📁 I18N/                 # Internacionalização
```

## 🚀 Como Usar

### Método 1: Uso básico
```lua
loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Main.lua'))()
```

### Método 2: Com configurações (igual ao zy_yz)
```lua
local Options = {
    Keybind = Enum.KeyCode.Home, --> Keybind para mostrar/esconder a UI
    Tempo = 2.5, --> Tempo para enviar mensagem
    Rainbow = false, --> Deixar a UI mais colorida (true/false)
    StartNumber = 1, --> Número inicial (1 até 100.000.000)
    EndNumber = 80, --> Número final (1 até 100.000.000)
    FinalPrompt = "!", --> Prompt final das mensagens
    AntiDetection = true, --> Anti-detecção

    Language = {
        UI = 'pt-br', --> Alterar a linguagem da UI, disponíveis: pt-br, en-us, es-es
        Words = 'pt-br' --> Alterar a linguagem dos números em extenso, disponíveis: pt-br, en-us, es-es
    },
};
loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Main.lua'))(Options);
```

## ✅ Funcionalidades

### 🔧 Sistema Completo
- **Múltiplos idiomas**: Português, Inglês, Espanhol
- **UI completa**: Interface moderna e funcional
- **Sistema modular**: Código organizado e reutilizável
- **Anti-detecção**: Variação no timing
- **Notificações**: Sistema avançado de feedback
- **Rainbow effect**: UI colorida opcional

### 🎮 Adaptação Automática de Chat
- **TextChatService**: Suporte ao novo sistema de chat do Roblox
- **LegacyChatService**: Suporte ao sistema antigo de chat
- **CustomChat**: Suporte a sistemas customizados
- **Fallback**: Sistema de backup para máxima compatibilidade
- **Detecção automática**: Identifica o tipo de chat automaticamente

### 🔢 Suporte a Números Grandes
- **Números 1-80**: Por extenso em todos os idiomas
- **Números 81-100.000.000**: Em formato digital
- **Configuração flexível**: Qualquer número inicial e final
- **Validação automática**: Previne configurações inválidas
- **Progresso em tempo real**: Notificações de progresso

### 🎯 Controles
- **RightControl**: Mostrar/esconder UI (configurável)
- **Mouse**: Arrastar interface
- **Botões**: Iniciar/Parar/Testar Chat
- **Inputs**: Configurar velocidade, idiomas, números, etc.

## 🔧 Configurações Avançadas

### Opções Disponíveis
```lua
local Options = {
    Keybind = Enum.KeyCode.RightControl, -- Tecla para mostrar/esconder UI
    Tempo = 2.5, -- Tempo entre mensagens (segundos)
    Rainbow = false, -- Efeito rainbow na UI
    StartNumber = 1, -- Número inicial (1-100.000.000)
    EndNumber = 80, -- Número final (1-100.000.000)
    FinalPrompt = "!", -- Prompt final das mensagens
    AntiDetection = true, -- Variação aleatória no timing
    
    Language = {
        UI = 'pt-br', -- Idioma da interface
        Words = 'pt-br' -- Idioma dos números
    }
}
```

### Exemplos de Uso

#### Contar de 1 a 10
```lua
local Options = {
    StartNumber = 1,
    EndNumber = 10,
    Tempo = 1.0
};
loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Main.lua'))(Options);
```

#### Contar de 1000 a 2000
```lua
local Options = {
    StartNumber = 1000,
    EndNumber = 2000,
    Tempo = 3.0
};
loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Main.lua'))(Options);
```

#### Contar apenas um número
```lua
local Options = {
    StartNumber = 50,
    EndNumber = 50,
    Tempo = 1.0
};
loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Main.lua'))(Options);
```

### Idiomas Suportados
- **pt-br**: Português Brasileiro
- **en-us**: Inglês Americano
- **es-es**: Espanhol

## 🛠️ Sistema de Adaptação de Chat

O script detecta automaticamente o tipo de chat usado no jogo:

1. **TextChatService** (Chat novo do Roblox)
2. **LegacyChatService** (Chat antigo)
3. **CustomChat** (Sistemas customizados)
4. **Fallback** (Métodos alternativos)

### Teste de Conexão
Use o botão "Testar Chat" na interface para verificar se o sistema está funcionando corretamente.

## 🎨 Interface

A interface inclui:
- **Status**: Mostra se está executando ou parado
- **Contador**: Número atual sendo enviado
- **Tipo de Chat**: Sistema detectado automaticamente
- **Número Inicial**: Configuração do primeiro número
- **Número Final**: Configuração do último número
- **Prompt Final**: Símbolo/palavra após o número
- **Velocidade**: Configuração do tempo entre mensagens
- **Idiomas**: Seleção de idioma para UI e números
- **Rainbow**: Toggle para efeito colorido
- **Botões**: Iniciar, Parar, Testar Chat

## ⚠️ Avisos

- Use por sua conta e risco
- Respeite as regras do jogo
- Não abuse do script
- O script é compatível com diferentes tipos de chat do Roblox
- Números muito grandes podem levar muito tempo para completar
- O sistema limita automaticamente o número máximo a 100.000.000

## 🔄 Atualizações

- Sistema de adaptação automática de chat
- Interface moderna e responsiva
- Suporte a múltiplos idiomas
- Sistema anti-detecção aprimorado
- Notificações avançadas
- **Suporte a números grandes (1-100.000.000)**
- **Configuração flexível de números inicial e final**
- **Progresso em tempo real**
- **Validação automática de configurações**

---

**Criado por K9zzzzz** - Script proprietário 