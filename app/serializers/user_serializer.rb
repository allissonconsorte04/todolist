class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :phone, :gender, :profile_type, :activities

  def phone
    object.show_phone == true ? object.phone : ''
  end

  def activities
    object.activities.where(public: true)
  end
end
