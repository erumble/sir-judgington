namespace :db do

  desc "Drop, create, and seed the database"
  task :reset => :environment do
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
    Rake::Task["db:seed"].invoke
  end

  namespace :backup do
    desc "Create a database backup"
    task :create => :environment do
      cmd = nil
      with_config do |app, host, db, user|
        file_name = "#{Time.now.strftime("%Y%m%d%H%M%S")}_#{db}#{db_ext}"

        cmd = "pg_dump"\
          " --format=custom"\
          " --verbose"\
          " --host=#{host}"\
          " --username=#{user}"\
          " --dbname=#{db}"\
          " --file=#{backup_dir}/#{file_name}"
      end
      puts cmd
      exec cmd
    end

    desc "List the existing database backups"
    task :list => :environment do
      puts "###############\n# DB Backups: #\n###############"
      backup_files.each { |backup_file| puts backup_file }
    end

    desc "Restore the database from a backup"
    task :restore, [:file] => :environment do |task,args|
      backup_file = if backup_files.include? args.file
        args.file
      else
        backup_files.last
      end

      puts "Restoring backup file #{backup_file}"
      cmd = nil
      with_config do |app, host, db, user|
        cmd = "pg_restore"\
          " --format=custom"\
          " --verbose"\
          " --clean"\
          " --create"\
          " --host=#{host}"\
          " --username=#{user}"\
          " --dbname=#{db}"\
          " #{backup_dir}/#{backup_file}"
      end
      Rake::Task["db:drop"].invoke
      Rake::Task["db:create"].invoke
      puts cmd
      exec cmd
    end
  end

  private

  def with_config
    yield Rails.application.class.parent_name.underscore,
      ActiveRecord::Base.connection_config[:host],
      ActiveRecord::Base.connection_config[:database],
      ActiveRecord::Base.connection_config[:username]
  end

  def backup_dir
    "#{Rails.root}/db/backups"
  end

  def db_ext
    ".psql"
  end

  def backup_files
    Dir.glob("#{backup_dir}/*").reject { |f| File.extname(f) != db_ext }.map { |f| File.basename f }.sort
  end
end
