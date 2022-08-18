defmodule ComicBookManagerWeb.PublisherLiveTest do
  use ComicBookManagerWeb.ConnCase

  import Phoenix.LiveViewTest
  import ComicBookManager.ComicsFixtures

  @create_attrs %{created_at: %{day: 17, month: 8, year: 2022}, name: "some name"}
  @update_attrs %{created_at: %{day: 18, month: 8, year: 2022}, name: "some updated name"}
  @invalid_attrs %{created_at: %{day: 30, month: 2, year: 2022}, name: nil}

  defp create_publisher(_) do
    publisher = publisher_fixture()
    %{publisher: publisher}
  end

  describe "Index" do
    setup [:create_publisher]

    test "lists all publishers", %{conn: conn, publisher: publisher} do
      {:ok, _index_live, html} = live(conn, Routes.publisher_index_path(conn, :index))

      assert html =~ "Listing Publishers"
      assert html =~ publisher.name
    end

    test "saves new publisher", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.publisher_index_path(conn, :index))

      assert index_live |> element("a", "New Publisher") |> render_click() =~
               "New Publisher"

      assert_patch(index_live, Routes.publisher_index_path(conn, :new))

      assert index_live
             |> form("#publisher-form", publisher: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#publisher-form", publisher: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.publisher_index_path(conn, :index))

      assert html =~ "Publisher created successfully"
      assert html =~ "some name"
    end

    test "updates publisher in listing", %{conn: conn, publisher: publisher} do
      {:ok, index_live, _html} = live(conn, Routes.publisher_index_path(conn, :index))

      assert index_live |> element("#publisher-#{publisher.id} a", "Edit") |> render_click() =~
               "Edit Publisher"

      assert_patch(index_live, Routes.publisher_index_path(conn, :edit, publisher))

      assert index_live
             |> form("#publisher-form", publisher: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#publisher-form", publisher: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.publisher_index_path(conn, :index))

      assert html =~ "Publisher updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes publisher in listing", %{conn: conn, publisher: publisher} do
      {:ok, index_live, _html} = live(conn, Routes.publisher_index_path(conn, :index))

      assert index_live |> element("#publisher-#{publisher.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#publisher-#{publisher.id}")
    end
  end

  describe "Show" do
    setup [:create_publisher]

    test "displays publisher", %{conn: conn, publisher: publisher} do
      {:ok, _show_live, html} = live(conn, Routes.publisher_show_path(conn, :show, publisher))

      assert html =~ "Show Publisher"
      assert html =~ publisher.name
    end

    test "updates publisher within modal", %{conn: conn, publisher: publisher} do
      {:ok, show_live, _html} = live(conn, Routes.publisher_show_path(conn, :show, publisher))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Publisher"

      assert_patch(show_live, Routes.publisher_show_path(conn, :edit, publisher))

      assert show_live
             |> form("#publisher-form", publisher: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        show_live
        |> form("#publisher-form", publisher: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.publisher_show_path(conn, :show, publisher))

      assert html =~ "Publisher updated successfully"
      assert html =~ "some updated name"
    end
  end
end
