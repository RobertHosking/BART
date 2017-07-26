require 'sidekiq/web'

class HardWorker
  include Sidekiq::Worker
  sidekiq_options retry:false
  
  
  

   def perform()
     #TODO sidekiq 
     require 'roo'
     require 'roo-xls'
     Dataset.sheet_to_database(Roo::Spreadsheet.open(@dataset[:original_file], extension: :xlsx))
     
     '''
      Dataset.sheet_to_database()
      serialize :columns, Array # allows :columns to be stored as an array
      # Returns a yaml object from a roo_object
      # Params:
      # +roo_object+ object created by Roo::Spreadsheet
  
      
      roo_object=Roo::Spreadsheet.open(dataset[:original_file], extension: :xlsx)
      
          
      col_model = Column.new(column_name: "sher", dataset_id: dataset.id) #storing each column into the database table called Column
      col_model.save
        
      
        roo_object.each_with_pagename do |name, sheet|
        
        num_columns = roo_object.last_column
        for i in 1..num_columns
          column_arr = []   #each element of a specific column will be stored here; 
          column = roo_object.column(i)
          
          header = column[0]
          for c in 1..roo_object.last_row()-1
            column_arr << column[c]
          end
          
          #check if column exist in database to prevent duplicates
          if header.nil?
            header=""
          end
          
          col_model = Column.new(column_name: header, dataset_id: dataset.id) #storing each column into the database table called Column
          col_model.save
     
          row_num=0
          for each_data in column_arr
            row_num+=1
            if each_data.nil? 
                each_data=""
            end
            if Element.find_by(data: each_data) != nil #check if data already exists in the database
              row_model = Rowelement.new(dataset_id: dataset, row_number: row_num, column_id: col_model.id, element_id:Element.find_by(data: each_data).id)
              row_model.save
    
            else
              #create new data 
              element_new   = Element.new(data: each_data) #storing each dataelement into the database table called Element
              element_new.save
              
              row_model = Rowelement.new(dataset_id: dataset.id, row_number: row_num, column_id: col_model.id, element_id: element_new.id)
              row_model.save
            end
          end
          
        end
      end
  '''    
   end
  
end
  