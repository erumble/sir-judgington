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
        file_name = Time.now.strftime("%Y%m%d%H%M%S") + "_" + db + '.psql'
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
      backups = Dir.glob("#{backup_dir}/*").reject{|f| File.directory? f}.sort

      puts "###############\n# DB Backups: #\n###############"
      backups.each do |backup|
        puts File.basename(backup)
      end
    end

    desc "Restore the database from a backup"
    task :restore, [:file] => :environment do |task,args|
      if args.file.present?
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
            " #{backup_dir}/#{args.file}"
        end
        Rake::Task["db:drop"].invoke
        Rake::Task["db:create"].invoke
        puts cmd
        exec cmd
      else
        puts 'Please pass a date to the task'
      end
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

end

