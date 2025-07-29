# Auto JJS Melhorado

Um script modular e avançado para automatizar polichinelos em jogos de Exército Brasileiro no Roblox, baseado no Auto JJS do zy_yz com melhorias significativas.

**Criado por K9zzzzz**

## 🚀 Funcionalidades

- **Múltiplos idiomas**: Português, Inglês, Espanhol (UI e números separados)
- **Interface gráfica completa**: UI moderna e funcional
- **Sistema de notificações**: Feedback visual em tempo real
- **Anti-detecção**: Variação no timing para parecer mais humano
- **Efeito Rainbow**: UI colorida opcional
- **Configuração flexível**: Todas as opções na interface
- **Draggable UI**: Interface arrastável
- **Modular**: Código organizado em módulos

## 📁 Estrutura do Projeto

```
AutoJJs-Melhorado/
├── Main.lua              # Arquivo principal
├── AutoJJs.lua           # Módulo core
├── UI.lua                # Módulo de interface
├── Numbers.lua           # Módulo de números
├── Notification.lua      # Módulo de notificações
├── loadstring.lua        # Arquivo para loadstring
└── README.md             # Este arquivo
```

## 🎯 Como usar

### Método 1: Loadstring simples
```lua
loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Main.lua'))()
```

### Método 2: Loadstring com configurações
```lua
loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/loadstring.lua'))()({
    Keybind = Enum.KeyCode.Home,
    Tempo = 2.0,
    Language = {
        UI = 'en-us',
        Words = 'pt-br'
    },
    Rainbow = true
})
```

## ⚙️ Configurações

| Configuração | Descrição | Padrão |
|--------------|-----------|--------|
| `Keybind` | Tecla para mostrar/esconder UI | `RightControl` |
| `Tempo` | Tempo entre mensagens (segundos) | `2.5` |
| `Language.UI` | Idioma da interface | `'pt-br'` |
| `Language.Words` | Idioma dos números | `'pt-br'` |
| `Rainbow` | Efeito rainbow na UI | `false` |
| `StartNumber` | Número inicial | `1` |
| `EndNumber` | Número final | `80` |
| `FinalPrompt` | Final da mensagem | `"!"` |
| `AntiDetection` | Anti-detecção | `true` |

### Idiomas disponíveis
- **pt-br**: Português (UM, DOIS, TRÊS...)
- **en-us**: Inglês (ONE, TWO, THREE...)
- **es-es**: Espanhol (UNO, DOS, TRES...)

## 🎮 Controles

- **Tecla configurada**: Mostrar/esconder a UI
- **Botão Iniciar**: Começar a contagem automática
- **Botão Parar**: Parar a contagem
- **Arrastar**: Mover a UI pela tela
- **Rainbow**: Ativar/desativar efeito colorido

## 🔧 Recursos Avançados

### Sistema de Notificações
- Notificações animadas
- Diferentes tipos (info, success, error, warning)
- Auto-remoção após tempo
- Botão de fechar manual

### Anti-Detecção
- Variação aleatória no timing
- Configurável via interface
- Simula comportamento humano

### Interface Moderna
- Design responsivo
- Animações suaves
- Hover effects
- Corner radius
- Stroke effects

## 📝 Exemplos de Uso

### Exemplo 1: Configuração básica
```lua
loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/loadstring.lua'))()({
    Keybind = Enum.KeyCode.Home,
    Tempo = 2.5,
    Language = {
        UI = 'pt-br',
        Words = 'pt-br'
    }
})
```

### Exemplo 2: Configuração avançada
```lua
loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/loadstring.lua'))()({
    Keybind = Enum.KeyCode.RightControl,
    Tempo = 1.5,
    Language = {
        UI = 'en-us',
        Words = 'es-es'
    },
    Rainbow = true,
    StartNumber = 10,
    EndNumber = 50,
    FinalPrompt = "!"
})
```

## 🛠️ Compatibilidade

### Executores suportados
- ✅ JJSploit
- ✅ Synapse X
- ✅ KRNL
- ✅ Script-Ware
- ✅ Fluxus
- ✅ Comet

### Jogos compatíveis
- ✅ Exércitos Brasileiros
- ✅ Jogos com chat LegacyChatService
- ✅ Jogos com TextChatService

## 🔄 Changelog

### v2.0 - Melhorado
- ✅ Interface gráfica completa
- ✅ Sistema modular
- ✅ Múltiplos idiomas
- ✅ Notificações avançadas
- ✅ Anti-detecção
- ✅ Efeito rainbow
- ✅ UI draggable

### v1.0 - Base
- ✅ Funcionalidade básica
- ✅ Configuração simples

## ⚠️ Avisos

- Use por sua conta e risco
- Alguns jogos podem ter sistemas anti-cheat
- Respeite as regras do jogo
- Não abuse do script

## 🤝 Contribuições

Sinta-se livre para melhorar o script e compartilhar suas modificações!

## 📄 Licença

MIT License - veja o arquivo LICENSE para detalhes.

---

**Criado por K9zzzzz** - Script proprietário

**Baseado no Auto JJS do zy_yz** - [Repositório original](https://github.com/Zv-yz/AutoJJs)

**Inspirado no K9-FrameWork** - [Repositório de referência](https://github.com/Progamador-Fred/K9-FrameWork) 