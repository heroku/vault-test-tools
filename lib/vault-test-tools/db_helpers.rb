module Vault::Test
  module DB
    module Truncation
      def setup
        super
        truncate_tables!
      end

      def truncate_tables!
        db.tables.each do |table|
          db["truncate #{table}"]
        end
      end
    end

    module Transactiion
      def setup
        super
        db['begin']
      end

      def teardown
        super
        db['commit']
        db['rollback']
      end
    end
  end
end
