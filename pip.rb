require 'date'
require 'cassandra'

class Pip

  module ClassMethods

    @@keyspace = 'pipsqueak'

    def pip(label, value)
      now = DateTime.now
      date = now.strftime('%F')
      timestamp = now.to_time
      statement = session.prepare('INSERT INTO pips_by_day (label, date, time, value) VALUES (?, ?, ?, ?)')
      session.execute(statement, arguments: [label, date, timestamp, value])
    end

    private

      def session
        @@session ||= Cassandra.cluster.connect(@@keyspace)
      end
  end

  extend ClassMethods

end
