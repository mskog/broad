require 'spec_helper'

describe "Feedindex", type: :request do
  When do
    get feed_index_path
  end

  Given(:feed_response){Feedjira::Feed.parse_with Feedjira::Parser::RSS, response.body}
end
