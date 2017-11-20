defmodule BankAccount do
  use GenServer

  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  def start_link do
    GenServer.start_link(__MODULE__, {0, :open})
  end

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    {:ok, acc} = BankAccount.start_link()
    acc
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    GenServer.cast(account, {:close})
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    GenServer.call(account, {:balance})
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    GenServer.call(account, {:update, amount})
  end

  # Server callbacks
  def handle_call({:balance}, _from, {cur_balance, :open} = state) do
    {:reply, cur_balance, state}
  end

  def handle_call({:balance}, _from, {_cur_balance, :closed} = state) do
    {:reply, {:error, :account_closed}, state}
  end

  def handle_call({:update, amount}, _from, {cur_balance, :open}) do
    new_balance = cur_balance + amount
    {:reply, new_balance, {new_balance, :open}}
  end

  def handle_call({:update, _amount}, _from, {_cur_balance, :closed} = state) do
    {:reply, {:error, :account_closed}, state}
  end

  def handle_cast({:close}, {ammount, :open}) do
    {:noreply, {ammount, :closed}}
  end
end
