import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

late HomeController myController;

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    myController = Get.find<HomeController>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('HomeView'),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => myController.replyingTo.value.isEmpty
                ? Container(
                    height: 0,
                  )
                : SizedBox(
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.grey.shade400),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "Replying to ${myController.replyingTo.value}",
                              style: const TextStyle(
                                  color: Colors.black87, fontSize: 15),
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                myController.replyingTo.value = '';
                                myController.mainIndex.value = 0;
                              },
                              child: const Icon(Icons.close))
                        ],
                      ),
                    ),
                  )),
            Container(
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    color: Colors.grey,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/user.jpeg',
                          height: 50,
                          width: 50,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: myController.typeController.value,
                            onChanged: (text) {
                              myController.typeController.refresh();
                            },
                            cursorColor: Colors.black,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                                hintText: "Write comment here..."),
                          ),
                        ),
                        Obx(() => myController.typeController.value.text
                                .toString()
                                .isEmpty
                            ? const Icon(
                                Icons.send,
                                color: Colors.grey,
                              )
                            : GestureDetector(
                                onTap: () {
                                  myController.addComment();
                                },
                                child: const Icon(
                                  Icons.send,
                                  color: Colors.black,
                                ),
                              ))
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              child: Obx(() => Text(
                    "Comments(${myController.commentModel.length})",
                    style: const TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  )),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                    itemCount: myController.commentModel.length,
                    reverse: true,
                    itemBuilder: (context, i) {
                      return Container(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  myController.commentModel[i].userImage,
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        color: Colors.grey.shade300,
                                        clipBehavior: Clip.hardEdge,
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      myController
                                                          .commentModel[i]
                                                          .userName,
                                                      style: const TextStyle(
                                                          color: Colors.purple,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        deleteComment(
                                                            context, i);
                                                      },
                                                      child: const Icon(
                                                          Icons.more_horiz))
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 5),
                                                child: Text(
                                                  myController.commentModel[i]
                                                      .userCommentTime,
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 11),
                                                ),
                                              ),
                                              Text(
                                                myController.commentModel[i]
                                                    .userComment,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        )),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 10, top: 10, bottom: 10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              myController.replyingTo.value =
                                                  myController
                                                      .commentModel[i].userName;
                                              myController.mainIndex.value = i;
                                            },
                                            child: const Padding(
                                              padding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 5.0),
                                              child: Text(
                                                "Reply",
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13),
                                              ),
                                            ),
                                          ),
                                          myController.commentModel[i]
                                                      .userCommentArray.isNotEmpty
                                              ? Row(
                                                  children: [
                                                    const Text(
                                                      "|",
                                                      style: TextStyle(
                                                          color: Colors.purple,
                                                          fontSize: 15),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5.0),
                                                      child: Text(
                                                        "${myController.commentModel[i].userCommentArray.length} Reply",
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.purple,
                                                            fontSize: 13),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                    ReplyComment(i)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void deleteComment(BuildContext context, int? mainIndex, {int? subIndex}) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete'),
            onTap: () {
              Navigator.pop(context); // Close the bottom sheet
              _showConfirmationDialog(
                  context, mainIndex, subIndex); // Show the confirmation dialog
            },
          ),
        ],
      );
    },
  );
}

void _showConfirmationDialog(
    BuildContext context, int? mainIndex, int? subIndex) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Are you sure you want to delete?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (subIndex == null) {
                myController.deleteMainCommentElement(mainIndex!);
              } else {
                myController.deleteSubCommentElement(mainIndex!, subIndex);
              }
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      );
    },
  );
}

class ReplyComment extends GetView<HomeController> {
  const ReplyComment(this.i, {super.key});

  final int i;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: myController.commentModel[i].userCommentArray.length,
        itemBuilder: (context, subIndex) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  myController
                      .commentModel[i].userCommentArray[subIndex].userImage,
                  height: 50,
                  width: 50,
                ),
              ),
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.grey.shade300,
                  clipBehavior: Clip.hardEdge,
                  margin: const EdgeInsets.only(bottom: 19),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                myController.commentModel[i]
                                    .userCommentArray[subIndex].userName,
                                style: const TextStyle(
                                    color: Colors.purple, fontSize: 15),
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  deleteComment(context, i, subIndex: subIndex);
                                },
                                child: const Icon(Icons.more_horiz))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            myController.commentModel[i]
                                .userCommentArray[subIndex].userCommentTime,
                            style: const TextStyle(color: Colors.grey, fontSize: 11),
                          ),
                        ),
                        Text(
                          myController.commentModel[i]
                              .userCommentArray[subIndex].userComment,
                          style: const TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
