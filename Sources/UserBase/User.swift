//
//  File.swift
//
//
//  Created by zhtg on 2022/8/29.
//

import Foundation
import FluentKit
import Vapor
import Fluent
import SQLKit
import VaporUtils

/// 用户
public final class User: Content, @unchecked Sendable {
    
    public var userId: UUID
    public var email: String?
    public var token: String
    public var appleId: String?
    public var isSetPassword: Bool
    
    init(userId: UUID, email: String? = nil, token: String, appleId: String? = nil, isSetPassword: Bool) {
        self.userId = userId
        self.email = email
        self.token = token
        self.appleId = appleId
        self.isSetPassword = isSetPassword
    }
}

extension User: Authenticatable {
    
}
