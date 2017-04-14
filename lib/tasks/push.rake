#!/usr/local/bin/ruby ruby.exe

require 'washbullet'
require 'dotenv'

namespace :gomi do
  desc "pushする"

  task :push => :environment do
#    def push
      p "push!!!!!!!!!!!!!!!!!!!!!!!!"
      Rails.logger.info "push!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
# end

    Dotenv.load ".env"

    client = Washbullet::Client.new(ENV['TOKEN'])

    puts "api key====="
    p ENV['TOKEN']

    puts "client------"
    p client

    client.push_note(receiver: :device, identifier:ENV['DEVICE'], params:{
        title: '朝やで',
        body: '朝'
    })

  end

end
