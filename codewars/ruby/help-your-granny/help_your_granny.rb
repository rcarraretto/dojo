def tour(friends, friend_town, town_dist)
  return 0 if friends.empty?
  dists = dists_x0_xn(friends, friend_town, town_dist)
  (dists.first + inter_town_dist(dists) + dists.last).floor
end

def dists_x0_xn(friends, friend_town, town_dist)
  friend_town = friend_town.to_h
  visited_towns = friends.map { |f| friend_town[f] }.compact
  visited_towns.map { |t| town_dist[t] }
end

def inter_town_dist(dists)
  return 0 if dists.length == 1
  dists.each_cons(2)
    .map { |l, h| triangle_leg(h, l) }
    .reduce(:+)
end

def triangle_leg(hypotenuse, leg)
  Math.sqrt(hypotenuse**2 - leg**2)
end
