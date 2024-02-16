// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:buy_sell_motorbike/logger.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/comment/comment_cubit.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/post/post_cubit.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/showroom/showroom_cubit.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/user/user_cubit.dart';
import 'package:buy_sell_motorbike/src/common/constants.dart';
import 'package:buy_sell_motorbike/src/common/utils.dart';
import 'package:buy_sell_motorbike/src/components/product_details.dart';
import 'package:buy_sell_motorbike/src/model/response/comment_response.dart';
import 'package:buy_sell_motorbike/src/model/response/comment_review_response_dto.dart';
import 'package:buy_sell_motorbike/src/model/response/post_projection_response.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:buy_sell_motorbike/src/pages/user_page.dart';

import 'package:buy_sell_motorbike/src/state/navigation_items.dart';

class DetailShowroom extends StatefulWidget {
  final double ratingStar;
  final int id;
  const DetailShowroom({super.key, required this.id, required this.ratingStar});

  @override
  State<DetailShowroom> createState() => _DetailShowroomState();
}

class _DetailShowroomState extends State<DetailShowroom> {
  String avatarURL = '';
  String customerName = '';
  int SIZE = 4;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> _loadShowroomByID() async {
    await context.read<ShowroomCubit>().getShowroomById(widget.id.toString());
    await context
        .read<PostCubit>()
        .getPostProjectionByShowroomID(widget.id.toString());
    await context.read<CommentCubit>().getComments(widget.id);
  }

  Future<void> _reloadReview() async {
    await context.read<CommentCubit>().getComments(widget.id);
  }

  Future<void> _loadAvatarURL() async {
    context.read<UserCubit>().getUser().then((value) {
      setState(() {
        customerName = value.customerDto?.fullName ?? 'Đang cập nhật';
        avatarURL = value.customerDto?.avatarUrl ?? ErrorConstants.ERROR_PHOTO;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadShowroomByID();
    _loadAvatarURL();
  }

  List<TextSpan> _renderStars(double numOfStars) {
    int numberOfStars = numOfStars.floor();
    List<TextSpan> stars = List.generate(
      numberOfStars,
      (index) => TextSpan(
        text: "★", // Unicode character for a solid star
        style: TextStyle(
          color: Colors.yellow, // Change the color as needed
          fontSize: 16,
        ),
      ),
    );
    return stars;
  }

  bool hasPfp(String url) {
    // true -> has, false -> no
    if (url.startsWith('http') || url.startsWith('https')) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Half star if applicable
    // if (widget.ratingStar - numberOfStars > 0) {
    //   stars.add(
    //     Icon(
    //       Icons.star_half,
    //       color: Colors.yellow,
    //       size: 20,
    //     ),
    //   );
    // }

    const TextStyle _styleCount =
        TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
    const TextStyle _styleDescription = TextStyle(color: Colors.grey);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Thông tin cửa hàng'),
        ),
        body: RefreshIndicator(
            onRefresh: _loadShowroomByID,
            child: BlocBuilder<ShowroomCubit, ShowroomState>(
              builder: (context, state) {
                if (state.status == ShowroomStatus.loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.status == ShowroomStatus.success &&
                    state.showroom != null) {
                  final showroom = state.showroom;
                  final showroomAdd =
                      state.showroom?.address ?? 'Đang cập nhật';
                  final showroomImageDtos =
                      showroom?.showroomImageDtos?.first.url ??
                          ErrorConstants.ERROR_PHOTO;
                  List<String> lines = showroomAdd.split(', ');
                  return ListView(
                    children: [
                      Container(
                        // alignment: Alignment.center,
                        height: 445,
                        child: Stack(
                          // alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 400,
                                    width: 900,
                                    child: CachedNetworkImage(
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) {
                                        Logger.log(
                                            'process ${downloadProgress.toString()}');
                                        return SizedBox(
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          height: 50.0,
                                          width: 50.0,
                                        );
                                      },
                                      imageUrl: showroomImageDtos,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      // placeholder: (context, url) => SizedBox(
                                      //   child: Center(child: CircularProgressIndicator()),
                                      //   height: 50.0,
                                      //   width: 50.0,
                                      // ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),

                                    // DecoratedBox(
                                    //   decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    //     shape: BoxShape.rectangle,
                                    //     image: DecorationImage(
                                    //       image: NetworkImage(showroomImageDtos),
                                    //       fit: BoxFit.cover,
                                    //     ),
                                    //   ),
                                    // ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                  width: 100,
                                  height: 100,
                                  alignment: Alignment.center,
                                  child: ClipOval(
                                    child: Image.asset(
                                      ErrorConstants.DEFAULT_SHOWROOM,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      // ten shop, dia chi, danh sach, so sao, so luong xe da ban
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              showroom?.name ?? "",
                              overflow: TextOverflow.ellipsis,
                              textScaleFactor: 1.2,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width * .3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: DesignConstants.primaryColor,
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: Color.fromARGB(132, 0, 0, 0),
                                    size: 20,
                                  ),
                                  SizedBox(width: 1),
                                  Text('Đối tác uy tín',
                                      style: TextStyle(
                                          color: Color.fromARGB(132, 0, 0, 0),
                                          fontSize: 16)),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              showroom?.address ?? ErrorConstants.UPDATING,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey, // Adjust color as needed
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.call,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  showroom?.phone ?? ErrorConstants.UPDATING,
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Divider(thickness: 5),
                            Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Text('Đang bán: ',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold))
                                  ],
                                )),
                            BlocBuilder<PostCubit, PostState>(
                              builder: (context, state) {
                                final motorbikes = state.postProjections;
                                return GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(10),
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 200,
                                          mainAxisSpacing: 10,
                                          childAspectRatio: 0.74,
                                          crossAxisSpacing: 10),
                                  itemCount: state.postProjections!.length,
                                  itemBuilder: (context, index) {
                                    return detailBikeCard(motorbikes![index],
                                        showroomAdd, showroom?.id ?? 0);
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      ElevatedButton(
                        onPressed: () {
                          print('123123123');
                        },
                        child: const Text("Xem thêm"),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Color(0xFF495057),
                          backgroundColor: DesignConstants.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                      ),
                      // comment section

                      Divider(thickness: 5),
                      ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: NavigationItems.isLogged == true
                                ? () {
                                    _showReviewBottomSheet(context);
                                  }
                                : () {
                                    _notifyNeedLogin(context,
                                        "Bạn cần đăng nhập để viết nhận xét");
                                  },
                            child: const Text("Viết nhận xét"),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Color(0xFF495057),
                              backgroundColor: Color(0xFFF6FDC3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      BlocBuilder<CommentCubit, CommentState>(
                        builder: (context, state) {
                          final comments = state.comments;
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            separatorBuilder: (context, index) => Divider(
                              color: Colors.grey,
                            ),
                            itemCount: comments.length,
                            itemBuilder: (context, index) {
                              return renderReview(comments[index], index);
                            },
                          );
                        },
                      ),
                      //comment section
                    ],
                  );
                } else {
                  return Center(
                    child: Text('Vui lòng thử lại'),
                  );
                }
              },
            )));
  }

  Widget renderReview(CommentResponse comment, int index) {
    final ratingStars = comment.reviewRating ?? 0;
    bool isAvatarUrlExist = hasPfp(comment.customerDto?.avatarUrl ?? "");
    final commentReviews = comment.commentReviewsDtos;
    String formattedDateTime = DateFormat('dd/MM/yyyy').format(
        DateTime.fromMillisecondsSinceEpoch(
            int.parse(comment.reviewDate.toString())));
    return Container(
      child: Column(
        children: [
          ListTile(
            // check if user have avatarUrl -> display it, nope -> display default avatar
            leading: isAvatarUrlExist
                ? SizedBox(
                    width: 35,
                    height: 35,
                    child: CircleAvatar(
                      backgroundColor: Colors.black45,
                      radius: 20,
                      backgroundImage: NetworkImage(
                          comment.customerDto?.avatarUrl ??
                              ErrorConstants.ERROR_PHOTO),
                    ),
                  )
                : ProfilePicture(
                    name: comment.customerDto?.fullName ?? "",
                    radius: 18,
                    fontsize: 15,
                  ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: comment.customerDto?.fullName ?? "",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    children: [
                      TextSpan(
                        text: " | ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                        ),
                      ),
                      ..._renderStars(ratingStars)
                    ],
                  ),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 2),
                Text(
                  comment.reviewContent ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      "$formattedDateTime",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: NavigationItems.isLogged == true
                          ? () {
                              _replyReview(context, comment.id.toString(),
                                  comment.customerDto?.fullName ?? "");
                            }
                          : () {
                              _notifyNeedLogin(context,
                                  "Bạn cần đăng nhập để phản hồi về nhận xét");
                            },
                      child: Text(
                        "Phản hồi",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          renderComment(commentReviews ?? []),
        ],
      ),
    );
  }

  Future<void> _notifyNeedLogin(BuildContext context, String content) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thông báo'),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text('Đóng'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _replyReview(BuildContext context, String commentID, String reviewName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          reverse: true,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            top: 20,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    maxLines: 3,
                    onChanged: (value) {
                      print('avt url: $avatarURL');
                      print('commentID: $commentID');
                      print('reviewName: $customerName');
                      context.read<CommentCubit>().onChangeReplyReview(value);
                    },
                    validator: (value) =>
                        (value == null || value.isEmpty || value.length < 2)
                            ? 'Vui lòng nhập ý kiến của bạn '
                            : null,
                    decoration: InputDecoration(
                      labelText: 'Phản hồi @$reviewName',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState != null &&
                        _formKey.currentState!.validate()) {
                      EasyLoading.show(status: 'Đang gửi đánh giá');
                      await context
                          .read<CommentCubit>()
                          .postReplyReview(
                              customerName, avatarURL, int.parse(commentID))
                          .then((value) {
                        if (value == CommentStatus.successComment) {
                          EasyLoading.showSuccess(
                              'Phản hồi đã được gửi, xin chân thành cảm ơn bạn đã dành thời gian');
                          Navigator.pop(context); // Close the bottom sheet
                          _reloadReview();
                        } else {
                          EasyLoading.showError(
                              'Phản hồi thất bại, vui lòng thử lại');
                        }
                      });
                    }
                  },
                  child: Text('Gửi phản hồi'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget renderComment(List<CommentReviewResponse> commentReviews) {
    List<Widget> commentWidgets = [];
    if (commentReviews.isNotEmpty) {
      for (var element in commentReviews) {
        String _formattedDateTime = DateFormat('dd/MM/yyyy').format(
            DateTime.fromMillisecondsSinceEpoch(
                int.parse(element.commentDate.toString())));
        bool isPfpHttps = hasPfp(element.avatarUrl ?? "");
        commentWidgets.add(ListTile(
          contentPadding: EdgeInsets.only(left: 40),
          // check if user have avatarUrl -> display it, nope -> display default avatar
          leading: !isPfpHttps
              ? SizedBox(
                  width: 30,
                  height: 30,
                  child: CircleAvatar(
                    backgroundColor: Colors.black45,
                    radius: 20,
                    backgroundImage: NetworkImage(
                        element.avatarUrl ?? ErrorConstants.ERROR_PHOTO),
                  ),
                )
              : ProfilePicture(
                  name: element.commentatorName ?? "",
                  radius: 15,
                  fontsize: 14,
                ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: element.commentatorName ?? "",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: " | ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
                    TextSpan(
                      text: "$_formattedDateTime",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          subtitle: Text(element.commentContent ?? "",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
        ));
      }
    }

    if (commentWidgets.isNotEmpty) {
      return Column(
        children: commentWidgets,
      );
    } else {
      return SizedBox();
    }
  }

  void _showReviewBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          reverse: true,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            top: 20,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Cảm nhận của bạn về cửa hàng',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                RatingBar.builder(
                  initialRating: 1,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemSize: 30.0,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print('Rating: $rating');
                    context.read<CommentCubit>().onChangeStars(rating);
                  },
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    maxLines: 3,
                    onChanged: (value) {
                      print(value);
                      context.read<CommentCubit>().onChangeUserReview(value);
                    },
                    validator: (value) =>
                        (value == null || value.isEmpty || value.length < 2)
                            ? 'Vui lòng nhập review của bạn'
                            : null,
                    decoration: InputDecoration(
                      labelText: 'Cảm nhận của bạn như thế nào?',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState != null &&
                        _formKey.currentState!.validate()) {
                      EasyLoading.show(status: 'Đang gửi đánh giá');
                      await context
                          .read<CommentCubit>()
                          .postReview(widget.id.toString())
                          .then((value) {
                        if (value == CommentStatus.success) {
                          EasyLoading.showSuccess(
                              'Đánh giá đã được gửi đến showroom, xin chân thành cảm ơn bạn đã dành thời gian');
                          Navigator.pop(context); // Close the bottom sheet
                          _reloadReview();
                        } else {
                          EasyLoading.showError('Gửi đánh giá thất bại');
                        }
                      });
                    }
                  },
                  child: Text('Gửi đánh giá'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget detailBikeCard(
      PostProjection postElement, String showroomAdd, int showroomID) {
    final formatedPrice = NumberFormat.currency(locale: 'vi', symbol: 'đ')
        .format(postElement.price);
    String formattedNumber =
        NumberFormat.decimalPattern().format(postElement.motorbikeOdo);
    return GestureDetector(
        onTap: () {
          print('postid ${postElement.id}');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetails(
                        id: postElement?.id ?? 0,
                      )));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 3))
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .15,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: NetworkImage(postElement.motorbikeThumbnail ??
                          ErrorConstants.UPDATING),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 15,
                          height: 15,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                image: NetworkImage(postElement.logoBrand ??
                                    ErrorConstants.UPDATING),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            postElement.motorbikeName ??
                                ErrorConstants.UPDATING,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          child: Text(
                              postElement.yearOfRegistration ?? 'Updating'),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.grey[300],
                          ),
                        ),
                        SizedBox(width: 5),
                        Container(
                          padding: const EdgeInsets.all(2),
                          child: Text('${formattedNumber} km'),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.grey[300],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      formatedPrice,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      postElement.location ?? ErrorConstants.UPDATING,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
