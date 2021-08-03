module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :status, String, null: false,
      description: "A basic status check to make sure the API and graphiql is working."
    def status
      "OK"
    end
  end
end
