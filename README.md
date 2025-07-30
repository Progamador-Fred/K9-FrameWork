# AutoJJs - Script para Roblox

Um script em Lua para enviar polichinelos (JJs) no chat do Roblox de forma automatizada.

## 📋 Funcionalidades

- ✅ Envia mensagens numeradas por extenso (ZERO, UM, DOIS...)
- ✅ Configuração de delay antes da execução
- ✅ Detecção automática do tipo de chat (antigo/novo)
- ✅ Interface amigável com Orion UI Library
- ✅ Opção para pular números pares
- ✅ Sufixo personalizável nas mensagens
- ✅ Compatível com dispositivos mobile

## 🎮 Executores Suportados

- **Delta** (Mobile/PC)
- **Hydrogen** (Mobile/PC)  
- **Fluxus** (Mobile/PC)

## 🚀 Como Usar

### Delta Executor

1. Abra o Delta Executor
2. Vá para a aba "Scripts"
3. Cole o seguinte código no loader:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/K9zzz32/Auto-JJ-s/main/loader.lua"))()
```

4. Execute o script
5. Configure o delay quando solicitado
6. Use a interface para configurar os parâmetros
7. Clique em "▶ Iniciar"

### Hydrogen Executor

1. Abra o Hydrogen Executor
2. Vá para a aba "Scripts"
3. Cole o mesmo código do loader
4. Execute e siga os passos acima

### Fluxus Executor

1. Abra o Fluxus Executor
2. Vá para a aba "Scripts"
3. Cole o mesmo código do loader
4. Execute e siga os passos acima

## 🖼️ Screenshots da Interface

```
┌─────────────────────────────────────┐
│         K9zzzzz - Auto JJs         │
├─────────────────────────────────────┤
│ Começar do: [    1    ]            │
│ Até o:      [   100   ]            │
│ Final do Prefix: [    !    ]       │
│ [✓] Pular números pares            │
│                                     │
│         [▶ Iniciar]                │
└─────────────────────────────────────┘
```

## ⚙️ Configurações

- **Começar do**: Número inicial para começar a contagem
- **Até o**: Número final para parar a contagem
- **Final do Prefix**: Texto adicional no final da mensagem (ex: "!")
- **Pular números pares**: Ativa/desativa para ignorar números pares
- **Delay**: Configurado via console antes da UI aparecer

## 🔧 Detecção de Chat

O script detecta automaticamente o tipo de chat usado pelo jogo:

- **Chat Novo**: Usa `TextChatService.TextChannels.RBXGeneral:SendAsync()`
- **Chat Antigo**: Usa `game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer()`

## ⚠️ Avisos Importantes

- Use apenas em jogos onde você tem permissão para usar scripts
- Respeite as regras do jogo e dos servidores
- O uso inadequado pode resultar em banimento
- Teste em servidores privados primeiro

## 📁 Estrutura do Projeto

```
/AutoJJs
├── README.md
├── scripts/
│   ├── jj_main.lua
│   ├── chat_legacy.lua
│   ├── chat_modern.lua
└── loader.lua
```

## 🤝 Contribuição

Contribuições são bem-vindas! Sinta-se à vontade para:

- Reportar bugs
- Sugerir melhorias
- Enviar pull requests

## 📄 Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.

## 👨‍💻 Autor

**K9zzzzz**

---

⭐ Se este projeto te ajudou, considere dar uma estrela no repositório! 