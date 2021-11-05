defmodule Glific.Mailer.UserEmail do
  import Swoosh.Email

  def notify(user) do
    new()
    |> to({user.name, user.email})
    |> from({"Donald Lobo", "lobo@chintugudiya.org"})
    |> subject("Hello, Avengers!")
    |> html_body("<h1>Hello #{user.name}</h1>")
    |> text_body("Hello #{user.name}\n")
  end
end
