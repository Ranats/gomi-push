require 'washbullet'
require 'dotenv'

Dotenv.load ".env"

client = Washbullet::Client.new(ENV['TOKEN'])

  client.push_note(receiver: :device, identifier:ENV['DEVICE'], params:{
      title: '朝やで',
      body: '朝'
  })
