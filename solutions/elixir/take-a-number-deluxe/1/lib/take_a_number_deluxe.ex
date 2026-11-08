defmodule TakeANumberDeluxe do
  use GenServer

  alias TakeANumberDeluxe.State

  # Client API

  def start_link(init_arg) do
    GenServer.start_link(__MODULE__, init_arg)
  end

  def report_state(machine), do: GenServer.call(machine, :report_state)

  def queue_new_number(machine), do: GenServer.call(machine, :queue_new_number)

  def serve_next_queued_number(machine, priority_number \\ nil) do
    GenServer.call(machine, {:serve_next_queued_number, priority_number})
  end

  def reset_state(machine), do: GenServer.cast(machine, :reset_state)

  # Server callbacks

  @impl GenServer
  def init(init_arg) do
    min_number = Keyword.get(init_arg, :min_number)
    max_number = Keyword.get(init_arg, :max_number)
    timeout = Keyword.get(init_arg, :auto_shutdown_timeout, :infinity)

    case State.new(min_number, max_number, timeout) do
      {:ok, state} -> {:ok, state, state.auto_shutdown_timeout}
      {:error, error} -> {:stop, error}
    end
  end

  @impl GenServer
  def handle_call(:report_state, _from, state) do
    {:reply, state, state, state.auto_shutdown_timeout}
  end

  def handle_call(:queue_new_number, _from, state) do
    case State.queue_new_number(state) do
      {:ok, new_number, new_state} ->
        {:reply, {:ok, new_number}, new_state, new_state.auto_shutdown_timeout}

      {:error, error} ->
        {:reply, {:error, error}, state, state.auto_shutdown_timeout}
    end
  end

  def handle_call({:serve_next_queued_number, priority_number}, _from, state) do
    case State.serve_next_queued_number(state, priority_number) do
      {:ok, next_number, new_state} ->
        {:reply, {:ok, next_number}, new_state, new_state.auto_shutdown_timeout}

      {:error, error} ->
        {:reply, {:error, error}, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_cast(:reset_state, state) do
    {:ok, new_state} =
      State.new(state.min_number, state.max_number, state.auto_shutdown_timeout)

    {:noreply, new_state, new_state.auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_info(:timeout, state) do
    {:stop, :normal, state}
  end

  def handle_info(_message, state) do
    {:noreply, state, state.auto_shutdown_timeout}
  end
end