# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     FrajBot.Repo.insert!(%FrajBot.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias FrajBot.Reddit

~w(
  anal asshole datgap gettingherselfoff gonewild happygaps homemadexxx
  jilling lesbians mmgirls nsfw NSFW_Snapchat PetiteGoneWild
  pussy RealGirls rearpussy simps StraightGirlsPlaying
)
|> Enum.each(fn topic ->
  Reddit.create_topic(%{name: topic})
end)
