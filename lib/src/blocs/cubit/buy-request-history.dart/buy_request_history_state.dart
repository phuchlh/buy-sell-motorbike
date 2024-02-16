part of 'buy_request_history_cubit.dart';

enum BuyRequestHistoryStatus {
  initial,
  loading,
  loaded,
  error,
  loadDetailSuccess,
  loadDetailError,
}

enum DetailBuyRequestHistoryStatus {
  initial,
  loading,
  loaded,
  error,
}

class BuyRequestHistoryState extends Equatable {
  final DetailBuyRequestHistoryStatus detailStatus;
  final DetailBuyRequest? detailBuyRequest;
  final BuyRequestHistoryStatus status;
  final DioError? error;
  final List<BuyRequestHistoryDTO> buyRequests;

  const BuyRequestHistoryState({
    this.detailStatus = DetailBuyRequestHistoryStatus.initial,
    this.detailBuyRequest,
    this.status = BuyRequestHistoryStatus.initial,
    this.error,
    this.buyRequests = const <BuyRequestHistoryDTO>[],
  });

  BuyRequestHistoryState copyWith({
    DetailBuyRequestHistoryStatus? detailStatus,
    DetailBuyRequest? detailBuyRequest,
    BuyRequestHistoryStatus? status,
    List<BuyRequestHistoryDTO>? sellRequests,
    DioError? error,
  }) {
    return BuyRequestHistoryState(
      detailStatus: detailStatus ?? this.detailStatus,
      detailBuyRequest: detailBuyRequest ?? this.detailBuyRequest,
      status: status ?? this.status,
      buyRequests: sellRequests ?? this.buyRequests,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        detailStatus,
        status,
        buyRequests,
        error,
        detailBuyRequest,
      ];
}
