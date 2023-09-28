defmodule Chat.Supervisor do
    use Supervisor
    
    def start_link(_arg) do
        DynamicSupervisor.start_link(__MODULE__, [], name: __MODULE__)
    end


    def start_player(id) do
        child_specification = %{
            id: id,
            start: {Chat.Player, :start_link, [[]]}
        }
        {:ok, pid} = DynamicSupervisor.start_link(__MODULE__, child_specification)
        Registry.register(:player_lookup_table, id, pid)
        {:ok, pid}
    end
    
    @impl true
    def init(_arg) do
        DynamicSupervisor.init(strategy: :one_for_one)
    end
end