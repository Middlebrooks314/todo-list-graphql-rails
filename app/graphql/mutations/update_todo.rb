class Mutations::UpdateTodo < Mutations::BaseMutation
  null true
  argument :todo_id, ID, required: true
  argument :completed, Boolean, required: false

  field :todo, Types::TodoType, null: false
  field :errors, [String], null: false

  def resolve(todo_id:, **args)
    todo = Todo.find(todo_id)

    if todo.update(args)
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
