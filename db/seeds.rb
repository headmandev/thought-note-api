# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

3.times do |i|
  Note.create(id: SecureRandom.uuid, data: [
    {
      type: "paragraph",
      children: [
        { text: 'This is editable ' },
        { text: 'rich', bold: true }
      ]
    }])
end