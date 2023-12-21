// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/motorbrand/motorbrand_cubit.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/post/post_cubit.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/user/user_cubit.dart';
import 'package:buy_sell_motorbike/src/common/constants.dart';
import 'package:buy_sell_motorbike/src/common/utils.dart';
import 'package:buy_sell_motorbike/src/components/custom_textfield.dart';
import 'package:buy_sell_motorbike/src/components/footer.dart';
import 'package:buy_sell_motorbike/src/components/notification_page.dart';
import 'package:buy_sell_motorbike/src/components/product_card.dart';
import 'package:buy_sell_motorbike/src/components/widget_location_selector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_sell_motorbike/src/model/response/motor_brand_response.dart';
import 'package:buy_sell_motorbike/src/model/response/post_response.dart';
import '../components/promotion_banner.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchInput = TextField(
    cursorColor: Colors.black,
    style: const TextStyle(
      color: Colors.black,
    ),
    decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        focusColor: Colors.black,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        prefixIcon: const Icon(Icons.search),
        prefixIconColor: MaterialStateColor.resolveWith((states) =>
            states.contains(MaterialState.focused) ? Colors.black : Colors.grey.shade400),
        labelText: 'Tìm kiếm sản phẩm'),
  );

  final List<String> brandLogoUrls = const [
    'assets/images/banner1.png',
    'assets/images/banner2.png',
  ];
  final IMG_URL =
      "https://www.vedantu.com/seo/content-images/a6802002-d263-47d8-a8ee-b2438420d754.png";

  final _scrollController = ScrollController();
  _sliverAppBar(BuildContext context) => SliverAppBar(
        actionsIconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: OutlinedButton.icon(
              onPressed: pushNavigatorOnPressed(context, (_) => NotificationPage()),
              icon: const Icon(Icons.notifications_none),
              label: const Text(''),
              style: ButtonStyle(
                  iconColor: MaterialStateProperty.all(Colors.white),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  side: MaterialStateProperty.all(const BorderSide(color: Colors.white))),
            ),
          ),
          const LocationSelector(),
        ],
        title: const Text('Logo Here'),
        pinned: true,
        expandedHeight: 400.0,
        leading: const FlutterLogo(),
        stretch: true,
        collapsedHeight: 61,
        backgroundColor: DesignConstants.primaryColor,
        // The "forceElevated" property causes the SliverAppBar to show
        // a shadow. The "innerBoxIsScrolled" parameter is true when the
        // inner scroll view is scrolled beyond its "zero" point, i.e.
        // when it appears to be scrolled below the SliverAppBar.
        // Without this, there are cases where the shadow would appear
        // or not appear inappropriately, because the SliverAppBar is
        // not actually aware of the precise position of the inner
        // scroll views.
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child: Container(padding: const EdgeInsets.all(10), child: _searchInput),
        ),
      );

  _createHeading(final String text) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Text(text, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)));
  }

  List<bool> picked = [];

  Future<void> _loadData() async {
    // if (context.read<MotorbikeCubit>().state.motorbikes.isEmpty) {
    //   context.read<MotorbikeCubit>().getMotorbikes();
    // }
    if (context.read<PostCubit>().state.posts.isEmpty) {
      context.read<PostCubit>().getPosts("", [], "", SIZE);
    }
    if (context.read<MotorBrandCubit>().state.motorBrands.isEmpty) {
      context.read<MotorBrandCubit>().getBrands();
    }
  }

  Future<void> _loadUser() async {
    if (context.read<UserCubit>().state.user == null) {
      context.read<UserCubit>().getUser();
    }
  }

  List<String> location = ['Toàn quốc', 'Hồ Chí Minh', 'Hà Nội'];
  String pickedLocation = "";
  int SIZE = 4;
  @override
  void initState() {
    super.initState();
    _loadData();
    _loadUser();
    pickedLocation = location.first;
  }

  // SizedBox(
  //     width: double.infinity,
  //     height: 150,
  //     child: Scrollbar(
  //         controller: _scrollController,
  //         child: ListView.separated(
  //             controller: _scrollController,
  //             scrollDirection: Axis.horizontal,
  //             shrinkWrap: true,
  //             itemCount: 5,
  //             itemBuilder: (context, index) => GestureDetector(
  //                   onTap: () {
  //                     // pushNavigatorOnPressed(context,
  //                     //     (_) => const ProductsByCategoryPage(categoryQuery: 'Hãng xe'));
  //                   },
  //                   child: Column(
  //                     children: [
  //                       CircleAvatar(
  //                         radius: 40, // Image radius
  //                         backgroundImage: NetworkImage(brandLogoUrls[index]),
  //                       ),
  //                       const Expanded(
  //                         child: Center(child: Text('Hãng xe')),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //             separatorBuilder: (context, index) => const SizedBox(width: 25)))),
  // Divider(),

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy Sell Motor'),
        backgroundColor: DesignConstants.primaryColor,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<PostCubit>().getPosts("", [], "", SIZE);
        },
        child: ListView(
          children: [
            PromotionBanner(children: brandLogoUrls, height: 220, isLocalFile: true),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomTextField(
                onChangedString: context.read<PostCubit>().onChangeSearchString,
                title: 'Tìm kiếm',
                hintText: 'Cần tìm xe? để chúng tôi giúp bạn',
                keyboardType: TextInputType.text,
                endIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            ),
            BlocBuilder<MotorBrandCubit, MotorBrandState>(
              builder: (context, state) {
                List<MotorBrand> brands = state.motorBrands;
                List<String> renderBrands = state.motorBrands.map((e) => e.name ?? "").toList();
                if (picked.isEmpty) {
                  picked = List.generate(brands.length, (index) => false);
                }

                return Wrap(
                  spacing: 15.0,
                  runSpacing: 8.0,
                  children: List.generate(
                    brands.length,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          picked[index] = !picked[index];
                        });

                        List<String?> pickBrands = List.generate(renderBrands.length, (index) {
                          return picked[index] ? renderBrands[index] : null;
                        }).where((element) => element != null).toList();

                        context.read<PostCubit>().onChangeBrandList(pickBrands);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                picked[index] ? DesignConstants.primaryColor : Colors.grey.shade400,
                          ),
                          color: picked[index] ? DesignConstants.primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          brands[index].name ?? "",
                          style: TextStyle(
                            color: picked[index] ? Colors.black : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Row(
              children: [
                Icon(Icons.location_on_outlined, size: 18, color: Colors.grey.shade600),
                Text(
                  'Khu vực tìm kiếm: ',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey.shade600),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Text(
                      'Danh sách khu vực',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items: location
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    value: pickedLocation,
                    onChanged: (String? value) {
                      setState(() {
                        pickedLocation = value.toString();
                      });
                      context.read<PostCubit>().onChangeLocation(value.toString());
                    },
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 40,
                      width: 160,
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                    ),
                  ),
                ),
              ],
            ),
            _createHeading("Danh sách xe"),
            BlocBuilder<PostCubit, PostState>(
              builder: (context, state) {
                List<Post> posts = state.posts;
                return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    crossAxisSpacing: 10, // Set the spacing between columns
                    mainAxisSpacing: 10, // Set the spacing between rows
                    childAspectRatio: 0.64,
                    maxCrossAxisExtent: 200,
                  ),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      product: posts[index],
                      productDetailsNavigationCallback: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             ProductDetails(id: posts[index].id ?? 0)));
                      },
                    );
                  },
                );
              },
            ),
            ElevatedButton(
              onPressed: () async {
                SIZE += 10;
                print('Xem thêm' + SIZE.toString());
                await context.read<PostCubit>().onChangeSize(SIZE);
              },
              child: const Text("Xem Thêm"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Color(0xFF495057),
                backgroundColor: DesignConstants.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
            ),
            // const Footer(),
          ],
        ),
      ),
    );
  }
}
