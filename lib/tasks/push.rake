#!/usr/local/bin/ruby ruby.exe

require 'washbullet'
require 'dotenv'

def oauth

end

def wday?(gomi)
  if gomi.mon == 1
    if Date.today.wday == 1
      return true
    end
  end

  if gomi.tues == 1
    if Date.today.wday == 2
      return true
    end
  end

  if gomi.wed == 1
    if Date.today.wday == 3
      return true
    end
  end

  if gomi.thurs == 1
    if Date.today.wday == 4
      return true
    end
  end

  if gomi.fri == 1
    if Date.today.wday == 5
      return true
    end
  end

  if gomi.sat == 1
    if Date.today.wday == 6
      return true
    end
  end

  if gomi.sat == 1
    if Date.today.wday == 0
      return true
    end
  end

end

namespace :gomi do
  desc "pushする"

  task :push => :environment do
#    def push
#      p "push!!!!!!!!!!!!!!!!!!!!!!!!"
      Rails.logger.info "push!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      Rails.logger.info Time.now
# end

#    Dotenv.load ".env"
=begin
    client = Washbullet::Client.new(ENV['TOKEN'])

    puts "api key====="
    p ENV['TOKEN']

    puts "client------"
    p client

    client.push_note(receiver: :device, identifier:ENV['DEVICE'], params:{
        title: '朝やで',
        body: '朝'
    })
=end

    users = User.all
    puts "user~~~~~~~~~~~~~~~~~~~~~~"
    #Rails.logger.info @user

    users.each do |user|
      id = user.id
      hour = user.pushtime.hour
      min = user.pushtime.min

      Rails.logger.info hour
      Rails.logger.info min
      # 時間
      if hour == Time.now.hour && min == Time.now.min
        client = Washbullet::Client.new(ENV['TOKEN'])

        Gomi.where(user_id:id).find_each do |gomi|
          # 曜日判定
          if wday?(gomi)
            client.push_note(receiver: :device, identifier:ENV['DEVICE'], params:{
                title: '今日のゴミ',
                body: gomi.name
            })
          end
        end
      end
    end




#    @user.each do |user|
#      Rails.logger.info user
#      p user
#    end
  end

end
