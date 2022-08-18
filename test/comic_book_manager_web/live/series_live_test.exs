defmodule ComicBookManagerWeb.SeriesLiveTest do
  use ComicBookManagerWeb.ConnCase

  import Phoenix.LiveViewTest
  import ComicBookManager.ComicsFixtures

  @create_attrs %{name: "some name", published_at: %{day: 17, month: 8, year: 2022}}
  @update_attrs %{name: "some updated name", published_at: %{day: 18, month: 8, year: 2022}}
  @invalid_attrs %{name: nil, published_at: %{day: 30, month: 2, year: 2022}}

  defp create_series(_) do
    series = series_fixture()
    %{series: series}
  end

  describe "Index" do
    setup [:create_series]

    test "lists all series", %{conn: conn, series: series} do
      {:ok, _index_live, html} = live(conn, Routes.series_index_path(conn, :index))

      assert html =~ "Listing Series"
      assert html =~ series.name
    end

    test "saves new series", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.series_index_path(conn, :index))

      assert index_live |> element("a", "New Series") |> render_click() =~
               "New Series"

      assert_patch(index_live, Routes.series_index_path(conn, :new))

      assert index_live
             |> form("#series-form", series: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#series-form", series: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.series_index_path(conn, :index))

      assert html =~ "Series created successfully"
      assert html =~ "some name"
    end

    test "updates series in listing", %{conn: conn, series: series} do
      {:ok, index_live, _html} = live(conn, Routes.series_index_path(conn, :index))

      assert index_live |> element("#series-#{series.id} a", "Edit") |> render_click() =~
               "Edit Series"

      assert_patch(index_live, Routes.series_index_path(conn, :edit, series))

      assert index_live
             |> form("#series-form", series: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#series-form", series: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.series_index_path(conn, :index))

      assert html =~ "Series updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes series in listing", %{conn: conn, series: series} do
      {:ok, index_live, _html} = live(conn, Routes.series_index_path(conn, :index))

      assert index_live |> element("#series-#{series.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#series-#{series.id}")
    end
  end

  describe "Show" do
    setup [:create_series]

    test "displays series", %{conn: conn, series: series} do
      {:ok, _show_live, html} = live(conn, Routes.series_show_path(conn, :show, series))

      assert html =~ "Show Series"
      assert html =~ series.name
    end

    test "updates series within modal", %{conn: conn, series: series} do
      {:ok, show_live, _html} = live(conn, Routes.series_show_path(conn, :show, series))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Series"

      assert_patch(show_live, Routes.series_show_path(conn, :edit, series))

      assert show_live
             |> form("#series-form", series: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        show_live
        |> form("#series-form", series: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.series_show_path(conn, :show, series))

      assert html =~ "Series updated successfully"
      assert html =~ "some updated name"
    end
  end
end
