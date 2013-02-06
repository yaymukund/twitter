class Tweet < ActiveRecord::Base
  belongs_to :user
  has_many :mentions, dependent: :destroy
  has_many :mentioned_users, through: :mentions, source: :user
  attr_accessible :content

  validates :user, presence: true
  validates :content, length: {in: 1..160}

  before_create :create_mentions

  # http://stackoverflow.com/questions/7520297/regex-to-parse-user-mentions
  MENTION_REGEX = /(?:^|\s)\@(\w*[a-zA-Z_]+\w*)/

  def create_mentions
    content.scan(MENTION_REGEX).each do |name|
      mentioned_user = User.find_by_name(name)

      if mentioned_user.present?
        mentions.build(user: mentioned_user)
      end
    end
  end
end
