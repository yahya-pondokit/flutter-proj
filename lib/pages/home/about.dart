import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(10.0, 18.0, 10.0, 18.0),
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Image.asset('lib/etc/ic_launcher.png', width: 120.0,),
                  ),
                  Text('TodoAPP', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                        'Project ini merupakan hasil pembelajaran mobile application dari santri jurusan programming di Pondok Informatika Al-Madinah. Dikerjakan dengan flutter selama -+1 bulan.'),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Pondok Informatika Al-Madinah',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    Icons.mail_outline,
                                    size: 18.0,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text('pondokinformatika@gmail.com'),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    Icons.public,
                                    size: 18.0,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text('http://pondokinformatika.com'),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    Icons.smartphone,
                                    size: 18.0,
                                  ),
                                  Container(
                                    width: (MediaQuery.of(context).size.width)-70.0,
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text(
                                        '0857 2524 9265 / 0822 5718 2656 (Irhamullah)'),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    Icons.home,
                                    size: 18.0,
                                  ),
                                  Container(
                                    width: (MediaQuery.of(context).size.width)-70.0,
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'Jl. Raya Krapyak RT.05, Karanganyar, Wedomartani, Ngemplak, Sleman, Daerah Istimewa Yogyakarta',
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
