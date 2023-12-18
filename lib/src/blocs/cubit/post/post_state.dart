part of 'post_cubit.dart';

enum PostStatus {
  initial,
  loading,
  success,
  error,
  loadMore,
  notLoginYet,
}

class PostState extends Equatable {
  final int pageSize;
  final String location;
  final List<String?> listBrand;
  final int size;
  final String searchString;
  final PostById? postById;
  final List<PostProjection>? postProjections;
  final int showroomID;
  final String name;
  final List<String> images;
  final String description;
  final double price;
  final String motorType;
  final double engineSize;
  final String licensePlate;
  final String condition = 'Cũ';
  final String odo;
  final String yearReg;
  final int brandID;
  final bool isEdit;
  final PostStatus status;
  final List<Post> posts;
  final bool hasReachedMax;
  final DioError? error;
  final String searchValue;
  final String brandName;

  const PostState({
    this.pageSize = 10,
    this.location = '',
    this.listBrand = const <String>[],
    this.size = 10,
    this.searchString = '',
    this.postById,
    this.postProjections = const <PostProjection>[],
    this.showroomID = 0,
    this.name = '',
    this.images = const <String>[],
    this.description = '',
    this.price = 0.0,
    this.motorType = '',
    this.engineSize = 0.0,
    this.licensePlate = '',
    this.odo = '',
    this.yearReg = '',
    this.brandID = -1,
    this.isEdit = false,
    this.status = PostStatus.initial,
    this.posts = const <Post>[],
    this.hasReachedMax = false,
    this.error,
    this.searchValue = '',
    this.brandName = '',
  });

  PostState copyWith({
    int? pageSize,
    String? location,
    List<String?> listBrand = const <String>[],
    int? size,
    String? searchString,
    PostById? postById,
    List<PostProjection>? postProjections,
    int? showroomID,
    String? name,
    List<String>? images,
    String? description,
    double? price,
    String? motorType,
    double? engineSize,
    String? licensePlate,
    String? odo,
    String? yearReg,
    int? brandID,
    bool? isEdit,
    PostStatus? status,
    List<Post>? posts,
    bool? hasReachedMax,
    DioError? error,
    String? searchValue,
    String? brandName,
  }) {
    return PostState(
      pageSize: pageSize ?? this.pageSize,
      location: location ?? this.location,
      listBrand: listBrand ?? this.listBrand,
      size: size ?? this.size,
      searchString: searchString ?? this.searchString,
      postById: postById ?? this.postById,
      postProjections: postProjections ?? this.postProjections,
      showroomID: showroomID ?? this.showroomID,
      name: name ?? this.name,
      images: images ?? this.images,
      description: description ?? this.description,
      price: price ?? this.price,
      motorType: motorType ?? this.motorType,
      engineSize: engineSize ?? this.engineSize,
      licensePlate: licensePlate ?? this.licensePlate,
      odo: odo ?? this.odo,
      yearReg: yearReg ?? this.yearReg,
      brandID: brandID ?? this.brandID,
      isEdit: isEdit ?? this.isEdit,
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error ?? this.error,
      searchValue: searchValue ?? this.searchValue,
      brandName: brandName ?? this.brandName,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        pageSize,
        location,
        listBrand,
        size,
        searchString,
        postById,
        postProjections,
        showroomID,
        name,
        images,
        description,
        price,
        motorType,
        engineSize,
        licensePlate,
        odo,
        yearReg,
        brandID,
        status,
        posts,
        hasReachedMax,
        error,
        isEdit,
        searchValue,
        brandName,
      ];
}
