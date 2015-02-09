#! /usr/bin/env ruby

# 田村ゆかりのいたずら黒うさぎを取得するサンプル

require './lib/crawler.rb'

class MyCrawler < Crawler

  # 各種設定
  def collect_input_data
    # ニコニコ動画のアカウント設定のファイル
    @account_setting_file = 'account.yaml'
    # 読み込む公開リスト
    @input_feed_url = 'http://www.nicovideo.jp/mylist/39123051?rss=2.0'
    # 出力するフィードのパス
    @output_feed_path = '/opt/nicopodcast/public/yukari.xml'
    # enclosureを出力するディレクトリのパス
    @output_file_path = '/opt/nicopodcast/public/enclosure/'
    # 外から見た上のディレクトリのパス
    @output_file_url ='http://pod.smallfield.info/enclosure/'
    # 入力されるenclosure(ニコニコ動画の場合はflv)
    @input_file_type = 'flv'
    # 出力するenclosure(mp3など)
    @output_file_type = 'm4a'
    # ffmpegのオプション(これを変えると動画も出せるはず)
    @ffmpeg_option = '-vn -acodec copy'
  end

  # フィードの整形
  def hook_publish_feed
    @output_feed.channel.title = 'いたずら黒うさぎ'
    @output_feed.items.each do |item|
      item.title.gsub!(/(田村ゆかりの)?いたずら黒うさぎ/,'')
      item.title.gsub!('回','回 ')
      item.title.gsub!(/「|」|（|）|（|）/, '')
      item.title.gsub!(/( |　)+/,' ')
      item.title.strip!
    end
  end
end

# newで設定を読んでrunで実行
MyCrawler.new.run
