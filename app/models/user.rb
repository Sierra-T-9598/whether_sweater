class User < ApplicationRecord
  has_secure_password

  validates_presence_of :password_digest
  validates_presence_of :email
  validates_uniqueness_of :email, case_sensitive: false

  encrypts :private_api_key, key: Lockbox.attribute_key(table: "users", attribute: "private_api_key_ciphertext")
  blind_index :private_api_key, key: ENV["blind_index_master_key"]
  before_create :set_private_api_key

  validates_presence_of :private_api_key, on: :set_private_api_key
  validates_uniqueness_of :private_api_key, on: :set_private_api_key

  private

  def set_private_api_key
    self.private_api_key = SecureRandom.urlsafe_base64(24) if self.private_api_key.nil?
  end
end
