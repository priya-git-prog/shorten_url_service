module UrlsHelper
  def url_with_protocol(url)
    url.present? ? /^http/.match(url) ? url : "http://#{url}" : ""
  end
end