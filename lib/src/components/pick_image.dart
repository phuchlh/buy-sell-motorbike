// ignore_for_file: sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PickImage extends StatefulWidget {
  const PickImage({super.key, required this.onImageSelected, required this.onImageDeleted});
  final Function(File) onImageSelected;
  final Function(int) onImageDeleted;

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  int totalPics = 0;
  bool isEnough = false;
  File pickedImage = File('');
  List<File> listPicked = [];
  @override
  void initState() {
    super.initState();
  }

  Future<String> uploadImageToFirebase(File imageFile, String imageName) async {
    // up từng tấm, sửa lại up 1 list
    try {
      Reference storageReference = FirebaseStorage.instance.ref().child("img-request/$imageName");
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      print("URL is $downloadUrl");

      // Return the download URL.
      return downloadUrl;
    } catch (error) {
      // Handle any errors that occur during the upload.
      print("Error uploading image: $error");
      return 'Error';
    }
  }

  Future<List<File>> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return listPicked;
    pickedImage = (File(pickedFile!.path)); // *fix chỗ này nếu back lại
    listPicked.add(pickedImage);
    widget.onImageSelected(pickedImage);
    setState(() {
      totalPics++;
      if (totalPics >= 6) {
        isEnough = true;
      }
    });
    for (var i = 0; i < listPicked.length; i++) {
      print('$i - ${listPicked[i].path}');
    }
    // uploadImageToFirebase(pickedImage, pickedFile.name);
    return listPicked;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tải lên hình ảnh sản phẩm của bạn',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Text(
                    'Đã tải lên: ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    '$totalPics',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue),
                  ),
                  SizedBox(width: 1),
                  const Text(
                    '(Bạn cần tải lên từ 3 đến 6 ảnh)',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  isEnough
                      ? Container()
                      : GestureDetector(
                          onTap: isEnough
                              ? null
                              : () {
                                  _pickImage();
                                },
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            width: 90,
                            height: 90,
                            color: Colors.grey[300],
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                ),
                                Text(
                                  'Thêm ảnh',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                  SizedBox(width: 10), // Adjust spacing between the button and images
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 90,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: listPicked.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Container(
                                  width: 90,
                                  height: 90,
                                  margin:
                                      EdgeInsets.only(right: 10), // Adjust spacing between images
                                  color: Colors.grey[300],
                                  child: Image.file(
                                    listPicked[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 3,
                                  child: GestureDetector(
                                    onTap: () {
                                      widget.onImageDeleted(index);
                                      setState(() {
                                        listPicked.removeAt(index);
                                        totalPics--;
                                        if (totalPics < 6) {
                                          isEnough = false;
                                        }
                                      });
                                    },
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(
                                        Icons.close,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                index == 0
                                    ? Positioned(
                                        bottom: 0,
                                        right: 0,
                                        left: 0,
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                          ),
                                          child: Text(
                                            'Ảnh bìa',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
