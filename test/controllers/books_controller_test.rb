require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get books_index_url
    assert_response :success
  end

  test "should get new" do
    get books_new_url
    assert_response :success
  end

  test "should create book when logged in" do
    user = User.create!(
      name: "Ana",
      email: "ana@example.com",
      password: "secret123",
      password_confirmation: "secret123"
    )

    post session_url, params: { email: user.email, password: "secret123" }

    assert_difference("Book.count", 1) do
      post books_url, params: {
        book: {
          title: "O Livro",
          author: "A Autora",
          published_year: 2020
        }
      }
    end

    assert_redirected_to root_path
  end
end
