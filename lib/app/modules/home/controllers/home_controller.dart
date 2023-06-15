import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:random_x/random_x.dart';

import '../comment_model.dart';

class HomeController extends GetxController {
  Rx<TextEditingController> typeController = TextEditingController().obs;
  Rx<String> replyingTo = ''.obs;
  Rx<int> mainIndex = 0.obs;

  RxList<CommentModel> commentModel = <CommentModel>[].obs;

  deleteMainCommentElement(int index) {
    commentModel.remove(commentModel.removeAt(index));
    mainIndex.value=0;
    replyingTo.value='';
  }

  deleteSubCommentElement(int mainIndex, int subIndex) {
    commentModel[mainIndex].userCommentArray.removeAt(subIndex);
    this.mainIndex.value=0;
    replyingTo.value='';
    commentModel.refresh();
  }

  addComment() {

    if(replyingTo.value.isEmpty&&mainIndex.value==0)
    {
      commentModel.add(CommentModel(
          '${RndX.generateName()}',
          'assets/user.jpeg',
          GetTimeAgo.parse(DateTime.now()),
          typeController.value.text.toString(), []));

      commentModel.refresh();
    }else{
      commentModel[mainIndex.value].userCommentArray.add(CommentModel(
          '${RndX.generateName()}',
          'assets/user.jpeg',
          GetTimeAgo.parse(DateTime.now()),
          typeController.value.text.toString(), []));

    }
    typeController.value.text='';
    // mainIndex.value=0;
    // replyingTo.value='';

    typeController.refresh();
    commentModel.refresh();

  }

  fillFakeComment() {
    for (int i = 0; i < 10; i++) {
      commentModel.add(CommentModel(
          '${RndX.generateName()}',
          'assets/user.jpeg',
          GetTimeAgo.parse(RndX.generateRandomDateBetween(
              start: (RndX.randomPastDate()), end: DateTime.timestamp())),
          'Testing',
          [
            CommentModel(
                '${RndX.generateName()}',
                'assets/user.jpeg',
                GetTimeAgo.parse(RndX.generateRandomDateBetween(
                    start: (RndX.randomPastDate()), end: DateTime.timestamp())),
                'Testing',
                [])
          ]));
    }
  }

  getComments() {}


  @override
  void onReady() {
    super.onReady();
    fillFakeComment();
  }

}
