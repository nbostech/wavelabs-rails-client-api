module Com
  module Nbos
    module Orm
      module ActiveRecord

        def create_activerecord_class table_name, base_class
          Class.new(base_class) do
            set_table_name table_name
          end
        end

      end
    end
  end
end