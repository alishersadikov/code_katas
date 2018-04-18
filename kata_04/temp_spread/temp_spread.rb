class TempSpread
  attr_reader   :loaded_file, :spreads, :sub_string,
                :start_char, :end_char, :column_1, :column_2
  attr_accessor :headers

  def initialize(file, start_char, end_char, column_1, column_2)
    @loaded_file = file
    @start_char = start_char
    @end_char = end_char
    @column_1 = column_1
    @column_2 = column_2
    @headers ||= []
    @spreads ||= {}
  end

  def determine_min_spread_day
    calculate_daily_spreads # populate the spreads
    # sorts by the spread ascending, gets the first element, spits out the day
    spreads.sort_by { |day| day[1]["Spread"] }.first.first
  end

  private

    def parse_data
      # Open the file, read it, extract substring, reject if invalid
      File.open(loaded_file, File::RDONLY){|f| f.read }.lines.map do |line|
        sub_str = line[start_char.to_i..end_char.to_i].gsub(/[^0-9a-z ]/i, '')
        sub_str.split unless sub_str.strip.empty?
      end.compact
    end

    def calculate_daily_spreads
      prepared_data.each do |line|
        line_data = {}

        counter = 1
        while counter < line.size
          line_data.store(headers[counter], line[counter])
          counter += 1
        end

        line_data.store("Spread", (line[headers.index(column_1)].to_i -
                                   line[headers.index(column_2)].to_i).abs)

        spreads[line[0]] = line_data
      end
    end

    def prepared_data
      raw_data = parse_data
      self.headers = raw_data.shift # stores and gets rid of the header array
      raw_data
    end
end
