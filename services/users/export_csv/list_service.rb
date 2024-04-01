# frozen_string_literal: true

module Users
  module ExportCsv
    class ListService
      include Utils::Contextable
      include Utils::Callable

      attr_accessor :context, :params

      with_context :current_user

      def initialize
        yield self
      end

      def call
        self
      end

      def data
        export_service.export_data
      end

      def csv_options
        {
          disposition: :inline,
          type: "text/csv",
          filename: filename
        }
      end

      private

      def filename
        @filename ||= "export_users_%s.csv" % [Time.current.strftime("%d_%m_%Y_%H_%M_%s")]
      end

      def export_options
        {
          header: {
            titles: ["your list of columns in needed sequence, same as SQL query has..."]
          }
        }
      end

      def query
        UsersFinder.call({ current_user: current_user }, params)
      end

      def export_service
        @export_service ||= Utils::CsvExport.new(query.to_sql, export_options).call
      end
    end
  end
end
