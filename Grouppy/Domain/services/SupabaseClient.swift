// Grouppy/core/services/SupabaseClientProvider.swift
import Supabase
import Foundation

final class SupabaseClientProvider {
    static let shared = SupabaseClient(
        supabaseURL: URL(string: SupabaseKeys.url)!,
        supabaseKey: SupabaseKeys.anonKey
    )
}
