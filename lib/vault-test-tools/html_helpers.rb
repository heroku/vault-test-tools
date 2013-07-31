module Vault::Test::HTMLHelpers
  # Save and open an HTML document in your browser.
  #
  # @param html [String] The page to open or nil to fetch it from
  #   `last_response.body` if testing a Sinatra app.
  def save_and_open_page(html = nil, name = 'page.html', i = 1)
    html ||= last_response.body
    name = "page_#{i=i+1}.html" while File.exist? name
    File.open(name, 'w') { |f| f << html }
    system "open #{name}"
  end

  # Parse an HTML document into a `Nokogiri::HTML` instance and store it as
  # the current document.
  def set_doc(body)
    @doc = Nokogiri::HTML(body)
  end

  # Get the current document or parse `last_response.body` into a
  # `Nokogiri::HTML` instance.
  #
  # @return [Nokogiri::HTML] The current HTML document.
  def doc
    @doc || Nokogiri::HTML(last_response.body)
  end

  # Get a list of text matches in the current document for a CSS selector.
  #
  # @param selector [String] A CSS selector to match elements in the document
  #   with.
  # @return [Array] A list of matching elements from the current document.
  def css(selector)
    doc.css(selector)
  end

  # Assert that at least one element in the current document matches the CSS
  # selector.
  #
  # @param selector [String] A CSS selector to match elements in the document
  #   with.
  def assert_includes_css(selector)
    exists = doc.css(selector).first
    assert exists, "Last response must include #{selector}"
  end

  # Assert that the content in the first element matching the CSS selector
  # matches the specified value.
  #
  # @param selector [String] A CSS selector to match elements in the document
  #   with.
  # @param content [String] The content to match in the first matching
  #   element.
  def assert_css(selector, content)
    e = css(selector).first
    assert e, "Element not found: #{selector}"
    assert_includes e.content, content
  end
end
