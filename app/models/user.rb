class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :name,
                  :password_digest,
                  :password

  validates :password_digest, presence: true, allow_blank: false
  validates :password, presence: true

  validates :name, presence: true,
                   uniqueness: true,
                   format: {
                     with: /^[[:alnum:]]+$/,
                     message: 'Only letters and numbers allowed.'
                   },
                   allow_blank: false

  def self.authenticate(name, password)
    find_by_name(name).try(:authenticate, password)
  end
end
