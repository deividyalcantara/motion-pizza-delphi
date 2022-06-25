unit Pizza.Librarys.EndPoint;

interface

uses
  Pizza.Librarys.Modelo,
  Horse, System.SysUtils;

type
  WebEndpoint = record
    prefixo: string;
    resource: string;
    metodos: TArrayOfPizzaMetodo;
  end;
  TArrayOfWebEndpoint = Array of WebEndpoint;

var
  FEndPoint: TArrayOfWebEndpoint;

procedure AddEndPoint(prefixo: string; resource: string; metodos: TArrayOfPizzaMetodo);
procedure AddRequest(var req: THorseRequest; var res: THorseResponse; prefixo: string; resource: string);

implementation

uses
 PizzaServer.Modules.System.Console,
  Pizza.Librarys.Biblioteca,
  Horse.Utils.ClientIP;

procedure AddEndPoint(prefixo: string; resource: string; metodos: TArrayOfPizzaMetodo);
begin
  SetLength(FEndPoint, Length(FEndPoint) + 1);
  FEndPoint[High(FEndPoint)].prefixo := prefixo;
  FEndPoint[High(FEndPoint)].resource := resource;
  FEndPoint[High(FEndPoint)].metodos := metodos;
end;

procedure AddRequest(var req: THorseRequest; var res: THorseResponse; prefixo: string; resource: string);
begin
  Pizza.Librarys.Biblioteca.Escreva('Request ');
  Pizza.Librarys.Biblioteca.Escreva('"' + Pizza.Librarys.Biblioteca.EndPoint(prefixo, resource) + '"', TConsoleColor.Magenta, False);
  Pizza.Librarys.Biblioteca.Escreva(' | ', TConsoleColor.White, False);
  Pizza.Librarys.Biblioteca.Escreva('Client ', TConsoleColor.White, False);
  Pizza.Librarys.Biblioteca.Escreva(ClientIP(req) + ' ', TConsoleColor.DarkCyan, False);
  Pizza.Librarys.Biblioteca.Escreva('| ', TConsoleColor.White, False);
  Pizza.Librarys.Biblioteca.Escreva('Response code ', TConsoleColor.White, False);
  Pizza.Librarys.Biblioteca.Escreva(IntToStr(res.Status), TConsoleColor.DarkCyan, False);
  Pizza.Librarys.Biblioteca.Reticencia;
end;

end.
