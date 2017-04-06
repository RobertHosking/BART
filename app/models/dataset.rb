class Dataset < ApplicationRecord
    serialize :columns, Array # allows :columns to be stored as an array
    serialize :display_columns, Array

    #####
    # BEGIN DATASET CREATE METHODS
    #####
    def write_columns_to_sheet
      # Opens working copy spreadsheet, updates column names, and writes changes
      require 'rubyXL'
      workbook = RubyXL::Parser.parse(self.working_file)
      worksheet = workbook[0]
      self.columns.each_with_index do |val, col|
        worksheet.add_cell(0, col, val)
      end
      workbook.write(self.working_file)
    end

    def self.write_to(f_path, content)
      # Writes content to file
      # Parms:
      # +f_path+ full file path from root
      # +content+ content to write to file
      FileUtils::mkdir_p(File.dirname(f_path)) unless File.directory?(File.dirname(f_path))
        File.open(f_path, 'wb') do |file|
            file.write(content)
        end
    end

    def self.yaml_to_sheet(yaml_file) #WORK IN PROGRESS
      # Returns a roo object from a yaml file
      # Params:
      # +yaml_file+ yaml object

      #require 'yaml2csv'
      require 'yaml'

      hash = YAML.load(File.read(yaml_file))
      columns = hash[0].keys
      oo = Roo::Spreadsheet.open(self.original_file)
      #set column names
      columns.each_with_index do |name, col|
        oo.set( 1, col, name )
      end

      return oo
    end

    def self.sheet_to_yaml(roo_object)
      # Returns a yaml object from a roo_object
      # Params:
      # +roo_object+ object created by Roo::Spreadsheet
        require 'roo'
        require 'yaml'
      yaml_hash = Hash.new

      roo_object.each_with_pagename do |name, sheet|
        num_columns = roo_object.last_column
        for i in 1..num_columns
          column_hash = Hash.new
          column = roo_object.column(i)
          header = column[0]
          column.each do |cell|
              yaml_hash[header] << cell
          end # cell
        end
      end
      return yaml_hash
    end
    #####
    # END DATASET CREATE METHODS
    #####


    ######
    # BEGIN YAML QUERYING HELPER METHODS
    #
    # The goal with the below functions is to mimic SQL queries
    #
    ######
    def hash
      require 'yaml'
      hash = YAML.load(File.read(self.yaml_file))
      return hash
    end

    def hash_where(column_name, column_value)
      # Returns new hash where column_name == column_value
      hash = self.hash
      result = Hash.new
      hash.each do |index, key|
        if key[column_name] == column_value
          result[index] = key
        end
      end
      return result
    end

    def get_columns
      # Returns a list of dataset column names
      hash = self.hash
      return columns = hash[0].keys
    end

    def select(column_name, where_column = nil, where_column_value = nil)
      # Returns column_name where sort_by_column == sort_by_column_value
      hash = self.hash
      entries = []
      if where_column != nil && where_column_value != nil
        # DO A SELECT WHERE
        hash.each do |index, key| # each row
          if key[where_column] == where_column_value
            entries << key[column_name]
          end
        end
      else
        #DO A REGULAR SELECT
        # Returns list of entries under column titled (column_name)
        # if index set, returns the index-th entry of the column
        hash.each do |index, key|
          entries << key[column_name]
        end
      end
      return entries
    end

    def count(data)
      # Does a select() for column_name and groups the result into a list of
      #     lists of like values
      # E.X. [a,b,b,a,b,c,c,d] => [[a,a],[b,b,b],[c,c],[d]]
      # self.select(column_name).group_by{|x| x}.values.sort
      # group_hash = Hash.new
      # group_hash.default = 0
      # data.each do |value|
      #   group_hash[value] = group_hash[value] + 1
      # end
      # return group_hash
      return data.reduce(Hash.new(0)) { |a, b| a[b] += 1; a }
    end

    def type_of(data)
      # Determines the data type of column_name
      #
      # Float, Integer => "Number"
      # Time           => "Time"
      # Else           => "String"
      def is_numeric?(obj)
        obj.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
      end
      def is_time?(obj)
        return DateTime.parse(obj) rescue nil
      end
      col_is_num = true
      col_is_time = true
      data.each do |cell|
        if is_numeric? cell
          next
        else
          col_is_num = false
          break
        end
      end
      if col_is_num
        return "Number"
      end
      data.each do |cell|
        if is_time? cell
          next
        else
          col_is_time = false
        end
      end
      if col_is_time
        return "Time"
      else
        return "String"
      end
    end


    def sum(data)
      # assuming type_of(data) == "Number", sums that data
      total = 0
      data.each do |cell|
        if cell.to_i.to_s == cell || cell.to_i == cell
          total += cell.to_i
        end
      end
      return total
    end

    def average(data)
      # assuming type_of(column_name) == "Number", averages that column
      total = self.sum(data).to_f
      len = data.length.to_f
      return total / len
    end

    def percent(data)
      percents = Hash.new
      count(data).each do |key, val|
        percents[key] = (val.to_f/data.length)* 100
      end
      return percents
    end

    def select_unique(data)
      unique_values = []
      count(data).each do |key, val|
        unique_values << key
      end
      return unique_values
    end

    def list_length(data)
      return data.length
    end
    ######
    # END YAML QUERYING HELPER METHODS
    ######





end #End Class
