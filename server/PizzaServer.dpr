program PizzaServer;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  System.SysUtils,
  PizzaServer.Modules.System.Console in 'Modules\console-master\PizzaServer.Modules.System.Console.pas',
  Pizza.Librarys.Biblioteca in 'Librarys\Pizza.Librarys.Biblioteca.pas',
  PizzaServer.Controllers.Pizza in 'Controllers\PizzaServer.Controllers.Pizza.pas',
  Pizza.Librarys.Modelo in 'Librarys\Pizza.Librarys.Modelo.pas',
  Pizza.Librarys.EndPoint in 'Librarys\Pizza.Librarys.EndPoint.pas',
  Horse.Utils.ClientIP in 'Modules\horse-utils-clientip-main\src\Horse.Utils.ClientIP.pas';

begin
  PizzaServer.Controllers.Pizza.Registry;

  THorse.Listen(
    9000,
    procedure (Horse: THorse)
    begin
      Escrevaln('                                       ________  ___  ________  ________  ________                                     ', TConsoleColor.White, False);
      Escrevaln('                                      |\   __  \|\  \|\_____  \|\_____  \|\   __  \                                    ', TConsoleColor.White, False);
      Escrevaln('                                      \ \  \|\  \ \  \\|___/  /|\|___/  /\ \  \|\  \                                   ', TConsoleColor.White, False);
      Escrevaln('                                       \ \   ____\ \  \   /  / /    /  / /\ \   __  \                                  ', TConsoleColor.White, False);
      Escrevaln('                                        \ \  \___|\ \  \ /  /_/__  /  /_/__\ \  \ \  \                                 ', TConsoleColor.White, False);
      Escrevaln('                                         \ \__\    \ \__\\________\\________\ \__\ \__\                                ', TConsoleColor.White, False);
      Escrevaln('                                          \|__|     \|__|\|_______|\|_______|\|__|\|__|                                ', TConsoleColor.White, False);
      Escrevaln('                                                                                                                       ', TConsoleColor.White, False);
      Pizza.Librarys.Biblioteca.LinhaVazia;
      Pizza.Librarys.Biblioteca.Escrevaln('Starting Pizza Server...');
      Pizza.Librarys.Biblioteca.Escreva('Server listening on ');
      Pizza.Librarys.Biblioteca.Escreva(GetIP, TConsoleColor.DarkCyan, False);
      Pizza.Librarys.Biblioteca.Escreva(' port ', TConsoleColor.White, False);
      Pizza.Librarys.Biblioteca.Escreva(IntToStr(Horse.Port), TConsoleColor.DarkCyan, False);
      Pizza.Librarys.Biblioteca.Reticencia;

      Pizza.Librarys.Biblioteca.ConsoleEndPoint;
    end
  );
end.
