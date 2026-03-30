class MockProxyController < ApplicationController
  allow_unauthenticated_access

  def handle
    path = "/#{params[:path]}"
    method = request.method.upcase

    mock = Mock.find_by(request_url: path, request_method: method)

    if mock.nil?
      render plain: "No mock found for #{method} #{path}", status: :not_found
      return
    end

    headers = parse_headers(mock.response_headers)
    content_type = headers.delete("Content-Type") || "text/plain"
    headers.each { |key, value| response.set_header(key, value) }

    render body: mock.response_body || "", status: mock.response_status, content_type: content_type
  end

  private

  def parse_headers(raw)
    return {} if raw.blank?

    raw.each_line.with_object({}) do |line, hash|
      key, value = line.strip.split(":", 2)
      hash[key.strip] = value.strip if key.present? && value.present?
    end
  end
end
