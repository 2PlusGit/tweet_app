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
    1行ごとに<%%>を用いてruby文を囲むことで埋め込める
    ```
    #each文を以下の様に埋め込める(postsという配列が用意されているとする)
    <% posts.each do |post| %>

    <%= post %>


    <% end %>

    ```

- viewファイル内では変数の定義は一般的ではなく、アクション内で定義する。
- クラスメソッド内での変数なのでインスタンス変数として定義する(つまり頭に@を付ける)。このときhtml.erbファイルでも@を付ける

- データベースの仕組み
  - データが格納されている表の事を**テーブル**という
  - 各行を**レコード**、各列を**カラム**という

- テーブルの作り方
  - まずマイグレーションファイルというファイルを作成
  - postsテーブルを作成する際には、Postとする(テーブル名はモデル名の複数形にする)
  - contextはカラム名、textはデータ型を表す
  ```
  rails g model Post content:text
  ```
  - このコマンドを実行することで*/db/migrate内にマイグレーションファイルが作成される(中身は自動生成される)
  - データベースに変更が生じたら(今回はマイグレーションファイルの作成)以下のコマンドを叩くことで、マイグレーションファイル通りにテーブルを作成してくれる
  ```
  rails db:migrate
  ```
- モデルとは
  - データベースのテーブルを操作する特殊なクラス
  - rails g modelというコマンドはモデルを生成するためのコマンド
  - モデルの情報はapp/models内にある

- rails consoleとは
  - railsコマンドを実行できる対話型プロンプト
  - quitで終了

- モデルを使ってテーブルへレコードを格納するにはざっくり以下のような流れになる
  - newメソッドでPostモデルのインスタンスを生成
  ```
  post1 = Post.new(content:###)
  ```
  - saveメソッドでインスタンスをpostsテーブルへ保存
  ```
  post.save
  ```
- post.firstでテーブルの先頭のレコードを取得できる
- contentカラムのデータが欲しい場合、以下の様にすることでその値を取得できる
```
post = Post.first
post.contnt
```
- 全てのレコードを取得する場合にはクラスメソッドのallを用いる(戻り値は配列)

- viewへデータベースの内容を表示する
  ```
  @posts = Post.all
  ```

- 共通UIの作成
  - railsでは共通のHTML部分はviews/layouts/application.html.erbにて生成できる

- link_to("表示する文字", "リンク先URL") = aタグ


## Ⅲ
- Post.newでインスタンスを作ると、指定したカラムの他にid,updated_at,created_atというカラムも自動で作成される
- idを指定してレコードの値を取得するにはfind_byメソッドを使用する
```
post = Post.find_by(id:3)
```
- 投稿詳細ページを作る
  - 大まかな流れは以下
    - ルーティングを作る
    - アクションを作る
    - ビューを作る

  - まずルーティング
    - URLがposts/各投稿のidとなるように設定する
    - routes.rbにgetメソッドを記述する
      - routes.rb内では get "posts/:id"と書くことで、Railsがシンボル:idに入る値をidと認識し、該当するhtmlファイルを返してくれる 
      - この時に気を付けるのは:idは数値であるという指定が特にないので、posts/indexなんかもindexをidの値だと認識されてしまう。その為posts/indexなどのURLのget文は:idを使用したgetよりも先に記述する必要がある。(上から実行されるので)

  - 次にアクションを作りこむ
    - アクション内でURLに記述されたidの値を読み取るにはparamsというハッシュを用いる
    - paramsにはURLで入力されている:idが入っている
    ```
    params = {id: 1, ...}
    ```
    - なのでparams[:id]とすればURLに入力されている値が取得できる
    - 取得した値はhtmlファイルで使用するのでインスタンス変数に入れる

  - 最後にビューを作る
    - ポイントとして式展開を使用する
    ```
    <%= link_to(post.content, "/posts/#{post.id}) %>
    ```
    これで所望なURLへのリンクをイテレーターで作成できる

  - 新規投稿ページを作成する
    - ルーティング
      - localhost:3000/posts/newというURLで新規投稿ページへ飛ぶようにする
    - アクション
      - postsコントローラー内にnewアクションを作る
    - ビュー
      - new.html.erbを作成する
      - 
  - 投稿データをデータベースへ登録する
    - postコントローラーにcreateアクションを作成して登録処理をそこに記述する
    - フォームの値を取得する時にはアクション内でgetメソッドではなく**postメソッド**を使用する
    - 入力された値を受け取るにはform_tagメソッドを使用する書き方は以下
    ```
    <%= form_tag("/posts/create") do %>
    #フォームのhtml
    <% end %>
    ```
    - createアクションでは他のビューファイルへ転送する処理を行う
    - 転送処理は**リダイレクト**という。今回は投稿一覧画面へリダイレクトする
    - リダイレクトには**redirect_toメソッド**を使用する。redirect_to(転送先のURL)とする
    ```
    #createアクション内
    redirect_to("posts/index")
    ```
    - 入力された値を登録するには、どの値をデータベースへ登録するのかを知らせるひつようがある
      - 今回入力フォームは<textarea>タグが使用されているので属性にname属性=contentを追加してこれを利用する
      - name属性の値をキーとしたハッシュがRails側へ送られる。ハッシュの値は入力値
      - アクションで入力値を受け取る際にはparams[:content]
      - データベースへの登録自体はインスタンス作成→saveアクション
  - 投稿を新しい順に並び変える
    - orderメソッドをPost.allに用いる
    - 降順が新しい順になるorder(created_at: :desc)とすればよい
  
## Ⅳ
- 投稿の編集と削除を実装する
- 投稿データの編集と削除 = データベースのレコードの編集と削除
- 編集はcontentの値を上書きすればよい
  ```
  post = Post.find_by(id:1)
  post.content = "hello, again!"
  post.save
  ```
  - レコードを更新するとテーブルにupdated_atカラムに値が入力される
- 削除は**destroyメソッドを用いる**
  - 削除後にはsaveメソッドは不要

- 編集フォームを作る
  - 新規投稿時と異なるのは、フォームに既に値が入っている点
  - データベースから値を取得するため、params[:id]を用いる
  ```
  #editアクション
  @post = Post.find_by(id:params[:id])

  #editビュー
  <textarea><%=@post.content%></textarea>
  ```
  - 編集内容をデータベースに反映する処理を担うupdateアクションを作成する
    - ルーティングはgetではなくpostメソッドで
    - postメソッドはform_tagを使用する際に用いる。form_tagの引数にURLを入れてpostメソッドの引数と一致しているときに対応するアクションが呼ばれる
    - form_tagの引数から受け取ったparams[:id]の値を使用して更新するレコードを指定し、そのcontentをsubmitの際にアクションが受け取るparams[:content] (=contenは<textarea>タグのname属性で指定された文字列)で更新する
  - 投稿削除もデータベースに変更を生じさせるのでpostメソッド
    - 削除ボタンをlink_to("削除", "/posts/#{@post.id}/destroy")で作成するとgetメソッドを探してしまう。その為postメソッドでデータベースを更新する為にはlink_toの第三引数に{method: "post"}と**postメソッドの使用を明示的に記述する**必要がある
    - destroyアクションでの操作は以下
    ```
    @post = Post.find_by(id:params[:id])
    @post.destroy

    ```

## Ⅴ
- この章ではバリデーションを学ぶ
  - バリデーションとはデータをチェックする仕組み
  - バリデーションが規定している制限に引っかかった場合はデータベースに反映されない
  - モデルでvalidatesメソッドを用いてバリデーションを設定していく
  - バリデーションを設定するファイルはapp/models内にある
- 空の文字列をはじくバリデーションを実装する
```
validates(制限を記述するカラム名をシンボル形式で, {presence: true})
```
- 文字数に上限を規定する
  - {maximum: 数値}で文字数を指定
  - 下記の様にバリデーションの指定内容はハッシュで渡すため、複数の指定を繋げて記載できる
```
validates :content, {presence: true, length: {maximum: 140}}
```

- モデルのsaveメソッドは戻り値があり、登録に成功した場合true、失敗した場合falseを返す。この性質を利用して投稿が成功した時と失敗した時で次の画面遷移を制御できる
```
def update
  @post = Post.find_by(id: params[:id])
  @post.content = params[:content]
  if @post.save
    redirect_to("/posts/index")
  else
    # renderメソッドを用いて、editアクションを経由せず、posts/edit.html.erbが表示されるようにしてください
    redirect_to("/posts/#{@post.id}/edit")
  end
end
```
- **renderメソッドを用いることで別のアクションを経由せずに**ビューを表示できる
- render("コントローラー名/アクション名")でアクション名と同名のhtml.erbファイルを表示できる
- 参考:https://qiita.com/1ulce/items/282cccba1e44158489c8
- @postはrenderで新しく画面描写されるものが維持される(つまり今回はバリデーションではじかれた文字列)
```
def update
  @post = Post.find_by(id: params[:id])
  @post.content = params[:content]
  if @post.save
    redirect_to("/posts/index")
  else
    # renderメソッドを用いて、editアクションを経由せず、posts/edit.html.erbが表示されるようにしてください
    render("posts/edit")
  end
end
```
- validatesはエラーメッセージを返す。メッセージは@post.errors.full_messagesに配列形式で格納される
```
<% @post.errors.full_messages.each do |message| %>
  <div class="form-error">
    <%= message %>
  </div>
<% end %>
```
- フラッシュ
  - ページ上に1度だけ表示されるメッセージ
  - Railsではflashという変数を利用する
  - flash[:notice]に表示したいメッセージを代入することで1度だけ有効になりビューで使用でき、その後は自動で中身が削除される
```
#application.html.erbで表示する
<% if %>
  <div class="flash">
    <%=flash[:notice] %>
  </div>
<% end %>

```

## Ⅵ
- このチャプターではユーザー情報に関する処理を作成する
- 投稿内容を保存したPostモデルのように、ユーザー情報を格納するUserモデルを作成する
```
rails g model User name:string email:string

```
- バリデーションの値の重複がないかのチェック 
  - uniqueness: trueをvalidatesの項目に追加する
- htmlのタグ属性内にrubyを無目混む時にも<%%>でくくる

## Ⅶ
- 画像を表示する
- 画像ファイルはpublicフォルダへ保存
- 画像とアカウントを紐づける画像の名称はモデルに保存
- モデルにカラムを追加する
  - rails g modelだと新規にモデルが追加されてしまうので以下のコマンドを叩く
  - このコマンドでマイグレーションファイルが作成される
    - マイグレーションファイルとはデータベースの設計図。これをdb:migrateすることでデータベースへ処理が反映される
  ```
  rails g migration [マイグレーションファイル名]
  ```
    - マイグレーションファイルの中にあるchangeメソッドにテーブルへの変更を記述する

    - カラムを追加する際にはadd_columnメソッドを使う
    ```
    add_column [:テーブル名], [:カラム名], [:データ型] 
    
    #マイグレーションファイルを反映
    rails db:migrate
    ```
- 画像の表示はimgタグで行う
  - その際に画像ファイルの場所を記述するため<%%>で保存場所を記入する(publicは省略して記入する、つまり/public/image_user/filename.jpgならば/image_user/filename.jpgのみでよい)
- フォームで画像を送信する時はform_tagの引数に{multipart: true}を含める
```
<%= form_tag("/users/#{@user.id}/update", {multipart: true}) do %>
  <p>ユーザー名</p>
  <input name="name" value="<%= @user.name %>">
  <p>画像</p>
  <input name="image" type="file">
  <p>メールアドレス</p>
  <input name="email" value="<%= @user.email %>">
  <input type="submit" value="保存">
<% end %>
```
- updateアクションでpublicフォルダへ画像ファイルを作成する
  - ruby でファイルを扱うにはFileクラスを利用する
  - ファイルを作成するにはFileクラスのwriteメソッドを使う
  ```
  File.write([ファイルを保存したい場所とその拡張し],[ファイルの中身] )
  ```
  - form_tagのブロック内で渡された画像ファイルはparams[:image]で受け取ることができる
  - 画像ファイルはwriteメソッドではなく、binwriteメソッドを用いる
    - バイナリファイルとは: https://wa3.i-3-i.info/word1147.html
    - binwrite: https://docs.ruby-lang.org/ja/latest/method/IO/s/binwrite.html
  - さらにparams[:image]にreadメソッドを用いた帰り値で保存が可能になる
    - readメソッド: 

## Ⅷ
- ログイン機能を作る
- application.html.erbは全てのアクションで呼び出される為、全アクションで共通の処理はapplicationコントローラーに**before_action**として記述する必要がある
```
before_action :set_current_user
  
def set_current_user
  @current_user = User.find_by(id: session[:user_id])
end
```
- ログインしていない状態でのアクセス制限はアプリで共通の処理なのでapplicationコントローラーで記述する
```
before_action :authenticate_user, {only: [:index, :show, :edit, :update]}
```

