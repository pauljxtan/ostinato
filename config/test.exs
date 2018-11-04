use Mix.Config

config :ostinato, Ostinato.Repo,
  adapter: Sqlite.Ecto2,
  database: "ostinato_test.sqlite",
  pool: Ecto.Adapters.SQL.Sandbox
