# 💻 Organiza+: Gerenciador de Tarefas e Hábitos Pessoais

## 🚀 Introdução

Este repositório documenta e apresenta o código-fonte do projeto **Organiza+**, um aplicativo móvel desenvolvido como **Trabalho de Conclusão da Disciplina (TCD)** de **Desenvolvimento de Aplicativos Móveis**.

O projeto foi realizado no **Centro Universitário Eurípides de Marília (UNIVEM)**, sob a orientação do **Prof. Ms. Nelson Julio de Oliveira Miranda**, e reflete a aplicação prática e a integração dos conhecimentos teóricos e técnicos adquiridos ao longo da disciplina.

#### Objetivo Geral

O **Objetivo Geral** do projeto foi **desenvolver um aplicativo Flutter funcional** que sirva como um Gerenciador de Tarefas Pessoais e Hábitos Diários, demonstrando domínio sobre os seguintes pilares do desenvolvimento móvel:

* **Interface Responsiva:** Construção da UI utilizando os widgets fundamentais do Flutter.
* **Gerenciamento de Estado:** Implementação de uma técnica eficiente (Provider ou setState) para updates dinâmicos.
* **Persistência Local:** Armazenamento persistente de dados usando `SharedPreferences` ou `sqflite`.
* **Boas Práticas de Arquitetura:** Organização do código em camadas (`model`, `view`, `controller`).

---

### ✨ Ideia Central e Recursos

O Organiza+ é um app de uso pessoal voltado à **produtividade e bem-estar**. Ele oferece uma plataforma limpa e intuitiva para o gerenciamento de atividades:

* **Gerenciamento de Tarefas:** Criação, edição e organização de tarefas diárias com título, descrição e prioridade.
* **Registro de Hábitos:** Acompanhamento de hábitos recorrentes (ex: beber água, caminhar, estudar).
* **Acompanhamento de Progresso:** Marcação de tarefas como concluídas e visualização do progresso diário.
* **Estatísticas Simples:** Exibição do percentual de tarefas concluídas no dia para feedback rápido.

---

### ⚙️ Requisitos Técnicos e Implementação

O aplicativo foi construído em Flutter, atendendo aos requisitos técnicos da disciplina:

| Requisito Técnico | Detalhe da Implementação |
| :--- | :--- |
| **Interface (UI)** | Construída com `Scaffold`, `AppBar`, `ListView`, `Card`, `TextField`, `IconButton`, `FloatingActionButton` e `SnackBar`. Aplicação de `ThemeData` para layout responsivo. |
| **Gerenciamento de Estado** | Utilizado **Provider** (ou **setState** - *Ajustar se usaram outra técnica*) para o gerenciamento de estado e atualização dinâmica da interface. |
| **Persistência de Dados** | As tarefas são salvas localmente utilizando **SharedPreferences** (ou **sqflite** - *Ajustar se usaram outra técnica*), garantindo a persistência dos dados. |
| **Estrutura de Projeto** | Segue a estrutura recomendada: `lib/model/`, `lib/view/`, `lib/controller/` ou `viewmodel/`. |

---

### ✅ Funcionalidades Implementadas

O projeto implementou todas as funcionalidades mínimas exigidas:

* **CRUD de Tarefas:** Adicionar, editar e remover tarefas.
* **Conclusão:** Marcar tarefas como concluídas e exibir na lista.
* **Filtragem:** Exibir a lista de tarefas filtrada (todas, pendentes, concluídas).
* **Métricas:** Exibição do percentual de tarefas concluídas no dia.
* **Persistência:** Armazenamento e recuperação de dados localmente após o fechamento do app.

#### 🚀 Extras 

* **EXTRAS**: **Modo Escuro (Dark Mode)**, **Notificações Locais** e
**Tela de Estatísticas**.

---

### 🛠️ Instruções de Execução

Para rodar o Organiza+ em sua máquina local, certifique-se de ter o Flutter instalado e siga os passos abaixo:

1.  **Clone o repositório:**
    ```bash
    git clone https://github.com/gpiantamar/organizamais
    cd Organizamais
    ```
2.  **Obtenha as dependências:**
    ```bash
    flutter pub get
    ```
3.  **Execute o aplicativo:**
    ```bash
    flutter run
    ```
    *Obs: O aplicativo foi testado nas plataformas [Android e/ou iOS e/ou web].*

---

### 👥 Integrantes do Grupo

* Guilherme Silva Piantamar - 638205
* Nikolas Dalton Perassoli Varella - 636010