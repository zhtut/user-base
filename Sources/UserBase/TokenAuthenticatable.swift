//
//  File.swift
//
//
//  Created by zhtg on 2023/4/14.
//

import Vapor
import FluentKit

public extension RoutesBuilder {
    /// 需要使用token的接口
    var tokenProtected: any RoutesBuilder {
        let tokenProtected = grouped([
            TokenAuthenticator(), // token表单认证，需要在body中加入token参数，否则就会失败
        ])
        return tokenProtected
    }
}

/// 远程token认证器
private struct TokenAuthenticator: AsyncRequestAuthenticator {
    func authenticate(request: Vapor.Request) async throws {
        let token = try request.content.get(String.self, at: "token")
        let uri = URI(string: "http://10.1.1.5:8081/inner/user/check_token")
        do {
            let res = try await request.client.post(uri,
                                                    content: ["token": token])
            print("TokenAuthenticator response: \(res.status)")
            guard let body = res.body else {
                throw Abort(.unauthorized, reason: "No response body")
            }
            let user = try JSONDecoder().decode(User.self, from: body)
            request.auth.login(user)
        } catch {
            print("TokenAuthenticator error: \(error)")
        }
    }
}

