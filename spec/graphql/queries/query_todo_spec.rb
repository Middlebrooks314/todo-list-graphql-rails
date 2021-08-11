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

    describe "searching todos by completion status" do
      it "will return a list of todos that are completed" do
        Todo.create(title: "Cut grass", completed: false, author: "Foo")
        Todo.create(title: "Pull weeds", completed: false, author: "Baz")
        Todo.create(title: "Make jam", completed: false, author: "Foo")
        Todo.create(title: "Code", completed: true, author: "FooBar")

        post "/graphql", params: {query: query_status(true)}

        todo_list = json["data"]["searchTodosByStatus"]

        expect(todo_list.count).to eq(1)
      end

      it "will return a list of todos that are not completed" do
        Todo.create(title: "Cut grass", completed: false, author: "Foo")
        Todo.create(title: "Pull weeds", completed: false, author: "Baz")
        Todo.create(title: "Make jam", completed: false, author: "Foo")
        Todo.create(title: "Code", completed: true, author: "FooBar")

        post "/graphql", params: {query: query_status(false)}

        todo_list = json["data"]["searchTodosByStatus"]

        expect(todo_list.count).to eq(3)
      end

      it "will return an error when a non-boolean is passed in" do
        Todo.create(title: "Cut grass", completed: false, author: "Foo")

        post "/graphql", params: {query: query_status(5)}

        error = json["errors"][0]["message"]

        expect(error).to eq("Argument 'completed' on Field 'searchTodosByStatus' has an invalid value (5). Expected type 'Boolean!'.")
      end

      def query_status(status)
        <<~GQL
        query{
          searchTodosByStatus(completed: #{status}) {
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
