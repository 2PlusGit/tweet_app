# Rails TweetApp
このリポジトリはprogateの学習内容をまとめています
## Ⅰ
- railsアプリを準備する
    - rails new アプリ名でアプリケーションの入れ物であるフォルダが作成される
    ```
    rails new tweet_app
    ```

- web serverを立ち上げる
    - rails server (rails sでも同じ)
    - localhost:3000へアクセスすることでサーバーが立ち上がっているのを確認できる

- topページを作る
    - rails generate (gでも可能) コントローラー名 アクション名
    ```
    rails g controller home top
    ```
    - 自動で home/top というページを作ってくれる
    - 上記コマンドを実行すると最低限必要なファイルが作成される
    - rails s で存在が確認できる

- ビューとは
    - htmlファイルのこと
    - ブラウザのリクエストに対してRailsがビューを返す
    - viewsフォルダの中に作成される
    - */app/views/home/top.html.erbという構成 ( *はルート )
    - erbという拡張子がついているが通常のhtmlファイルとして扱える

- コントローラーとは
    - Railsはブラウザからのリクエストを受けてコントローラーを経由してビューがブラウザへわたされる
    - コントローラーファイル
        - rails g controller*** を入力したときに home_controller.rbというファイルがapp/controllers内に作成されている
        - 中身はHomeControllerというクラス、メソッドはtop、が自動で作成される
        - コントローラー内のメソッドを**アクション**という(この場合topアクション)
            - アクションの役割はブラウザに返すビューファイルをviewsフォルダ内から探すこと
            - コントローラーと同じ名前のビューファイルから(この場合home)アクションと同じ名前のhtmlファイル(この場合top)を探してブラウザへ返す

- ルーティングとは
    - ブラウザとコントローラーを繋ぐ
    - つまり　ブラウザ→ルーティング→コントローラー→ビュー→ブラウザ　という順番で処理がすすむ
    - どのコントローラーのどのアクションで処理を行うかを決める対応表
    - */config/routes.rbにルーティングが記載されている
    - get "URL" => "コントローラー#アクション名" と記載することでURLがきたときにアクション名を呼び出す
    - routes.rb内ではdrawメソッドのブロック内でURLとアクションの指定が行われる。
    - =>はハッシュ時に使用する記法。つまり"URL"がキーで"コントローラー#アクション名" が値
