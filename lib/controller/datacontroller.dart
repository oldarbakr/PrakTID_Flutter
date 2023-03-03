import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:praktid_flutter/model/dataclass.dart';

class DataController extends GetxController {
  late RxList<Chapter> chapters = <Chapter>[].obs;

  
  Future<List<Chapter>> fetchData() async {
    final docRef = FirebaseFirestore.instance.collection("gifs");
    var docSnapshot = await docRef.get();
    List<Chapter> chaptersData = [];
    for (var doc in docSnapshot.docs) {
      final lessonsData = doc.data();
      final chapterName = lessonsData["name"];
      lessonsData.keys
          .where((key) => !key.startsWith("lesson_"))
          .toList()
          .forEach(lessonsData.remove);
      String chapterId = doc.id;
      List<Lesson> lessons = [];
      lessonsData.forEach(
        (key, value) {
          lessons.add(
            Lesson(
              id: key,
              meaning: value['meaning'],
              videoUrl: value['url'],
            ),
          );
        },
      );
      chaptersData.add(
        Chapter(
          id: chapterId,
          name: chapterName,
          lessons: lessons,
        ),
      );
    }
    // print(chaptersData);
    // chaptersData.forEach((chapter) {
    //   print(chapter.id);
    //   print(chapter.name);
    //   chapter.lessons.forEach((lesson) {
    //     print(lesson.id);
    //     print(lesson.meaning);
    //     print(lesson.videoUrl);
    //   });
    // });
    chapters.value = chaptersData;
    return chaptersData;
  }
}
