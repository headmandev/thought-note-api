require "test_helper"

class NotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    Rack::Attack.enabled = false
    @default_note = notes(:note_1)
  end

  test "should not create note without nested params" do
    post notes_url, params: { note: { a: @default_note.data } }, as: :json
    assert_response :unprocessable_entity
  end

  test "should not create note with incorrect params" do
    assert_raise(ActionController::ParameterMissing) do
      post notes_url, params: { data: @default_note.data }, as: :json
    end
  end

  test "should not create note" do
    assert_no_difference("Note.count") do
      post notes_url, params: { note: { data: @default_note.data, id: @default_note.id } }, as: :json
    end

    assert_response :unprocessable_entity
  end

  test "should create note" do
    assert_difference("Note.count") do
      post notes_url, params: { note: { data: @default_note.data, id: SecureRandom.uuid } }, as: :json
    end

    assert_response :created
  end

  test "should create note without id" do
    assert_difference("Note.count") do
      post notes_url, params: { note: { data: @default_note.data } }, as: :json
    end

    assert_response :created
  end

  test "should not show note" do
    assert_raise(ActiveRecord::RecordNotFound) do
      get note_url({ id: SecureRandom.uuid })
    end
  end

  test "should show note" do
    get note_url(@default_note), as: :json
    assert_response :success
  end

  test "should not update note" do
    assert_raise(ActiveRecord::RecordNotFound) do
      patch note_url({ id: SecureRandom.uuid }), params: { note: { data: @default_note.data, id: SecureRandom.uuid } }, as: :json
    end

    # assert_response :not_found
  end

  test "should not update note with invalid data" do
    patch note_url(@default_note), params: { note: { data: { hello: 1, a: { b: 2 } }, id: SecureRandom.uuid } }, as: :json
    assert_response :unprocessable_entity
  end

  test "should update note" do
    patch note_url(@default_note),
          params: {
            note: {
              data: [{
                type: "paragraph",
                children: [
                  { text: 'This is editable ' },
                  { text: 'rich', bold: true }
                ]
              }]
            }
          },
          as: :json
    assert_response :success
  end

  test "should not update only id note" do
    patch note_url(@default_note), params: { note: { id: SecureRandom.uuid } }, as: :json
    assert_response :unprocessable_entity
  end

  test "should not update note without data" do
    assert_raise(ActionController::ParameterMissing) do
      patch note_url(@default_note), params: { data: [{"type":"a123","children":[]}], asd: [] }, as: :json
    end
  end

  test "should destroy note" do
    assert_difference("Note.count", -1) do
      delete note_url(@default_note), as: :json
    end

    assert_response :no_content
  end
end
