# mix run priv/repo/seeds.exs

alias Ostinato.Repo
alias Ostinato.Task
alias Ostinato.TaskCompletion

title = "Do something fun"
{:ok, task} = %Task{title: title} |> Repo.insert()

{:ok, completion1} =
  Repo.insert(%TaskCompletion{task_id: task.id, date: ~D[2018-01-01]})

{:ok, completion2} =
  Repo.insert(%TaskCompletion{task_id: task.id, date: ~D[2018-01-02]})

{:ok, completion3} =
  Repo.insert(%TaskCompletion{task_id: task.id, date: ~D[2018-01-03]})
