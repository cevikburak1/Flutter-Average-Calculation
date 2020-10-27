import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      primarySwatch: Colors.red,

      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dersadi;
  int dersKredi = 1;
  double dersHarfDegeri = 4;
  List<Ders> tumDersler;
  static int sayac=0;
  var formKey = GlobalKey<FormState>();
  double ortalama = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tumDersler = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Ortalama Hesaplama"),),
      floatingActionButton: FloatingActionButton(onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
        }
      }, child: Icon(Icons.add),),
      body: uygulamaGovdesi(),
    );
  }

  Widget uygulamaGovdesi() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Container(
              color: Colors.yellow, padding: EdgeInsets.fromLTRB(10, 10, 10, 0)
              , child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(

                        labelText: "Ders Adı giriniz",
                        hintText: "Ders Adını gir",
                        labelStyle: TextStyle(fontSize: 20, color: Colors.red),
                        hintStyle: TextStyle(color: Colors.red),

                        border: OutlineInputBorder(

                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),

                      ),
                      validator: (girilendeger) {
                        if (girilendeger.length > 0) {
                          return null;
                        } else
                          return "Ders Adı Boş Olamaz";
                      },
                      onSaved: (kaydedilcekdeger) {
                        dersadi = kaydedilcekdeger;
                        setState(() {
                          tumDersler.add(
                              Ders(dersadi, dersHarfDegeri, dersKredi));
                          ortalamayiHesapla();
                        });
                      },

                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(

                            child: DropdownButton<int>
                              (items: dersKredileriItems(),
                              value: dersKredi,
                              onChanged: (secilenKredi) {
                                setState(() {
                                  dersKredi = secilenKredi;
                                });
                              },),

                            margin: EdgeInsets.only(top: 8),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.redAccent, width: 2),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(8))
                            )

                        ),
                        Container(
                            child: DropdownButton<double>
                              (items: dersHarfDegerleriItems(),
                              value: dersHarfDegeri,
                              onChanged: (secilenHarf) {
                                setState(() {
                                  dersHarfDegeri = secilenHarf;
                                });
                              },),
                            margin: EdgeInsets.only(top: 8),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.redAccent, width: 2),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(8))
                            )

                        )

                      ],
                    ),


                  ],
                )),
            ),

          ),
          Container(
            height: 70,
            color: Colors.red,
            child: Center
              (child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Ortalama : ", style: TextStyle(fontSize: 20)),
                    TextSpan(
                        text: tumDersler.length==0 ? "Lütfen Ders Ekleyiniz" : " ${ortalama.toStringAsFixed(2)} ", style: TextStyle(fontSize: 20)),
                  ]
              ),
            )),
          ),
          Expanded(
              child: Container(
                  color: Colors.yellow,
                  child: ListView.builder(
                      itemBuilder: _listeElemanlariniOlustur,
                      itemCount: tumDersler.length)


              )),
        ],
      ),
    );
  }


  List<DropdownMenuItem<int>> dersKredileriItems() {
    List<DropdownMenuItem<int>> krediler = [];
    for (int i = 0; i <= 10; i++) {
      krediler.add(DropdownMenuItem<int>(value: i,
        child: Text(
            "$i Kredi ", style: TextStyle(fontSize: 20, color: Colors.red)),));
    }
    return krediler;
  }

  List<DropdownMenuItem<double>> dersHarfDegerleriItems() {
    List<DropdownMenuItem<double>> harfler = [];
    harfler.add(DropdownMenuItem(
        child: Text("AA", style: TextStyle(fontSize: 20, color: Colors.red),),
        value: 4));
    harfler.add(DropdownMenuItem(
        child: Text("BA", style: TextStyle(fontSize: 20, color: Colors.red),),
        value: 3.5));
    harfler.add(DropdownMenuItem(
        child: Text("BB", style: TextStyle(fontSize: 20, color: Colors.red),),
        value: 3));
    harfler.add(DropdownMenuItem(
        child: Text("CA", style: TextStyle(fontSize: 20, color: Colors.red),),
        value: 2.5));
    harfler.add(DropdownMenuItem(
        child: Text("CB", style: TextStyle(fontSize: 20, color: Colors.red),),
        value: 2));
    harfler.add(DropdownMenuItem(
        child: Text("CC", style: TextStyle(fontSize: 20, color: Colors.red),),
        value: 1.5));
    harfler.add(DropdownMenuItem(
        child: Text("DC", style: TextStyle(fontSize: 20, color: Colors.red),),
        value: 1));
    harfler.add(DropdownMenuItem(
        child: Text("DD", style: TextStyle(fontSize: 20, color: Colors.red),),
        value: 0.5));
    harfler.add(DropdownMenuItem(
        child: Text("FF", style: TextStyle(fontSize: 20, color: Colors.red),),
        value: 0));


    return harfler;
  }

  Widget _listeElemanlariniOlustur(BuildContext context, int index) {
    sayac ++;
    debugPrint(sayac.toString());
    return Dismissible(
      key: Key(sayac.toString()),
    direction: DismissDirection.startToEnd,

    onDismissed: (direction){
        setState(() {
          tumDersler.removeAt(index);
          ortalamayiHesapla();
        });
    },
    child:  Card(
      child: ListTile(
        title: Text(tumDersler[index].ad),
        subtitle: Text(
          tumDersler[index].kredi.toString() + " Kredi Ders Not Degeri : " +
              (tumDersler[index].harf.toString()),
        ),
      ),),
    );
  }

  void ortalamayiHesapla() {
    double toplamNot = 0;
    double toplamKredi = 0;
    for (var oankiDers in tumDersler) {
      var kredi = oankiDers.kredi;
      var harfDegeri = oankiDers.harf;

      toplamNot = toplamNot + (harfDegeri * kredi);
      toplamKredi += kredi;
    }
    ortalama=toplamNot / toplamKredi;

  }



}


class Ders{
  String ad;
  double harf;
  int kredi;

  Ders(this.ad,this.harf,this.kredi);
}




