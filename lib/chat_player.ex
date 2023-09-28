defmodule Chat.Player do
  use GenServer

  @spec init(List) :: {:ok, []}
  def init(state) do
    {:ok, state}
  end

  def handle_call({sender, message}, _from, state) do
    send(sender, {:response, :ack})
    {:reply, :ok, [message | state]}
  end

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def send_message(pid, message) do
    GenServer.call(__MODULE__, {pid, message})
  end
end