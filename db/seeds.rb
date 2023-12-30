friends = [
  { name: "Marget Jones", event: "Muesem", balance: -100 },
  { name: "Micheal Johnson", event: "Baseball game", balance: 75 },
  { name: "Mary Jane", event: "House of Pies", balance: -50 },
]

friends.each do |friend|
  Friend.create friend
  puts "creating cat #{friend}"
end
