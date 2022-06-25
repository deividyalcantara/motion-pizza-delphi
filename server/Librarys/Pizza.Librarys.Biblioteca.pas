unit Pizza.Librarys.Biblioteca;

interface

uses
  System.SysUtils,
  Pizza.Librarys.Modelo,
  PizzaServer.Modules.System.Console,
  Winapi.WinSock,
  Pizza.Librarys.EndPoint;

procedure GetDataHoraFormatada;
procedure LinhaVazia;
procedure Reticencia;
procedure CorDoTexto(nova_cor: TConsoleColor);
function GetIP: string;
procedure Escreva(texto: string; cor: TConsoleColor = TConsoleColor.White; mostrar_data_hora: Boolean = True);
procedure Escrevaln(texto: string; cor: TConsoleColor = TConsoleColor.White; mostrar_data_hora: Boolean = True);
procedure ConsoleEndPoint;
function IIfInt(Condicao: Boolean; verdadeiro: Integer; falso: Integer = 0): Integer; overload;
function IIfStr(Condicao: Boolean; verdadeiro: string; falso: string = ''):string; overload;
function EndPoint(prefixo: string; resource: string): string;

implementation

procedure GetDataHoraFormatada;
begin
  CorDoTexto(TConsoleColor.Green);
  Write(FormatDateTime('[dd-mm-yyyy hh:nn:ss] ', Now));
end;

function GetIP: string;
var
  WSAData: TWSAData;
  HostEnt: PHostEnt;
  Name: PAnsiChar;
begin
  WSAStartup(2, WSAData);
  Name := AllocMem(255);
  GetHostName(Name, 255);
  HostEnt := GetHostByName(Name);
  with HostEnt^ do
    Result := Format('%d.%d.%d.%d',[Byte(h_addr^[0]),Byte(h_addr^[1]),Byte(h_addr^[2]),Byte(h_addr^[3])]);
  WSACleanup;
end;

procedure CorDoTexto(nova_cor: TConsoleColor);
begin
  Console.ForegroundColor := nova_cor;
end;

procedure Reticencia;
begin
  CorDoTexto(TConsoleColor.White);
  Writeln('...');
end;

procedure Escreva(texto: string; cor: TConsoleColor = TConsoleColor.White; mostrar_data_hora: Boolean = True);
begin
  if mostrar_data_hora then
    GetDataHoraFormatada;

  CorDoTexto(cor);
  Write(texto);
end;

procedure Escrevaln(texto: string; cor: TConsoleColor= TConsoleColor.White; mostrar_data_hora: Boolean = True);
begin
  if mostrar_data_hora then
    GetDataHoraFormatada;

  CorDoTexto(cor);
  Writeln(texto);
end;

procedure ConsoleEndPoint;
var
  i: Integer;
  k: Integer;

  function MetodoParaString(metodo: TPizzaMetodo): string;
  begin
    case metodo of
      pmGet: Result := 'Get';
      pmPost: Result := 'Post';
      pmDelete: Result := 'Delete';
      pmPut: Result := 'Put';
      pmHead: Result := 'Head';
      Patch: Result := 'Patch';
    end;
  end;
begin
  for i := Low(FEndPoint) to High(FEndPoint) do begin
    with FEndPoint[i] do begin
      Escreva('Created Endpoint');
      Escreva(' "' + EndPoint(prefixo, resource) + '"', TConsoleColor.Magenta, False);

      Escreva(' method' + IIfStr(Length(metodos) > 1, 's ', ' '), TConsoleColor.White, False);

      for k := Low(metodos) to High(metodos) do begin
        if k = Low(metodos) then begin
          Escreva('[', TConsoleColor.Magenta, False);
          Escreva(MetodoParaString(metodos[k]), TConsoleColor.Magenta, False);

          if Length(metodos) = 1 then
            Escreva(']', TConsoleColor.Magenta, False);

          Continue;
        end;

        Escreva(', ', TConsoleColor.Magenta, False);

        if k = High(metodos) then begin
          Escreva(MetodoParaString(metodos[k]), TConsoleColor.Magenta, False);
          Escreva(']', TConsoleColor.Magenta, False);
          Break;
        end;

        Escreva(MetodoParaString(metodos[k]), TConsoleColor.Magenta, False);
      end;
    end;

    Reticencia;
  end;
end;

function EndPoint(prefixo: string; resource: string): string;
begin
  prefixo := IIfStr(Copy(prefixo, 1, 1) <> '/', '/', '') + prefixo;
  resource := IIfStr((Copy(prefixo, Length(prefixo)) <> '/') and (Copy(resource, 1, 1) <> '/'), '/', '') + resource;
  Result := prefixo + resource;
end;

procedure LinhaVazia;
begin
  Writeln('');
end;

function IIfInt(condicao: Boolean; verdadeiro: Integer; falso: Integer = 0):Integer; overload;
begin
  if Condicao then
    Result := Verdadeiro
  else
    Result := Falso;
end;

function IIfStr(condicao: Boolean; verdadeiro: string; falso: string = ''):string; overload;
begin
  if Condicao then
    Result := Verdadeiro
  else
    Result := Falso;
end;

end.
