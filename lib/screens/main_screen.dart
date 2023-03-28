import 'package:flutter/material.dart';
import 'package:chatting_app/config/palette.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {

  bool isSignupScreen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: Stack(
        children: [
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 300,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('image/red.jpg'),
                    fit: BoxFit.fill                 //상단 스크린 꽉차게 하기 위해
                  )
                ),
                child: Container(
                  padding: const EdgeInsets.only(top: 90, left: 20), //텍스트 위치 조정
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(                     //폰트의 크기와 특징이 다를 경우
                        text: const TextSpan(             //텍스트나 문단을 모아서 구성할 수 있게 해줌
                          text: 'Welcome',
                          style: TextStyle(
                            letterSpacing: 1.0,
                            fontSize: 25,
                            color: Colors.white
                          ),
                          children: [
                            TextSpan(
                              text: ' to Yummy chat!',
                              style: TextStyle(
                                  letterSpacing: 1.0,
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ]
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Signup to continue',
                        style: TextStyle(
                            letterSpacing: 1.0,
                            color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              )
          ),
          Positioned(
              top: 180,
              child: Container(
                padding: EdgeInsets.all(20),
                height: 280,
                width: MediaQuery.of(context).size.width-40,
                margin: const EdgeInsets.symmetric(horizontal: 20), //양쪽 20픽셀씩
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(                          //박스 뒤 그림자 생성
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 5
                      )
                    ]
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = false;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                'LOGIN',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:!isSignupScreen ? Palette.activeColor : Palette.textColor1
                                ),
                              ),
                              if(!isSignupScreen)
                              Container(
                                margin: const EdgeInsets.only(top: 3),
                                height: 2,
                                width: 55,
                                color: Colors.orange,
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              isSignupScreen = true;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                'SIGNUP',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color:isSignupScreen ? Palette.activeColor : Palette.textColor1
                                ),
                              ),
                              if(isSignupScreen)
                              Container(
                                margin: const EdgeInsets.only(top: 3),
                                height: 2,
                                width: 55,
                                color: Colors.orange,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      child: Form(                    //validation check를 위해
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.account_circle,
                                  color: Palette.iconColor,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Palette.textColor1
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(35))
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Palette.textColor1
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(35))
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}
