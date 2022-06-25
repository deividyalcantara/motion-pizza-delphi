program Pizza;

// Projeto disponibilizado por Deividy Alcantara para estudos...
// Acesse: https://www.linkedin.com/in/deividy-alcantara-590889177/
// Git: https://github.com/deividyalcantara

{$R *.dres}

uses
  System.StartUpCopy,
  FMX.Forms,
  Pizza.View.Main in 'View\Pizza.View.Main.pas' {FormPizza},
  Pizza.View.Frame.Opcoes.Recheio in 'View\Frame\Pizza.View.Frame.Opcoes.Recheio.pas' {FrameOpcoesRecheio: TFrame},
  Pizza.View.Frame.Recheio in 'View\Frame\Pizza.View.Frame.Recheio.pas' {FormRecheio: TFrame},
  Pizza.RSP.RSP37704 in 'RSP\Pizza.RSP.RSP37704.pas',
  Pizza.Librarys.Biblioteca in 'Librarys\Pizza.Librarys.Biblioteca.pas',
  Pizza.Librarys.Modelo in 'Librarys\Pizza.Librarys.Modelo.pas',
  Pizza.View.Frame.Sabor in 'View\frame\Pizza.View.Frame.Sabor.pas' {FrameSabor: TFrame},
  Pizza.View.Frame.Pizza in 'View\frame\Pizza.View.Frame.Pizza.pas' {FramePizza: TFrame},
  Pizza.Interfaces.WebClient in 'Interfaces\Pizza.Interfaces.WebClient.pas',
  Pizza.Interfaces.WebClientType in 'Interfaces\Pizza.Interfaces.WebClientType.pas',
  Pizza.Controllers.Pizza in 'Controllers\Pizza.Controllers.Pizza.pas',
  Pizza.Interfaces.Configuracoes in 'Interfaces\Pizza.Interfaces.Configuracoes.pas',
  Pizza.Interfaces.Manipulacao in 'Interfaces\Pizza.Interfaces.Manipulacao.pas',
  Pizza.Interfaces.TimePizza in 'Interfaces\Pizza.Interfaces.TimePizza.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Portrait, TFormOrientation.InvertedPortrait];
  Application.CreateForm(TFormPizza, FormPizza);
  Application.Run;
end.

