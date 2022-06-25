unit Pizza.Interfaces.Configuracoes;

interface

const
  cBaseUrl  = 'http://10.4.5.101:9000/';
  cPrefix   = 'api/v1/';

  // Como é um projeto teste... só pra garanti que mesmo sem o server a aplicação funcione
  cPreResponseErro =
  '{' +
  '"ordemTamanho": [' +
  '"S",' +
  '"M",' +
  '"L"' +
  '],' +
  '"tamanhoInicial": "L",' +
  '"cardapio": [' +
  '{' +
  '"id": 1,' +
  '"nome": "Italian",' +
  '"descricao": "tomato sauce and mozzarella",' +
  '"url": "https://i.imgur.com/27DNfji.png",' +
  '"custos": [' +
  '5.60,' +
  '7.50,' +
  '9.50' +
  '],' +
  '"qtdMaximaRecheio": 3' +
  '},' +
  '{' +
  '"id": 2,' +
  '"nome": "Pepperoni",' +
  '"descricao": "pepperoni and tomato sauce",' +
  '"url": "https://i.imgur.com/zggMX1B.png",' +
  '"custos": [' +
  '5.10,' +
  '7.00,' +
  '8.90' +
  '],' +
  '"qtdMaximaRecheio": 3' +
  '},' +
  '{' +
  '"id": 3,' +
  '"nome": "Catupiry",' +
  '"descricao": "catupiry and tomato sauce",' +
  '"url": "https://i.imgur.com/h3K5E6l.png",' +
  '"custos": [' +
  '5.00,' +
  '6.90,' +
  '8.60' +
  '],' +
  '"qtdMaximaRecheio": 3' +
  '}' +
  '],' +
  '"itemRecheio": [' +
  '{' +
  '"id": 1,' +
  '"descricao": "Mushroom",' +
  '"url": "https://i.imgur.com/pE7GOV4.png",' +
  '"urlSobrepor": "https://i.imgur.com/MkQe6xP.png",' +
  '"valor": 2.30,' +
  '"qtdMaximaDisponivel": 1,' +
  '"animacao": {' +
  '"quantidade": 15,' +
  '"width": 15,' +
  '"height": 15,' +
  '"diminuirRaioPorc": [' +
  '17,' +
  '17,' +
  '17' +
  '],' +
  '"tipoAnimacao": [' +
  '0' +
  '],' +
  '"primeiroAoCentro": "True",' +
  '"rotacionar": "True"' +
  '}' +
  '},' +
  '{' +
  '"id": 2,' +
  '"descricao": "Tomato",' +
  '"url": "https://i.imgur.com/DWR0DJ4.png",' +
  '"urlSobrepor": "https://i.imgur.com/a2XlCwC.png",' +
  '"valor": 0.60,' +
  '"qtdMaximaDisponivel": 1,' +
  '"animacao": {' +
  '"quantidade": 8,' +
  '"width": 20,' +
  '"height": 20,' +
  '"diminuirRaioPorc": [' +
  '17,' +
  '17,' +
  '17' +
  '],' +
  '"tipoAnimacao": [' +
  '0' +
  '],' +
  '"primeiroAoCentro": "True",' +
  '"rotacionar": "True"' +
  '}' +
  '},' +
  '{' +
  '"id": 3,' +
  '"descricao": "Corn",' +
  '"url": "https://i.imgur.com/CPd2Go6.png",' +
  '"urlSobrepor": "https://i.imgur.com/TEgKZET.png",' +
  '"valor": 0.40,' +
  '"qtdMaximaDisponivel": 1,' +
  '"animacao": {' +
  '"quantidade": 100,' +
  '"width": 4,' +
  '"height": 4,' +
  '"diminuirRaioPorc": [' +
  '17,' +
  '17,' +
  '17' +
  '],' +
  '"tipoAnimacao": [' +
  '0' +
  '],' +
  '"primeiroAoCentro": "True",' +
  '"rotacionar": "True"' +
  '}' +
  '},' +
  '{' +
  '"id": 5,' +
  '"descricao": "Fries",' +
  '"url": "https://i.imgur.com/a5kFcJB.png",' +
  '"urlSobrepor": "https://i.imgur.com/7YLnupg.png",' +
  '"valor": 1.60,' +
  '"qtdMaximaDisponivel": 1,' +
  '"animacao": {' +
  '"quantidade": 100,' +
  '"width": 10,' +
  '"height": 10,' +
  '"diminuirRaioPorc": [' +
  '17,' +
  '17,' +
  '17' +
  '],' +
  '"tipoAnimacao": [' +
  '0' +
  '],' +
  '"primeiroAoCentro": "True",' +
  '"rotacionar": "True"' +
  '}' +
  '},' +
  '{' +
  '"id": 6,' +
  '"descricao": "Onion",' +
  '"url": "https://i.imgur.com/wyBdkS5.png",' +
  '"urlSobrepor": "https://i.imgur.com/wRX6xIP.png",' +
  '"valor": 0.40,' +
  '"qtdMaximaDisponivel": 1,' +
  '"animacao": {' +
  '"quantidade": 100,' +
  '"width": 10,' +
  '"height": 10,' +
  '"diminuirRaioPorc": [' +
  '17,' +
  '17,' +
  '17' +
  '],' +
  '"tipoAnimacao": [' +
  '0' +
  '],' +
  '"primeiroAoCentro": "True",' +
  '"rotacionar": "True"' +
  '}' +
  '}' +
  ']' +
  '}';


implementation

end.
