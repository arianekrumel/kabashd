class Gamestate
  @@states = Hash.new

  def self.getState(key)
    if @@states[key] != nil
      return @@states[key]
    else
      return "UNDEFINED"
    end
  end

  def self.setState(key, value)
    @@states[key] = value
  end

  def self.setDefaults()
    @@states["Location"] ="Hospital"
  end

end
