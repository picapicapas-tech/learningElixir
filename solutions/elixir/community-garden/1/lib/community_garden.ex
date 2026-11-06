# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(fn -> %{plots: [], next_id: 1} end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn state -> state.plots end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn state -> 
      plot = %Plot{plot_id: state.next_id, registered_to: register_to}
      new_state = %{state | plots: [plot | state.plots], next_id: state.next_id + 1}
      {plot, new_state}
    end)
  end

  def release(pid, plot_id) do
    Agent.get_and_update(pid, fn state -> 
      remaining_plots = Enum.reject(state.plots, fn plot -> plot.plot_id == plot_id end)
      new_state = %{state | plots: remaining_plots, next_id: state.next_id}
      {:ok, new_state}
    end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn state -> 
      Enum.find(state.plots, fn plot -> plot.plot_id == plot_id end) ||
        {:not_found, "plot is unregistered"}
    end)
  end
end
