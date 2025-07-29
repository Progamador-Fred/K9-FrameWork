# 🦘 K9-FrameWork - Auto JJs Script

Script simples e funcional para contar JJ's automaticamente no chat.

**Criado por K9zzzzz**

## 📁 Estrutura do Projeto

```
K9-FrameWork/
├── 📄 Main.lua              # Arquivo principal
├── 📄 UI.lua                # Interface gráfica
├── 📄 Notification.lua      # Sistema de notificações
├── 📄 LICENSE               # Licença MIT
├── 📄 README.md             # Este arquivo
├── 📁 I18N/                 # Internacionalização
│   ├── pt-br.lua           # Português Brasileiro
│   ├── en-us.lua           # Inglês Americano
│   ├── es-es.lua           # Espanhol
│   └── en-us-dev.lua       # Inglês (Desenvolvimento)
└── 📁 Modules/              # Módulos do sistema
    ├── Character.lua        # Gerenciamento de personagem
    ├── Extenso.lua          # Conversão de números (Gambiarra)
    ├── RemoteChat.lua       # Sistema de chat
    └── Request.lua          # Requisições HTTP
```

## 🚀 Como Usar

### Método 1: Uso básico
```lua
loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Main.lua'))()
```

### Método 2: Com configurações
```lua
local Options = {
    StartNumber = 1,        -- Número inicial
    EndNumber = 100,        -- Número final
    FinalPrompt = "!",      -- Prompt final
    SkipMode = false,       -- Modo pular
    Tempo = 2.5            -- Velocidade
};
loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Main.lua'))(Options);
```

## ✅ Funcionalidades

- **UI igual ao zy_yz**: Interface simples e funcional
- **Gambiarra do Extenso**: Converte qualquer número para extenso
- **Sistema de chat**: Suporte a chat antigo e novo
- **Interface draggable**: Pode ser movida
- **Toggle de pular**: Opção para pular números
- **Configuração flexível**: Qualquer número inicial e final

## 🎯 Controles

- **Mouse**: Arrastar interface
- **Botão Play**: Iniciar/Parar contagem
- **Inputs**: Configurar números e prompt
- **Toggle**: Ativar/desativar modo pular

## 🔧 Gambiarra do Extenso

O script usa uma gambiarra inteligente para converter qualquer número para extenso:

- **Números 1-99**: Conversão normal
- **Números 100+**: Gambiarra que converte cada dígito

Exemplo:
- 123 = "UM DOIS TRÊS"
- 1000 = "UM ZERO ZERO ZERO"

## ⚠️ Avisos

- Use por sua conta e risco
- Respeite as regras do jogo
- Não abuse do script

---

**Criado por K9zzzzz** - Script proprietário 