unit Pizza.View.Main;

interface

uses
  System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Effects, FMX.Ani,
  FMX.Styles.Objects, System.SysUtils, Pizza.View.Frame.Opcoes.Recheio,
  Pizza.View.Frame.Sabor, FMX.Gestures, Pizza.View.Frame.Pizza, System.Math,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
  Pizza.Controllers.Pizza, Pizza.Librarys.Modelo, Pizza.Librarys.Biblioteca,
  Pizza.Interfaces.TimePizza;

type
  TFormPizza = class(TForm)
    lytToolBar: TLayout;
    gplPrincipal: TGridPanelLayout;
    lytToolBarLeft: TLayout;
    lytToolBarRight: TLayout;
    lytToolBarCenter: TLayout;
    lblTitulo: TLabel;
    lblDescricao: TLabel;
    btnGostei: TSpeedButton;
    patGostei: TPath;
    btnVoltar: TSpeedButton;
    patVoltar: TPath;
    lytOpcoes: TLayout;
    lblValorTotal: TLabel;
    lytTamanho: TLayout;
    lytAddCart: TLayout;
    lblQuantidade: TLabel;
    lblSubAddCart: TLayout;
    patFundoAddCart: TPath;
    patBotaoAddCart: TPath;
    lytBotaoAddCart: TLayout;
    lblRecheio: TLayout;
    rctBotaoAddCart: TRectangle;
    lblBotaoAddCart: TLabel;
    patIconAddCart: TPath;
    sheBotaoAddCart: TShadowEffect;
    rctTamanho: TRectangle;
    lytTamanhoSelecionado: TLayout;
    lytTamanhoCentroBase: TLayout;
    lytTamanhoBase: TLayout;
    btnTamanhoPequena: TRectangle;
    btnTamanhoGrande: TRectangle;
    btnTamanhoMedia: TRectangle;
    sheTamanhoCentro: TShadowEffect;
    sheTamanhoPrincipal: TShadowEffect;
    crcTamanhoSelecionado: TCircle;
    lytTamanhoTexto: TLayout;
    lblTamanhoEsquerda: TLabel;
    lblTamanhoCentro: TLabel;
    lblTamanhoDireita: TLabel;
    anmTamanho: TFloatAnimation;
    ShadowEffect2: TShadowEffect;
    anmTamanhoTexto: TColorAnimation;
    frmPizza: TFramePizza;
    frmRecheio: TFrameOpcoesRecheio;
    ColorAnimation1: TColorAnimation;
    anmToolBarOpacidade: TFloatAnimation;
    anmToolBarPosicao: TFloatAnimation;
    procedure FormShow(Sender: TObject);
    procedure btnTamanhoPequenaClick(Sender: TObject);
    procedure anmTamanhoFinish(Sender: TObject);
    procedure anmTamanhoProcess(Sender: TObject);
    procedure btnTamanhoGrandeClick(Sender: TObject);
    procedure btnTamanhoMediaClick(Sender: TObject);
    procedure frmPizzabtnPizzaEsquerdaClick(Sender: TObject);
    procedure frmPizzalytBgPizzaGesture(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure FormResize(Sender: TObject);
    procedure frmPizzabtnPizzaDireitaClick(Sender: TObject);
    procedure anmToolBarOpacidadeFinish(Sender: TObject);
    procedure frmRecheioClick(Sender: TObject);
  private
    tamanho_pizza: TArrayOfString;
    tamanho_inicial: string;
    pizzas: TArrayOfWebPizza;
    recheios: TArrayOfWebPizzaRecheio;
    proxima_pizza: Integer;

    procedure SelecionarCorTextoTamanho(lbl: TLabel);
    procedure AnimarBotaoSelecionarTamanho(tag: Integer; posic_x: Integer);
    procedure AnimarTituloDescricao(acao: TPizzaAcao);
    procedure AnimarQuantidade(valor_padrao: Integer = -1);
    procedure AnimarValores(
      acao: TPizzaAcao;
      recheio_id: Integer;
      verificar_animacao: Boolean = False;
      considerar_recheios: Boolean = False
    );
    procedure TamanhoPizzaInicial;
    procedure CarregarPizzas;
    procedure CarregarRecheios;

    procedure SelecionarRecheio(recheio_id: Integer);
    function RecheioIndisponivel(recheio_id: Integer): Boolean;
  end;

var
  FormPizza: TFormPizza;

implementation

{$R *.fmx}

procedure TFormPizza.AnimarBotaoSelecionarTamanho(tag, posic_x: Integer);
begin
  if anmTamanho.Tag = tag then
    Exit;

  anmTamanho.Tag := tag;
  anmTamanho.StopValue := posic_x;
  anmTamanho.Start;
end;

procedure TFormPizza.AnimarQuantidade(valor_padrao: Integer = -1);
  function QtdMaximaPizza: Integer;
  var
    k: Integer;
  begin
    Result := 0;
    for k := Low(pizzas) to High(pizzas) do begin
      if pizzas[k].pizza_id <> frmPizza.ItemIndex then
        Continue;

      Result := pizzas[k].qtd_maxima_recheio;
      Break;
    end;
  end;

begin
  if valor_padrao <> -1 then begin
    lblQuantidade.Text := IntToStr(valor_padrao) + '/' + IntToStr(QtdMaximaPizza);
    Exit;
  end;

  lblQuantidade.Text := IntToStr(frmPizza.QtdItensRecheio + 1) + '/' + IntToStr(QtdMaximaPizza);
end;

procedure TFormPizza.AnimarTituloDescricao(acao: TPizzaAcao);
begin
  if frmPizza.FrmSelecionado.AnimacaoAtiva then
    Exit;

  if acao = TPizzaAcao.paRetornar then
    proxima_pizza := frmPizza.ItemIndexAnterior
  else if acao = TPizzaAcao.paAvancar then
    proxima_pizza := frmPizza.ItemIndexProximo
  else
    proxima_pizza := frmPizza.ItemIndex;

  anmToolBarOpacidade.Inverse := False;
  anmToolBarOpacidade.Start;
end;

procedure TFormPizza.AnimarValores(
  acao: TPizzaAcao;
  recheio_id: Integer;
  verificar_animacao: Boolean = False;
  considerar_recheios: Boolean = False
);
var
  tempo: TTimeValorPizza;
  i: Integer;
  total_recheios: Double;

  function ValorItemRecheio(id: Integer): Double;
  var
    k: Integer;
  begin
    Result := 0;
    for k := Low(recheios) to High(recheios) do begin
      if recheios[k].recheio_id <> id then
        Continue;

      Result := recheios[k].valor;
      Break;
    end;
  end;
begin
  if verificar_animacao and frmPizza.FrmSelecionado.AnimacaoAtiva then
    Exit;

  if acao = TPizzaAcao.paRetornar then
    proxima_pizza := frmPizza.ItemIndexAnterior
  else if acao = TPizzaAcao.paAvancar then
    proxima_pizza := frmPizza.ItemIndexProximo
  else
    proxima_pizza := frmPizza.ItemIndex;

  total_recheios := 0;
  if (recheio_id <> -1) or (considerar_recheios) then begin
    with frmPizza do begin
      for i := Low(ItensRecheio) to High(ItensRecheio) do
        total_recheios := total_recheios + ItensRecheio[i].qtd_recheio * ValorItemRecheio(ItensRecheio[i].id);
    end;

    total_recheios := total_recheios + (1 * ValorItemRecheio(recheio_id));
  end;

  for i := Low(pizzas) to High(pizzas) do begin
    if pizzas[i].pizza_id <> proxima_pizza then
      Continue;

    tempo := TTimeValorPizza.Create(Application);
    tempo.AbreviacaoMoeda := '$';
    tempo.Interval := 30;
    tempo.ValorIncremental := 0.10;
    tempo.LabelTexto := lblValorTotal;
    tempo.ValorFinal := pizzas[i].custos[Integer(frmPizza.TamanhoSelecionado)] + total_recheios;
    tempo.Iniciar;
    Break;
  end;
end;

procedure TFormPizza.anmTamanhoFinish(Sender: TObject);
begin
  if anmTamanho.Tag = Integer(ptPequena) then begin
    SelecionarCorTextoTamanho(lblTamanhoEsquerda);
    anmTamanhoTexto.Parent := lblTamanhoEsquerda;
  end
  else if anmTamanho.Tag = Integer(ptMedia) then begin
    SelecionarCorTextoTamanho(lblTamanhoCentro);
    anmTamanhoTexto.Parent := lblTamanhoCentro;
  end
  else begin
    SelecionarCorTextoTamanho(lblTamanhoDireita);
    anmTamanhoTexto.Parent := lblTamanhoDireita;
  end;

  anmTamanhoTexto.Start;
end;

procedure TFormPizza.FormResize(Sender: TObject);
begin
  frmPizza.AtualizarAreaPizza;
end;

procedure TFormPizza.FormShow(Sender: TObject);
begin
  Pizza.Controllers.Pizza.BuscarPizzas(pizzas, recheios, tamanho_pizza, tamanho_inicial);
  CarregarPizzas;
  TamanhoPizzaInicial;
  CarregarRecheios;
  FormPizza.SystemStatusBar.BackgroundColor := TAlphaColors.Red;
  FormPizza.SystemStatusBar.visibility := TFormSystemStatusBar.TVisibilityMode.Visible;
end;

procedure TFormPizza.frmRecheioClick(Sender: TObject);
begin
  if RecheioIndisponivel(frmRecheio.ItemIndex) then begin
    // Definir mensagem quando atigir quantidade máxima por pizza ou do item....
    frmRecheio.RedefinirOpacidadeItem(frmRecheio.ItemIndex);
    Exit;
  end;

  AnimarValores(TPizzaAcao.paInicial, frmRecheio.ItemIndex);
  AnimarQuantidade;
  frmRecheio.FrameClick(Sender);
  SelecionarRecheio(frmRecheio.ItemIndex);
end;

function TFormPizza.RecheioIndisponivel(recheio_id: Integer): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := Low(pizzas) to High(pizzas) do begin
    if pizzas[i].pizza_id <> frmPizza.ItemIndex then
      Continue;

    if pizzas[i].qtd_maxima_recheio = frmPizza.QtdItensRecheio then begin
      Result := True;
      Break;
    end;
  end;

  // Validar quantidade total do recheio...
end;

procedure TFormPizza.frmPizzabtnPizzaDireitaClick(Sender: TObject);
begin
  AnimarTituloDescricao(TPizzaAcao.paAvancar);
  AnimarValores(TPizzaAcao.paAvancar, -1);
  AnimarQuantidade(0);
  frmPizza.btnPizzaDireitaClick(Sender);
  frmRecheio.RedefinirOpacidade;
end;

procedure TFormPizza.frmPizzabtnPizzaEsquerdaClick(Sender: TObject);
begin
  AnimarTituloDescricao(TPizzaAcao.paRetornar);
  AnimarValores(TPizzaAcao.paRetornar, -1);
  AnimarQuantidade(0);
  frmPizza.btnPizzaEsquerdaClick(Sender);
  frmRecheio.RedefinirOpacidade;
end;

procedure TFormPizza.frmPizzalytBgPizzaGesture(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  if EventInfo.GestureID = sgiLeft then
    frmPizza.btnPizzaEsquerda.OnClick(Sender)
  else if EventInfo.GestureID = sgiRight then
    frmPizza.btnPizzaDireita.OnClick(Sender)
  else if EventInfo.GestureID = sgiUp then begin
    if frmPizza.TamanhoSelecionado = ptPequena then
      btnTamanhoMedia.OnClick(Sender)
    else if frmPizza.TamanhoSelecionado = ptMedia then
      btnTamanhoGrande.OnClick(Sender);
  end
  else if EventInfo.GestureID = sgiDown then begin
    if frmPizza.TamanhoSelecionado = ptGrande then
      btnTamanhoMedia.OnClick(Sender)
    else if frmPizza.TamanhoSelecionado = ptMedia then
      btnTamanhoPequena.OnClick(Sender);
  end
  else if EventInfo.GestureID = sgiSemiCircleLeft  then begin
    frmPizza.RotacionarPizza(-100, 0.7);
  end
  else if EventInfo.GestureID = sgiSemiCircleRight  then begin
    frmPizza.RotacionarPizza(100, 0.7);
  end
  else if EventInfo.GestureID = igiDoubleTap  then begin
    if frmPizza.TamanhoSelecionado = ptPequena then
      btnTamanhoGrande.OnClick(Sender)
    else if frmPizza.TamanhoSelecionado = ptGrande then
      btnTamanhoPequena.OnClick(Sender);
  end;
end;

procedure TFormPizza.anmTamanhoProcess(Sender: TObject);
begin
  anmTamanho.StartValue := crcTamanhoSelecionado.Position.X;
end;

procedure TFormPizza.anmToolBarOpacidadeFinish(Sender: TObject);
var
  i: Integer;
begin
  if lytToolBarCenter.Opacity = 0 then begin
    lblTitulo.Text := '';
    lblDescricao.Text := '';

    for i := Low(pizzas) to High(pizzas) do begin
      if pizzas[i].pizza_id <> proxima_pizza then
        Continue;

      lblTitulo.Text := pizzas[i].nome;
      lblDescricao.Text := pizzas[i].descricao;
      Break;
    end;

    anmToolBarPosicao.Start;
    anmToolBarOpacidade.Inverse := True;
    anmToolBarOpacidade.Start;
  end;
end;

procedure TFormPizza.btnTamanhoPequenaClick(Sender: TObject);
begin
  if not frmPizza.EmExecucao(ptPequena) then begin
    AnimarBotaoSelecionarTamanho(Integer(ptPequena), 0);
    frmPizza.TamanhoSelecionado := ptPequena;
    AnimarValores(TPizzaAcao.paInicial, -1, False, True);
  end;
end;

procedure TFormPizza.CarregarPizzas;
var
  i: Integer;
begin
  frmPizza.LimparImagem;

  for i := Low(pizzas) to High(pizzas) do begin
    frmPizza.AddPizza(
      pizzas[i].pizza_id,
      pizzas[i].url
    );
  end;

  if pizzas <> nil then begin
    frmPizza.ItemIndex := pizzas[Low(pizzas)].pizza_id;
    lblTitulo.Text :=  pizzas[Low(pizzas)].nome;
    lblDescricao.Text := pizzas[Low(pizzas)].descricao;
  end;
end;

procedure TFormPizza.CarregarRecheios;
var
  i: Integer;
begin
  frmRecheio.QtdItensTela := 4;

  for i := Low(recheios) to High(recheios) do begin
    frmRecheio.AddItem(
      recheios[i].recheio_id,
      recheios[i].url,
      recheios[i].url_sobrepor
    );
  end;
end;

procedure TFormPizza.btnTamanhoMediaClick(Sender: TObject);
begin
  if not frmPizza.EmExecucao(ptMedia) then begin
    AnimarBotaoSelecionarTamanho(Integer(ptMedia), 70);
    frmPizza.TamanhoSelecionado := ptMedia;
    AnimarValores(TPizzaAcao.paInicial, -1, False, True);
  end;
end;

procedure TFormPizza.btnTamanhoGrandeClick(Sender: TObject);
begin
  if not frmPizza.EmExecucao(ptGrande) then begin
    AnimarBotaoSelecionarTamanho(Integer(ptGrande), 140);
    frmPizza.TamanhoSelecionado := ptGrande;
    AnimarValores(TPizzaAcao.paInicial, -1, False, True);
  end;
end;

procedure TFormPizza.SelecionarCorTextoTamanho(lbl: TLabel);
begin
  lblTamanhoEsquerda.FontColor := Pizza.Librarys.Modelo.lmCorBotaoPadrao;
  lblTamanhoCentro.FontColor := Pizza.Librarys.Modelo.lmCorBotaoPadrao;
  lblTamanhoDireita.FontColor := Pizza.Librarys.Modelo.lmCorBotaoPadrao;
end;

procedure TFormPizza.SelecionarRecheio(recheio_id: Integer);
var
  i: Integer;
begin
  for i := Low(recheios) to High(recheio_id) do begin
    if recheios[i].recheio_id <> recheio_id then
      Continue;

    if frmPizza.ItemRecheio[recheio_id].qtd_recheio = recheios[i].qtd_maxima_disponivel then begin
      // ShowMessage('Quantidade máxima do item atingida!');
      // Não utilizarei o "ShowMessage" para mostrar mensagens. Quando possível irei criar
      // uma tela especifica para mostrar mensagens...
      Break;
    end;

    frmPizza.AddRecheio(
      recheios[i].recheio_id,
      recheios[i].url_sobrepor,
      recheios[i].animacao.qtd,
      recheios[i].animacao.width,
      recheios[i].animacao.height,
      Pizza.View.Frame.Pizza.TArrayOfInteger(recheios[i].animacao.diminuir_raio_porc),
      Pizza.View.Frame.Pizza.TArrayOfAnimacoes(recheios[i].animacao.tipo_animacao),
      recheios[i].animacao.primeiro_ao_centro,
      recheios[i].animacao.rotacionar
    );

    Break;
  end;
end;

procedure TFormPizza.TamanhoPizzaInicial;
begin
  if tamanho_inicial = 'S' then
    btnTamanhoPequena.OnClick(Self)
  else if tamanho_inicial = 'M' then
    btnTamanhoMedia.OnClick(Self)
  else
    btnTamanhoGrande.OnClick(Self);
end;

end.
