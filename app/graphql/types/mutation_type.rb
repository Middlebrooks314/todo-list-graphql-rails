module Types
  class MutationType < Types::BaseObject
    field :create_todo, mutation: Mutations::CreateTodo,
     description: "Adds new todo"
  end
end 
