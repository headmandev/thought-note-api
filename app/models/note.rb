class Note < ApplicationRecord
  self.implicit_order_column = "created_at"
  validates :id, uuid: true, if: -> { id.present? }
  validates :id, uniqueness: true, if: -> { id.present? }
  # validates :data, presence: true, json: true
  validates :data, presence: true

  DATA_SCHEMA = {
    "type": "object",
    "required": %w[type children],
    "properties": {
      "type": {
        "type": "string"
      },
      "children": {
        "type": "array"
      }
    }
  }

  validates :data, schema: { json: false, list: true }, if: -> { data.present? }
end
