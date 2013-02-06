require 'spec_helper'

describe Mention do
  it 'gets destroyed when the associated tweet is destroyed' do
    tweet = Fabricate(:tweet)
    5.times { Fabricate(:mention, tweet: tweet) }
    expect { tweet.destroy }.to change { tweet.mentions.count }.from(5).to(0)
  end
end
