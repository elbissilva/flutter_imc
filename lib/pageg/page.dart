import 'package:flutter/material.dart';
import 'package:flutter_imc/models/imc.dart';
import 'package:flutter_imc/repositorios/pessoa_repository.dart';

class ImcPage extends StatefulWidget {
  const ImcPage({Key? key}) : super(key: key);

  @override
  State<ImcPage> createState() => _ImcPageState();
}

class _ImcPageState extends State<ImcPage> {
  var pessoaRepository = PessoaRepository();
  var nomeController = TextEditingController();
  var pesoController = TextEditingController();
  var alturaController = TextEditingController();
  var imcController = TextEditingController();
  var imccalc = "";
  var situacaoAtual = "";

  var _pessoaslist = <Pessoa>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obterPessoas();
  }

  void obterPessoas() async {
    _pessoaslist = await pessoaRepository.listarPessoa();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          title: const Text(
            "Calculadora de IMC",
            textAlign: TextAlign.left,
          ),
          backgroundColor: Colors.green),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          nomeController.text = "";
          pesoController.text = "";
          alturaController.text = "";
          imccalc = "";
          situacaoAtual = "";
          showDialog(
              context: context,
              builder: (BuildContext bc) {
                return AlertDialog(
                  title: const Column(
                    children: [
                      Text("Adicione o nome o Peso e a Altura do Paciente")
                    ],
                  ),
                  content: Column(
                    children: [
                      TextField(
                        controller: nomeController,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.red,
                          ),
                          contentPadding: EdgeInsets.only(top: 20),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.white,
                          )),
                          hintText: "Nome",
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                      TextField(
                        controller: pesoController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.balance,
                            color: Colors.red,
                          ),
                          contentPadding: EdgeInsets.only(top: 20),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.white,
                          )),
                          hintText: "Peso kg",
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                      TextField(
                        controller: alturaController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.gas_meter_sharp,
                            color: Colors.red,
                          ),
                          contentPadding: EdgeInsets.only(top: 20),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.white,
                          )),
                          hintText: "Altura",
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                      Text(imccalc),
                    ],
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancelar")),
                    TextButton(
                        onPressed: () async {
                          setState(() {
                            num axn = (num.parse(pesoController.text) /
                                (num.parse(alturaController.text) *
                                    num.parse(alturaController.text)));
                            if (axn < 16) {
                              situacaoAtual = "MAGREZA GRAVE";
                            } else if (axn < 17) {
                              situacaoAtual = "MAGREZA MODERADA";
                            } else if (axn < 18.5) {
                              situacaoAtual = "MAGREZA LEVE";
                            } else if (axn < 25) {
                              situacaoAtual = "PESO SALDÁVEL";
                            } else if (axn < 30) {
                              situacaoAtual = "SOBREPESO";
                            } else if (axn < 35) {
                              situacaoAtual = "OBESO GRAU 1";
                            } else if (axn < 40) {
                              situacaoAtual = "OBESO GRAU 2";
                            } else if (axn >= 40) {
                              situacaoAtual = "OBESIDADE GRAVE";
                            }

                            imccalc = axn.toString();
                          });
                          await pessoaRepository.addPessoa(Pessoa(
                              nomeController.text,
                              alturaController.text,
                              pesoController.text,
                              imccalc.toString(),
                              situacaoAtual.toString()));
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                        child: const Text("Adicionar"))
                  ],
                );
              });
        },
      ),
      body: ListView.builder(
          itemCount: _pessoaslist.length,
          itemBuilder: (BuildContext bc, int index) {
            var pessoa = _pessoaslist[index];
            return Text(
                "Nome: ${pessoa.nome}, Peso:  ${pessoa.peso.toString()}Kg, Altura: ${pessoa.altura.toString()}m, IMC: ${pessoa.imc}, Estado${pessoa.situacao}}");
          }),
    ));
  }
}
