require 'spec_helper'

describe Tweet do
  describe '.mentions' do
    let(:user) { Fabricate(:user) }

    subject do
      tweet = Fabricate(:tweet, content: content)
      tweet
    end

    context 'when mentioning a user' do
      let(:content) { "Hi @#{user} how are you" }
      its(:mentioned_users) { should include(user) }
    end

    context 'with two mentions' do
      let(:user2) { Fabricate(:user) }
      let(:content) { "Hi @#{user} and @#{user2}" }
      its(:mentioned_users) { should include(user, user2) }
    end

    context 'with one mention and a failed match' do
      let(:content) { "Hi *%$. @notavalidmatch @#{user} 8($&# how are you" }
      its(:mentioned_users) { should include(user) }
    end

    context 'with invalid characters after the username' do
      let(:content) { "Hi *%$. @#{user}%$#* 8($&# how are you" }
      its(:mentioned_users) { should include(user) }
    end

    context 'with numbers in the username' do
      let(:user) { Fabricate(:user, name: 'user1234') }
      let(:content) { "Hi *%$. @#{user} this works too!" }
      its(:mentioned_users) { should include(user) }
    end

    # Failure cases

    context 'with invalid characters before the username' do
      let(:content) { "Hi *%$.@#{user} 8($&# how are you" }
      its(:mentioned_users) { should_not include(user) }
    end

    context 'with an invalid username' do
      let(:content) { "Hello imaginary @fake_user" }
      its(:mentioned_users) { should be_empty }
    end
  end
end
