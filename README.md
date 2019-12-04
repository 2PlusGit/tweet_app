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

- すでに存在するコントローラーにアクションを追加するしてページを追加する
    - routes.rb
    ```
    get "about" => "home#about"
    ```
    - home_controller.rb
    ```
      def about
    end
    ```
    - アクションを追加
        - homeフォルダ内にabout.html.erbを作成する

- CSSファイルの場所
    - app/assets/stylesheetsの中にcss系のファイルをまとめる

- 画像などのメディアの場所
    - */publicの中
    - 画像などのファイルを読み出すときには、ディレクトリは/と付ければ良い

- デフォルトのトップページ(http://localhost:3000/)でのルーティングを設定するには
    - routes.rbに以下を追加(キーが大事)
        ```
        get "/" => "home#top"

        ```
- サイト内のリンクの飛ばし方
    - href = "URL"とすれば良い

## Ⅱ
- データベース
    - データを保存する場所

- 今回のSNSみたいなアプリにおいて、投稿用のデータベースを作るために専用のコントローラーを作成する方が良い

- 今回は以下のようにpostsコントローラーを作る(indexアクションも作る)
    ```
    rails g controller posts index
    ```

- index.html.erb
```
<header>
  <div class="header-logo">
    <a href="/">TweetApp</a>
  </div>
  <ul class="header-menus">
    <li>
      <a href="/about">TweetAppとは</a>
    </li>
  </ul>
</header>

<div class="main posts-index">
  <div class="container">
    <div class="posts-index-item">
      今日からProgateでRailsの勉強するよー！
    </div>
    <div class="posts-index-item">
      投稿一覧ページ作成中！
    </div>
  </div>
</div>
```

- posts.scss
```
/* posts/index ================================ */
.posts-index-item {
  padding: 20px 30px;
  background-color: white;
  overflow: hidden;
  box-shadow: 0 2px 6px #c1ced7;
}

.post-left img {
  width: 50px;
  height: 50px;
  border-radius: 40%;
  box-shadow: 0 2px 6px #c1ced7;
  object-fit: cover;
}

.post-user-name a {
  font-weight: 600;
}

.post-user-name a:hover {
  color: #3ecdc6;
}

.post-left {
  float: left;
  width: 10%;
}

.post-right {
  float: left;
  width: 90%;
  padding-left: 25px;
  text-align: left;
}

/* posts/show ================================ */
.posts-show form {
  display: inline;
}

.posts-show-item {
  padding: 30px;
  background-color: white;
  box-shadow: 0 2px 6px #c1ced7;
  overflow: hidden;
}

.posts-show-item img {
  width: 60px;
  height: 60px;
  border-radius: 40%;
  box-shadow: 0 2px 6px #c1ced7;
  vertical-align: middle;
  object-fit: cover;
}

.posts-show-item .post-user-name a {
  vertical-align: middle;
  font-size: 24px;
  margin-left: 15px;
}

.posts-show-item p {
  font-size: 24px;
  margin: 20px 0;
}

.post-time {
  color: #8899a6;
  margin-bottom: 10px;
}

.post-menus {
  float: right;
}

.post-menus a, .post-menus input {
  color: #8899a6;
  text-decoration: underline;
  font-size: 14px;
}

/* posts/new ================================ */
.posts-new textarea {
  font-size: 20px;
  padding: 10px;
  min-height: 140px;
  border: 1px solid rgb(216, 218, 223);
  resize: none;
}

.posts-new textarea::-webkit-input-placeholder {
  font-size: 24px;
  opacity: 0.5;
}

```

- viewファイル内で変数を定義する
    - erbファイル内で<% %>で囲うことでhtmlファイルにrubyを埋め込むことが出来る
    ```
    # 変数宣言
    <% posts = "hello" %>
    
    #変数の中身を表示
    <%= posts%>
     ```