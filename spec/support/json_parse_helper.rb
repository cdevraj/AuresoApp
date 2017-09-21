module JsonParseHelper
  def json(response_body)
    JSON.parse response_body
  end
end
