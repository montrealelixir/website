defmodule Twitter.Tweet do
  defstruct [id: nil, text: nil, timestamp: nil]

  @type t :: %__MODULE__{}
end
