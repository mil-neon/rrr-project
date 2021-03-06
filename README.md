# README

## 【Railsで新規アプリ作成手順】

### 1.プロジェクトディレクトリ新規作成
```bash
mkdir プロジェクト名
cd プロジェクト名
```

### 2.Gemfile作成
```bash
bundle init
```

### 3.Gemfile編集
```bash
gem "rails", "5.2.3"  #任意のバージョンにする
```

### 4.Railsをインストール
```bash
bundle install --path vendor/bundle
```
* パス指定してインストールする事で、今後`/ディレクトリ`＞`vendor/bundleディレクトリ`内にgemをインストールする
* `gemfile.lock`が作成される
* gemfileあるよ！って警告出ますが、上書きEnterで進めてください。


### 5.railsのアプリを新規作成する
```bash
bundle exec rails new . -B -d mysql --skip-turbolinks --skip-test
```
* `-d mysql`データベースの指定
* `--skip-turbolinks`Turbolinks5を無視する
* `--skip-test`テスト作成しない

* GitHubで管理したく無いファイルを指定
```gitignore
!/vendor/.keep
/vendor/bundle
```

### 6.残りのgemを一括でインストール
```bash
bundle install
```
#### ◾今回MySQLで躓いた。
```bash
sudo open /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg
```
```bash
gem install mysql2 -v '0.4.10' --source 'https://rubygems.org/'
```
```bash
bundle config --local build.mysql2 "--with-cppflags=-I/usr/local/opt/openssl/include"
```
```bash
bundle install
```
で解決


### 7.rails起動
```bash
bundle exec rails s
```
* DBがないので、エラーが出ています。
* `bundle exec`はGemfileで指定された環境で実行できる様にする


### 8.DB作成
```bash
bundle exec rake db:create
```
* `development` `test`が作成される
* http://localhost:3000/ 表示される

### 9.MVC設定
#### ▼モデル作成 （モデル名は単数形小文字）
```bash
bundle exec rails g model user
```
#### ▼マイグレーションファイルにテーブル名・カラムを設定する
例）
```user.rb
class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string            :name
      t.integer           :birthday
      t.timestamps    null: true
    end
  end
end
```
#### ▼マイグレーションファイル実行
```bash
bundle exec rake db:migrate
```
#### ▼コントローラ作成
```bash
bundle exec rails g controller users
```
* （コントローラ名は複数形小文字）

#### ▼コントローラーファイル編集
```
def index 
  @userdata = User.all
end
```

#### ▼ビューファイル作成
```
index.html.haml
```
* bodyの中身を記述
* hamlに変更したら、サーバー立ち上げ直す


### 10.ルート設定
```bash
root 'コントローラ名#アクション名'
resources :users
```
* `bundle exec rake routes`で確認

## 【投稿機能作成手順】

### 「form_for」を使ってフォームを作成する
#### ▼フォーム表示画面のアクションにモデルのインスタンス作成
```users_controller.rb
def index
    @userdata = User.all
    @user = User.new
  end
```
#### ▼ビューにフォームを作成
* hamlで作成する為に、Gemを記述
```Gemfile
gem 'haml-rails'
gem 'erb2haml'
```
```index.html.haml
= form_for @user do |f|
  = f.text_field :name
  = f.text_field :birthday
  = f.submit "送信"
```
* `form_for`では、送信される時自動で、`create`や`update`にアクションが不振り分けられる

#### ▼createアクションを設定する
```user_controller.rb
def create
  @user = テーブル名.create(user_params)
  redirect_to controller: :users, action: :index
end

private
def user_params
  params.require(:テーブル名).permit(:カラム, :カラム)
end
```

## 【GitHub管理】
#### ▼リモートリポジトリ作成
* GitHubにログインした状態で、「New Repository」ボタンを押下します。
* 「Public」
* 「Create repository」ボタンをクリック
* アドレス控える

#### ▼ローカルリポジトリ作成
* 管理したいディレクトリに移動
* `git init`コマンドでGitリポジトリを新たに作成
* 管理したいAPPをディレクトリに移動
* `git add アプリ名`でインデックスに追加
* `git commit -m "コメント"`でコミットする

#### ▼リモートリポジトリにローカルリポジトリを反映
* `git remote add origin https://github.com//~~~`リモートリポジトリの情報を追加
* `git push origin master`ローカルリポジトリをプッシュ
