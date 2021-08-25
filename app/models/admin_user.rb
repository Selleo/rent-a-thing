class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable
  validates :email, presence: true,
    format: { with: /^(.+)@(.+)$/, message: "Email invalid", :multiline => true  },
    uniqueness: { case_sensitive: false },
    length: { minimum: 4, maximum: 254 }
  validates :encrypted_password, presence: true
end
