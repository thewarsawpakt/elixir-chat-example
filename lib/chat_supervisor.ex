defmodule Chat.Supervisor do
    require Logger
    use DynamicSupervisor

    @spec start_link(any) :: :ignore | {:error, any} | {:ok, pid()}
    def start_link(_arg) do
        DynamicSupervisor.start_link(__MODULE__, [], name: __MODULE__)
    end


    @spec start_player(any) :: :error | {:ok, pid()}
    def start_player(id) do
        child_specification = %{
            id: id,
            start: {Chat.Player, :start_link, [id]}
        }
        {:ok, pid} = DynamicSupervisor.start_child(__MODULE__, child_specification)
        case Registry.register(:player_lookup_table, id, pid) do
            {:ok, _} ->
                Logger.info("NEW_PLAYER SUCCESS #{inspect pid}")
                {:ok, pid}
            {:error, _} ->
                Logger.info("NEW_PLAYER FAILED")
                :error
        end
    end

    @impl true
    def init(_arg) do
        DynamicSupervisor.init(strategy: :one_for_one)
    end
end
