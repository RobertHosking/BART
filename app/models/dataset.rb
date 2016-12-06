class Dataset < ApplicationRecord
    has_many :sections
    has_many :entries

    def self.sheet_to_db(roo_object)
        require 'roo'
        roo_object.each_with_pagename do |name, sheet|
            for i in 2..roo_object.last_row()
              entry = Entry.new
              roo_object.row(i).each_with_index do |cell, index|
                  entry.attributes[index] = cell
              end # cell
            end # row
        end # sheet

    end

    def self.sheet_to_yaml(roo_object)
      require 'roo'
      require 'yaml'
      header = roo_object.row(1)
      yaml_string = "entries: \n"

      roo_object.each_with_pagename do |name, sheet|
        for i in 2..roo_object.last_row()
          col = 0
          roo_object.row(i).each do |cell|
            if col == 0
              yaml_string << "- #{header[col]}: '#{cell}'\n"
            else
              yaml_string << "#{header[col]}: '#{cell}'\n"
            end
            col += 1
          end
        end
      end
      return yaml_string
    end

    def self.sheet_to_hash(roo_object)
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
        return yaml_hash
    end

end
