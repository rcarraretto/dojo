def winner(candidates)
  return false if not valid_game?(candidates)
  winner = find_winner(candidates)
  return false if not winner
  winner['name']
end

def valid_game?(candidates)
  candidates.length == 3 && candidates.all? { |c| valid_candidate?(c) }
end

def valid_candidate?(candidate)
  candidate['name'] && valid_scores?(candidate)
end

def valid_scores?(candidate)
  scores = candidate['scores'] || []
  valid_num_rolls = [1, 2].include? scores.length
  valid_numbers = scores.all? { |score| score.between?(5, 100) && score % 5 == 0 }
  valid_num_rolls && valid_numbers
end

def find_winner(candidates)
  candidates.each { |c| calculate_score(c) }
  candidates.select! { |c| eligible_score?(c) }
  candidates.max_by { |c| score(c) }
end

def calculate_score(candidate)
  candidate[:result] = candidate['scores'].reduce(:+)
end

def eligible_score?(candidate)
  candidate[:result] <= 100
end

def score(candidate)
  candidate[:result]
end
