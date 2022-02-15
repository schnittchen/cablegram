defmodule Cablegram.InputFile do
  # Struct to describe an upload. Use `from_file` or `from_binary` to build.
  # Only one InputFile can be used in the params of a request.
  #
  # When uploading from an URL, simply pass that URL as a string instead of using this module.

  defstruct [:path, :binary, :name, :filename]

  # opts: [filename: optional_possibly_shown_name] (for both functions)

  def from_file(path, opts \\ []) do
    opts = Keyword.validate!(opts, filename: "")

    struct!(__MODULE__, [{:path, path} | opts])
  end

  def from_binary(binary, opts \\ []) do
    opts = Keyword.validate!(opts, filename: "")

    struct!(__MODULE__, [{:binary, binary} | opts])
  end
end
