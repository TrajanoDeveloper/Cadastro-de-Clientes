unit DfmCadClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Mask, Vcl.DBCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait, UcadClientes, Datasnap.DBClient, Datasnap.Provider,
  Data.Win.ADODB, Vcl.Grids, Vcl.DBGrids, UValidacoes, UFuncionalidades;

type
  THabilitaBotoes = (todos, novo, pesquisa, limpar);
  TFrmcadClientes = class(TForm)
    PageControl: TPageControl;
    Panel1: TPanel;
    Btn_novo: TButton;
    Btn_Limpar: TButton;
    PgCadastro: TTabSheet;
    PgPesquisa: TTabSheet;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    Edt_nome: TDBEdit;
    Edt_CPF: TDBEdit;
    Edt_data_nascimento: TDBEdit;
    Edt_CEP: TDBEdit;
    GroupBox2: TGroupBox;
    btnBuscarCEP: TButton;
    Edt_Endereco: TDBEdit;
    Edt_numero: TDBEdit;
    Edt_complemento: TDBEdit;
    Edt_Bairro: TDBEdit;
    Edt_cidade: TDBEdit;
    Edt_estado: TDBEdit;
    Lb_nome: TLabel;
    Lb_CPF: TLabel;
    Lb_CEP: TLabel;
    Lb_Datanascimento: TLabel;
    Label5: TLabel;
    Lb_numero: TLabel;
    Label7: TLabel;
    Lb_complemento: TLabel;
    Lb_Bairro: TLabel;
    Lb_Estado: TLabel;
    Panel3: TPanel;
    GrdClientes: TDBGrid;
    Btn_Salvar: TButton;
    Btn_Fechar: TButton;
    Btn_Excluir: TButton;
    Gb_periodo: TGroupBox;
    lblDataInicial: TLabel;
    lblDataFinal: TLabel;
    dtpDataInicial: TDateTimePicker;
    dtpDataFinal: TDateTimePicker;
    Gb_Cidades: TGroupBox;
    lblCidade: TLabel;
    CMB_cidades: TDBLookupComboBox;
    Gb_Estados: TGroupBox;
    CMB_Estado: TDBLookupComboBox;
    btn_filtrar: TButton;
    Rgb_Filtro: TRadioGroup;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GrdClientesDblClick(Sender: TObject);
    procedure Btn_LimparClick(Sender: TObject);
    procedure Btn_novoClick(Sender: TObject);
    procedure Btn_FecharClick(Sender: TObject);
    procedure Btn_SalvarClick(Sender: TObject);
    procedure Btn_ExcluirClick(Sender: TObject);
    procedure btnBuscarCEPClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure Rgb_FiltroClick(Sender: TObject);
    procedure btn_filtrarClick(Sender: TObject);
  private
    { Private declarations }
    FUCadClientes: TcadClientes;
    HabilitaBotoes: THabilitaBotoes;
    procedure ParemtrizarCamposAoBanco;
    Procedure LimparCampos;
    procedure HabilitarCampos(Habilitar: Boolean);
    procedure HabilitarBotoes(HabilitaBotao: THabilitaBotoes);
    function ValidarDados: Boolean;

  public
    { Public declarations }
  end;

var
  FrmcadClientes: TFrmcadClientes;

implementation

{$R *.dfm}

procedure TFrmcadClientes.Btn_novoClick(Sender: TObject);
begin
  LimparCampos;
  HabilitarBotoes(novo);
  HabilitarCampos(True);
  if not FUCadClientes.FCDS_Aux.Active then
    FUCadClientes.FCDS_Aux.Active := True;
  FUCadClientes.FCDS_Aux.Insert;
  Edt_nome.SetFocus;
end;

procedure TFrmcadClientes.Btn_SalvarClick(Sender: TObject);
begin

  if ValidarDados then
  begin
    if FUCadClientes.FCDS_Aux.FieldByName('ID').IsNull then
      FUCadClientes.Persistencia(True)
    else
      FUCadClientes.Persistencia(False);
   FUCadClientes.CarregarDadosClientes;
   HabilitarBotoes(todos);
   HabilitarCampos(False);
   LimparCampos;
  end;
end;

procedure TFrmcadClientes.btnBuscarCEPClick(Sender: TObject);
var
  CEP: string;
begin
  CEP := Trim(edt_CEP.Text);

  if CEP = '' then
  begin
    MessageDlg('Informe o CEP para realizar a busca.',TMsgDlgType.mtInformation,[TMsgDlgBtn.mbOK],0);
    edt_CEP.SetFocus;
    Exit;
  end;

  if not TValidacoes.ValidarCEP(CEP) then
  begin
    MessageDlg('CEP inválido. Informe um CEP com 8 dígitos.',TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
    edt_CEP.SetFocus;
    Exit;
  end;

  if FUCadClientes.BuscarCEP(CEP) then
  begin

    if FUCadClientes.FCDS_Aux.State in [dsbrowse] then
      FUCadClientes.FCDS_Aux.Edit;
    Edt_Endereco.Field.Value := FUCadClientes.Endereco_Cliente.endereco;
    Edt_complemento.Field.Value := FUCadClientes.Endereco_Cliente.complemento;
    Edt_Bairro.Field.Value := FUCadClientes.Endereco_Cliente.bairro;
    Edt_cidade.text := FUCadClientes.Endereco_Cliente.cidade;
    Edt_estado.text := FUCadClientes.Endereco_Cliente.estado;
    FUCadClientes.FCDS_Aux.FieldByName('UF').AsString := FUCadClientes.Endereco_Cliente.UF;
    if FUCadClientes.FCDS_Aux.State in [dsbrowse] then
      FUCadClientes.FCDS_Aux.Post;
    Edt_numero.SetFocus;
  end
  else
    Edt_CEP.SetFocus;
end;

procedure TFrmcadClientes.Btn_ExcluirClick(Sender: TObject);
var
  PodeExcluir: Boolean;
  MensagemValidacao: string;
begin
  TFuncionalidades.ValidarIdExclusao(FUCadClientes.FCDS_Aux.FieldByName('ID').AsInteger, PodeExcluir, MensagemValidacao);
  if not PodeExcluir then
  begin
    MessageDlg((MensagemValidacao),TMsgDlgType.mtWarning,[TMsgDlgBtn.mbOK],0);
    Exit;
  end;
  if MessageDlg('Você tem certeza que deseja excluir o cliente?',mtConfirmation,[mbyes,mbno],0)=mryes then
  begin
    FUCadClientes.Excluir;
    FUCadClientes.CarregarDadosClientes;
  end;
  HabilitarBotoes(todos);
  LimparCampos;
end;

procedure TFrmcadClientes.Btn_FecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmcadClientes.btn_filtrarClick(Sender: TObject);
begin
  case Rgb_Filtro.ItemIndex of
     0:
     begin
       FUCadClientes.FOpcaoFiltro := 0;
       FUCadClientes.AplicarFiltros;
     end;
     1:
     begin
        FUCadClientes.FDataNascIni := dtpDataInicial.Date;
        FUCadClientes.FDataNascFin := dtpDataFinal.Date;
        FUCadClientes.FOpcaoFiltro := 1;
        FUCadClientes.AplicarFiltros;
     end;
     2:
     begin
       if CMB_cidades.KeyValue < 0 then
       begin
         MessageDlg('Informe uma Cidade!',TMsgDlgType.mtWarning,[TMsgDlgBtn.mbOK],0);
         Exit;
       end;
       FUCadClientes.FIdCidade := StrToInt(CMB_cidades.KeyValue);
       FUCadClientes.FOpcaoFiltro := 2;
       FUCadClientes.AplicarFiltros;
     end;
     3:
     begin
       if CMB_Estado.KeyValue < 0 then
       begin
         MessageDlg('Informe um Estado!',TMsgDlgType.mtWarning,[TMsgDlgBtn.mbOK],0);
         Exit;
       end;
       FUCadClientes.FIdEstado := StrToInt(CMB_Estado.KeyValue);
       FUCadClientes.FOpcaoFiltro := 3;
       FUCadClientes.AplicarFiltros;
     end;
  end;

end;

procedure TFrmcadClientes.Btn_LimparClick(Sender: TObject);
begin
  LimparCampos;
  HabilitarBotoes(limpar);
  HabilitarCampos(false);
end;

procedure TFrmcadClientes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := TCloseAction.caFree;
end;

procedure TFrmcadClientes.FormCreate(Sender: TObject);
begin
  FUCadClientes := TcadClientes.Create;
  ParemtrizarCamposAoBanco;
  FUCadClientes.FOpcaoFiltro := 0;
end;

procedure TFrmcadClientes.FormShow(Sender: TObject);
begin
  PageControl.TabIndex := 0;
  Rgb_Filtro.ItemIndex := 0;
  FUCadClientes.CarregarDadosClientes;
  FUCadClientes.CarregarCidades;
  FUCadClientes.CarregarEstados;
  FUCadClientes.RetornarDadosDoCliente(0);
  LimparCampos;
  GrdClientes.DataSource := FUCadClientes.FDataSourceCliente;
end;

procedure TFrmcadClientes.GrdClientesDblClick(Sender: TObject);
begin
  PageControl.TabIndex := 0;
  FUCadClientes.RetornarDadosDoCliente(GrdClientes.DataSource.DataSet.FieldByName('ID').AsInteger);
  HabilitarBotoes(todos);
  HabilitarCampos(True);
end;

procedure TFrmcadClientes.HabilitarBotoes(HabilitaBotao: THabilitaBotoes);
begin
  case HabilitaBotao of
    todos:
    begin
     Btn_novo.Enabled := true;
     Btn_Salvar.Enabled := true;
     Btn_Excluir.Enabled := true;
     Btn_Limpar.Enabled := true;
     Btn_Fechar.Enabled := true;
     btnBuscarCEP.Enabled := false;
    end;
    novo:
    begin
      Btn_Excluir.Enabled := false;
      Btn_novo.Enabled := False;
      btnBuscarCEP.Enabled := true;
    end;
    pesquisa:
    begin
     Btn_novo.Enabled := False;
     Btn_Salvar.Enabled := False;
     Btn_Excluir.Enabled := False;
     Btn_Limpar.Enabled := False;
     Btn_Fechar.Enabled := true;
     btnBuscarCEP.Enabled := False;
    end;
    limpar:
    begin
     Btn_novo.Enabled := true;
     Btn_Salvar.Enabled := true;
     Btn_Excluir.Enabled := true;
     Btn_Limpar.Enabled := true;
     Btn_Fechar.Enabled := true;
     btnBuscarCEP.Enabled := False;
    end;
  end;
end;

procedure TFrmcadClientes.HabilitarCampos(Habilitar: Boolean);
var
  I: Integer;
begin
  for I := 0 to ComponentCount  - 1 do
   begin
     if Components[I] is TDBEdit  then
     begin
       (Components[I] as TDBEdit).Enabled := Habilitar;
     end;
    end;
end;

procedure TFrmcadClientes.LimparCampos;
begin
   if not FUCadClientes.FCDS_Aux.Active then
     Exit;

   if not (FUCadClientes.FCDS_Aux.State in [dsInsert, dsEdit]) then
     FUCadClientes.FCDS_Aux.EmptyDataSet;
   FUCadClientes.FCDS_Aux.Close;
end;

procedure TFrmcadClientes.PageControlChange(Sender: TObject);
begin
  if PageControl.TabIndex = 0 then
  begin
    HabilitarBotoes(todos);
    CMB_cidades.KeyValue := -1;
    CMB_Estado.KeyValue := -1;
  end;
  if PageControl.TabIndex = 1 then
  begin
    HabilitarBotoes(pesquisa);
    LimparCampos;
    HabilitarCampos(false);
    Rgb_Filtro.ItemIndex := 0;
    FUCadClientes.FOpcaoFiltro := 0;
    FUCadClientes.AplicarFiltros;
  end;
end;

procedure TFrmcadClientes.ParemtrizarCamposAoBanco;
begin
 Edt_nome.DataSource := FUCadClientes.FDTS_Aux;
 Edt_nome.DataField :='NOME_CLIENTE';
 Edt_CPF.DataSource := FUCadClientes.FDTS_Aux;
 Edt_CPF.DataField := 'CPF_CNPJ';
 Edt_data_nascimento.DataSource := FUCadClientes.FDTS_Aux;
 Edt_data_nascimento.DataField := 'DATANASCIMENTO';
 Edt_CEP.DataSource := FUCadClientes.FDTS_Aux;
 Edt_CEP.DataField := 'CEP';
 Edt_Endereco.DataSource := FUCadClientes.FDTS_Aux;
 Edt_Endereco.DataField := 'ENDERECO';
 Edt_numero.DataSource := FUCadClientes.FDTS_Aux;
 Edt_numero.DataField :='NUMERO';
 Edt_complemento.DataSource := FUCadClientes.FDTS_Aux;
 Edt_complemento.DataField := 'COMPLEMENTO';
 Edt_Bairro.DataSource := FUCadClientes.FDTS_Aux;
 Edt_Bairro.DataField := 'BAIRRO';
 Edt_cidade.DataSource := FUCadClientes.FDTS_Aux;
 Edt_cidade.DataField := 'NOME_CIDADE';
 Edt_estado.DataSource := FUCadClientes.FDTS_Aux;
 Edt_estado.DataField := 'NOME_ESTADO';
 CMB_cidades.ListSource := FUCadClientes.FDtsCidades;
 CMB_Estado.ListSource := FUCadClientes.FDtsEstados;
end;

procedure TFrmcadClientes.Rgb_FiltroClick(Sender: TObject);
begin

 case Rgb_Filtro.ItemIndex of
   0:
    begin
      btn_filtrar.Enabled := False;
      Gb_periodo.Enabled := False;
      Gb_Cidades.Enabled := False;
      Gb_Estados.Enabled := False;
      CMB_cidades.KeyValue := -1;
      CMB_Estado.KeyValue := -1;
      if FUCadClientes.FOpcaoFiltro > 0 then
      begin
        FUCadClientes.FOpcaoFiltro := 0;
        FUCadClientes.AplicarFiltros;
      end;
    end;
   1:
    begin
      btn_filtrar.Enabled := True;
      Gb_periodo.Enabled := True;
      Gb_Cidades.Enabled := False;
      Gb_Estados.Enabled := False;
      CMB_cidades.KeyValue := -1;
      CMB_Estado.KeyValue := -1;
    end;
   2:
    begin
      btn_filtrar.Enabled := True;
      Gb_periodo.Enabled := False;
      Gb_Cidades.Enabled := True;
      Gb_Estados.Enabled := False;
      CMB_Estado.KeyValue := -1;
    end;
   3:
    begin
      btn_filtrar.Enabled := True;
      Gb_periodo.Enabled := False;
      Gb_Cidades.Enabled := False;
      Gb_Estados.Enabled := True;
      CMB_cidades.KeyValue := -1;
    end;
 end;
end;

function TFrmcadClientes.ValidarDados: Boolean;
var
  MensagemValidacao: string;
begin
  TFuncionalidades.ValidarCamposObrigatorios(Self, Result, MensagemValidacao);

  if not Result then
  begin
    MessageDlg((MensagemValidacao),TMsgDlgType.mtWarning,[TMsgDlgBtn.mbOK],0);
    Exit;
  end;

  if not UValidacoes.TValidacoes.ValidarCPF(Edt_CPF.text) then
  begin
    MessageDlg('CPF inválido',TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
    Edt_CPF.SetFocus;
    Result := False;
    Exit;
  end;

end;

end.
