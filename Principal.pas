unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxGeometry, dxFramedControl, dxPanel, Vcl.Menus,
  cxContainer, cxEdit, cxLabel, cxCheckBox, cxCustomListBox, cxCheckListBox,
  Vcl.ComCtrls, Vcl.ExtCtrls,DfmCadClientes, DfmRelClientes ,Vcl.StdCtrls, Uconexao;

type
  TFrmprincipal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastro1: TMenuItem;
    Clientes1: TMenuItem;
    Relatrio1: TMenuItem;
    RelatriosdeClientes1: TMenuItem;
    Ajuda1: TMenuItem;
    Sobre1: TMenuItem;
    Sair1: TMenuItem;
    StatusBar1: TStatusBar;
    procedure Clientes1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RelatriosdeClientes1Click(Sender: TObject);
  private
    { Private declarations }
    Fconexao: Tconecxao;
  public
    { Public declarations }
  end;

var
  Frmprincipal: TFrmprincipal;

implementation

{$R *.dfm}





procedure TFrmprincipal.Clientes1Click(Sender: TObject);
var
  frmcadclientes: TFrmCadClientes;
  i: Integer;
begin
  // 1. Tenta encontrar uma inst�ncia j� aberta do formul�rio de clientes.
  frmcadclientes := nil;
  for i := 0 to MDIChildCount - 1 do
  begin
    // Verifica se o formul�rio na lista de filhos MDI � do tipo TFrmCadCliente
    if MDIChildren[i] is TFrmCadClientes then
    begin
      frmcadclientes := TFrmCadClientes(MDIChildren[i]); // Se for, armazena a refer�ncia
      break; // Para a busca, pois j� encontrou
    end;
  end;

  // 2. Se n�o encontrou (frmcadcliente ainda � nil), cria uma nova inst�ncia.
  if frmcadclientes = nil then
  begin
    frmcadclientes := TFrmCadClientes.Create(Application);
  end
  else
  // 3. Se encontrou uma inst�ncia existente, apenas a traz para a frente.
  begin
    frmcadclientes.BringToFront;
    Application.ExeName
  end;
end;

procedure TFrmprincipal.FormCreate(Sender: TObject);
begin
  Fconexao := Tconecxao.Create;
end;

procedure TFrmprincipal.RelatriosdeClientes1Click(Sender: TObject);
var
  frmrelclientes: TFrmrelClientes;
  i: Integer;
begin
  // 1. Tenta encontrar uma instância já aberta do formulário de relatórios.
  frmrelclientes := nil;
  for i := 0 to MDIChildCount - 1 do
  begin
    // Verifica se o formulário na lista de filhos MDI é do tipo TFrmrelClientes
    if MDIChildren[i] is TFrmrelClientes then
    begin
      frmrelclientes := TFrmrelClientes(MDIChildren[i]); // Se for, armazena a referência
      break; // Para a busca, pois já encontrou
    end;
  end;

  // 2. Se não encontrou (frmrelclientes ainda é nil), cria uma nova instância.
  if frmrelclientes = nil then
  begin
    frmrelclientes := TFrmrelClientes.Create(Application);
  end
  else
  // 3. Se encontrou uma instância existente, apenas a traz para a frente.
  begin
    frmrelclientes.BringToFront;
  end;

end;

end.
