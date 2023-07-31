import 'package:flutter_imc/models/imc.dart';

class PessoaRepository {
  List<Pessoa> _pessoas = [];

  Future<void> addPessoa(Pessoa pessoa) async {
    await Future.delayed(const Duration(microseconds: 100));
    _pessoas.add(pessoa);
  }

  Future<List<Pessoa>> listarPessoa() async {
    await Future.delayed(const Duration(microseconds: 100));
    return _pessoas;
  }
}
