module Types
  class MutationType < Types::BaseObject
    field :create_todo, mutation: Mutations::CreateTodo,
     description: "Adds new todo"

    field :update_todo, mutation: Mutations::UpdateTodo,
     description: "Updates a todo"

    field :destroy_todo, mutation:Mutations::DestroyTodo,
      description: "Removes a todo"
  end
end 
