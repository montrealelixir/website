defmodule Twitter.Tweet do
  @moduledoc false
  @derive Jason.Encoder
  defstruct id: nil, text: nil, timestamp: nil

  @type t :: %__MODULE__{}
end
