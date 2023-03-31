module ApplicationHelper
  def format_phone_number(phone_number)
    number = phone_number.gsub(/\D/, '')

    case number.length
    when 11
      number.gsub(/(\d{2})(\d{5})(\d{4})/, '(\1) \2-\3')
    when 10
      number.gsub(/(\d{2})(\d{4})(\d{4})/, '(\1) \2-\3')
    else
      number
    end
  end

  def format_cpf(cpf)
    CPF.new(cpf).formatted
  end
end
