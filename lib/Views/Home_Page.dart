
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Controlleres/News_Controller.dart';
import '../Helperes/News_helperes.dart';
import '../Modals/News_Modals.dart';
import 'Detail_Page.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Jeet's News App"),
        leading: IconButton(
          onPressed: (){},
          icon: Icon(Icons.download_for_offline),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: NewsHelper.newsHelper.FetchAllNews(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.hasError}"),
              );
            } else if (snapshot.hasData) {
              NewsModal data = snapshot.data;
              return (data != null)
                  ? ListView.builder(
                  itemCount: data.articles!.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      leading: Container(
                          color: Colors.grey[200],
                          height: 150,
                          width: 150,
                          child: Image.network(
                            "${data.articles![i].urlToImage}",
                            fit: BoxFit.fitHeight,
                          )),
                      title: Text("${data.articles![i].title}"),
                      subtitle: Text("${data.articles![i].content}"),
                      onTap: () {
                        homeController.d1.value.urlToImage = data.articles![i].urlToImage;
                        homeController.d1.value.content = data.articles![i].title as String?;
                        homeController.d1.value.title = data.articles![i].content as String?;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (e) => const detail_page()));
                      },
                    );
                  })
                  : const Center(
                child: Text("No any data found"),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
