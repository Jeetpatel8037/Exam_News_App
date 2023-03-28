import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../Controlleres/News_Controller.dart';
import '../Helperes/News_helperes.dart';
import '../Modals/News_Modals.dart';


class detail_page extends StatefulWidget {
  const detail_page({Key? key}) : super(key: key);

  @override
  State<detail_page> createState() => _detail_pageState();
}

class _detail_pageState extends State<detail_page> {
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Detail News"),
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
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            NewsModal data = snapshot.data;
            return (data != null)
                ? ListView.builder(
                itemCount: 1,
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      Container(
                        height: 250,
                        color: Colors.grey,
                        child:
                        Image.network(homeController.d1.value.urlToImage),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${homeController.d1.value.title}",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            // Text(
                            //   "${homeController.d1.value.publishedAt}",
                            //   style: const TextStyle(
                            //       fontStyle: FontStyle.italic),
                            // ),
                            const SizedBox(height: 5),
                            Text("${homeController.d1.value.content}"),
                            const Divider(),
                          ],
                        ),
                      ),
                    ],
                  );
                })
                : const Center(
              child: Text("data not found"),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // DBHelper.dbHalper.insertData(author: , title: title, description: description, source: source);
          Navigator.pop(context);
        },
        child: const Icon(Icons.close),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
