unit Pizza.View.Frame.Sabor;

interface

uses
  System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Effects, FMX.Objects, FMX.Ani, System.SysUtils;

type
  TPizzaSaborAcao = (paRetornar, paAvancar);

  TFrameSabor = class(TFrame)
    anmPizzaBottom: TFloatAnimation;
    anmPizzaBottomExtra: TFloatAnimation;
    anmPizzaTop: TFloatAnimation;
    anmPizzaTopExtra: TFloatAnimation;
    imgPizza: TImage;
    ShadowEffect4: TShadowEffect;
    anmPizzaRotar: TFloatAnimation;
    anmPizzaDirecao: TFloatAnimation;
    procedure anmPizzaDirecaoFinish(Sender: TObject);
    private
      FDeletar: Boolean;
    public
      function Slide(acao: TPizzaSaborAcao; var anterior: TFrameSabor): TFrameSabor;
      function Animar(acao: TPizzaSaborAcao): TFrameSabor;
      function Deletar: TFrameSabor;
      procedure Start; overload;
      procedure Start(novo: Boolean); overload;
  end;

implementation

uses
  Pizza.Librarys.Biblioteca;

{$R *.fmx}

{ TFrameSabor }

function TFrameSabor.Animar(acao: TPizzaSaborAcao): TFrameSabor;
begin
  anmPizzaRotar.StartValue := anmPizzaRotar.StopValue;

  anmPizzaRotar.StopValue := anmPizzaRotar.StartValue + IIfInt(acao = paAvancar, 100, -100);
  anmPizzaTopExtra.StopValue := anmPizzaTop.StopValue + 20;
  anmPizzaBottomExtra.StopValue := anmPizzaTop.StopValue + 20;

  if acao = paAvancar then begin
    anmPizzaDirecao.StartValue := Self.Position.X;
    anmPizzaDirecao.StopValue := (Self.Width + 1);
  end
  else begin
    anmPizzaDirecao.StartValue := Self.Position.X;
    anmPizzaDirecao.StopValue := (Self.Width * -1);
  end;

  anmPizzaTopExtra.AutoReverse := False;
  anmPizzaBottomExtra.AutoReverse := False;

  Result := Self;
end;

procedure TFrameSabor.anmPizzaDirecaoFinish(Sender: TObject);
begin
  if FDeletar then
    FreeAndNil(Self);
end;

function TFrameSabor.Deletar: TFrameSabor;
begin
  FDeletar := True;
  Result := Self;
end;

function TFrameSabor.Slide(acao: TPizzaSaborAcao; var anterior: TFrameSabor): TFrameSabor;
begin
  Self.Parent := anterior.Parent;
  Self.Align := TAlignLayout.Scale;
  Self.Width := anterior.Width;
  Self.Height := anterior.Height;
  Self.Position.Y := anterior.Position.Y;

  if acao = paAvancar then
    Self.Position.X := (anterior.Width * -1)
  else
    Self.Position.X := (Self.Width + 1);

  anmPizzaRotar.StartValue := 0;
  anmPizzaRotar.StartValue := 100;

  anmPizzaDirecao.StartValue := Self.Position.X;
  anmPizzaDirecao.StopValue := Self.Position.X * -1;

  FDeletar := False;
  Result := Self;
end;

procedure TFrameSabor.Start(novo: Boolean);
begin
  anmPizzaRotar.Start;
  anmPizzaDirecao.Start;
end;

procedure TFrameSabor.Start;
begin
  anmPizzaBottomExtra.Start;
  anmPizzaTopExtra.Start;
  anmPizzaRotar.Start;
  anmPizzaDirecao.Start;
end;

end.
