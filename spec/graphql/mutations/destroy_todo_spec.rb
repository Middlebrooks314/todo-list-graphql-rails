require "rails_helper"

module Mutations
  RSpec.describe DestroyTodo, type: :request do
    it "deletes and returns the deleted item" do
      todo = Todo.create(title: "Meditate", completed: true, author: "Dalai Lama")
      todo_id = todo.id

      expect { post "/graphql", params: {query: query(todo_id)} }.to change(Todo, :count).by(-1)

      deleted_todo = json["data"]["destroyTodo"]["todo"]

      expect(response).to have_http_status(:success)
      expect(deleted_todo["title"]).to eq("Meditate")
      expect(deleted_todo["author"]).to eq("Dalai Lama")
      expect(deleted_todo["id"]).to eq(todo_id.to_s)
    end

    it "returns an error when the todo id is not found" do
      expect { post "/graphql", params: {query: query(25)} }.to change(Todo, :count).by(0)

      expect(response).to have_http_status(:success)
      expect(json["errors"][0]["message"]).to eq("Couldn't find Todo with 'id'=25")
    end

    def query(todo_id)
      <<~GQL
      mutation{
        destroyTodo(input:{
          todoId: #{todo_id}
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
    end
  end
end
