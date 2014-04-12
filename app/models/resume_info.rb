class ResumeInfo
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :name, :email, :phone, :message
  attr_accessor :attachment

  def populate(name, email, phone, message, attachment)
    @name = name
    @email = email
    @phone = phone
    @message = message
    @attachment = attachment
  end

  # for form that wants a true model but we don't use a db; part of ActiveModel extend/include above
  def persisted?
    false
  end

  def to_s
    "#{@name}, #{@email}, #{@phone}, #{@message}"
  end
end
