import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

//class responsável por todo o aplicativo
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false ,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
  int count = 0;

  void decrement() {
    setState(() {
      count--;
    });
    print(count);
  }

  void increment() {
    setState(() {
      count++;
    });
    print(count);
  }

  bool get isEmpty => count == 0;
  bool get isFull => count ==20;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/Teste33.jpg'),
            fit: BoxFit.cover,
          )),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, //Alinhamento do eixo principal
            children: [
               Text(
                isFull ? 'Lotado !!' : 'Pode entrar!',
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  //Espaçamento das letras  letterSpacing: 10,
                ),
              ),
               Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  '$count',
                  style:  TextStyle(
                    fontSize: 100,
                    color: isFull ?  Colors.red : Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: isEmpty ? null : decrement,
                    style: TextButton.styleFrom(
                        backgroundColor: isEmpty ? Colors.white.withOpacity(0.2) :  Colors.white,
                        fixedSize: const Size(100, 100),
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        )
                        //padding: const EdgeInsets.all(24),//palavras diferentes , fazem com que botôes tenham tamanhos diferentes
                        ),
                    child: const Text(
                      'Saiu',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  TextButton(
                    onPressed: isFull ? null : increment,
                    style: TextButton.styleFrom(
                        backgroundColor: isFull ?  Colors.white.withOpacity(0.2) : Colors.white,
                        fixedSize: const Size(100, 100),
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        )),
                    child: const Text(
                      'Entrou',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

//class responsável pela pagina principal do aplicativo
