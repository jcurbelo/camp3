# frozen_string_literal: true

class Camp3::Client
  module ProjectAPI

    def projects(options = {})
      get("/projects", options)
    end

    def message_board(project)
      board = project.message_board
      get(board.url, override_path: true)
    end

    def todoset(project)
      todoset = project.todoset
      get(todoset.url, override_path: true)
    end
  end
end