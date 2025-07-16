// import '../../../provider/all_providers.dart';
// import '../../../utils/packages.dart';
// import '../presentation/model/conversation_mode.dart';

   

//    class ChatDetailsPaginationNotifier extends StateNotifier<AsyncValue<List<ConversationResponse>>> {
//   final Ref ref;
//   final String userIDTwo;
//   int _currentPage = 1;
//   bool _hasMore = true;
//   bool _isLoading = false;

//   ChatDetailsPaginationNotifier(this.ref, this.userIDTwo)
//       : super(const AsyncValue.loading()) {
//     _fetchInitial();
//   }

//   List<ConversationResponse> _messages = [];

//   Future<void> _fetchInitial() async {
//     try {
//       _messages = await ref.read(allServiceProvider).fetchChatConversationList(userIDTwo);
//       state = AsyncValue.data(_messages);
//     } catch (e, st) {
//       state = AsyncValue.error(e, st);
//     }
//   }

//   Future<void> fetchMore() async {
//     if (_isLoading || !_hasMore) return;

//     _isLoading = true;
//     _currentPage++;
//     try {
//       final newMessages = await ref
//           .read(allServiceProvider)
//           .fetchChatConversationList(userIDTwo, page: _currentPage);

//       if (newMessages.isEmpty) {
//         _hasMore = false;
//       } else {
//         _messages.addAll(newMessages);
//         state = AsyncValue.data([..._messages]);
//       }
//     } catch (e, st) {
//       state = AsyncValue.error(e, st);
//     } finally {
//       _isLoading = false;
//     }
//   }
// }

// final chatDetailsPaginationProvider = StateNotifierProvider.family<
//     ChatDetailsPaginationNotifier, AsyncValue<List<ConversationResponse>>, String>(
//   (ref, userIDTwo) => ChatDetailsPaginationNotifier(ref, userIDTwo),
// );
