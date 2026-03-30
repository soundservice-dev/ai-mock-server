class Mock < ApplicationRecord
  validates :request_url, presence: true
  validates :request_method, presence: true, inclusion: {in: %w[GET POST PUT PATCH DELETE HEAD OPTIONS]}
  validates :response_status, presence: true,
    numericality: {only_integer: true, greater_than_or_equal_to: 100, less_than: 600}
end
