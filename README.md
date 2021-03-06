[![Build Status](https://travis-ci.org/nakamura-tsuyoshi/rails-sample.svg?branch=master)](https://travis-ci.org/nakamura-tsuyoshi/rails-sample)

# 初めに目的とか
* まぁともかくrailsを触ってみよう。触っていくなかで良し悪しを語ろうと。
* 今のプロダクトに活かせる部分を探す。良ければリプレイスも考えていきたい

# 環境構築
1. rbenvのインストール

 https://github.com/rbenv/rbenv
 
 1. 確認
 ```
 [dev@host ~]$ rbenv --version
 rbenv 1.0.0-16-gd6ab394
 ```
 
1. ruby-buildインストール
 ```
 git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
 ```
 1. rubyのバージョン確認
 ```
 [dev@host ~]$ rbenv install --list
  2.3.0-dev
  2.3.0-preview1
  2.3.0-preview2
  2.3.0
 ```

1. ruby2.3.0のインストール
 ```
 [dev@host ~]$ rbenv install 2.3.0
 ```
 
 1. 読み込み
 ```
 [dev@host ~]$ rbenv rehash
 ```
 
 1. 確認
 ```
 [dev@host ~]$ rbenv versions
  2.3.0
 ```
 1. ruby2.3.0を使う設定
 ```
 [dev@host ~]$ rbenv global 2.3.0
 ```
 
 1. 確認
 ```
 [dev@host ~]$ rbenv version
 2.3.0 (set by /home/dev/.rbenv/version)
 ```

1. bundler
 1. bundlerインストール
 ```
 [dev@host ~]$ gem install bundler
 ```
 
 1. このレポジトリをcloneしてbundle install
 ```
 [dev@host rails-sample]$ bundle install
 ```

1. elasticsearch
 1. wip
