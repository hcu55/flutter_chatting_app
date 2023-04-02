import 'package:chatting_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:chatting_app/config/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {

  final _authentication = FirebaseAuth.instance;
  bool isSignupScreen = true;
  bool showSpinner = false;
  final _formKey = GlobalKey<FormState>();
  String userName = '';
  String userEmail = '';
  String userPassword = '';


  void _tryValidation(){
    final isValid = _formKey.currentState!.validate();
    if(isValid){
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Stack(
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
                            text: TextSpan(             //텍스트나 문단을 모아서 구성할 수 있게 해줌
                              text: 'Welcome',
                              style: const TextStyle(
                                letterSpacing: 1.0,
                                fontSize: 25,
                                color: Colors.white
                              ),
                              children: [
                                TextSpan(
                                  text: isSignupScreen ? ' to Yummy chat!' : ' back',
                                  style: const TextStyle(
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
                          Text(
                            isSignupScreen ? 'Signup to continue' : 'Signin to continue',
                            style: const TextStyle(
                                letterSpacing: 1.0,
                                color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
              ),
              //배경
              AnimatedPositioned(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  top: 180,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                    padding: const EdgeInsets.all(20),
                    height: isSignupScreen ? 280 : 250,
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
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 20),
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
                          if(isSignupScreen)
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Form(                    //validation check를 위해
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    key: const ValueKey(1),
                                    validator: (value) {
                                      if(value!.isEmpty || value.length < 4){
                                        return 'Please enter at least 4 characters';
                                      }
                                      return null;
                                    },
                                    onSaved: (newValue) {
                                      userName = newValue!;
                                    },
                                    onChanged: (value) {
                                      userName = value;
                                    },
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
                                      hintText: 'User name',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Palette.textColor1
                                      ),
                                      contentPadding: EdgeInsets.all(10)
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,    //이메일 전용 키보드
                                    key: const ValueKey(2),
                                    validator: (value) {
                                      if(value!.isEmpty || !value.contains('@')){
                                        return 'Please enter a valid email address.';
                                      }
                                      return null;
                                    },
                                    onSaved: (newValue) {
                                      userEmail = newValue!;
                                    },
                                    onChanged: (value) {
                                      userEmail = value;
                                    },
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.email,
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
                                        hintText: 'email',
                                        hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Palette.textColor1
                                        ),
                                        contentPadding: EdgeInsets.all(10)
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  TextFormField(
                                    obscureText: true,      //비밀번호 ****로 표시하도록
                                    key: const ValueKey(3),
                                    validator: (value) {
                                      if(value!.isEmpty || value.length < 6){
                                        return 'Password must be at least 7 characters long.';
                                      }
                                      return null;
                                    },
                                    onSaved: (newValue) {
                                      userPassword = newValue!;
                                    },
                                    onChanged: (value) {
                                      userPassword = value;
                                    },
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.lock,
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
                                        hintText: 'password',
                                        hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Palette.textColor1
                                        ),
                                        contentPadding: EdgeInsets.all(10)
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          if(!isSignupScreen)
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    key: const ValueKey(4),
                                    validator: (value) {
                                      if(value!.isEmpty || !value.contains('@')) {
                                        return 'Please enter a valid email address.';
                                      }
                                      return null;
                                    },
                                    onSaved: (newValue) {
                                      userEmail = newValue!;
                                    },
                                    onChanged: (value) {
                                      userEmail = value;
                                    },
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
                                        hintText: 'User name',
                                        hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Palette.textColor1
                                        ),
                                        contentPadding: EdgeInsets.all(10)
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  TextFormField(
                                    key: const ValueKey(5),
                                    validator: (value) {
                                      if(value!.isEmpty || value.length < 6){
                                        return 'Password must be at least 7 characters long.';
                                      }
                                      return null;
                                    },
                                    onSaved: (newValue) {
                                      userPassword = newValue!;
                                    },
                                    onChanged: (value) {
                                      userPassword = value;
                                    },
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.lock,
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
                                        hintText: 'password',
                                        hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Palette.textColor1
                                        ),
                                        contentPadding: EdgeInsets.all(10)
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
              ),
              //텍스트 폼 필드
              AnimatedPositioned(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  top: isSignupScreen ? 430 : 390,
                  right: 0,
                  left: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: GestureDetector(
                        onTap: () async{
                          setState(() {
                            showSpinner = true;
                          });
                          if(isSignupScreen){
                            _tryValidation();

                            try {
                              final newUser = await _authentication
                                  .createUserWithEmailAndPassword(
                                  email: userEmail,
                                  password: userPassword
                              );
                              if(newUser.user != null){        //등록이 된거니 채팅페이지로 넘어가도록
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context){
                                      return ChatScreen();
                                    })
                                );
                                setState(() {
                                  showSpinner = false;
                                });
                              }
                            }
                            catch(e){
                              print(e);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                    Text('Please check your email and password'),
                                  backgroundColor: Colors.blue,
                                )
                              );
                            }
                          }
                          if(!isSignupScreen) {
                            _tryValidation();
                            try {
                              final newUser = await _authentication
                                  .signInWithEmailAndPassword(
                                  email: userEmail,
                                  password: userPassword
                              );
                              if (newUser.user != null) { //등록이 된거니 채팅페이지로 넘어가도록
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return ChatScreen();
                                    })
                                );
                              }
                            }catch(e){
                              print(e);
                            }
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Colors.orange,
                                Colors.red
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight
                            ),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(0, 1)
                              )
                            ]
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
              ),
              //전송버튼
              AnimatedPositioned(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  top: isSignupScreen ? MediaQuery.of(context).size.height-125
                      : MediaQuery.of(context).size.height-165,
                  right: 0,
                  left: 0,
                  child: Column(
                    children: [
                      Text(isSignupScreen ? 'or Signup with' : 'or Signin with'),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton.icon(
                        onPressed: () {

                        },
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            minimumSize: const Size(155, 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            backgroundColor: Palette.googleColor
                        ),
                        icon: const Icon(Icons.add),
                        label: const Text('Google'),
                      ),
                    ],
                  )
              )
              //구글 로그인 버튼
            ],
          ),
        ),
      ),
    );
  }
}
