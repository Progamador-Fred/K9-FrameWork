# 🦘 K9-FrameWork - Auto JJs Script

Script modular, personalizável e compatível com múltiplos jogos para contar JJ's automaticamente no chat.

**Criado por K9zzzzz**

## 📁 Estrutura do Projeto

```
K9-FrameWork/
├── 📄 Main.lua              # Arquivo principal (execução)
├── 📄 loadstring.lua         # Arquivo para loadstring com config
├── 📄 LICENSE                # Licença MIT
├── 📁 modules/               # Módulos do sistema
│   ├── AutoJJs.lua          # Core do script
│   ├── UI.lua               # Interface gráfica
│   ├── Numbers.lua          # Números por extenso
│   └── Notification.lua     # Sistema de notificações
├── 📁 docs/                  # Documentação
│   ├── README.md            # Documentação completa
│   └── USO.md               # Instruções de uso
└── 📁 examples/              # Exemplos e configurações
    ├── example.lua          # Exemplos de uso
    └── Config.lua           # Configurações de exemplo
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

    Language = {
        UI = 'pt-br', --> Alterar a linguagem da UI, disponíveis: pt-br, en-us, es-es
        Words = 'pt-br' --> Alterar a linguagem dos números em extenso, disponíveis: pt-br, en-us, es-es
    },
};
loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Main.lua'))(Options);
```

## ✅ Funcionalidades

- **Múltiplos idiomas**: Português, Inglês, Espanhol
- **UI completa**: Interface moderna e funcional
- **Sistema modular**: Código organizado e reutilizável
- **Anti-detecção**: Variação no timing
- **Notificações**: Sistema avançado de feedback
- **Rainbow effect**: UI colorida opcional

## 🎮 Controles

- **RightControl**: Mostrar/esconder UI
- **Mouse**: Arrastar interface
- **Botões**: Iniciar/Parar/Configurar

## 📚 Documentação

- [📖 Documentação Completa](docs/README.md)
- [🚀 Instruções de Uso](docs/USO.md)
- [💡 Exemplos](examples/example.lua)

## ⚠️ Avisos

- Use por sua conta e risco
- Respeite as regras do jogo
- Não abuse do script

---

**Criado por K9zzzzz** - Script proprietário 