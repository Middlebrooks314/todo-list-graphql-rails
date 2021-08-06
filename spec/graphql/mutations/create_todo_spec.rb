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

        it "creates a todo without a provided description" do
          query = <<~GQL
      mutation{
        createTodo(input:{
          title: "Tie my shoes"
          completed: true,
          author: "Bert"
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
          expect(actual_todo["title"]).to eq("Tie my shoes")
          expect(actual_todo["description"]).to eq(nil)
          expect(actual_todo["completed"]).to eq(true)
          expect(actual_todo["author"]).to eq("Bert")
        end

        it "creates a todo with a completion status set to false when one is not provided" do
          query = <<~GQL
      mutation{
        createTodo(input:{
          title: "Drink water"
          author: "Ernie"
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
          expect(actual_todo["title"]).to eq("Drink water")
          expect(actual_todo["description"]).to eq(nil)
          expect(actual_todo["completed"]).to eq(false)
          expect(actual_todo["author"]).to eq("Ernie")
        end
      end

      context "when required attributes are not given" do
        it "does not create a todo without a title and returns an error" do
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

        it "does not create a todo without an author and returns an error" do
          query = <<~GQL
      mutation{
        createTodo(input:{
          title: "",
          description: "Lorem Ipsum.",
          completed: true,
          author: ""
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

        it "does not create a todo with invalid fields" do
          query = <<~GQL
      mutation{
        createTodo(input:{
          title: "Say Hello",
          snacks: "peaches"
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
          expect(json["errors"][0]["message"]).to eq("InputObject 'CreateTodoInput' doesn't accept argument 'snacks'")
        end
      end
    end
  end
end
