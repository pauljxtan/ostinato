defmodule Ostinato do
  @moduledoc false
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [Ostinato.Repo]

    opts = [strategy: :one_for_one, name: Ostinato.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
