require 'cpf_cnpj'

class CpfValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless CPF.valid?(value)
      record.errors.add attribute, 'inválido'
    end
  end
end
