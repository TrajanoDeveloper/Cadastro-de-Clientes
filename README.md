# Sistema de Cadastro de Clientes

## 📋 Descrição

Sistema desktop desenvolvido em **Delphi/Pascal** para gerenciamento completo de clientes, com integração à API ViaCEP para preenchimento automático de endereços e validações de dados como CPF.

**Tecnologias:** Object Pascal (Delphi) • VCL • Firebird 3.0+ • FireDAC • API ViaCEP

## ⚡ Funcionalidades Principais

- ✅ **Cadastro Completo de Clientes** - Nome, CPF, endereço, data de nascimento
- ✅ **Validação Automática de CPF** - Algoritmo oficial brasileiro
- ✅ **Integração ViaCEP** - Preenchimento automático por CEP (8 dígitos)
- ✅ **Gerenciamento de Localidades** - Estados e cidades com relacionamentos
- ✅ **Sistema de Pesquisa Avançada** - Por período, cidade ou estado
- ✅ **Operações CRUD Completas** - Criar, visualizar, editar e excluir
- ✅ **Interface MDI Intuitiva** - Múltiplas janelas e navegação por abas
- ✅ **Relatórios de Clientes** - Listagem e exportação de dados

## Apresentação do Sistema

🖼 Tela Principal

<img width="1158" height="796" alt="image" src="https://github.com/user-attachments/assets/8dcc82d1-7333-450d-b629-8610176293a0" />

🖼 Tela de Cadastro

<img width="1063" height="748" alt="image" src="https://github.com/user-attachments/assets/b503909c-a907-4387-bec7-9a8af71a51c9" />

🖼 Tela de Pesquisa

<img width="1061" height="745" alt="image" src="https://github.com/user-attachments/assets/e46fa042-91fe-47b8-986e-1fda789eb2c6" />

🖼 Tela de Relatório

<img width="1058" height="725" alt="image" src="https://github.com/user-attachments/assets/61ae7ddb-e76b-45cd-a4ba-495470804a52" />

🖼 Relatório Emitido

<img width="881" height="1222" alt="image" src="https://github.com/user-attachments/assets/161b5cf6-05dd-4a2a-9bcb-32032f8c104c" />

🖼 Visão Geral do Sistema

<img width="2196" height="922" alt="image" src="https://github.com/user-attachments/assets/fd9ebeb3-c61b-4d73-88bb-b8a4819285c3" />




## 🔧 Requisitos do Sistema

### Mínimos
- **SO:** Windows 7+ (32/64 bits)
- **RAM:** 2 GB (4 GB recomendado)
- **Disco:** 500 MB + espaço para banco
- **Firebird:** 3.0+

### Desenvolvimento
- **RAD Studio/Delphi:** 10.3 Rio+
- **Componentes:** FireDAC (incluído)
- **Opcional:** DevExpress VCL

## 🚀 Instalação e Configuração

### 1. Configurar Firebird
```bash
# Instalar Firebird 3.0+ com configurações padrão
# Porta: 3050 | Usuário: SYSDBA | Senha: masterkey
```

### 2. Configurar Banco de Dados
```ini
# Editar Config/database.ini
[DATABASE]
DriverID=FB
Database=D:\Sistema Clientes\Database\CLIENTES.FDB
User_Name=SYSDBA
Password=masterkey
Server=localhost
Port=3050
CharacterSet=UTF8
```

### 3. Executar Sistema
```bash
# Executar diretamente
Win32\Debug\Clientes.exe

# Ou compilar no Delphi
dcc32 Clientes.dpr
```

## 📁 Estrutura de Pastas

```
Sistema Clientes/
├── 📁 Apresentação/           # Interface visual (Forms)
│   ├── DfmCadClientes.dfm     # Layout cadastro de clientes
│   ├── DfmCadClientes.pas     # Lógica cadastro de clientes
│   ├── DfmRelClientes.dfm     # Layout relatórios
│   └── DfmRelClientes.pas     # Lógica relatórios
│
├── 📁 Controles/              # Lógica de negócio
│   └── UcadClientes.pas       # Controlador principal
│
├── 📁 InfraData/              # Acesso a dados
│   └── Uconexao.pas           # Conexão com Firebird
│
├── 📁 Funcoes/                # Utilitários
│   ├── UFuncionalidades.pas   # Funções gerais
│   ├── UValidacoes.pas        # Validação CPF/dados
│   └── UViaCEP.pas           # Integração API ViaCEP
│
├── 📁 Config/                 # Configurações
│   └── database.ini           # Config banco Firebird
│
├── 📁 Database/               # Banco de dados
│   └── CLIENTES.FDB          # Arquivo Firebird
│
├── 📁 Win32/Debug/           # Executáveis
│   └── Clientes.exe          # Sistema compilado
│
├── 📄 Clientes.dpr           # Projeto principal
├── 📄 Principal.pas          # Formulário MDI principal
└── 📄 README.md              # Esta documentação
```

## 💡 Exemplos de Uso

### Cadastrar Cliente
1. **Menu:** Cadastro → Clientes
2. **Preencher:** Nome, CPF, Data Nascimento
3. **Buscar CEP:** Digite CEP → "Buscar CEP" (preenchimento automático)
4. **Completar:** Número, complemento
5. **Salvar:** Validação automática de CPF

### Pesquisar por Período
1. **Aba:** Pesquisa
2. **Filtro:** "Clientes por Período"
3. **Datas:** Data inicial e final
4. **Executar:** "Filtrar"
5. **Visualizar:** Duplo clique para editar

### Integração ViaCEP (Exemplo de Código)
```pascal
function TcadClientes.BuscarCEP(CEP: String): Boolean;
var
  ViaCEP: TViaCEP;
  Endereco: TEndereco;
begin
  ViaCEP := TViaCEP.Create;
  try
    Endereco := ViaCEP.BuscarCEP(CEP);
    if not Endereco.Erro then
    begin
      Endereco_Cliente.endereco := Endereco.Logradouro;
      Endereco_Cliente.bairro := Endereco.Bairro;
      Endereco_Cliente.cidade := Endereco.Localidade;
      Result := True;
    end;
  finally
    ViaCEP.Free;
  end;
end;
```

## 🗄️ Estrutura do Banco

### Tabelas Principais

**CLIENTE**
- `ID` (INTEGER, PK) - Chave primária
- `NOME` (VARCHAR(100)) - Nome completo
- `CPF_CNPJ` (VARCHAR(20)) - CPF/CNPJ
- `CEP` (VARCHAR(10)) - Código postal
- `ENDERECO` (VARCHAR(200)) - Logradouro
- `NUMERO` (VARCHAR(10)) - Número
- `COMPLEMENTO` (VARCHAR(100)) - Complemento
- `BAIRRO` (VARCHAR(100)) - Bairro
- `CIDADE` (INTEGER, FK) - Referência à cidade
- `DATANASCIMENTO` (DATE) - Data nascimento

**CIDADE**
- `ID` (INTEGER, PK) - Chave primária
- `NOME` (VARCHAR(100)) - Nome da cidade
- `ESTADOID` (INTEGER, FK) - Referência ao estado

**ESTADO**
- `ID` (INTEGER, PK) - Chave primária
- `NOME` (VARCHAR(100)) - Nome do estado
- `UF` (VARCHAR(2)) - Sigla UF

## 🔧 Solução de Problemas

### Erro de Conexão
```bash
# Verificar serviço Firebird
net start FirebirdServerDefaultInstance

# Testar conexão
isql -user SYSDBA -password masterkey localhost:caminho\CLIENTES.FDB
```

### DLL Não Encontrada
```bash
# Copiar fbclient.dll para pasta da aplicação
# Ou adicionar pasta Firebird ao PATH do sistema
```
⭐ Se este projeto foi útil para você, considere dar uma estrela no repositório! ⭐

---

**Versão:** 1.0.0 | **Atualização:** Outubro 2025 | **Compatibilidade:** Delphi 12+ / Firebird 3.0+

*Desenvolvido com ❤️ em Delphi/Pascal*
