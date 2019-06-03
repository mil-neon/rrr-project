# README

## 【Railsで新規アプリ作成手順】

### 1.プロジェクトディレクトリ新規作成
```bash
mkdir プロジェクト名
cd　プロジェクト名
```

### 2.Gemfile作成
```bash
bundle init
```

### 3.gemfile編集
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
bundle exec rails g model モデル名
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
bundle exec rails g controller コントローラ名
```
* （コントローラ名は複数形小文字）

#### ▼コントローラーファイル編集
```
def index 
  @変数 = User.all
end
```

#### ▼ビューファイル作成
```
アクション名.html.haml
```
* bodyの中身を記述
* hamlに変更したら、サーバー立ち上げ直す


### 10.ルート設定
```bash
root 'コントローラ名#アクション名'
```
* `bundle exec rake routes`で確認