module Vault::Test
  module DB
    module Truncation
      def teardown
        super
        truncate_tables!
      end

      def truncate_tables!
        (db.tables - [:schema_migrations]).each do |table|
          db << "truncate #{table}"
        end
      end
    end
  end
end
