defmodule Twitter.Tweet do
  @moduledoc false
  defstruct [id: nil, text: nil, timestamp: nil]

  @type t :: %__MODULE__{}
end
