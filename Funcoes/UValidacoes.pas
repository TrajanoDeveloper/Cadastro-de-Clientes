unit UValidacoes;

interface

uses
  System.SysUtils, System.Classes, System.RegularExpressions;

type
  TValidacoes = class
  public
    class function ValidarCPF(const ACPF: string): Boolean;
    class function ValidarCNPJ(const ACNPJ: string): Boolean;
    class function ValidarCPF_CNPJ(const ADocumento: string): Boolean;
    class function FormatarCPF(const ACPF: string): string;
    class function FormatarCNPJ(const ACNPJ: string): string;
    class function FormatarCPF_CNPJ(const ADocumento: string): string;
    class function LimparFormatacao(const ATexto: string): string;
    class function ValidarCEP(const ACEP: string): Boolean;
    class function FormatarCEP(const ACEP: string): string;
    class function ValidarEmail(const AEmail: string): Boolean;
    class function SomenteNumeros(const ATexto: string): string;
  end;

implementation

{ TValidacoes }

class function TValidacoes.ValidarCPF(const ACPF: string): Boolean;
var
  CPF: string;
  I, Soma, Resto: Integer;
  Digito1, Digito2: Integer;
begin
  Result := False;

  // Remove formatação
  CPF := SomenteNumeros(ACPF);

  // Verifica se tem 11 dígitos
  if Length(CPF) <> 11 then
    Exit;

  // Verifica se todos os dígitos são iguais
  if (CPF = '00000000000') or (CPF = '11111111111') or
     (CPF = '22222222222') or (CPF = '33333333333') or
     (CPF = '44444444444') or (CPF = '55555555555') or
     (CPF = '66666666666') or (CPF = '77777777777') or
     (CPF = '88888888888') or (CPF = '99999999999') then
    Exit;

  // Calcula o primeiro dígito verificador
  Soma := 0;
  for I := 1 to 9 do
    Soma := Soma + StrToInt(CPF[I]) * (11 - I);

  Resto := Soma mod 11;
  if Resto < 2 then
    Digito1 := 0
  else
    Digito1 := 11 - Resto;

  // Calcula o segundo dígito verificador
  Soma := 0;
  for I := 1 to 10 do
    Soma := Soma + StrToInt(CPF[I]) * (12 - I);

  Resto := Soma mod 11;
  if Resto < 2 then
    Digito2 := 0
  else
    Digito2 := 11 - Resto;

  // Verifica se os dígitos calculados conferem
  Result := (Digito1 = StrToInt(CPF[10])) and (Digito2 = StrToInt(CPF[11]));
end;

class function TValidacoes.ValidarCNPJ(const ACNPJ: string): Boolean;
const
  Pesos1: array[1..12] of Integer = (5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2);
  Pesos2: array[1..13] of Integer = (6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2);
var
  CNPJ: string;
  I, Soma, Resto: Integer;
  Digito1, Digito2: Integer;

begin
  Result := False;

  // Remove formatação
  CNPJ := SomenteNumeros(ACNPJ);

  // Verifica se tem 14 dígitos
  if Length(CNPJ) <> 14 then
    Exit;

  // Verifica se todos os dígitos são iguais
  if (CNPJ = '00000000000000') or (CNPJ = '11111111111111') or
     (CNPJ = '22222222222222') or (CNPJ = '33333333333333') or
     (CNPJ = '44444444444444') or (CNPJ = '55555555555555') or
     (CNPJ = '66666666666666') or (CNPJ = '77777777777777') or
     (CNPJ = '88888888888888') or (CNPJ = '99999999999999') then
    Exit;

  // Calcula o primeiro dígito verificador
  Soma := 0;
  for I := 1 to 12 do
    Soma := Soma + StrToInt(CNPJ[I]) * Pesos1[I];

  Resto := Soma mod 11;
  if Resto < 2 then
    Digito1 := 0
  else
    Digito1 := 11 - Resto;

  // Calcula o segundo dígito verificador
  Soma := 0;
  for I := 1 to 13 do
    Soma := Soma + StrToInt(CNPJ[I]) * Pesos2[I];

  Resto := Soma mod 11;
  if Resto < 2 then
    Digito2 := 0
  else
    Digito2 := 11 - Resto;

  // Verifica se os dígitos calculados conferem
  Result := (Digito1 = StrToInt(CNPJ[13])) and (Digito2 = StrToInt(CNPJ[14]));
end;

class function TValidacoes.ValidarCPF_CNPJ(const ADocumento: string): Boolean;
var
  Doc: string;
begin
  Doc := SomenteNumeros(ADocumento);

  case Length(Doc) of
    11: Result := ValidarCPF(Doc);
    14: Result := ValidarCNPJ(Doc);
  else
    Result := False;
  end;
end;

class function TValidacoes.FormatarCPF(const ACPF: string): string;
var
  CPF: string;
begin
  CPF := SomenteNumeros(ACPF);

  if Length(CPF) = 11 then
    Result := Format('%s.%s.%s-%s', [Copy(CPF, 1, 3), Copy(CPF, 4, 3), Copy(CPF, 7, 3), Copy(CPF, 10, 2)])
  else
    Result := ACPF;
end;

class function TValidacoes.FormatarCNPJ(const ACNPJ: string): string;
var
  CNPJ: string;
begin
  CNPJ := SomenteNumeros(ACNPJ);

  if Length(CNPJ) = 14 then
    Result := Format('%s.%s.%s/%s-%s', [Copy(CNPJ, 1, 2), Copy(CNPJ, 3, 3), Copy(CNPJ, 6, 3), Copy(CNPJ, 9, 4), Copy(CNPJ, 13, 2)])
  else
    Result := ACNPJ;
end;

class function TValidacoes.FormatarCPF_CNPJ(const ADocumento: string): string;
var
  Doc: string;
begin
  Doc := SomenteNumeros(ADocumento);

  case Length(Doc) of
    11: Result := FormatarCPF(Doc);
    14: Result := FormatarCNPJ(Doc);
  else
    Result := ADocumento;
  end;
end;

class function TValidacoes.LimparFormatacao(const ATexto: string): string;
begin
  Result := TRegEx.Replace(ATexto, '[^0-9]', '');
end;

class function TValidacoes.ValidarCEP(const ACEP: string): Boolean;
var
  CEP: string;
begin
  CEP := SomenteNumeros(ACEP);
  Result := Length(CEP) = 8;
end;

class function TValidacoes.FormatarCEP(const ACEP: string): string;
var
  CEP: string;
begin
  CEP := SomenteNumeros(ACEP);

  if Length(CEP) = 8 then
    Result := Format('%s-%s', [Copy(CEP, 1, 5), Copy(CEP, 6, 3)])
  else
    Result := ACEP;
end;

class function TValidacoes.ValidarEmail(const AEmail: string): Boolean;
const
  EmailPattern = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
begin
  Result := TRegEx.IsMatch(AEmail, EmailPattern);
end;

class function TValidacoes.SomenteNumeros(const ATexto: string): string;
begin
  Result := TRegEx.Replace(ATexto, '[^0-9]', '');
end;

end.
