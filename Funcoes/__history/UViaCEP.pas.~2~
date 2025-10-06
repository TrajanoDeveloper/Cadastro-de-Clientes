unit UViaCEP;

interface

uses
  System.SysUtils, System.Classes, System.JSON, System.Net.HttpClient,
  System.Net.URLClient, System.StrUtils;

type
  TEndereco = record
    CEP: string;
    Logradouro: string;
    Complemento: string;
    Bairro: string;
    Localidade: string;
    UF: string;
    IBGE: string;
    GIA: string;
    DDD: string;
    SIAFI: string;
    Erro: Boolean;
    MensagemErro: string;
    Estado: string;
  end;

  TViaCEP = class
  private
    FHttpClient: THTTPClient;
    function ValidarCEPAvancado(const ACEP: string): Boolean;
    function LimparEFormatarCEP(const ACEP: string): string;
  public
    constructor Create;
    destructor Destroy; override;
    function BuscarCEP(const ACEP: string): TEndereco;
    function BuscarEndereco(const AUF, ACidade, ALogradouro: string): TArray<TEndereco>;
    function TestarConexao: Boolean;
  end;

implementation

uses
  UValidacoes;

{ TViaCEP }

constructor TViaCEP.Create;
begin
  inherited Create;
  FHttpClient := THTTPClient.Create;
  FHttpClient.ConnectionTimeout := 10000; // 10 segundos
  FHttpClient.ResponseTimeout := 10000;   // 10 segundos
end;

destructor TViaCEP.Destroy;
begin
  FHttpClient.Free;
  inherited Destroy;
end;

function TViaCEP.BuscarCEP(const ACEP: string): TEndereco;
var
  CEP: string;
  URL: string;
  Response: IHTTPResponse;
  JSONResponse: TJSONObject;
  JSONValue: TJSONValue;
  ResponseContent: string;
begin
  // Inicializa o resultado com valores padrão
  FillChar(Result, SizeOf(Result), 0);
  Result.Erro := True;
  Result.MensagemErro := 'CEP não encontrado';

  try
    // Validação avançada do CEP de entrada
    if Trim(ACEP) = '' then
    begin
      Result.MensagemErro := 'CEP não informado';
      Exit;
    end;

    if not ValidarCEPAvancado(ACEP) then
    begin
      Result.MensagemErro := 'CEP inválido. Deve conter 8 dígitos numéricos válidos';
      Exit;
    end;

    // Limpa e formata o CEP
    CEP := LimparEFormatarCEP(ACEP);

    // Monta a URL da API com protocolo HTTPS
    URL := Format('https://viacep.com.br/ws/%s/json/', [CEP]);

    try
      // Configura headers para melhor compatibilidade
      FHttpClient.UserAgent := 'Sistema Clientes v1.0';
      FHttpClient.Accept := 'application/json';

      // Faz a requisição HTTP
      Response := FHttpClient.Get(URL);

      // Verifica o status da resposta
      case Response.StatusCode of
        200:
        begin
          ResponseContent := Trim(Response.ContentAsString);

          // Verifica se a resposta não está vazia
          if ResponseContent = '' then
          begin
            Result.MensagemErro := 'Resposta vazia da API ViaCEP';
            Exit;
          end;

          // Parse do JSON com tratamento de erro
          try
            JSONResponse := TJSONObject.ParseJSONValue(ResponseContent) as TJSONObject;
          except
            on E: Exception do
            begin
              Result.MensagemErro := 'Erro ao processar resposta da API: ' + E.Message;
              Exit;
            end;
          end;

          try
            if Assigned(JSONResponse) then
            begin
              // Verifica se houve erro na API (CEP não encontrado)
              JSONValue := JSONResponse.GetValue('erro');
              if Assigned(JSONValue) and (LowerCase(JSONValue.Value) = 'true') then
              begin
                Result.MensagemErro := 'CEP não encontrado na base de dados dos Correios';
                Exit;
              end;

              // Sucesso - preenche os dados do endereço
              Result.Erro := False;
              Result.MensagemErro := '';

              // Extrai dados com verificação de nulidade
              JSONValue := JSONResponse.GetValue('cep');
              Result.CEP := IfThen(Assigned(JSONValue), JSONValue.Value, '');

              JSONValue := JSONResponse.GetValue('logradouro');
              Result.Logradouro := IfThen(Assigned(JSONValue), Trim(JSONValue.Value), '');

              JSONValue := JSONResponse.GetValue('complemento');
              Result.Complemento := IfThen(Assigned(JSONValue), Trim(JSONValue.Value), '');

              JSONValue := JSONResponse.GetValue('bairro');
              Result.Bairro := IfThen(Assigned(JSONValue), Trim(JSONValue.Value), '');

              JSONValue := JSONResponse.GetValue('localidade');
              Result.Localidade := IfThen(Assigned(JSONValue), Trim(JSONValue.Value), '');

              JSONValue := JSONResponse.GetValue('uf');
              Result.UF := IfThen(Assigned(JSONValue), UpperCase(Trim(JSONValue.Value)), '');

              JSONValue := JSONResponse.GetValue('estado');
              Result.Estado := IfThen(Assigned(JSONValue), UpperCase(Trim(JSONValue.Value)), '');

              JSONValue := JSONResponse.GetValue('ibge');
              Result.IBGE := IfThen(Assigned(JSONValue), JSONValue.Value, '');

              JSONValue := JSONResponse.GetValue('gia');
              Result.GIA := IfThen(Assigned(JSONValue), JSONValue.Value, '');

              JSONValue := JSONResponse.GetValue('ddd');
              Result.DDD := IfThen(Assigned(JSONValue), JSONValue.Value, '');

              JSONValue := JSONResponse.GetValue('siafi');
              Result.SIAFI := IfThen(Assigned(JSONValue), JSONValue.Value, '');

              // Validação adicional dos dados essenciais
              if (Result.Localidade = '') and (Result.UF = '') then
              begin
                Result.Erro := True;
                Result.MensagemErro := 'Dados incompletos retornados pela API';
              end;
            end
            else
            begin
              Result.MensagemErro := 'Resposta inválida da API ViaCEP';
            end;
          finally
            if Assigned(JSONResponse) then
              JSONResponse.Free;
          end;
        end;

        400:
          Result.MensagemErro := 'Requisição inválida. Verifique o formato do CEP';

        404:
          Result.MensagemErro := 'CEP não encontrado';

        429:
          Result.MensagemErro := 'Muitas requisições. Tente novamente em alguns segundos';

        500..599:
          Result.MensagemErro := 'Erro interno do servidor ViaCEP. Tente novamente mais tarde';

        else
          Result.MensagemErro := Format('Erro na requisição: %d - %s', [Response.StatusCode, Response.StatusText]);
      end;

    except
      on E: ENetHTTPClientException do
      begin
        Result.MensagemErro := 'Erro de conexão: ' + E.Message;
      end;
      on E: ENetHTTPRequestException do
      begin
        Result.MensagemErro := 'Erro na requisição HTTP: ' + E.Message;
      end;
    end;

  except
    on E: Exception do
    begin
      Result.Erro := True;
      Result.MensagemErro := 'Erro inesperado ao consultar CEP: ' + E.Message;
    end;
  end;
end;

function TViaCEP.BuscarEndereco(const AUF, ACidade, ALogradouro: string): TArray<TEndereco>;
var
  URL: string;
  Response: IHTTPResponse;
  JSONResponse: TJSONArray;
  JSONObject: TJSONObject;
  JSONValue: TJSONValue;
  I: Integer;
  Endereco: TEndereco;
begin
  SetLength(Result, 0);

  try
    // Valida os parâmetros
    if (Trim(AUF) = '') or (Trim(ACidade) = '') or (Trim(ALogradouro) = '') then
      Exit;

    if (Length(Trim(AUF)) <> 2) or (Length(Trim(ACidade)) < 3) or (Length(Trim(ALogradouro)) < 3) then
      Exit;

    // Monta a URL da API
    URL := Format('https://viacep.com.br/ws/%s/%s/%s/json/',
      [Trim(AUF), Trim(ACidade), Trim(ALogradouro)]);

    // Faz a requisição
    Response := FHttpClient.Get(URL);

    if Response.StatusCode = 200 then
    begin
      // Parse do JSON
      JSONResponse := TJSONObject.ParseJSONValue(Response.ContentAsString) as TJSONArray;
      try
        if Assigned(JSONResponse) then
        begin
          SetLength(Result, JSONResponse.Count);

          for I := 0 to JSONResponse.Count - 1 do
          begin
            JSONObject := JSONResponse.Items[I] as TJSONObject;

            // Inicializa o endereço
            FillChar(Endereco, SizeOf(Endereco), 0);
            Endereco.Erro := False;

            // Preenche os dados
            JSONValue := JSONObject.GetValue('cep');
            if Assigned(JSONValue) then
              Endereco.CEP := JSONValue.Value;

            JSONValue := JSONObject.GetValue('logradouro');
            if Assigned(JSONValue) then
              Endereco.Logradouro := JSONValue.Value;

            JSONValue := JSONObject.GetValue('complemento');
            if Assigned(JSONValue) then
              Endereco.Complemento := JSONValue.Value;

            JSONValue := JSONObject.GetValue('bairro');
            if Assigned(JSONValue) then
              Endereco.Bairro := JSONValue.Value;

            JSONValue := JSONObject.GetValue('localidade');
            if Assigned(JSONValue) then
              Endereco.Localidade := JSONValue.Value;

            JSONValue := JSONObject.GetValue('uf');
            if Assigned(JSONValue) then
              Endereco.UF := JSONValue.Value;

            JSONValue := JSONObject.GetValue('ibge');
            if Assigned(JSONValue) then
              Endereco.IBGE := JSONValue.Value;

            JSONValue := JSONObject.GetValue('gia');
            if Assigned(JSONValue) then
              Endereco.GIA := JSONValue.Value;

            JSONValue := JSONObject.GetValue('ddd');
            if Assigned(JSONValue) then
              Endereco.DDD := JSONValue.Value;

            JSONValue := JSONObject.GetValue('siafi');
            if Assigned(JSONValue) then
              Endereco.SIAFI := JSONValue.Value;

            Result[I] := Endereco;
          end;
        end;
      finally
        JSONResponse.Free;
      end;
    end;

  except
    on E: Exception do
    begin
      // Em caso de erro, retorna array vazio
      SetLength(Result, 0);
    end;
  end;
end;

function TViaCEP.ValidarCEPAvancado(const ACEP: string): Boolean;
var
  CEP: string;
  I: Integer;
  DigitosIguais: Boolean;
begin
  Result := False;
  CEP := LimparEFormatarCEP(ACEP);

  // Verifica se tem exatamente 8 dígitos
  if Length(CEP) <> 8 then
    Exit;

  // Verifica se todos os caracteres são dígitos
  for I := 1 to Length(CEP) do
  begin
    if not CharInSet(CEP[I], ['0'..'9']) then
      Exit;
  end;

  // Verifica se não são todos dígitos iguais
  DigitosIguais := True;
  for I := 2 to Length(CEP) do
  begin
    if CEP[I] <> CEP[1] then
    begin
      DigitosIguais := False;
      Break;
    end;
  end;

  if DigitosIguais then
    Exit;

  // Validação básica de faixas de CEP válidas no Brasil
  // CEPs válidos: 01000-000 a 99999-999 (excluindo algumas faixas reservadas)
  if (CEP < '01000000') or (CEP > '99999999') then
    Exit;

  Result := True;
end;

function TViaCEP.LimparEFormatarCEP(const ACEP: string): string;
var
  I: Integer;
begin
  Result := '';

  // Remove todos os caracteres não numéricos
  for I := 1 to Length(ACEP) do
  begin
    if CharInSet(ACEP[I], ['0'..'9']) then
      Result := Result + ACEP[I];
  end;

  // Completa com zeros à esquerda se necessário (para CEPs com menos de 8 dígitos)
  while Length(Result) < 8 do
    Result := '0' + Result;
end;

function TViaCEP.TestarConexao: Boolean;
var
  Response: IHTTPResponse;
begin
  Result := False;

  try
    // Testa conectividade com um CEP conhecido (Praça da Sé, São Paulo)
    FHttpClient.ConnectionTimeout := 5000; // 5 segundos para teste
    FHttpClient.ResponseTimeout := 5000;

    Response := FHttpClient.Get('https://viacep.com.br/ws/01310-100/json/');
    Result := (Response.StatusCode = 200);

    // Restaura timeouts originais
    FHttpClient.ConnectionTimeout := 10000;
    FHttpClient.ResponseTimeout := 10000;

  except
    Result := False;
  end;
end;

end.
