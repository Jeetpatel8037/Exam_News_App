import 'dart:convert';

import 'package:http/http.dart' as http;
import '../Modals/News_Modals.dart';

class NewsHelper {
  NewsHelper._();
  static final NewsHelper newsHelper = NewsHelper._();

  Future<NewsModal?> FetchAllNews() async {
    String api =
        "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=850da516b5474a6db03d93ca47ab4703";

    var responce = await http.get(Uri.parse(api));

    if (responce.statusCode == 200) {
      Map decodeddata = jsonDecode(responce.body);

      NewsModal n1 = NewsModal.fromJson(decodeddata);
      return n1;
    }
  }
}

//850da516b5474a6db03d93ca47ab4703
