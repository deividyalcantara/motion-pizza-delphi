unit Pizza.View.Frame.Sabor;

interface

uses
  System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Effects, FMX.Objects, FMX.Ani, System.SysUtils, FMX.Layouts;

type
  TPizzaSaborTamanho = (ptPequena, ptMedia, ptGrande);
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
    lytSabor: TLayout;
    lytSaborBase: TLayout;
    imgSabor: TImage;
    anmSaborBottom: TFloatAnimation;
    anmSaborTop: TFloatAnimation;
    anmSaborLeft: TFloatAnimation;
    anmSaborRight: TFloatAnimation;
    rctSaborArea: TRectangle;
    crcSaborArea: TCircle;
    anmSaborBottomExtra: TFloatAnimation;
    anmSaborTopExtra: TFloatAnimation;
    procedure FinishPizzaAnterior(Sender: TObject);
    procedure FinishPizzaNova(Sender: TObject);
    private
      FPizzaNova: Boolean;

    public
      function AnimacaoAtiva: Boolean;
      function SlidePizzaNova(acao: TPizzaSaborAcao; var anterior: TFrameSabor): TFrameSabor;
      function SlidePizzaAnterior(acao: TPizzaSaborAcao): TFrameSabor;
      function Imagem(img: TBitmap): TFrameSabor; overload;
      procedure FinishAnimacao;
      procedure Start;
  end;

implementation

uses
  Pizza.Librarys.Biblioteca,
  Pizza.View.Main;

{$R *.fmx}

{ TFrameSabor }

function TFrameSabor.AnimacaoAtiva: Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Self.ComponentCount - 1 do begin
    if Self.Components[i] is TFloatAnimation then begin
      if not TFloatAnimation(Self.Components[i]).Running then
        Continue;

      Result := True;
      Break;
    end;
  end;
end;

function TFrameSabor.SlidePizzaAnterior(acao: TPizzaSaborAcao): TFrameSabor;
begin
  anmPizzaDirecao.OnFinish := FinishPizzaAnterior;
  FPizzaNova := False;

  anmPizzaRotar.StartValue := imgPizza.RotationAngle;
  anmPizzaDirecao.Delay := 0.2;

  anmPizzaRotar.StopValue := anmPizzaRotar.StartValue + IIfInt(acao = paAvancar, 100, -100);
  anmPizzaRotar.Delay := 0.1;

  anmPizzaTopExtra.StartValue := Self.Padding.Top;
  anmPizzaBottomExtra.StartValue := Self.Padding.Bottom;
  anmPizzaTopExtra.StopValue := anmPizzaTopExtra.StartValue + 15;
  anmPizzaBottomExtra.StopValue := anmPizzaBottomExtra.StartValue + 15;

  anmSaborTopExtra.StartValue := lytSabor.Padding.Top;
  anmSaborBottomExtra.StartValue := lytSabor.Padding.Bottom;
  anmSaborTopExtra.StopValue := anmSaborTopExtra.StartValue + 15;
  anmSaborBottomExtra.StopValue := anmSaborBottomExtra.StartValue + 15;

  anmSaborTopExtra.Duration := anmPizzaTopExtra.Duration;
  anmSaborBottomExtra.Duration := anmPizzaTopExtra.Duration;

  anmPizzaDirecao.StartValue := Self.Position.X;

  if acao = paAvancar then
    anmPizzaDirecao.StopValue := (Self.Width + 1)
  else
    anmPizzaDirecao.StopValue := (Self.Width * -1);

  anmPizzaTopExtra.AutoReverse := False;
  anmPizzaBottomExtra.AutoReverse := False;
  anmSaborBottomExtra.AutoReverse := False;
  anmSaborTopExtra.AutoReverse := False;

  Result := Self;
end;

procedure TFrameSabor.FinishAnimacao;
begin
  Self.BeginUpdate;
  Self.Position.X := 0;
  Self.EndUpdate;
end;

procedure TFrameSabor.FinishPizzaAnterior(Sender: TObject);
begin
  FreeAndNil(Self);
end;

procedure TFrameSabor.FinishPizzaNova(Sender: TObject);
begin
  Self.BeginUpdate;
  Self.Position.X := 0;
  Self.EndUpdate;
end;

function TFrameSabor.Imagem(img: TBitmap): TFrameSabor;
begin
  imgPizza.Bitmap.Assign(img);
  Result := Self;
end;

function TFrameSabor.SlidePizzaNova(acao: TPizzaSaborAcao; var anterior: TFrameSabor): TFrameSabor;
begin
  anmPizzaDirecao.OnFinish := FinishPizzaNova;
  FPizzaNova := True;

  Self.Align := TAlignLayout.Scale;
  Self.Parent := anterior.Parent;
  Self.Padding.Bottom := anterior.Padding.Bottom;
  Self.Padding.Top := anterior.Padding.Top;
  Self.Width := anterior.Width;
  Self.Height := anterior.Height;
  Self.Position.Y := anterior.Position.Y;
  Self.Position.X := Self.Width * IIfInt(acao = paAvancar, -1, 1);

  anmPizzaRotar.StartValue := 0;
  anmPizzaRotar.StopValue := anmPizzaRotar.StartValue + IIfInt(acao = paAvancar, 100, -100);

  anmPizzaDirecao.StartValue := Self.Position.X;
  anmPizzaDirecao.StopValue := Self.Position.X * -1;
  anmPizzaDirecao.Delay := 0;

  Result := Self;
end;

procedure TFrameSabor.Start;
begin
  if not FPizzaNova then begin
    anmSaborTopExtra.Start;
    anmSaborBottomExtra.Start;

    anmPizzaBottomExtra.Start;
    anmPizzaTopExtra.Start;
  end;

  anmPizzaRotar.Start;
  anmPizzaDirecao.Start;
end;

end.
