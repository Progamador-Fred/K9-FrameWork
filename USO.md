# 🚀 Como Usar o Auto JJS Melhorado

## 📋 Instruções Rápidas

### 1. Execute o script
```lua
loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Main.lua'))()
```

### 2. Use no jogo
- Pressione **RightControl** para mostrar/esconder a UI
- Configure a velocidade e idioma na interface
- Clique em **Iniciar** para começar
- Clique em **Parar** para parar

## 🎮 Controles

| Tecla | Função |
|-------|--------|
| **RightControl** | Mostrar/esconder a UI |
| **Mouse** | Arrastar a UI pela tela |
| **Botões** | Iniciar/Parar/Configurar |

## ⚙️ Configurações

### Velocidade
- Digite o tempo entre mensagens (ex: 2.5 segundos)

### Idioma
- **UI**: Idioma da interface (pt-br, en-us, es-es)
- **Números**: Idioma dos números (pt-br, en-us, es-es)

### Rainbow
- Ative para ter a UI colorida

## 🎯 Exemplos de Uso

### Uso básico:
```lua
loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Main.lua'))()
```

### Com configurações personalizadas (igual ao zy_yz):
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

### Exemplo completo:
```lua
local Options = {
    Keybind = Enum.KeyCode.F5,           --> Tecla para mostrar/esconder UI
    Tempo = 1.5,                         --> Tempo entre mensagens
    Rainbow = true,                      --> UI colorida
    Language = {
        UI = 'en-us',                    --> Interface em inglês
        Words = 'pt-br'                  --> Números em português
    },
};
loadstring(game:HttpGet('https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/Main.lua'))(Options);
```

## ⚠️ Avisos

- Use por sua conta e risco
- Respeite as regras do jogo
- Não abuse do script
- Alguns jogos podem ter sistemas anti-cheat

## 🆘 Suporte

Se tiver problemas:
1. Verifique se está em um jogo compatível
2. Teste com configurações básicas
3. Verifique se o chat está funcionando

---

**Criado por K9zzzzz** - Script proprietário 