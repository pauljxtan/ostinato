defmodule Ostinato.Router do
  @moduledoc false
  use Plug.Builder
  use Trot.Router
  use Trot.Template
  alias Ostinato.Query
  alias Ostinato.Task

  # @template_root "priv/templates"

  # Serves index page
  get "/" do
    render_template("index.html.eex", [])
  end

  # Returns all tasks
  get "/task" do
    tasks = Query.select_tasks_with_completions()
    Enum.map(tasks, &Task.encodable/1)
  end

  #! Using GETs for non-GET stuff because I'm lazy, it seems good enough for now

  # Adds a new task
  get "/task/:title" do
    Query.insert_task(title)
    %{:message => "Created task '#{title}'"}
  end

  # Deletes a task
  delete "/task/:task_id" do
    case Query.select_task(task_id) do
      :not_found ->
        %{:message => "Task id=#{task_id} not found"}

      task ->
        Query.delete_task(task)
        %{:message => "Deleted task '#{task.title}'"}
    end
  end

  # Toggles the completion for the given task and date
  get "/task/:task_id/:completion_date" do
    case Query.select_task(task_id) do
      :not_found ->
        %{:message => "Task id=#{task_id} not found"}

      task ->
        # Accept dates in the following formats: YYYY-MM-DD, YYYYMMDD
        date =
          case String.length(completion_date) do
            10 ->
              Date.from_iso8601!(completion_date)

            8 ->
              Date.from_iso8601!(
                "#{String.slice(completion_date, 0, 4)}-#{
                  String.slice(completion_date, 4, 2)
                }-#{String.slice(completion_date, 6, 2)}"
              )
          end

        case Query.select_completion_by_task_and_date(task.id, date) do
          :not_found ->
            # Add completion
            Query.insert_completion(task.id, date)
            %{:message => "Added completion for '#{task.title}' on #{date}"}

          completion ->
            # Remove completion
            Query.delete_completion(completion)
            %{:message => "Removed completion for #{task.title} on #{date}"}
        end
    end
  end

  import_routes(Trot.NotFound)
end
