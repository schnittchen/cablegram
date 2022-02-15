defmodule Cablegram.InputFile do
  @moduledoc """
  A file upload, to be used as a request parameter.

  Use `from_file` or `from_binary` to build. For both functions, you can pass
  a `filename` option which Telegram in some cases uses as the file name shown to the user.

  If you want to upload from a URL, provide that URL instead as a string parameter,
  as documented in the Telegram Bot API documentation.
  """

  defstruct [:path, :binary, :name, :filename]

  @doc """
  Build an input file from a path, pointing to a file on disk.

  Pass a `filename` option if you want to give the upload a file name.
  """
  def from_file(path, opts \\ []) do
    opts = Keyword.validate!(opts, filename: "")

    struct!(__MODULE__, [{:path, path} | opts])
  end

  @doc """
  Build an input file from a binary, usually a string.

  Pass a `filename` option if you want to give the upload a file name.
  """
  def from_binary(binary, opts \\ []) do
    opts = Keyword.validate!(opts, filename: "")

    struct!(__MODULE__, [{:binary, binary} | opts])
  end
end
