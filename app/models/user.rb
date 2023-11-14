class User < ApplicationRecord
  has_secure_password
  has_many :favorites, dependent: :destroy
  validates_presence_of :name, :password_digest, :email 
  validates_uniqueness_of :email, case_sensitive: false
  before_create :generate_api_key

  private

  def generate_api_key
    self.api_key = SecureRandom.uuid
  end
end
