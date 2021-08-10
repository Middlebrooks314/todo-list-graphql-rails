class Mutations::DestroyTodo < Mutations::BaseMutation
  null true
  argument :todo_id, ID, required: true

  field :todo, Types::TodoType, null: false
  field :errors, [String], null: false

  def resolve(todo_id:)
    todo = Todo.find(todo_id)

    if todo.destroy
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
