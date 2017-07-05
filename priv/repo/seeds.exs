Learnit.Repo.delete_all Learnit.User

Learnit.User.changeset(%Learnit.User{}, %{name: "Dédé", email: "test@example.com", password: "secret", password_confirmation: "secret"})
|> Learnit.Repo.insert!
