require "spec_helper"

describe MarvelClient do
  let(:character_response) do
    VCR.use_cassette("marvel/character", match_requests_on: [:body]) do
      MarvelClient.new.character_by_name("hulk")
    end
  end

  let(:story_response) do
    VCR.use_cassette("marvel/story", match_requests_on: [:body]) do
      MarvelClient.new.character_stories("1009351", limit: 8)
    end
  end

  it "can fetch & parse character data" do
    expect(character_response).to be_kind_of(Character)
    expect(character_response.name).to eq("Hulk")
  end

  it "can fetch & parse story data" do
    expect(story_response).to be_kind_of(Array)
    expect(story_response.count).to eq(8)
  end
end
