class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :name,
                  :password_digest,
                  :password

  validates :name, presence: true,
                   uniqueness: true,
                   format: {with: /[[:alnum:]]+/},
                   allow_blank: false
end
