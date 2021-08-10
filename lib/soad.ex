defmodule Soad do
  require Logger

  def listen(port) do
    {:ok, socket} =
      :gen_tcp.listen(port, [
        :binary,
        packet: :line,
        active: false,
        reuseaddr: true
      ])

    Logger.info("Listening on #{port}")
    accept(socket)
  end

  def accept(socket) do
    {:ok, conn} = :gen_tcp.accept(socket)
    spawn(fn -> serve(conn) end)
    accept(socket)
  end

  def serve(conn) do
    conn
    |> read_line()
    |> write_line(conn)

    serve(conn)
  end

  def read_line(socket) do
    {:ok, data} = :gen_tcp.recv(socket, 0)
    data
  end

  def write_line(line, socket) do
    :gen_tcp.send(socket, line)
  end
end
