defmodule OstinatoTest do
  use ExUnit.Case
  import Ecto.Query
  alias Ostinato.{Query, Repo, Task, TaskCompletion}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Ostinato.Repo)
  end

  @title1 "Do something fun"

  test "query helpers work properly" do
    # Insert task
    task = Query.insert_task(@title1)

    # Query task
    assert Query.select_task(task.id) == task
    assert Query.select_task(task.id + 1) == :not_found

    # Insert completions
    completion1 = Query.insert_completion(task.id, ~D[2018-02-01])
    completion2 = Query.insert_completion(task.id, ~D[2018-02-02])
    completion3 = Query.insert_completion(task.id, ~D[2018-02-03])

    # Query completions separately
    assert Query.select_completion_by_task_and_date(task.id, ~D[2018-02-01]) ==
             completion1

    assert Query.select_completion_by_task_and_date(task.id, ~D[2018-02-02]) ==
             completion2

    assert Query.select_completion_by_task_and_date(task.id, ~D[2018-02-03]) ==
             completion3

    # Query non-existing completions
    assert Query.select_completion_by_task_and_date(
             task.id + 1,
             ~D[2018-02-03]
           ) == :not_found

    assert Query.select_completion_by_task_and_date(task.id, ~D[2018-03-03]) ==
             :not_found

    # Delete one completion
    %TaskCompletion{id: deleted_id} = Query.delete_completion(completion2)
    assert deleted_id == completion2.id

    assert Query.select_completion_by_task_and_date(task.id, ~D[2018-02-02]) ==
             :not_found
  end
end
