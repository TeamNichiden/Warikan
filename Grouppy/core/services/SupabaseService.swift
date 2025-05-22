//
//  SupabaseService.swift
//  Grouppy
//
//  Created by Yuki Imai on 2025/05/22.
//
import Foundation
import Supabase

// SupabaseService.swift
protocol SupabaseServiceProtocol {
    func fetch<T: Decodable>(
        from table: String,
        column: String?,
        value: (any PostgrestFilterValue)?
    ) async throws -> [T]
    
    func insert<T: Codable>(into table: String, data: T) async throws -> T
}

final class SupabaseService: SupabaseServiceProtocol {
    private let client: SupabaseClient
    
    init() {
        self.client = SupabaseClient(
            // TODO: URL,Keyの秘匿化
            supabaseURL: URL(string: "https://your-url.supabase.co")!,
            supabaseKey: "your-anon-key"
        )
    }
    
    func fetch<T: Decodable>(
        from table: String,
        column: String? = nil,
        value: (any PostgrestFilterValue)? = nil
    ) async throws -> [T] {
        var query = client.from(table).select()
        
        if let column = column, let value = value {
            query = query.eq(column, value: value)
        }
        
        let response = try await query.execute()
        return try JSONDecoder().decode([T].self, from: response.data)
    }
    
    func insert<T: Codable>(into table: String, data: T) async throws -> T {
        let response = try await client.from(table)
            .insert(data)
            .select()  // 挿入後にデータを取得
            .single()  // 単一オブジェクトとして取得
            .execute()
        
        return try JSONDecoder().decode(T.self, from: response.data)
    }
}

