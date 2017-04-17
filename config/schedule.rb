# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever



# ログの出力先を設定
set :output, 'log/crontab.log'
# production 環境で cron 実行
#set :environment, :production
set :environment, :development

=begin

# 3時間毎に
every 3.hours do # 1.minute 1.day 1.week 1.month 1.year is also supported
  # MyModel モデルの some_process クラスメソッドを実行
  runner "MyModel.some_process"
  # Rake タスクを実行
  rake "my:rake:task"
  # コマンドを実行
  command "/usr/bin/my_great_command"
end

=end

# 1日1回 AM6:00 に
every 1.day, :at => '6:00 am' do
  # MyModel モデルの task_to_run_at_four_thirty_in_the_morning クラスメソッドを実行
#  runner "MyModel.task_to_run_at_four_thirty_in_the_morning"

#  runner "gomi.push"

#  script '/home/coda/RubymineProjects/gomi-push/app/controllers/concerns/pushbullet_test.rb'
#  script '/home/coda/RubymineProjects/gomi-push/app/controllers/concerns/pushbullet_test.rb'

#  runner "gomi.push"
end

every 1.minute do
#  runner "gomi.push"
  rake "gomi:push"
end

=begin

# 1時間毎に
every :hour do # Many shortcuts available: :hour, :day, :month, :year, :reboot
  # SomeModel モデルの ladeeda クラスメソッドを実行
  runner "SomeModel.ladeeda"
end

every :sunday, :at => '12pm' do # Use any day of the week or :weekend, :weekday
  # 日曜日のPM12:00 に Task モデルの do_something_great クラスメソッドを実行
  runner "Task.do_something_great"
end

# 毎月27〜31日の 00:00 に
every '0 0 27-31 * *' do
  # コマンドを実行
  command "echo 'you can use raw cron syntax too'"
end

# run this task only on servers with the :app role in Capistrano
# see Capistrano roles section below
# role が :app のサーバーで、毎日 AM 12:20 に
every :day, :at => '12:20am', :roles => [:app] do
  # Rake タスクを実行
  rake "app_server:task"
end

=end
