//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture

@Reducer
struct RepliesFeature {
    // MARK: Types

    struct State: Equatable {
        let commentID: Int
        var replies: [RepliesCommentView.ViewModel]
    }

    enum Action {
        case refresh
        case replies([RepliesCommentView.ViewModel])
    }

    // MARK: Properties

    @Dependency(\.repliesService) var repliesService
    @Dependency(\.repliesViewModelFactory) var viewModelFactory

    // MARK: Reducer

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .refresh:
                return .run { [state] send in
                    let comments = try await repliesService.loadComments(for: state.commentID)
                    let viewModels = viewModelFactory.makeViewModel(from: comments)
                    return await send(.replies(viewModels))
                }
            case let .replies(viewModel):
                state.replies = viewModel
                return .none
            }
        }
    }
}
