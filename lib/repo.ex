defmodule Ostinato.Repo do
  @moduledoc false
  use Ecto.Repo,
    otp_app: :ostinato,
    adapter: Sqlite.Ecto2
end
