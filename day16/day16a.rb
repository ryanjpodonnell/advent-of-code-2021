class Packet
  attr_reader :remaining_string, :packet_version, :subpackets

  def initialize(binary)
    @input_string = binary.dup
    @remaining_string = binary.dup
    @packet_version = @remaining_string.slice!(0..2).to_i(2)
    @packet_type_id = @remaining_string.slice!(0..2).to_i(2)
    @subpackets = []

    literal_value || number_of_subpackets || length_of_subpackets
    create_subpackets_number
    create_subpackets_length
    value
  end

  def value
    if packet_type == :sum
      @subpackets.map(&:value).sum
    elsif packet_type == :product
      @subpackets.map(&:value).inject(:*)
    elsif packet_type == :minimum
      @subpackets.map(&:value).min
    elsif packet_type == :maximum
      @subpackets.map(&:value).max
    elsif packet_type == :greater_than
      @subpackets.first.value > @subpackets.last.value ? 1 : 0
    elsif packet_type == :less_than
      @subpackets.first.value < @subpackets.last.value ? 1 : 0
    elsif packet_type == :equal_to
      @subpackets.first.value == @subpackets.last.value ? 1 : 0
    elsif packet_type == :literal_value
      literal_value
    end
  end

  def create_subpackets_number
    return if number_of_subpackets.nil?

    number_of_subpackets.times do
      subpacket = Packet.new(@remaining_string)
      @remaining_string = subpacket.remaining_string
      @subpackets << subpacket
    end
  end

  def create_subpackets_length
    return if length_of_subpackets.nil?

    subpacket_string = @remaining_string.slice!(0..length_of_subpackets - 1)
    while subpacket_string.length.positive?
      subpacket = Packet.new(subpacket_string)
      @subpackets << subpacket
      subpacket_string = subpacket.remaining_string
    end
  end

  def packet_type
    return @packet_type if defined? @packet_type

    @packet_type = case @packet_type_id
                   when 0
                     :sum
                   when 1
                     :product
                   when 2
                     :minimum
                   when 3
                     :maximum
                   when 4
                     :literal_value
                   when 5
                     :greater_than
                   when 6
                     :less_than
                   when 7
                     :equal_to
                   end
  end

  def length_type_id
    return @length_type_id if defined? @length_type_id
    return unless packet_type != :literal_value

    @length_type_id = @remaining_string.slice!(0..0).to_i(2)
  end

  def length_type
    return @length_type if defined? @length_type
    return unless packet_type != :literal_value

    @length_type = if length_type_id.zero?
                     :length_of_subpackets
                   else
                     :number_of_subpackets
                   end
  end

  def length_of_subpackets
    return @length_of_subpackets if defined? @length_of_subpackets
    return unless packet_type != :literal_value
    return unless length_type == :length_of_subpackets

    @length_of_subpackets = @remaining_string.slice!(0..14).to_i(2)
  end

  def number_of_subpackets
    return @number_of_subpackets if defined? @number_of_subpackets
    return unless packet_type != :literal_value
    return unless length_type == :number_of_subpackets

    @number_of_subpackets = @remaining_string.slice!(0..10).to_i(2)
  end

  def literal_value
    return @literal_value if defined? @literal_value
    return unless packet_type == :literal_value

    binary_string = ''
    loop do
      value_string = @remaining_string.slice!(0..4)
      binary_string << value_string[1..-1]

      break_char = value_string[0]
      break if break_char == '0'
    end

    @literal_value = binary_string.to_i(2)
  end
end

module Day16a
  def solution(filename)
    binary_string = parse_input(filename)
    packet = Packet.new(binary_string)
    packet.value
  end

  def parse_input(filename)
    input = File.read(filename).chomp
    input.split('').map { |char| char.hex.to_s(2).rjust(4, '0') }.join
  end
end
