class Dataset < ApplicationRecord
    has_many :sections
    has_many :entries

    def self.sheet_to_db(roo_object)
        require 'roo'
        # get headers
        header = roo_object.row(1)
        # iterate pages in a sheet
        roo_object.each_with_pagename do |name, sheet|
            # iterate rows
            row = 0
            (2..roo_object.last_row).each do |i|
              entry = Entry.new
              
              # map spreadsheet columns to values 1:1
              entry.save
            end # row
        end # sheet
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
            sheet_hash = Hash[] # a single sheet
            row = 0
            for i in 2..roo_object.last_row()
              row_hash = Hash[] # a single row
              # iterate cells in a row
              col = 0
              roo_object.row(i).each do |cell|
                  row_hash.store(header[col], cell)
                  col += 1
              end # cell
              sheet_hash.store(row ,row_hash)
              row += 1
            end # row
            yaml_hash.store(sheet, sheet_hash)
        end # sheet
        return yaml_hash
    end

end
