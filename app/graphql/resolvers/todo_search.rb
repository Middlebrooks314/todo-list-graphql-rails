module Resolvers
  class TodoSearch < Resolvers::BaseSearchResolver
    type Types::TodoType.connection_type, null: false
    description "Lists todos"

    scope { Todo.all }

    option :completed, type: types.Boolean, with: :apply_completed_filter

    def apply_completed_filter(scope, value)
      if value
        scope.completed
      else
        scope.incompleted
      end
    end
  end
end
