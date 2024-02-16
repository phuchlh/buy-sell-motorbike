part of 'sell_request_cubit.dart';

enum SellRequestHistoryStatus {
  initial,
  loading,
  loaded,
  error,
  loadingDetail,
  loadDetailSuccess,
  loadDetailError,
}

enum DetailSellRequestStatus {
  initial,
  loading,
  loaded,
  error,
}

class SellRequestHistoryState extends Equatable {
  final DetailSellRequestStatus? detailStatus;
  final DetailSellRequest? detailSellRequest;
  final SellRequestHistoryStatus status;
  final DioError? error;
  final List<SellRequestHistoryDTO> sellRequests;

  const SellRequestHistoryState({
    this.detailStatus = DetailSellRequestStatus.initial,
    this.detailSellRequest,
    this.status = SellRequestHistoryStatus.initial,
    this.error,
    this.sellRequests = const <SellRequestHistoryDTO>[],
  });

  SellRequestHistoryState copyWith({
    DetailSellRequestStatus? detailStatus,
    DetailSellRequest? detailSellRequest,
    SellRequestHistoryStatus? status,
    List<SellRequestHistoryDTO>? sellRequests,
    DioError? error,
  }) {
    return SellRequestHistoryState(
      detailStatus: detailStatus ?? this.detailStatus,
      detailSellRequest: detailSellRequest ?? this.detailSellRequest,
      status: status ?? this.status,
      sellRequests: sellRequests ?? this.sellRequests,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [detailSellRequest, status, sellRequests, error, detailStatus];
}
