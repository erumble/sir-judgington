namespace :csv do
  desc "Create CSV of contestants for lineup"
  task :create => :environment do
    csv_file = "#{Time.now.strftime("%Y%m%d%H%M%S")}_lineup.csv"

    puts "Generating #{csv_dir}/#{csv_file}"
    File.open("#{csv_dir}/#{csv_file}", 'w') { |f| f.write Entry.to_csv }
  end

  desc "List the existing lineup CSVs"
  task :list => :environment do
    puts "################\n# Lineup CSVs: #\n################"
    Dir.glob("#{csv_dir}/*").reject { |f| File.extname(f) != ".csv" }.map { |f| File.basename f }.sort.each { |csv_file| puts csv_file }
  end

  private

  def csv_dir
    "#{Rails.root}/data/csvs"
  end
end
