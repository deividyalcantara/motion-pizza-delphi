unit Pizza.View.Frame.Recheio;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Effects, FMX.Ani;

type
  TFormRecheio = class(TFrame)
    imgRecheio: TImage;
    anmOpacidade: TFloatAnimation;
    anmPosicaoX: TFloatAnimation;
    anmPosicaoY: TFloatAnimation;
    anmHeight: TFloatAnimation;
    anmWidth: TFloatAnimation;
    procedure FrameClick(Sender: TObject);
    private
      FItemId: Integer;

    public
      property ItemId: Integer read FItemId write FItemId;
  end;

implementation

{$R *.fmx}

procedure TFormRecheio.FrameClick(Sender: TObject);
begin
  //
end;

end.
