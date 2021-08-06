class Mutations::CreateTodo < Mutations::BaseMutation
  null true
  argument :title, String, required: true
  argument :description, String, required: false
  argument :completed, Boolean, required: true
  argument :author, String, required: true

  field :todo, Types::TodoType, null: false
  field :errors, [String], null: false

  def resolve(title:, description:, completed:, author:)
    todo = Todo.new(title: title, description: description, completed: completed, author: author)
    if todo.save
      {
        todo: todo,
        errors: []
      }
    else
      {
        todo: nil,
        errors: todo.errors.full_messages
      }
  end
  end
end
