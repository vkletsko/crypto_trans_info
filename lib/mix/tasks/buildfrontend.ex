defmodule Mix.Tasks.Buildfrontend do
  @moduledoc """
    React frontend compilation and bundling for production.
  """
  use Mix.Task
  require Logger
  # Path for the frontend static assets that are being served
  # from our Phoenix router when accessing /app/* for the first time
  @public_path "./priv/static/www"

  @shortdoc "Compile and bundle React frontend for production"
  def run(_) do
    Logger.info("installing npm packages")
    System.cmd("npm", ["install", "--quiet"], cd: "./frontend")

    Logger.info("compiling React frontend")
    System.cmd("npm", ["run", "build"], cd: "./frontend")

    Logger.info("moving dist folder to Phoenix at #{@public_path}")
    # First clean up any stale files from previous builds if any
    System.cmd("rm", ["-rf", @public_path])
    System.cmd("cp", ["-R", "./frontend/dist", @public_path])

    Logger.info("React successfully built.")
  end


end
