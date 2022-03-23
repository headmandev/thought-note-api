class CreateNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :notes, id: :uuid do |t|
      t.json :data

      t.timestamps
    end
  end
end
