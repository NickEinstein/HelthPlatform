import '../../../services/all_service.dart';
import '../../../utils/packages.dart';
import '../presentation/model/chatcontact_model.dart';

class ChatPaginationNotifier
    extends StateNotifier<AsyncValue<List<ChatContact>>> {
  ChatPaginationNotifier(this._apiService) : super(const AsyncValue.loading());

  final AllService _apiService;
  int _pageNumber = 1;
  final int _pageSize = 10;
  bool _isLoading = false;
  bool _hasMore = true;

  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> fetchInitial() async {
    _pageNumber = 1;
    _hasMore = true;
    state = const AsyncValue.loading();

    try {
      final newItems = await _apiService.fetchChatContactList(
        pageNumber: _pageNumber,
        pageSize: _pageSize,
      );

      _hasMore = newItems.length == _pageSize;
      state = AsyncValue.data(newItems);
      _pageNumber++;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> fetchNextPage() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    try {
      final newItems = await _apiService.fetchChatContactList(
        pageNumber: _pageNumber,
        pageSize: _pageSize,
      );

      _hasMore = newItems.length == _pageSize;

      // Merge old and new items if current state is data, else just new items
      final currentList = state.value ?? [];

      state = AsyncValue.data([...currentList, ...newItems]);
      _pageNumber++;
    } catch (e) {
      // You can decide whether to update error state here or just ignore
      // For now, just ignore to not override existing data:
      // state = AsyncValue.error(e, st);
    } finally {
      _isLoading = false;
    }
  }
}
