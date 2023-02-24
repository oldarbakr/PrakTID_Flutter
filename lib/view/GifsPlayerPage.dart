
import 'package:flutter/material.dart';



class GifsPlayerPage extends StatelessWidget {
  const GifsPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(child: Image.network("https://firebasestorage.googleapis.com/v0/b/praktid-flutter.appspot.com/o/teyze.gif?alt=media&token=7b6a0b19-61c6-41e7-b77a-1e158d129059"),);
  }
}