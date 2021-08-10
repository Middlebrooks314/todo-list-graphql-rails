require "rails_helper"

module Mutations
  RSpec.describe UpdateTodo, type: :request do
    describe ".resolve" do
      it "updates a todo status" do
        todo = Todo.create(title: "Water plants", completed: false, author: "Georgia O'Keeffe")
        todo_id = todo.id

        expect(todo.title).to eq("Water plants")
        expect(todo.author).to eq("Georgia O'Keeffe")
        expect(todo.completed).to eq(false)

        query = <<~GQL
        mutation{
          updateTodo(input:{
            todoId: #{todo_id}
            completed: true
          }) {
            todo {
              id,
              title,
              description,
              completed,
              author
            }
            errors
          }
        }
        GQL

        post "/graphql", params: {query: query}
        updated_todo = json["data"]["updateTodo"]["todo"]

        expect(response).to have_http_status(200)
        expect(updated_todo["title"]).to eq("Water plants")
        expect(updated_todo["author"]).to eq("Georgia O'Keeffe")
        expect(updated_todo["completed"]).to eq(true)
      end

      it "does not update invalid attributes" do
        todo = Todo.create(title: "Give out cars", completed: false, author: "Oprah")
        todo_id = todo.id

        expect(todo.title).to eq("Give out cars")
        expect(todo.author).to eq("Oprah")
        expect(todo.completed).to eq(false)

        query = <<~GQL
        mutation{
          updateTodo(input:{
            todoId: #{todo_id}
            author: "Martha Stewart"
          }) {
            todo {
              id,
              title,
              description,
              completed,
              author
            }
            errors
          }
        }
        GQL

        post "/graphql", params: {query: query}

        expect(response).to have_http_status(200)
        expect(json["errors"][0]["message"]).to eq("InputObject 'UpdateTodoInput' doesn't accept argument 'author'")

      end

      it "returns an error when the todo id is not found" do
        query = <<~GQL
        mutation{
          updateTodo(input:{
            todoId: 15
            completed: true
          }) {
            todo {
              id,
              title,
              description,
              completed,
              author
            }
            errors
          }
        }
        GQL

        post "/graphql", params: {query: query}

        expect(response).to have_http_status(200)
        expect(json["errors"][0]["message"]).to eq("Couldn't find Todo with 'id'=15")
      end
    end
  end
end
