import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite_application/common/utils/constants.dart';
import 'package:country_picker/country_picker.dart';
import 'package:sqflite_application/common/widgets/reusable_text.dart';
import '../../../common/widgets/custom_otline_btn.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../common/widgets/appstyle.dart';
import '../../../common/widgets/dialogue_bix.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController phone = TextEditingController();
  Country country = Country(
    phoneCode: "86",
    countryCode: "CN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "China",
    example: "China",
    displayName: "China",
    displayNameNoCountryCode: "CN",
    e164Key: "",
  );

  sendCodeToUser() {
    if (phone.text.isEmpty) {
      return showAlertDialog(
          context: context, message: "Please enter your phone number");
    } else if (phone.text.length < 6) {
      return showAlertDialog(
          context: context, message: "Number must be greater than 8");
    } else {
      debugPrint('+${country.phoneCode}${phone.text}');
      ref.read(authControllerProvider).sendOtp(
            context: context,
            phone: '+${country.phoneCode}${phone.text}',
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConst.kBkDark,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Image.asset('assets/images/todo.png'),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 16),
              child: ReusableText(
                text: "Please enter your phone number",
                style: appstyle(17, AppConst.kLight, FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: CustomTextField(
                controller: phone,
                prefixIcon: Container(
                  padding: const EdgeInsets.all(14),
                  child: GestureDetector(
                    onTap: () {
                      showCountryPicker(
                          context: context,
                          countryListTheme: CountryListThemeData(
                              backgroundColor: AppConst.kGreyLight,
                              bottomSheetHeight: AppConst.kHeight * 0.6,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(AppConst.kRadius),
                                topRight: Radius.circular(AppConst.kRadius),
                              )),
                          onSelect: (code) {
                            setState(() {
                              country = code;
                            });
                          });
                    },
                    child: ReusableText(
                        text: "${country.flagEmoji} + ${country.phoneCode}",
                        style: appstyle(18, AppConst.kBkDark, FontWeight.bold)),
                  ),
                ),
                hintText: "Enter your phone number",
                keyboardType: TextInputType.phone,
                hintStyle: appstyle(16, AppConst.kBkDark, FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomOutlineButton(
                  onTap: () {
                    sendCodeToUser();
                  },
                  width: AppConst.kWidth * 0.8,
                  height: AppConst.kHeight * 0.07,
                  color: AppConst.kBkDark,
                  color2: AppConst.kLight,
                  text: "Send Code"),
            ),
          ],
        ),
      )),
    );
  }
}
