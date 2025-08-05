# Auto JJs - Script para Roblox

Script automatizado para contagem de polichinelos ("JJs") em jogos Roblox simulando Exército Brasileiro.

## 📋 Características

- **Conversão automática**: Números convertidos para extenso com acentuação correta
- **Suporte até 21 dígitos**: Números de 0 a 999.999.999.999.999.999.999
- **Interface moderna**: Rayfield UI com design elegante e funcional
- **Controle total**: Iniciar, pausar, retomar e parar a contagem
- **Personalização**: Velocidade ajustável e texto adicional
- **Feedback visual**: Notificações informativas para todas as ações
- **Compatibilidade**: Funciona com principais executores de scripts

## 🚀 Como usar

### Carregamento via loadstring
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Progamador-Fred/K9-FrameWork/main/AutoJJs.lua"))()
```

### Interface
O script possui duas abas principais:

#### Aba "Auto JJs"
- **COMEÇAR DO**: Número inicial da contagem (0-999.999.999.999.999.999.999)
- **TERMINAR EM**: Número final da contagem (0-999.999.999.999.999.999.999)
- **FINAL DO PROMPT**: Texto opcional para adicionar ao final
- **VELOCIDADE**: Intervalo entre envios (0.5-3 segundos)
- **PULAR?**: Ativa/desativa o pulo do personagem
- **Botões de controle**: Começar, Pausar, Parar

#### Aba "Créditos"
- Informações sobre o script
- Lista de funcionalidades
- Instruções de uso

## ⚙️ Funcionalidades

### Conversão Numérica
- **Suporte até 21 dígitos**: Números de 0 a 999.999.999.999.999.999.999
- Acentuação correta em português
- Formato maiúsculo conforme solicitado
- Suporte a milhares, milhões, bilhões, trilhões, etc.

### Controles de Automação
- **Começar**: Inicia a contagem automática
- **Pausar**: Pausa temporariamente o envio
- **Retomar**: Continua a contagem pausada
- **Parar**: Cancela completamente e reseta

### Envio de Mensagens
- Utiliza o sistema de chat padrão do Roblox
- Compatível com `ReplicatedStorage.DefaultChatSystemChatEvents`
- Envio para todos os jogadores ("All")

### Sistema de Pulo
- Ativação opcional via toggle
- Utiliza `Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)`
- Executado após cada envio de mensagem

## 📱 Notificações

O script exibe notificações para todas as ações importantes:

- **Carregamento**: "Auto JJs carregado"
- **Início**: "Auto JJs iniciado"
- **Pausa**: "Auto JJs pausado"
- **Retomada**: "Auto JJs retomado"
- **Parada**: "Auto JJs parado"
- **Finalização**: "Auto JJs finalizado"
- **Erros**: Validação de inputs e ações inválidas

## 🔧 Requisitos Técnicos

### Executores Compatíveis
- Delta
- Synapse X
- Script-Ware
- KRNL
- Outros executores baseados em Lua

### Dependências
- Rayfield UI (carregado automaticamente)
- Sistema de chat do Roblox
- Humanoid do personagem (para pulo)

## 📝 Exemplos de Uso

### Contagem básica (0-1000)
```
COMEÇAR DO: 0
TERMINAR EM: 1000
VELOCIDADE: 1.5s
```

### Contagem com números grandes
```
COMEÇAR DO: 1000000
TERMINAR EM: 1000005
FINAL DO PROMPT: " - SOLDADO!"
VELOCIDADE: 2s
PULAR?: Ativado
```

### Contagem com números muito grandes
```
COMEÇAR DO: 999999999999999999990
TERMINAR EM: 999999999999999999999
FINAL DO PROMPT: " - ULTIMO!"
VELOCIDADE: 1s
PULAR?: Ativado
```

## 📁 Estrutura do Projeto

```
K9-FrameWork/
├── AutoJJs.lua          # Script principal (tudo em um arquivo)
├── README.md            # Documentação
├── LICENSE              # Licença do projeto
└── exemplo_uso.lua      # Exemplos de uso
```

## ⚠️ Observações

- **Uso exclusivo para testes internos**
- **Compatível apenas com jogos que utilizam o sistema de chat padrão do Roblox**
- **Requer permissões adequadas do executor**
- **Testado em ambiente controlado**
- **Estrutura simplificada para máxima compatibilidade**
- **Suporte até 21 dígitos (999.999.999.999.999.999.999)**

## 👨‍💻 Desenvolvimento

**Criado por**: k9zzzzzz  
**Nome do script**: Auto JJs  
**Versão**: 2.0  
**Data**: 2024  

### Estrutura do Código
- Interface Rayfield UI integrada
- Conversor numérico para extenso (até 21 dígitos)
- Sistema de controle de estados
- Funções de envio e pulo
- Sistema de notificações

## 📄 Licenças

### Licença do Projeto
Este projeto está licenciado sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

### Rayfield UI
Este projeto utiliza a biblioteca Rayfield UI, que é distribuída sob sua própria licença. Para mais informações sobre a Rayfield UI, visite: https://sirius.menu/rayfield

**Nota**: O uso da Rayfield UI está em conformidade com os termos de uso da biblioteca.

## 🤝 Contribuições

Este projeto é destinado exclusivamente para testes internos. Não são aceitas contribuições externas.

## ⚖️ Aviso Legal

Este script é destinado exclusivamente para testes internos em ambiente controlado. O uso deste script deve respeitar os Termos de Serviço do Roblox e as políticas do jogo específico.

---

**⚠️ Aviso**: Este script é destinado exclusivamente para testes internos em ambiente controlado. 