defmodule ProposerBehaviour do
  @callback prepare(String.t()) :: {:ok, term} | {:error, String.t()}
  @callback accept(String.t()) :: {:ok, term} | {:error, String.t()}
end
