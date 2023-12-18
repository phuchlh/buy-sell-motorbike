part of 'buy_request_cubit.dart';

enum BuyRequestStatus { notLoginYet, initial, loading, loaded, error, success }

class BuyRequestState extends Equatable {
  final BuyRequestStatus status;
  final String err;

  const BuyRequestState({
    required this.status,
    required this.err,
  });

  BuyRequestState copywith({
    BuyRequestStatus? status,
    String? err,
  }) {
    return BuyRequestState(
      status: status ?? this.status,
      err: err ?? this.err,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, err];
}
