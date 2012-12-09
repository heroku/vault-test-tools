module Vault::HTMLTestHelpers
  def save_and_open_page(html = nil, name = 'page.html', i = 1)
    html ||= last_response.body
    name = "page_#{i=i+1}.html" while File.exist? name
    File.open(name, 'w') { |f| f << html }
    system "open #{name}"
  end

  def set_doc(body)
    @doc = Nokogiri::HTML(body)
  end

  def doc
    @doc || Nokogiri::HTML(last_response.body)
  end

  def css(string)
    doc.css(string)
  end

  def assert_includes_css(css_string)
    exists = doc.css(css_string).first
    assert exists, "Last response must include #{css_string}"
  end

  def assert_css(css_string, content)
    e = css(css_string).first
    assert e, "Element not found: #{css_string}"
    assert_includes e.content, content
  end
end
