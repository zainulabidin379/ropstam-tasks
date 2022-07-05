import 'package:flutter/material.dart';
import 'package:the_validator/the_validator.dart';
import '../services/auth.dart';
import '../shared/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscurePassword = true;
  bool loading = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        ShaderMask(
          shaderCallback: (rect) => LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [kPrimaryColor.withOpacity(0.3), Colors.transparent],
          ).createShader(rect),
          blendMode: BlendMode.multiply,
          child: Container(
            height: size.height,
            width: size.width,
            color: kWhite,
          ),
        ),
        GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('Hello Again!',
                              style: kBodyText.copyWith(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Center(
                        child: Text('Chance to get your\nlife better',
                            textAlign: TextAlign.center,
                            style: kBodyText.copyWith(fontSize: 20)),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      //Email
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20),
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          style: kBodyText.copyWith(color: kBlack),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(20),
                            hintText: 'Email',
                            hintStyle: kBodyText.copyWith(color: kGrey),
                            errorStyle: const TextStyle(
                              fontSize: 16.0,
                            ),
                            fillColor: kWhite,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              borderSide: BorderSide(
                                color: kWhite,
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              borderSide: BorderSide(
                                color: kWhite,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              borderSide:
                                  BorderSide(color: kPrimaryColor, width: 1),
                            ),
                          ),
                          validator: FieldValidator.multiple([
                            FieldValidator.required(
                                message: 'The email field is required'),
                            FieldValidator.email(
                                message: 'Please enter valid email'),
                          ]),
                        ),
                      ),

                      //Password
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20),
                        child: TextFormField(
                          obscureText: obscurePassword,
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          style: kBodyText.copyWith(color: kBlack),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(20),
                            hintText: 'Password',
                            hintStyle: kBodyText.copyWith(color: kGrey),
                            errorStyle: const TextStyle(
                              fontSize: 16.0,
                            ),
                            fillColor: kWhite,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              borderSide: BorderSide(
                                color: kWhite,
                                width: 1,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              borderSide: BorderSide(
                                color: kWhite,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              borderSide:
                                  BorderSide(color: kPrimaryColor, width: 1),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscurePassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: kGrey,
                              ),
                              onPressed: () {
                                setState(() {
                                  obscurePassword = !obscurePassword;
                                });
                              },
                            ),
                          ),
                          validator: FieldValidator.multiple([
                            FieldValidator.required(
                                message: 'The password field is required'),
                            FieldValidator.password(
                                errorMessage: 'Password is too short',
                                minLength: 8),
                          ]),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              if (!await AuthController().login(
                                  emailController.text,
                                  passwordController.text)) {
                                setState(() {
                                  loading = false;
                                });
                              }
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20),
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: kPrimaryColor,
                              ),
                              child: Center(
                                child: loading
                                    ? CircularProgressIndicator(
                                        color: kWhite,
                                      )
                                    : Text(
                                        'Login',
                                        style: kBodyText.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: kWhite),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          'or continue with',
                          style: kBodyText.copyWith(fontSize: 16),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                        color: kWhite.withOpacity(0.8),
                                        width: 3),
                                    borderRadius: BorderRadius.circular(16)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.asset('assets/icons/google.png'),
                                )),
                            Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                        color: kWhite.withOpacity(0.8),
                                        width: 3),
                                    borderRadius: BorderRadius.circular(16)),
                                child: const Icon(
                                  Icons.apple,
                                  size: 40,
                                )),
                            Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                        color: kWhite.withOpacity(0.8),
                                        width: 3),
                                    borderRadius: BorderRadius.circular(16)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child:
                                      Image.asset('assets/icons/facebook.png'),
                                )),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: RichText(
                            text: TextSpan(
                              text: 'Not a member? ',
                              style: kBodyText,
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Register Now',
                                    style: kBodyText.copyWith(
                                        color: kPrimaryColor)),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
