require 'washbullet'
#require 'dotenv-rails'


#Dotenv.load ".env"

p ENV['TOKEN']

client = Washbullet::Client.new(ENV['TOKEN'])

  client.push_note(receiver: :device, identifier:ENV['DEVICE'], params:{
      title: '朝やで',
      body: '朝'
  })
