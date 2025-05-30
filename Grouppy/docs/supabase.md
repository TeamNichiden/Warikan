# Supabase

## Grouppy データベース設計（Swift データモデル準拠）

---

## users テーブル

| フィールド名 | 型      | 説明                          |
| ------------ | ------- | ----------------------------- |
| id           | string  | ユーザーの UUID（主キー）     |
| name         | string  | ユーザー名                    |
| email        | string  | メールアドレス                |
| userId       | string? | ユーザーが設定した ID（任意） |
| iconUrl      | string? | アイコン画像の URL            |

---

## events テーブル

| フィールド名   | 型            | 説明                                    |
| -------------- | ------------- | --------------------------------------- |
| id             | string        | イベントの UUID（主キー）               |
| title          | string        | イベント名                              |
| description    | string        | イベントの説明                          |
| date           | timestamp     | イベント日付                            |
| place          | string        | イベントの場所                          |
| ownerId        | string        | イベント作成者のユーザー ID（users.id） |
| participantIds | [string]      | 参加者のユーザー ID 配列（users.id）    |
| transactions   | [Transaction] | 関連取引の詳細情報配列（直接保持）      |
| createdAt      | timestamp     | 作成日時                                |
| updatedAt      | timestamp     | 更新日時                                |

---

## transactions テーブル

| フィールド名 | 型        | 説明                                       |
| ------------ | --------- | ------------------------------------------ |
| id           | string    | 取引の UUID（主キー）                      |
| eventId      | string    | 関連イベントの UUID（events.id）           |
| payerId      | string    | 支払者のユーザー ID（users.id）            |
| payeeIds     | [string]  | 割り勘対象者のユーザー ID 配列（users.id） |
| amount       | int       | 割り勘対象金額                             |
| totalAmount  | int       | 合計金額                                   |
| memo         | string    | メモ（用途や詳細など）                     |
| createdAt    | timestamp | 作成日時                                   |
| updatedAt    | timestamp | 更新日時                                   |

---

## リレーションまとめ

- users（1）- events（多）: ownerId, participantIds
- events（1）- transactions（多）: transactions（Transaction 配列を直接保持）
- users（1）- transactions（多）: payerId, payeeIds

---

この設計は Swift データモデル（User, Event, Transaction）と完全に対応しています。

---

## 割り勘アプリ データベース設計（Supabase 用）

supabase にする？（要検討）

↓

[Firebase vs Supabase](https://www.notion.so/Firebase-vs-Supabase-1ee30979bc9680818010e748683c359b?pvs=21)

### コレクション一覧

[users コレクション](https://www.notion.so/Supabase-1e130979bc968105b357e3c2869dcf3b?pvs=21)

[events コレクション](https://www.notion.so/Supabase-1e130979bc968105b357e3c2869dcf3b?pvs=21)

[transaction コレクション](https://www.notion.so/Supabase-1e130979bc968105b357e3c2869dcf3b?pvs=21)

[サンプル JSON](https://www.notion.so/Supabase-1e130979bc968105b357e3c2869dcf3b?pvs=21)

---

## users コレクション

登録しているユーザーの情報を保存する

| フィールド名 | 型                          | 説明                  |
| ------------ | --------------------------- | --------------------- |
| id           | string                      | ユーザーの UUID       |
| name         | string                      | ユーザー名            |
| email        | string                      | メールアドレス        |
| userId       | string?                     | ユーザーが設定した ID |
| icon         | UIImage?(supabase では URL) | アイコン              |
| ...          | ...                         | 必要に応じて追加      |

---

## events コレクション

イベントごとの情報を管理する

| フィールド名   | 型            | 説明                                      |
| -------------- | ------------- | ----------------------------------------- |
| uuid           | string        | イベントの UUID（ドキュメント ID でも可） |
| title          | string        | イベント名（例：飲み会、旅行など）        |
| description    | string        | イベントの説明                            |
| date           | timestamp     | イベント日付                              |
| place          | string        | イベントの場所                            |
| ownerId        | string        | イベント作成者のユーザー ID（users.id）   |
| participantIds | [string]      | 参加者のユーザー ID 配列（users.id）      |
| transactions   | [Transaction] | イベントの関連の支払い詳細を直接保持      |
| createdAt      | timestamp     | 作成日時                                  |
| updatedAt      | timestamp     | 更新日時                                  |

---

## transaction コレクション

取引ごとの情報を管理する

| フィールド名 | 型        | 説明                                       |
| ------------ | --------- | ------------------------------------------ |
| uuid         | uuid      | 取引の UUID（ドキュメント ID でも可）      |
| event        | uuid      | 関連イベントの UUID                        |
| payerId      | string    | 請求者（支払った人）のユーザー ID          |
| payeeIds     | [string]  | 被請求者（割り勘対象者）のユーザー ID 配列 |
| amount       | int       | 割り勘対象金額                             |
| total_amount | int       | 合計金額                                   |
| memo         | string    | メモ（用途や詳細など）                     |
| createdAt    | timestamp | 作成日時                                   |
| updatedAt    | timestamp | 更新日時                                   |

---

## サンプル JSON

```jsx
// events/{event_uuid}
{
  "uuid": "event-123",
  "title": "飲み会",
  "description": "4月の歓迎会",
  "date": "2025-04-20T18:00:00Z",
  "ownerId": "user-001",
  "participantIds": ["user-001", "user-002", "user-003"],
  "transactions": [
    {
      "uuid": "txn-789",
      "payerId": "user-001",
      "payeeIds": ["user-002", "user-003"],
      "amount": 10000,
      "total_amount": 30000,
      "memo": "二次会分",
      "createdAt": "...",
      "updatedAt": "..."
    }
  ],
  "createdAt": "...",
  "updatedAt": "..."
}
```
