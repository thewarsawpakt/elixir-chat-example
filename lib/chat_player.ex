defmodule Chat.Player do
  require Logger
  use GenServer

  @spec init(List) :: {:ok, []}
  def init(state) do
    {:ok, state}
  end

  def handle_info({sender, message}, state) do
    Logger.info("#{inspect self()} got message #{message} from #{inspect sender}")
    {:noreply, [message | state]}
  end

  @spec start_link(atom()) :: :ignore | {:error, any} | {:ok, pid}
  def start_link(name) do
    GenServer.start_link(__MODULE__, [], name: name)
  end
end
