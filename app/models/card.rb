class Card < ApplicationRecord
  def calc(dataset_id=nil, column=nil, where_column=nil, where_equals=nil, action=nil)
    if dataset_id == nil or column == nil or action == nil
      dataset_id = self.dataset_id
      column = self.column
      where_column = self.where_column
      where_equals = self.where_equals
      action = self.action
    end
    dataset = Dataset.find(dataset_id)
    if where_equals.to_i.to_s == where_equals
      equal_to = where_equals.to_i
    else
      equal_to = where_equals
    end
    data = dataset.select(column, where_column, equal_to)
    if action == 'sum'
      result = dataset.sum(data)
    elsif action == 'average'
      result = dataset.average(data)
    elsif action == 'percent'
      result = dataset.percent(data)
    elsif action == 'count'
      result = dataset.count(data)
    elsif action == 'length' # not clear what this is for
      result = dataset.list_length(data)
    elsif action == 'select'
      result = data
    elsif action == 'values'
      result = dataset.select_unique(data)
    end
    return result
  end

  def format_data(data)
    keys = data.keys
    x_axis_categories = ['x'] + keys

    chart_data = ["data"]
    keys.each do |key|
      chart_data.push(data[key])
    end
    return [x_axis_categories, chart_data]
  end




  def format_data_pie_donut(data)
    data_columns = []
    data.keys.each do |key|
      data_columns.push([key, data[key]])
    end

    return data_columns
  end

  def javacriptify_data()
    if self.chart_type == "bar_graph"
      return self.format_data(self.calc())
    elsif self.chart_type == "pie_chart"
      return self.format_data_pie_donut(self.calc())
    end

  end
end # END CLASS
