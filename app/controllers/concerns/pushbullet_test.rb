require 'washbullet'
#require 'dotenv-rails'
require "dotenv"

module PushbulletTest
  extend ActiveSupport::Concern

  def init
    Dotenv.load ".env"

    p ENV['TOKEN']

#    client = Washbullet::Client.new(ENV['TOKEN'])

#    client.push_note(receiver: :device, identifier:ENV['DEVICE'], params:{
#        title: '朝やで',
#        body: '朝'
#    })

  end

  def push
    @user = User.all
    puts "user~~~~~~~~~~~~~~~~~~~~~~"
    @user.each do |user|
      p user
    end
  end

end
