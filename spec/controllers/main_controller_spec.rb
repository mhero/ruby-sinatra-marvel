require "spec_helper"
require "rack/test"

RSpec.describe MainController do
  describe "/character" do
    it "returns 200 with valid params" do
      VCR.use_cassette(
          "marvel/character",
          match_requests_on: [:body],
          re_record_interval: 30.days
        ) do
        get "/character", name: "hulk"
      end

      expect(last_response.status).to be 200
    end

    it "returns 404 with invalid params" do
      VCR.use_cassette(
          "marvel/character_error",
          match_requests_on: [:body],
          re_record_interval: 30.days
        ) do
        get "/character", name: "happy_hero"
      end
      expect(last_response.status).to be 404
    end
  end

  describe "/character/:id/stories" do
    it "returns 200 with valid params" do
      VCR.use_cassette(
          "marvel/story",
          match_requests_on: [:body],
          re_record_interval: 30.days
        ) do
        get "/character/:id/stories", id: "1009351"
      end

      expect(last_response.status).to be 200
    end

    it "returns 500 when there's an error in the API" do
      VCR.use_cassette(
          "marvel/story_error",
          match_requests_on: [:body],
          re_record_interval: 30.days
        ) do
        get "/character/:id/stories", id: "abc"
      end
      expect(last_response.status).to be 500
    end
  end

  describe "/story/:id/characters" do
    it "returns 200 with valid params" do
      VCR.use_cassette(
          "marvel/story_characters",
          match_requests_on: [:body],
          re_record_interval: 30.days
        ) do
        get "/story/:id/characters", id: "702"
      end

      expect(last_response.status).to be 200
    end

    it "returns 500 when there's an error in the API" do
      VCR.use_cassette(
          "marvel/story_characters_error",
          match_requests_on: [:body],
          re_record_interval: 30.days
        ) do
        get "/story/:id/characters", id: "abc"
      end
      expect(last_response.status).to be 500
    end
  end
end
