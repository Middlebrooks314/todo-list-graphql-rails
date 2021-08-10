require "rails_helper"

module Queries
  RSpec.describe Todo, type: :request do
    describe "query all todos" do
      it "returns a successful response when there are no todos" do

        post "/graphql", params: {query: query}

        todo_list = json["data"]["allTodos"]

        expect(todo_list).to eq([])
        expect(response).to have_http_status(:success)
      end

      it "returns a single todo" do
        Todo.create(title: "Make coffee", completed: false, author: "Albert Einstein", description: "Do it well.")

        post "/graphql", params: {query: query}

        todo_list = json["data"]["allTodos"]
        todo = todo_list[0]

        expect(todo_list.count).to eq(1)
        expect(response).to have_http_status(:success)
        expect(todo["title"]).to eq("Make coffee")
        expect(todo["completed"]).to eq(false)
        expect(todo["author"]).to eq("Albert Einstein")
        expect(todo["description"]).to eq("Do it well.")
      end

      it "returns many todos" do
        Todo.create(title: "Cut grass", completed: false, author: "Foo")
        Todo.create(title: "Pull weeds", completed: true, author: "Foo")
        Todo.create(title: "Make jam", completed: true, author: "Foo")

        post "/graphql", params: {query: query}

        todo_list = json["data"]["allTodos"]

        expect(todo_list.count).to eq(3)
        expect(todo_list[0]["title"]).to eq("Cut grass")
        expect(todo_list[1]["title"]).to eq("Pull weeds")
        expect(todo_list[2]["title"]).to eq("Make jam")
      end

      def query
        <<~GQL
          query {
            allTodos {
              id
              title
              description
              completed
              author
            }
          }
        GQL
      end
    end
  end
end
