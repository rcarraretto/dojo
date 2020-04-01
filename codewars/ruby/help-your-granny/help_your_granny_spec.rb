describe 'tour' do
  it 'should be 0 for 0 friends' do
    friends = []
    towns = []
    dist = {}
    Test.assert_equals(tour(friends, towns, dist), 0)
  end

  it 'should vist 1 friend' do
    friends = ['A1']
    towns = [['A1', 'X1']]
    dist = Hash['X1', 100.2]
    Test.assert_equals(tour(friends, towns, dist), 200)
  end

  it 'should visit 2 friends' do
    friends = ['A1', 'A2']
    towns = [['A1', 'X1'], ['A2', 'X2']]
    dist = Hash['X1', 100.0, 'X2', 200.0]
    Test.assert_equals(tour(friends, towns, dist), 473)
  end

  it 'should visit 3 friends' do
    friends = ['A1', 'A2', 'A3']
    towns = [['A1', 'X1'], ['A2', 'X2'], ['A3', 'X3']]
    dist = Hash['X1', 100.0, 'X2', 200.0, 'X3', 250.0]
    Test.assert_equals(tour(friends, towns, dist), 673)
  end

  it 'should visit towns of friends' do
    friends = ['B1', 'B2']
    towns = [['B1', 'Y1'], ['B2', 'Y2'], ['B3', 'Y3'], ['B4', 'Y4'], ['B5', 'Y5']]
    dist = Hash['Y1', 50.0, 'Y2', 70.0, 'Y3', 90.0, 'Y4', 110.0, 'Y5', 150.0]
    Test.assert_equals(tour(friends, towns, dist), 168)
  end

  it 'should ignore a friend whose town is unknown' do
    friends = ['A1', 'A2', 'A3', 'A4', 'A5']
    towns = [['A1', 'X1'], ['A2', 'X2'], ['A3', 'X3'], ['A4', 'X4']]
    dist = Hash['X1', 100.0, 'X2', 200.0, 'X3', 250.0, 'X4', 300.0]
    Test.assert_equals(tour(friends, towns, dist), 889)
  end
end
