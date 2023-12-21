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

class SellRequestHistoryState extends Equatable {
  final DetailSellRequest? detailSellRequest;
  final SellRequestHistoryStatus status;
  final DioError? error;
  final List<SellRequestHistoryDTO> sellRequests;

  const SellRequestHistoryState({
    this.detailSellRequest,
    this.status = SellRequestHistoryStatus.initial,
    this.error,
    this.sellRequests = const <SellRequestHistoryDTO>[],
  });

  SellRequestHistoryState copyWith({
    DetailSellRequest? detailSellRequest,
    SellRequestHistoryStatus? status,
    List<SellRequestHistoryDTO>? sellRequests,
    DioError? error,
  }) {
    return SellRequestHistoryState(
      detailSellRequest: detailSellRequest ?? this.detailSellRequest,
      status: status ?? this.status,
      sellRequests: sellRequests ?? this.sellRequests,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [detailSellRequest, status, sellRequests, error];
}
