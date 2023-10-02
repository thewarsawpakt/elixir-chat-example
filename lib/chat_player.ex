defmodule Chat.Player do
  require Logger
  use GenServer

  @spec init(List) :: {:ok, []}
  def init(state) do
    {:ok, state}
  end

  def handle_info({sender, message}, state) do
    [{_, name}] = Registry.lookup(:player_lookup_table, sender)
    [{_, my_name}] = Registry.lookup(:player_lookup_table, self()) # TODO: optimize this out
    Logger.info("#{my_name} got message <#{message}> from #{name}")
    {:noreply, [message | state]}
  end

  @spec start_link(atom()) :: :ignore | {:error, any} | {:ok, pid}
  def start_link(name) do
    GenServer.start_link(__MODULE__, [], name: name)
  end
end
