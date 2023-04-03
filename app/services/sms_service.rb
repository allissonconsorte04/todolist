require 'twilio-ruby'
require 'dotenv'

class SmsService
  def self.send_sms(to, message)
    Dotenv.load

    client = Twilio::REST::Client.new(
      ENV['TWILIO_ACCOUNT_SID'],
      ENV['TWILIO_AUTH_TOKEN']
    )

    client.messages.create(
      to: "+55#{to}",
      from: ENV['TWILIO_FROM_NUMBER'],
      body: "O seu código de verificação é: #{message}"
    )
  end
end
