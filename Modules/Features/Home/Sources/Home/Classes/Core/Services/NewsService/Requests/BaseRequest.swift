//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import Foundation
import NetworkLayerInterfaces

class BaseRequest: IRequest {
    var path: String { "" }

    var httpMethod: NetworkLayerInterfaces.HTTPMethod {
        .get
    }

    var domainName: String {
        "https://hacker-news.firebaseio.com/v0/"
    }
}
