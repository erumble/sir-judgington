class Contest < ActiveRecord::Base
  has_one :number_chalice
  has_many :entries
  has_many :contestants, through: :entries, source: :contestants
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :judging_times
  before_create :build_number_chalice
  after_create :initialize_categories, :initialize_judging_times

  def self.current
    where("date between ? and ?", Date.today.beginning_of_year, Date.today.end_of_year).first
  end

  def has_category?(category)
    categories.include? category
  end

  def has_judging_time?(judging_time, entry)
    available_judging_times(entry).include? judging_time
  end

  def available_judging_times(entry)
    time = [].tap do |row|
      judging_times.each do |jt|
        row << jt if entries.where(judging_time: jt).count < 4
      end
      if entry.judging_time && (!row.include? entry.judging_time)
        row << entry.judging_time #if (entry.judging_time) && !row.include? entry.judging_time)
      end
    end
  end

  def self.create_date_from_params(params)
    Contest.create! date: Date.new(*(%w(1 2 3).map { |e| params["date(#{e}i)"].to_i }))
  end

  def aquire_pristine_virgin_number_from_chalice(series)
    retries = 0
    begin
      chalice_of_glorious_numbers = number_chalice.reload
      num = chalice_of_glorious_numbers.send("next_#{series.to_s}".to_sym)
      chalice_of_glorious_numbers.update!(series.to_sym => num)
      num
    rescue ActiveRecord::StaleObjectError
      raise if retries >= 3
      retries += 1
      retry
    end
  end

  private

  def initialize_categories
    categories << Category.where(common: true)
  end

  def initialize_judging_times
    judging_times << JudgingTime.where(common: true)
  end

end
