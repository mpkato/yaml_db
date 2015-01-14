namespace :db do
  desc "Dump schema and data to db/schema.rb and db/data.yml"
  task(:dump => [ "db:schema:dump", "db:data:dump" ])

  desc "Load schema and data from db/schema.rb and db/data.yml"
  task(:load => [ "db:schema:load", "db:data:load" ])

  namespace :data do
    desc "Dump contents of database to db/data.extension (defaults to yaml)"
    task :dump => :environment do
      YamlDb::RakeTasks.data_dump_task
    end

    desc "Dump contents of a table to a given filepath (defaults to db/table_name.yml)"
    task :dump_table => :environment do
      table_name = ENV['table_name']
      raise ArgumentError.new('table_name is not given') if table_name.nil?
      filepath = ENV['filepath']
      filepath = "#{Rails.root}/db/#{table_name}.yml" if filepath.nil?
      YamlDb::RakeTasks.data_dump_table_task(table_name, filepath)
    end

    desc "Dump contents of database to curr_dir_name/tablename.extension (defaults to yaml)"
    task :dump_dir => :environment do
      YamlDb::RakeTasks.data_dump_dir_task
    end

    desc "Load contents of db/data.extension (defaults to yaml) into database"
    task :load => :environment do
      YamlDb::RakeTasks.data_load_task
    end

    desc "Load contents of a given filepath into database"
    task :load_table => :environment do
      filepath = ENV['filepath']
      raise ArgumentError.new('filepath is not given') if filepath.nil?
      YamlDb::RakeTasks.data_load_table_task(filepath)
    end

    desc "Load contents of db/data_dir into database"
    task :load_dir  => :environment do
      YamlDb::RakeTasks.data_load_dir_task
    end
  end
end
