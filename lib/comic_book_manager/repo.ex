defmodule ComicBookManager.Repo do
  use Ecto.Repo,
    otp_app: :comic_book_manager,
    adapter: Ecto.Adapters.SQLite3
end
