module Types
  class TodoType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: true
    field :completed, Boolean, null: false
    field :author, String, null: false
  end
end
