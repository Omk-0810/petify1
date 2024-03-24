import 'package:flutter/material.dart';
import 'package:petify/LostAndFound/lostAndFoundForm.dart';
import 'package:petify/dashboard/donation.dart';
import 'package:petify/LostAndFound/lostAndFound.dart';


class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child:
        Stack(
          children: [
            Container(height: 800,width: 70,decoration: BoxDecoration(color: Colors.amber[200]),),
                ListView(
                            padding: EdgeInsets.only(top: 100),
                            children:[
                ListTile(
                selectedColor:Colors.amber,
                leading: Image.asset(
                  'assets/images/donate.png',
                  width: 40,
                  height: 40,
                ),
                  title: Text('Donate pet'),
                 onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PetInformationForm()),

                );
                }
                            ),
                ListTile(
                    leading: Icon(Icons.pets),
                    title: Text('Submit Lost/Found pet',style: TextStyle(),),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LostAndFoundForm()),

                      );
                    }        ),

                ListTile(
                    leading: Image.asset(
                      'assets/images/lostAndFound.jpg',
                      width: 40,
                      height: 40,
                    ),
                    title: Text('Lost & Found'),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LostAndFound()),

                      );
                    }        ),

                          ListTile(
                            leading: Image.asset(
                'assets/images/support.jpg',
                width: 40,
                height: 40,
                            ),
                            title: Text('Help & Support'),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LostAndFoundForm()),

                  );
                }        ),
                  ],
                ),
              ],
        )


      );
  }
}
