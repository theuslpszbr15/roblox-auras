# Auras do Super Socoo

27 auras (partículas, raios e asas) prontas para personagens R15, mais o **AuraKit**, que coloca as auras no jogador ou cria bonecos de vitrine com aura, como nos pedestais do Castelo Místico.

## Como usar

1. No Roblox Studio, clique com o botão direito em **ReplicatedStorage** > **Insert from File...** e escolha `AuraPack.rbxm`. A pasta precisa se chamar `AuraPack`.
2. Crie um **ModuleScript** chamado `AuraKit` dentro de ReplicatedStorage e cole o conteúdo de `AuraKit.luau`.
3. Crie um **LocalScript** em StarterPlayer > StarterPlayerScripts e cole `ExemploAura.client.luau`.
4. Dê Play.

## Funções

| Função | O que faz |
|---|---|
| `AuraKit.list()` | Nomes de todas as auras |
| `AuraKit.wear(personagem, "Aura_FlameCrown", cor?)` | Veste a aura no personagem e devolve uma função que tira a aura |
| `AuraKit.ghost("Aura_Atomic", CFrame, altura?, cor?, pai?)` | Cria um boneco brilhante com a aura em cima do ponto |

O parâmetro `cor` é opcional e puxa as cores da aura para a cor escolhida.

## Auras usadas no Super Socoo

| Soco | Aura |
|---|---|
| Punho de Ferro | `Aura_Anon` (puxada para prata) |
| Soco Flamejante | `Aura_FlameCrown` |
| Soco do Trovão | `Aura_Atomic` (puxada para azul claro) |
| Soco Arcano | `Aura_Aether` |
| Soco Celestial | `Aura_WhiteWings` |
| Soco do Abismo | `Aura Kurama` |

As demais auras do pacote também funcionam com as mesmas funções.

## Observações

- Os efeitos são só visuais. Rode no cliente (LocalScript); cada jogador vê as auras de todos se você chamar `wear` para cada personagem.
- Muitos efeitos ao mesmo tempo pesam no celular. Desligue os emissores quando o jogador estiver longe.
- As auras vieram de modelos gratuitos da Creator Store (scripts removidos). Use em jogos de Roblox e não revenda os arquivos.
