class CreateMocks < ActiveRecord::Migration[8.1]
  def change
    create_table :mocks do |t|
      t.string :request_url, null: false
      t.string :request_method, null: false, default: "GET"
      t.text :request_headers
      t.text :request_body
      t.integer :response_status, null: false, default: 200
      t.text :response_headers
      t.text :response_body

      t.timestamps
    end
  end
end
