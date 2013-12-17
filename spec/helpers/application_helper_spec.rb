require 'spec_helper'

describe ApplicationHelper do
  describe "#avatar_url" do
    let(:user) { build(:user) }
    it "returns a gravatar url" do
      url = helper.avatar_url user, 120
      expect(url).to match("#{Digest::MD5.hexdigest(user.email.downcase)}")
    end

    it "contains the size" do
      size = rand(1000)
      url = helper.avatar_url user, size
      expect(url).to match("s=#{size}")
    end
  end
end
