class Dataset < ApplicationRecord
    serialize :columns, Array # allows :columns to be stored as an array
    serialize :display_columns, Array
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

    def get_columns
      # Returns a list of dataset column names
      require 'yaml'
      hash = YAML.load(File.read(self.yaml_file))
      return columns = hash[0].keys
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
      #hash.each_with_index do |row, row_num|
      #  row..each_with_index do |value, col|
      #    oo.set( row, col, value )
      #  end
      #end
      return oo
    end

    def self.sheet_to_yaml(roo_object)
      # Returns a yaml object from a roo_object
      # Params:
      # +roo_object+ object created by Roo::Spreadsheet
        require 'roo'
        require 'yaml'
        # get headers
        header = roo_object.row(1)
        # iterate pages in a sheet
        yaml_hash = Hash[] # the whole hash
        row_hash = Hash[]
        col_hash = Hash[]
        roo_object.each_with_pagename do |name, sheet|
            # iterate rows
            row = 0
            for i in 2..roo_object.last_row()
              row_hash = Hash[] # a single row
              # iterate cells in a row
              col = 0
              roo_object.row(i).each do |cell|
                  row_hash.store(header[col], cell)
                  col += 1
              end # cell
              yaml_hash.store(row ,row_hash)
              row += 1
            end # row
        end # sheet
        return yaml_hash.to_yaml
    end

    ######
    # BEGIN YAML QUERYING HELPER METHODS
    ######

    def column(column_name)
      # Returns list of entries under column titled (column_name)
      require 'yaml'
      hash = YAML.load(File.read(self.yaml_file))
      entries = []
      hash.each do |index, key|
        entries << key[column_name]
      end
      return entries
    end

    def group(column_name)
      self.column(column_name).group_by{|x| x}.values.sort
    end

    def count(column_name)
      col = self.group(column_name)
      count_list = []
      .group_by{|x| x}.values.sort
      col.each do |group|
        count_list << [group[0], group.length]
      end
      return count_list
    end



end #End Class
