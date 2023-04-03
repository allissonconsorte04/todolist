class Api::V1::SmsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def send_sms
    to = params[:to]
    message = params[:message]

    SmsService.send_sms("+55#{to}", "Seu código de confirmação é #{message}")

    render json: { message: 'SMS enviado com sucesso' }
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
