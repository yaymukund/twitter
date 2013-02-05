Fabricator(:tweet) do
  EXAMPLES = [
    "Roses are red.",
    "Violets are red.",
    "Bushes are red.",
    "My garden's on fire."
  ]

  content { sequence(:content) { |i| EXAMPLES[i % EXAMPLES.count] }}
  user
end
