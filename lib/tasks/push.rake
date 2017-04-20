#!/usr/local/bin/ruby ruby.exe

require 'washbullet'
require 'dotenv'

$week = {0 => :sunday,
         1 => :monday,
         2 => :tuesday,
         3 => :wednesday,
         4 => :thursday,
         5 => :friday,
         6 => :saturday}

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

def push(gomi)
  $client.push_note(receiver: :device, identifier: ENV['DEVICE'], params: {
      title: $title,
      body: gomi.name
  })
end

namespace :gomi do
  desc "pushする"

  task :push => :environment do
#    def push
#      p "push!!!!!!!!!!!!!!!!!!!!!!!!"
# => development.log / production.log
    Rails.logger.info "push!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    # => crontab.log
    puts Time.now

    User.all.each do |user|
      id = user.id
      hour = user.pushtime.hour
      min = user.pushtime.min

      $title = user.title

      Rails.logger.info hour
      Rails.logger.info min
      # 時間
      if hour == Time.now.hour && min == Time.now.min
        $client = Washbullet::Client.new(ENV['TOKEN'])

        Gomi.where(user_id: id).find_each do |gomi|
          # 隔週
          if gomi.every == 2
            if gomi.start_date.to_i == Date.today.day
              push(gomi)
              gomi.start_date = -7.days.ago.next_week($week[Date.today.wday]).day
              gomi.save
            end
          else
            # 曜日判定
            if wday?(gomi)
              push(gomi)
            end
          end
        end
      end
    end
  end

  task :test do
    p $week[Date.today.wday]
    p -7.days.ago.next_week($week[Date.today.wday]).day
    p Date.today.next_week.next_week($week[Date.today.wday])
  end

end
