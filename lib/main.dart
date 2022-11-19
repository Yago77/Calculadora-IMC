import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String infoText = 'Informe seus dados';

  void resetField() {
    weightController.text = '';
    heightController.text = '';
    setState(() {
      infoText = 'Informe seus dados!';
      formKey = GlobalKey<FormState>();
    });
  }

  void calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.6) {
        infoText = 'Abaixo do Peso (${imc.toStringAsPrecision(3)})';
      } else if (imc <= 18.6 && imc < 24.9) {
        infoText = 'Peso Ideal (${imc.toStringAsPrecision(3)})';
      } else if (imc <= 24.9 && imc < 29.9) {
        infoText = 'Levemente Acima do Peso (${imc.toStringAsPrecision(3)})';
      } else if (imc <= 29.9 && imc < 34.9) {
        infoText = 'Obesidade Grau I (${imc.toStringAsPrecision(3)})';
      } else if (imc <= 34.9 && imc < 39.9) {
        infoText = 'Obesidade Grau II (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 40) {
        infoText = 'Obesidade Grau III (${imc.toStringAsPrecision(3)})';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                resetField();
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.person_outlined,
                size: 120,
                color: Colors.black,
              ),
              TextFormField(
                controller: weightController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Insira seu peso!';
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Peso em (kg)',
                  labelStyle: TextStyle(color: Colors.black),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black, fontSize: 25),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: heightController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Insira sua altura!';
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Altura em (cm)',
                  labelStyle: TextStyle(color: Colors.black),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black, fontSize: 25),
                keyboardType: TextInputType.number,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          calculate();
                        });
                      }
                    },
                    child: const Text(
                      'Calcular',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
              ),
              Text(
                infoText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
