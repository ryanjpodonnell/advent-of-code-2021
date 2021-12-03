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
    rate_string([], 0, :most_significant_bit).to_i(2)
  end

  def epsilon_rate
    rate_string([], 0, :least_significant_bit).to_i(2)
  end

  def oxygen_generator_rating
    remainder_string(binary_reports.dup, 0, :most_significant_bit).to_i(2)
  end

  def co2_scrubber_rating
    remainder_string(binary_reports.dup, 0, :least_significant_bit).to_i(2)
  end

  def most_significant_bit(bits)
    zeroes, ones = bits.partition { |bit| bit == '0' }
    zeroes.count > ones.count ? '0' : '1'
  end

  def least_significant_bit(bits)
    most_significant_bit(bits) == '0' ? '1' : '0'
  end

  def number_of_bits_per_report
    binary_reports.first.split('').count
  end

  def rate_string(rate_bits, string_position, bit_method)
    return rate_bits.join if rate_bits.count == number_of_bits_per_report

    bits = bits_from_position(binary_reports, string_position)
    rate_string(rate_bits + [send(bit_method, bits)], string_position + 1, bit_method)
  end

  def remainder_string(reports, string_position, bit_method)
    return reports.first if reports.count == 1
    return reports.first if string_position == number_of_bits_per_report

    bits = bits_from_position(reports, string_position)
    significant_bit = send(bit_method, bits)
    reports.select! { |report| report.split('')[string_position] == significant_bit }

    remainder_string(reports, string_position + 1, bit_method)
  end

  def bits_from_position(collection, position)
    collection.map { |report| report.split('')[position] }
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
    file_data.readlines.map(&:chomp)
  end
end
