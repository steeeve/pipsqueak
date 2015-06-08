require 'date'
require 'cassandra'
require 'json'

class Pip

  attr_accessor :label, :time, :value

  def initialize(params)
    params.each do |key, value|
      instance_variable_set("@#{key}", value) unless value.nil?
    end
  end

  def to_json(*a)
    {
      label: label,
      time: time,
      value: value
    }.to_json(*a)
  end

  module ClassMethods

    @@keyspace = 'pipsqueak'

    def pip(label, value)
      now = DateTime.now
      date = now.strftime('%F')
      timestamp = now.to_time
      statement = session.prepare('INSERT INTO pips_by_day (label, date, time, value) VALUES (?, ?, ?, ?)')
      session.execute(statement, arguments: [label, date, timestamp, value])
    end

    def find(from_s, to_s)
      from = DateTime.parse(from_s)
      to = DateTime.parse(to_s)
      from_time = from.to_time
      to_time = to.to_time
      statement = session.prepare('SELECT * ' \
                                  'FROM pips_by_day ' \
                                  'WHERE time > ? ' \
                                  'AND time < ? ' \
                                  'ALLOW FILTERING')
      results = session.execute(statement, arguments: [from_time, to_time])

      results.map do |row|
        Pip.new(row)
      end
    end

    private

      def session
        @@session ||= Cassandra.cluster.connect(@@keyspace)
      end
  end

  extend ClassMethods

end
