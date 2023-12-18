part of 'buy_request_history_cubit.dart';

enum BuyRequestHistoryStatus {
  initial,
  loading,
  loaded,
  error,
  loadDetailSuccess,
  loadDetailError,
}

class BuyRequestHistoryState extends Equatable {
  final DetailBuyRequest? detailBuyRequest;
  final BuyRequestHistoryStatus status;
  final DioError? error;
  final List<BuyRequestHistoryDTO> buyRequests;

  const BuyRequestHistoryState({
    this.detailBuyRequest,
    this.status = BuyRequestHistoryStatus.initial,
    this.error,
    this.buyRequests = const <BuyRequestHistoryDTO>[],
  });

  BuyRequestHistoryState copyWith({
    DetailBuyRequest? detailBuyRequest,
    BuyRequestHistoryStatus? status,
    List<BuyRequestHistoryDTO>? sellRequests,
    DioError? error,
  }) {
    return BuyRequestHistoryState(
      detailBuyRequest: detailBuyRequest ?? this.detailBuyRequest,
      status: status ?? this.status,
      buyRequests: sellRequests ?? this.buyRequests,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        buyRequests,
        error,
        detailBuyRequest,
      ];
}
