# ostinato

A simple daily task tracker with an Elixir/Trot backend and Vue.js frontend.

## Quick start

- Setup database: `mix ecto.setup`
- Start server: `mix trot.server`
- Open http://localhost:4000.

## Road map

High-priority:

- [x] Add and remove tasks (title only)
- [x] Toggle task completions
- [x] Adjust lookback days
- [ ] Edit task titles
- [ ] Improve styling

Medium-priority:

- [ ] Optimize data refreshes
- [ ] Refine data model
- [ ] Database backups
- [ ] Manually set displayed dates

Low-priority:

- [ ] Add and edit task descriptions

## Data

All data is stored in the relevant `ostinato_[env].sqlite` database to be perused at your pleasure.
