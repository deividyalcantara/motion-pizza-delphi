unit Pizza.View.Frame.Opcoes.Recheio;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, Pizza.View.Frame.Recheio, FMX.Objects;

type
  WebRecheioItens = record
    item_id: Integer;
    item: TFormRecheio;
    url: string;
    url_sobrepor: string;

    function UrlSobrepor: string;
  end;
  TArrayOfWebRecheioItens = Array of WebRecheioItens;

  TFrameOpcoesRecheio = class(TFrame)
  hsbRecheio: THorzScrollBox;
    procedure FrameResized(Sender: TObject);
    procedure FrameClick(Sender: TObject); virtual;
  private
    FItens: TArrayOfWebRecheioItens;
    FTamanhoItem: Integer;
    FQtdItensTela: Integer;
    FItemIndex: Integer;

    procedure AtualizarTamanhoItem;
    function GetItensCount: Integer;

    {$IFDEF MSWINDOWS}
    procedure CliqueDoRecheio(Sender: TObject);
    {$ELSE}
    procedure CliqueDoRecheioTap(Sender: TObject; const Point: TPointF);
    {$ENDIF}

    function GetItem(id: Integer): WebRecheioItens;
  public
    property TamanhoItem: Integer read FTamanhoItem write FTamanhoItem;
    property Itens: TArrayOfWebRecheioItens read FItens write FItens;
    property Item[id: Integer]: WebRecheioItens read GetItem;
    property ItensCount: Integer read GetItensCount;
    property QtdItensTela: Integer read FQtdItensTela write FQtdItensTela;
    property ItemIndex: Integer read FItemIndex;

    procedure RedefinirOpacidade;
    procedure RedefinirOpacidadeItem(id: Integer);
    procedure AddItem(item_id: Integer; url: string; url_sobrepor: string = '');
  end;

implementation

uses
  Pizza.Librarys.Biblioteca;

{$R *.fmx}

{ TFrameOpcoesRecheio }

procedure TFrameOpcoesRecheio.AddItem(item_id: Integer; url: string; url_sobrepor: string = '');
var
  recheio: TFormRecheio;
begin
  AtualizarTamanhoItem;

  recheio := TFormRecheio.Create(hsbRecheio);
  recheio.Parent := hsbRecheio;
  recheio.Width := FTamanhoItem;
  recheio.Name := 'lblRecheioItem' + IntToStr(item_id);
  recheio.Align := TAlignLayout.MostLeft;
  recheio.ItemId := item_id;

  {$IFDEF MSWINDOWS}
  recheio.OnClick := CliqueDoRecheio;
  {$ELSE}
  recheio.OnTap := CliqueDoRecheioTap;
  {$ENDIF}

  recheio.HitTest := True;
  recheio.Cursor := crHandPoint;

  Pizza.Librarys.Biblioteca.CarregarImagemURL(recheio.imgRecheio, url, False);

  SetLength(FItens, Length(FItens) + 1);
  FItens[High(FItens)].item_id := item_id;
  FItens[High(FItens)].item := recheio;
  FItens[High(FItens)].url := url;
  FItens[High(FItens)].url_sobrepor := url_sobrepor;
end;

procedure TFrameOpcoesRecheio.AtualizarTamanhoItem;
begin
  if FQtdItensTela = 0 then
    FQtdItensTela := 3;

  FTamanhoItem := round(Self.Width / FQtdItensTela);
end;

{$IFDEF MSWINDOWS}
procedure TFrameOpcoesRecheio.CliqueDoRecheio(Sender: TObject);
begin
  FItemIndex := TFormRecheio(Sender).ItemId;
  TFormRecheio(Sender).anmOpacidade.StartValue := 1;
  TFormRecheio(Sender).anmOpacidade.StopValue := 0.4;
  TFormRecheio(Sender).anmOpacidade.Start;
  Self.OnClick(Sender);
end;
{$ELSE}
procedure TFrameOpcoesRecheio.CliqueDoRecheioTap(
  Sender: TObject;
  const Point: TPointF
);
begin
  FItemIndex := TFormRecheio(Sender).ItemId;
  TFormRecheio(Sender).anmOpacidade.StartValue := 1;
  TFormRecheio(Sender).anmOpacidade.StopValue := 0.4;
  TFormRecheio(Sender).anmOpacidade.Start;
  Self.OnClick(Sender);
end;
{$ENDIF}

procedure TFrameOpcoesRecheio.FrameClick(Sender: TObject);
begin
  //
end;

procedure TFrameOpcoesRecheio.FrameResized(Sender: TObject);
var
  i: Integer;
begin
  AtualizarTamanhoItem;

  for i := 0 to hsbRecheio.ComponentCount - 1 do begin
    if hsbRecheio.Components[i] is TFormRecheio then
      TFormRecheio(hsbRecheio.Components[i]).Width := FTamanhoItem;
  end;
end;

function TFrameOpcoesRecheio.GetItem(id: Integer): WebRecheioItens;
var
  i: Integer;
begin
  Result := Default(WebRecheioItens);

  for i := Low(FItens) to High(FItens) do begin
    if FItens[i].item_id <> id then
      Continue;

    Result := FItens[i];
    Break;
  end;
end;

function TFrameOpcoesRecheio.GetItensCount: Integer;
begin
  Result := Length(FItens);
end;

procedure TFrameOpcoesRecheio.RedefinirOpacidade;
var
  i: Integer;
begin
  for i := Low(Itens) to High(Itens) do
    Itens[i].item.imgRecheio.Opacity := 1;
end;

procedure TFrameOpcoesRecheio.RedefinirOpacidadeItem(id: Integer);
var
  meu_item: WebRecheioItens;
begin
  meu_item := Item[id];
  meu_item.item.anmOpacidade.Stop;
  meu_item.item.anmOpacidade.StartValue := meu_item.item.imgRecheio.Opacity;
  meu_item.item.anmOpacidade.StopValue := 1;
  meu_item.item.anmOpacidade.Start;
end;

{ WebRecheioItens }

function WebRecheioItens.UrlSobrepor: string;
begin
  if url_sobrepor = '' then
    Result := url
  else
    Result := url_sobrepor;
end;

end.
