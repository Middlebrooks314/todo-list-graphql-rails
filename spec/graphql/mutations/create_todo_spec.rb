require "rails_helper"

module Mutations
  RSpec.describe CreateTodo, type: :request do
    describe ".resolve" do
      context "when valid todo parameters are given" do
        it "creates a todo" do
          query = <<~GQL
      mutation{
        createTodo(input:{
          title: "FooBar",
          description: "Lorem Ipsum.",
          completed: false,
          author: "Bill Murray"
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

          expect { post "/graphql", params: {query: query} }.to change(Todo, :count).by(1)
          actual_todo = json["data"]["createTodo"]["todo"]

          expect(response).to have_http_status(200)
          expect(actual_todo["title"]).to eq("FooBar")
          expect(actual_todo["description"]).to eq("Lorem Ipsum.")
          expect(actual_todo["completed"]).to eq(false)
          expect(actual_todo["author"]).to eq("Bill Murray")
        end

        it "creates a todo with a null description" do
          query = <<~GQL
      mutation{
        createTodo(input:{
          title: "Foo",
          description: null,
          completed: true,
          author: "Adam Sandler"
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

          expect { post "/graphql", params: {query: query} }.to change(Todo, :count).by(1)
          actual_todo = json["data"]["createTodo"]["todo"]

          expect(response).to have_http_status(200)
          expect(actual_todo["title"]).to eq("Foo")
          expect(actual_todo["description"]).to eq(nil)
          expect(actual_todo["completed"]).to eq(true)
          expect(actual_todo["author"]).to eq("Adam Sandler")
        end
      end

      context "when required attributes are not given" do
        it "does not create a todo and returns an error" do
          query = <<~GQL
      mutation{
        createTodo(input:{
          title: "",
          description: "Lorem Ipsum.",
          completed: true,
          author: "Lisa Kudrow"
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

          expect { post "/graphql", params: {query: query} }.to change(Todo, :count).by(0)

          expect(response).to have_http_status(200)
          expect(json["createTodo"]).to eq(nil)
          expect(json["errors"][0]["message"]).to eq("Cannot return null for non-nullable field CreateTodoPayload.todo")
        end
      end
    end
  end
end
