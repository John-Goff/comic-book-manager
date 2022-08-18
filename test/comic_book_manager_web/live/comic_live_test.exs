defmodule ComicBookManagerWeb.ComicLiveTest do
  use ComicBookManagerWeb.ConnCase

  import Phoenix.LiveViewTest
  import ComicBookManager.ComicsFixtures

  @create_attrs %{issue_number: 42, published_at: %{day: 17, month: 8, year: 2022}, read_percentage: 42}
  @update_attrs %{issue_number: 43, published_at: %{day: 18, month: 8, year: 2022}, read_percentage: 43}
  @invalid_attrs %{issue_number: nil, published_at: %{day: 30, month: 2, year: 2022}, read_percentage: nil}

  defp create_comic(_) do
    comic = comic_fixture()
    %{comic: comic}
  end

  describe "Index" do
    setup [:create_comic]

    test "lists all comics", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.comic_index_path(conn, :index))

      assert html =~ "Listing Comics"
    end

    test "saves new comic", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.comic_index_path(conn, :index))

      assert index_live |> element("a", "New Comic") |> render_click() =~
               "New Comic"

      assert_patch(index_live, Routes.comic_index_path(conn, :new))

      assert index_live
             |> form("#comic-form", comic: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#comic-form", comic: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.comic_index_path(conn, :index))

      assert html =~ "Comic created successfully"
    end

    test "updates comic in listing", %{conn: conn, comic: comic} do
      {:ok, index_live, _html} = live(conn, Routes.comic_index_path(conn, :index))

      assert index_live |> element("#comic-#{comic.id} a", "Edit") |> render_click() =~
               "Edit Comic"

      assert_patch(index_live, Routes.comic_index_path(conn, :edit, comic))

      assert index_live
             |> form("#comic-form", comic: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#comic-form", comic: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.comic_index_path(conn, :index))

      assert html =~ "Comic updated successfully"
    end

    test "deletes comic in listing", %{conn: conn, comic: comic} do
      {:ok, index_live, _html} = live(conn, Routes.comic_index_path(conn, :index))

      assert index_live |> element("#comic-#{comic.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#comic-#{comic.id}")
    end
  end

  describe "Show" do
    setup [:create_comic]

    test "displays comic", %{conn: conn, comic: comic} do
      {:ok, _show_live, html} = live(conn, Routes.comic_show_path(conn, :show, comic))

      assert html =~ "Show Comic"
    end

    test "updates comic within modal", %{conn: conn, comic: comic} do
      {:ok, show_live, _html} = live(conn, Routes.comic_show_path(conn, :show, comic))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Comic"

      assert_patch(show_live, Routes.comic_show_path(conn, :edit, comic))

      assert show_live
             |> form("#comic-form", comic: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        show_live
        |> form("#comic-form", comic: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.comic_show_path(conn, :show, comic))

      assert html =~ "Comic updated successfully"
    end
  end
end
