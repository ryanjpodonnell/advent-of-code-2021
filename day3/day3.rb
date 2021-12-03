class DiagnosticReport
  attr_reader :binary_reports

  def initialize(binary_reports)
    @binary_reports = binary_reports
  end

  def power_consumption
    gamma_rate * epsilon_rate
  end

  def life_support_rating
    oxygen_generator_rating * co2_scrubber_rating
  end

  private

  def gamma_rate
    rate_string(:most_significant_bit).to_i(2)
  end

  def epsilon_rate
    rate_string(:least_significant_bit).to_i(2)
  end

  def oxygen_generator_rating
    remainder_string(:most_significant_bit).to_i(2)
  end

  def co2_scrubber_rating
    remainder_string(:least_significant_bit).to_i(2)
  end

  def most_significant_bit(bits)
    zeroes_count = bits.select { |bit| bit == '0' }.count
    ones_count = bits.select { |bit| bit == '1' }.count

    zeroes_count > ones_count ? '0' : '1'
  end

  def least_significant_bit(bits)
    most_significant_bit(bits) == '0' ? '1' : '0'
  end

  def number_of_bits_per_report
    binary_reports.first.split('').count
  end

  def rate_string(bit_method)
    rate_bits = []

    string_position = 0
    while string_position < number_of_bits_per_report
      bits = binary_reports.map { |report| report.split('')[string_position] }
      rate_bits << send(bit_method, bits)

      string_position += 1
    end

    rate_bits.join
  end

  def remainder_string(bit_method)
    remaining_reports = binary_reports.dup

    string_position = 0
    while string_position < number_of_bits_per_report
      bits = remaining_reports.map { |report| report.split('')[string_position] }
      significant_bit = send(bit_method, bits)
      remaining_reports.select! { |report| report.split('')[string_position] == significant_bit }

      return remaining_reports.first if remaining_reports.count == 1

      string_position += 1
    end

    remaining_reports.first
  end
end

module Day3
  def part_1(filename)
    binary_reports = parse_input(filename)
    diagnostic_report = DiagnosticReport.new(binary_reports)
    diagnostic_report.power_consumption
  end

  def part_2(filename)
    binary_reports = parse_input(filename)
    diagnostic_report = DiagnosticReport.new(binary_reports)
    diagnostic_report.life_support_rating
  end

  def parse_input(filename)
    file_data = File.open(filename)
    file_data.readlines.map do |line|
      line.chomp
    end
  end
end
