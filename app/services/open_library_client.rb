# app/services/open_library_client.rb
require "httparty"

class OpenLibraryClient
  include HTTParty
  base_uri "https://openlibrary.org"

  def search_by_title(title, limit: 10)
    title = title.to_s.strip
    return [] if title.empty?

    resp = self.class.get(
      "/search.json",
      query: { title: title, limit: limit },
      headers: { "Accept" => "application/json" },
      timeout: 8
    )

    return [] unless resp.success?

    docs = resp.parsed_response["docs"] || []
    docs.map do |d|
      {
        key: d["key"], # ex: "/works/OL..."
        title: d["title"],
        author: Array(d["author_name"]).first,
        year: d["first_publish_year"]
      }
    end
  rescue StandardError => e
    Rails.logger.warn("[OpenLibrary] search failed: #{e.class} - #{e.message}")
    []
  end
end
