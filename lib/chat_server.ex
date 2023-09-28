defmodule Chat.Server do
  @moduledoc """
  Supervisor responsible for handling chatters.
  """  

  use Application

  @impl true
  def start(_type, _args) do
    children = [
        Chat.Supervisor,
        {Registry, [keys: :unique, name: :player_lookup_table]}
    ]

    opts = [strategy: :one_for_one, name: __MODULE__]
    Supervisor.start_link(children, opts)
  end
end

