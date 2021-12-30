defmodule TakeANumber do
  def start() do
    spawn(fn -> machine(0) end)
  end

  defp machine(state) do
    state =
      receive do
        {:report_state, pid} ->
          send(pid, state)
          state

        {:take_a_number, pid} ->
          new_state = state + 1
          send(pid, new_state)
          new_state

        :stop ->
          exit(:stop)

        _ ->
          state
      end

    machine(state)
  end
end
