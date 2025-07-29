# Auto JJS v2.1 - K9zzzzz

Sistema avançado de automação para polichinelos em jogos do Exército Brasileiro no Roblox.

## 🚀 Características

- **Interface moderna**: UI rainbow, minimalista e responsiva
- **Sistema modular**: Arquitetura organizada e escalável
- **Internacionalização**: Suporte para PT-BR, EN-US e ES-ES
- **Chat adaptativo**: Funciona com LegacyChatService (chat antigo)
- **Banco de numeros avançado**: Suporte para números gigantes
- **Notificações elegantes**: Sistema de notificações compacto
- **Compatibilidade**: PC e Mobile

## 📁 Estrutura do Projeto

```
K9zzzzzz-Script/
├── Main.lua                # Script principal (bootstrap)
├── UI.lua                  # Interface do usuário
├── Notification.lua        # Sistema de notificações
├── README.md               # Documentação
├── LICENSE                 # Licença MIT
│
├── Modules/                # Módulos de funcionalidade
│   ├── Character.lua       # Gerenciamento de personagem
│   ├── Extenso.lua         # Conversão numérica
│   ├── RemoteChat.lua      # Sistema de chat antigo
│   └── Request.lua         # Utilitários HTTP
│
└── I18N/                   # Internacionalização
    ├── pt-br.lua           # Português brasileiro
    ├── en-us.lua           # Inglês americano
    └── es-es.lua           # Espanhol
```

## 🎮 Como Usar


### Exemplo Completo
```lua
local Options = {
    Tempo = 2.0,           -- Mensagens a cada 2 segundos
    Language = "en-us"     -- Interface em inglês
}

loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Main.lua'))(Options)
```

### Configurações da UI
- **Começar do**: Definido na interface (padrão: 1)
- **Até o**: Definido na interface (padrão: 10)
- **Final do Prefix**: Definido na interface (padrão: "!")

## 🎨 Interface

- **Tamanho**: 1/8 da largura e 1/2 da altura da tela
- **Design**: Fundo preto com efeitos rainbow
- **Campos**: Começar do, Até o, Final do Prefix
- **Botão**: ▶ PULAR (rainbow animado)
- **Draggable**: Funciona no PC e Mobile

## 🔧 Módulos

### Character.lua
- Gerenciamento de personagem
- Informações do jogador
- Monitoramento de mudanças

### Extenso.lua
- Conversão numérica avançada
- Suporte para números gigantes
- Banco de dados para números complexos

### RemoteChat.lua
- Sistema para chat antigo (LegacyChatService)
- Retry automático
- Validação de mensagens

### Request.lua
- Utilitários HTTP
- Carregamento de scripts
- Testes de conectividade

## 🌍 Internacionalização

### Idiomas Suportados
- **pt-br**: Português brasileiro
- **en-us**: Inglês americano
- **es-es**: Espanhol

### Estrutura I18N
```lua
I18N = {
    UI = { ... },           -- Interface
    Notifications = { ... }, -- Notificações
    Numbers = { ... },       -- Números
    Errors = { ... },        -- Erros
    Success = { ... },       -- Sucessos
    Config = { ... }         -- Configurações
}
```

## 🎯 Funcionalidades

### Sistema de Números
- Conversão automática para extenso
- Suporte para números de 1 a trilhões
- Banco de dados para números gigantes
- Validação de entrada

### Sistema de Chat
- Compatível com LegacyChatService
- Retry automático em caso de falha
- Validação de tamanho de mensagem
- Monitoramento de status

### Sistema de Notificações
- Notificações compactas
- Posicionamento no canto inferior direito
- Cores por tipo (info, success, warning, error)
- Animações suaves

## 🔄 Próximas Atualizações

- [ ] Suporte para TextChatService (chat novo)
- [ ] Mais idiomas
- [ ] Configurações avançadas
- [ ] Sistema de temas
- [ ] Logs detalhados

## 🛠️ Desenvolvimento

### Testando Módulos
```lua
-- Testar módulo Extenso
local ext = loadstring(game:HttpGet('URL/Modules/Extenso.lua'))()
ext:TestarConversao()

-- Testar módulo RemoteChat
local chat = loadstring(game:HttpGet('URL/Modules/RemoteChat.lua'))()
chat:Test()

-- Testar módulo Character
local char = loadstring(game:HttpGet('URL/Modules/Character.lua'))()
char:Test()
```

### Adicionando Novo Idioma
1. Criar arquivo `I18N/novo-idioma.lua`
2. Seguir estrutura dos outros arquivos
3. Adicionar suporte na UI.lua

## 📝 Licença

MIT License - veja arquivo [LICENSE](LICENSE) para detalhes.

## 👨‍💻 Autor

**K9zzzzz** - Desenvolvedor do Auto JJS v2.1

---

⭐ **Se este projeto te ajudou, considere dar uma estrela!** 