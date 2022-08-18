defmodule ComicBookManagerWeb.UniverseLiveTest do
  use ComicBookManagerWeb.ConnCase

  import Phoenix.LiveViewTest
  import ComicBookManager.ComicsFixtures

  @create_attrs %{first_published_at: %{day: 17, month: 8, year: 2022}, name: "some name"}
  @update_attrs %{first_published_at: %{day: 18, month: 8, year: 2022}, name: "some updated name"}
  @invalid_attrs %{first_published_at: %{day: 30, month: 2, year: 2022}, name: nil}

  defp create_universe(_) do
    universe = universe_fixture()
    %{universe: universe}
  end

  describe "Index" do
    setup [:create_universe]

    test "lists all universes", %{conn: conn, universe: universe} do
      {:ok, _index_live, html} = live(conn, Routes.universe_index_path(conn, :index))

      assert html =~ "Listing Universes"
      assert html =~ universe.name
    end

    test "saves new universe", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.universe_index_path(conn, :index))

      assert index_live |> element("a", "New Universe") |> render_click() =~
               "New Universe"

      assert_patch(index_live, Routes.universe_index_path(conn, :new))

      assert index_live
             |> form("#universe-form", universe: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#universe-form", universe: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.universe_index_path(conn, :index))

      assert html =~ "Universe created successfully"
      assert html =~ "some name"
    end

    test "updates universe in listing", %{conn: conn, universe: universe} do
      {:ok, index_live, _html} = live(conn, Routes.universe_index_path(conn, :index))

      assert index_live |> element("#universe-#{universe.id} a", "Edit") |> render_click() =~
               "Edit Universe"

      assert_patch(index_live, Routes.universe_index_path(conn, :edit, universe))

      assert index_live
             |> form("#universe-form", universe: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#universe-form", universe: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.universe_index_path(conn, :index))

      assert html =~ "Universe updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes universe in listing", %{conn: conn, universe: universe} do
      {:ok, index_live, _html} = live(conn, Routes.universe_index_path(conn, :index))

      assert index_live |> element("#universe-#{universe.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#universe-#{universe.id}")
    end
  end

  describe "Show" do
    setup [:create_universe]

    test "displays universe", %{conn: conn, universe: universe} do
      {:ok, _show_live, html} = live(conn, Routes.universe_show_path(conn, :show, universe))

      assert html =~ "Show Universe"
      assert html =~ universe.name
    end

    test "updates universe within modal", %{conn: conn, universe: universe} do
      {:ok, show_live, _html} = live(conn, Routes.universe_show_path(conn, :show, universe))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Universe"

      assert_patch(show_live, Routes.universe_show_path(conn, :edit, universe))

      assert show_live
             |> form("#universe-form", universe: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        show_live
        |> form("#universe-form", universe: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.universe_show_path(conn, :show, universe))

      assert html =~ "Universe updated successfully"
      assert html =~ "some updated name"
    end
  end
end
