# Grouppy ディレクトリ構成（2025/xx/xx 現在）

## 概要

本プロジェクトは、クリーンアーキテクチャ／レイヤードアーキテクチャの考え方を参考に、機能（ドメイン）ごとに責務を分離した構成を採用しています。

---

## 主要ディレクトリ構成

```
Grouppy/
  core/
    entity/                # アプリ全体で使う共通Entity
    repository/           # 各種Repositoryプロトコル・実装
    usecase/              # 各種UseCaseプロトコル・実装
    mock/                 # モックデータ
    navigation/           # 画面遷移・ルーティング
    services/             # 汎用サービス
  features/
    [feature_name]/
      Domain/
        [Entity_name].swift            # Entity（ドメインモデル）
        Repository.swift  # Repositoryプロトコル
        UseCase.swift     # UseCaseプロトコル＋実装
      Data/
        RepositoryImpl.swift # Repository実装（API, DB, Mockなど）
        DataSource.swift     # データソース層（必要に応じて）
      Presentation/
        View/
        ViewModel/
        component/             # UI部品
        extensions/            # 拡張
    ...（他ドメインも同様に分割可能）
```

---

## 設計方針

- **Domain 層**：ビジネスロジックの中心。モデル、リポジトリ・ユースケースのインターフェースを定義。
- **Data 層**：データ取得・保存の実装。API/DB/Mock などの実装を担当。
- **Presentation 層**：UI・画面表示。SwiftUI View や ViewModel、UI 部品などを管理。
- **機能ごと（Event, User, Transaction 等）にディレクトリを分割**し、責務を明確化。

---

## 今後の拡張例

- User や Transaction など他ドメインも同様の構成で追加可能
- Data 層で API/DB/キャッシュ等の切り替えも容易
- Presentation 層で画面単位の部品化・再利用性向上

---

何かご不明点や追加要望があればご相談ください。
