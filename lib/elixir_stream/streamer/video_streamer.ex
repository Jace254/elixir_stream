defmodule ElixirStream.VideoStreamer do
  use GenServer

  def start_link(dir \\ "chunk/*.webm") do
    files = Path.wildcard(dir)
    IO.inspect(files, label: "Matched files")

    if files == [] do
      {:error, :no_files_found}
    else
      GenServer.start_link(__MODULE__, files, name: __MODULE__)
    end
  end

  def init(files) do
    {:ok, files}
  end

  def start() do
    GenServer.cast(__MODULE__, :start)
  end

  def handle_cast(:start, files) do
    IO.inspect(files, label: "Files to stream")
    Task.start(fn -> blocking_start_stream(files) end)
    {:noreply, files}
  end

  def blocking_start_stream(files) do
    files
    |> Stream.map(&read_bytes/1)
    |> Stream.flat_map(&apply_filter/1)
    |> play
  end

  def read_bytes(file) do
    case File.read(file) do
      {:ok, content} -> [content]
      {:error, reason} -> IO.puts("Error reading file #{file}: #{reason}"); []
    end
  end

  def apply_filter(bytes) do
    opts = [in: bytes, out: :stream]
    %{"yay" => yays, "nay" => nays} = ElixirStream.Voter.get_results()
    %{out: out} = Porcelain.spawn("ffmpeg", [
      "-i", "-",
      "-f", "mpegts",
      "-b", "12000k",
      "-acodec", "copy",
      "-vf", "drawtext='fontfile=/Library/Fonts/Arial\\ Bold.ttf: \
            text=\'yays-#{yays} nays-#{nays} time-#{:os.system_time(:seconds)}\': \
            fontcolor=white: fontsize=72: box=1: boxcolor=black@0.5: \
            boxborderw=5: x=(w-text_w)/2: y=(h-text_h)'",
      "-"], opts)
    out
  end

  def play(bytes) do
    opts = [in: bytes]
    Porcelain.spawn_shell("ffmpeg -i - -acodec copy -f mpegts -b 12000k  - | ffplay - -x 1080 -y 720", opts)
  end
end
