module Xively
  class Client
    class FeedHandler
      def initialize(headers)
        @headers = headers
      end

      def all
        SearchResult.new(Client.get("/v2/feeds.json", @headers).body).results
      end

      def get(feed_id)
        Feed.new(Client.get("/v2/feeds/#{feed_id}.json", @headers).body)
      end
    end
  end
end
