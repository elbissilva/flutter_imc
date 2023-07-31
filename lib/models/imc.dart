class Pessoa {
  String _nome = "";
  var _peso = "";
  var _altura = "";
  var _imc = "";
  var _situacao = "";

  Pessoa(this._nome, this._altura, this._peso, this._imc, this._situacao) {
    _nome = nome;
    _peso = peso;
    _altura = altura;
    _situacao = situacao;
  }

  get nome => _nome;
  set nome(nome) {
    _nome = nome;
  }

  get peso => _peso;
  set peso(peso) {
    _peso = peso;
  }

  get altura => _altura;
  set altura(altura) {
    _altura = altura;
  }

  get imc => _imc;
  set imc(imc) {
    _imc = imc;
  }

  get situacao => _situacao;
  set situacao(situacao) {
    _situacao = situacao;
  }
}
