class Scale
  def initialize(tonic, type, intervals = '')
    @tonic = tonic
    @type = type
  end

  def pitches
    if @tonic == 'C'
      return ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']
    end
    ['F', 'Gb', 'G', 'Ab', 'A', 'Bb', 'B', 'C', 'Db', 'D', 'Eb', 'E']
  end

  def name
    "#{@tonic.upcase} #{@type}"
  end
end
