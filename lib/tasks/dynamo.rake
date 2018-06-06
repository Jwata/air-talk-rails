namespace :dynamo do
  desc 'Create dynamo tables'
  task :create_tables => :environment do
    migration = Aws::Record::TableMigration.new(Image)
    migration.create!(
      provisioned_throughput: {
        read_capacity_units: 1,
        write_capacity_units: 1
      }
    )
    migration.wait_until_available
  end
end
