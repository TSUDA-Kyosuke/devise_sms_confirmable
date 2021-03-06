# frozen_string_literal: true

module SharedUserWithoutEmail
  extend ActiveSupport::Concern

  included do
    # NOTE: This is missing :validatable and :confirmable, as they both require
    # an phone field at the moment. It is also missing :omniauthable because that
    # adds unnecessary complexity to the setup
    devise :database_authenticatable, :lockable, :recoverable,
           :registerable, :rememberable, :timeoutable,
           :trackable
  end

  # This test stub is a bit rubbish because it's tied very closely to the
  # implementation where we care about this one case. However, completely
  # removing the phone field breaks "recoverable" tests completely, so we are
  # just taking the approach here that "phone" is something that is a not an
  # ActiveRecord field.
  def phone_changed?
    raise NoMethodError
  end

  def respond_to?(method_name, include_all=false)
    return false if method_name.to_sym == :phone_changed?
    super(method_name, include_all)
  end
end
