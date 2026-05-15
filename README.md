# Mini-Transformer em RISC-V

Projeto da UC **Introdução à Arquitetura de Computadores (IAC)** — IST.

Implementação de um **Mini-Transformer** simplificado, inspirado no mecanismo de atenção do artigo *Attention Is All You Need* (Vaswani et al., 2017). O objetivo é compreender na prática como funcionam os mecanismos centrais por trás de modelos como o ChatGPT.

## Estado atual do projeto

- **Parte 1**: Concluído e submetido  
- **Parte 2**: Em desenvolvimento (não publicado)  
- **Parte 3** (Acelerador em hardware): Ainda não iniciado

**Apenas o Projeto 1 está disponível neste repositório.**

## Projeto 1 — Operações Fundamentais

Implementação em Assembly RISC-V (com extensão M) das seguintes funções:

- `select` — Seleção de elemento num vetor
- `argmax` — Índice do maior elemento (menor índice em caso de empate)
- `dot` — Produto interno entre dois vetores (com deteção de overflow)

Estas funções são a base para o mecanismo de atenção que será implementado no Projeto 2.

### Tecnologias
- Assembly RISC-V (RV32IM)
- Simulador **Ripes**
- Extensão de multiplicação (M)

## Como executar (Ripes)

1. Abrir o Ripes
2. Carregar o ficheiro `.s` correspondente
3. Configurar os registos de entrada (`a1`, `a2`, `a3`)
4. Executar e verificar os valores de retorno em `a0` e `a1`

## Objetivos de aprendizagem

- Manipulação eficiente de vetores em Assembly
- Gestão de ponteiros e memória
- Controlo de fluxo e deteção de erros
- Preparação para implementação de um mecanismo de atenção simplificado

---

**Nota importante**

Este repositório contém **apenas** a parte 1. O código das partes 2 e 3 **não será** publicado enquanto não forem avaliadas, para evitar qualquer problema com regras de plágio ou avaliação da UC.

---
