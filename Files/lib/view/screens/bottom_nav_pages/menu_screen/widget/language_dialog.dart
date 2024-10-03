import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/data/model/language/main_language_response_model.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/menu_screen/widget/language_dialog_body.dart';

import '../../../../../data/model/language/language_model.dart';

void showLanguageDialog(String languageList, Locale selectedLocal, BuildContext context, {bool fromSplash = false}) {
  var language = jsonDecode(languageList);
  MainLanguageResponseModel model = MainLanguageResponseModel.fromJson(language);

  List<MyLanguageModel> langList = [];

  if (model.data?.languages != null && model.data!.languages!.isNotEmpty) {
    for (var listItem in model.data!.languages!) {
      MyLanguageModel model = MyLanguageModel(imageUrl: listItem.image ?? '', languageCode: listItem.code ?? '', countryCode: listItem.name ?? '', languageName: listItem.name ?? '');
      langList.add(model);
    }
  }

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: MyColor.bgColor1,
          content: LanguageDialogBody(
            langList: langList,
            fromSplashScreen: fromSplash,
          ),
        );
      });
}
