module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :status, String, null: false,
      description: "A basic status check to make sure the API and graphiql is working."
    field :all_todos, [Types::TodoType], null: false,
      description: "Returns all todos"
    
    def status
      "OK"
    end

   def all_todos
    Todo.all
   end
  end
end
