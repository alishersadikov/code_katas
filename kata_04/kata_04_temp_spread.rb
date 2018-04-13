class TempSpread
  attr_reader :loaded_file, :spreads_by_day
  attr_accessor :headers

  def initialize(file)
    @loaded_file = file
    @headers ||= []
    @spreads_by_day ||= {}
  end

  def determine_min_spread_day
    calculate_daily_spreads # populate the spreads
    # sorts by the spread ascending, gets the first element, spits out the day
    spreads_by_day.sort_by { |day| day[1]["Spread"] }.first.first
  end

  private

    def parse_data
      # Open the file, read it, map the lines by grabbing the first 14 chars
      File.open(loaded_file, File::RDONLY){|f| f.read }.lines.map { |line| line[0..13].split }
    end

    def calculate_daily_spreads
      prepared_data.each do |line|
        spreads_by_day[line[0]] = { headers[1] => line[1],
                                    headers[2] => line[2],
                                    "Spread" => (line[1].to_i - line[2].to_i).abs }
      end
    end

    def prepared_data
      raw_data = parse_data
      self.headers = raw_data.shift # stores and gets rid of the header array
      raw_data.shift # gets rid of the empty array
      raw_data
    end
end
