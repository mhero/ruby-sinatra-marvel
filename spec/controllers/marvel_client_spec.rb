require "spec_helper"

describe Marvel::Client do
  let(:character_response) do
    VCR.use_cassette("marvel/character", match_requests_on: [:body]) do
      Marvel::Client.new.character_by_name("hulk")
    end
  end

  let(:story_response) do
    VCR.use_cassette("marvel/story", match_requests_on: [:body]) do
      Marvel::Client.new.character_stories("1009351", limit: 8)
    end
  end

  let(:story_chaacters_response) do
    VCR.use_cassette("marvel/story_chaacters", match_requests_on: [:body]) do
      Marvel::Client.new.story_characters("702")
    end
  end

  it "can fetch & parse character data" do
    expect(character_response).to be_kind_of(Array)
    expect(character_response.count).to eq(1)
    expect(character_response.first.name).to eq("Hulk")
  end

  it "can fetch & parse story data" do
    expect(story_response).to be_kind_of(Array)
    expect(story_response.count).to eq(8)
  end

  it "can fetch & parse story's characters data" do
    expect(story_chaacters_response).to be_kind_of(Array)
  end
end
