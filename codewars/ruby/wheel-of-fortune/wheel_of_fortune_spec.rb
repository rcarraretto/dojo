c1 = {"name"=>"Bob", "scores"=>[10, 65]}
c2 = {"name"=>"Bill", "scores"=>[90, 5]}
c3 = {"name"=>"Charlie", "scores"=>[40, 55]}
Test.assert_equals(winner([c1, c2, c3]), "Bill")

c1 = {"name"=>"Bob", "scores"=>[10, 65]}
c2 = {"name"=>"Bill", "scores"=>[90, 10]}
c3 = {"name"=>"Charlie", "scores"=>[40, 55]}
Test.assert_equals(winner([c1, c2, c3]), "Bill")

c1 = {"name"=>"Bob", "scores"=>[10, 65]}
c2 = {"name"=>"Bill", "scores"=>[90, 15]}
c3 = {"name"=>"Charlie", "scores"=>[40, 55]}
Test.assert_equals(winner([c1, c2, c3]), "Charlie", "Score above 100 should be eliminated")

c1 = {"name"=>"Bob", "scores"=>[10, 65]}
c2 = {"name"=>"Bill", "scores"=>[10, 65]}
c3 = {"name"=>"Charlie", "scores"=>[10, 65]}
Test.assert_equals(winner([c1, c2, c3]), "Bob", "On tie, first one wins")

c1 = {"name"=>"Bob", "scores"=>[100]}
c2 = {"name"=>"Bill", "scores"=>[10, 65]}
c3 = {"name"=>"Charlie", "scores"=>[10, 65]}
Test.assert_equals(winner([c1, c2, c3]), "Bob", "Should accept single roll")

Test.assert_equals(false, winner([]), "Should not accept less than 3 candidates")
Test.assert_equals(winner([c1, c2, c3, c1]), false, "Should not accept more than 3 candidates")

c1 = {"name"=>"Bob", "scores"=>[]}
c2 = {"name"=>"Bill", "scores"=>[10, 65]}
c3 = {"name"=>"Charlie", "scores"=>[10, 65]}
Test.assert_equals(winner([c1, c2, c3]), false, "Candidate must roll at least once")

c1 = {"name"=>"Bob", "scores"=>[10, 10, 10]}
c2 = {"name"=>"Bill", "scores"=>[10, 65]}
c3 = {"name"=>"Charlie", "scores"=>[10, 65]}
Test.assert_equals(winner([c1, c2, c3]), false, "Candidates cannot roll more than twice")

c1 = {"name"=>"Bob", "scores"=>[7, 10]}
c2 = {"name"=>"Bill", "scores"=>[10, 65]}
c3 = {"name"=>"Charlie", "scores"=>[10, 65]}
Test.assert_equals(winner([c1, c2, c3]), false, "Should check scores are multiples of 5")

c1 = {"name"=>"Bob", "scores"=>[0, 10]}
c2 = {"name"=>"Bill", "scores"=>[10, 65]}
c3 = {"name"=>"Charlie", "scores"=>[10, 65]}
Test.assert_equals(winner([c1, c2, c3]), false, "Should check score is at least 5")

c1 = {"name"=>"Bob", "scores"=>[105]}
c2 = {"name"=>"Bill", "scores"=>[105]}
c3 = {"name"=>"Charlie", "scores"=>[10]}
Test.assert_equals(winner([c1, c2, c3]), false, "Should check score is at most 100")

c1 = {"name"=>"Bob"}
c2 = {"name"=>"Bill", "scores"=>[105]}
c3 = {"name"=>"Charlie", "scores"=>[10]}
Test.assert_equals(winner([c1, c2, c3]), false, "Should check if candidate has score")

c1 = {"scores"=>[10, 5]}
c2 = {"name"=>"Bill", "scores"=>[100, 5]}
c3 = {"name"=>"Charlie", "scores"=>[100, 5]}
Test.assert_equals(winner([c1, c2, c3]), false, "Should check if candidate has name")

c1 = {"name"=>"Bob", "scores"=>[100, 5]}
c2 = {"name"=>"Bill", "scores"=>[100, 5]}
c3 = {"name"=>"Charlie", "scores"=>[100, 5]}
Test.assert_equals(winner([c1, c2, c3]), false, "If everyone scored more than 100, there's no winner")
