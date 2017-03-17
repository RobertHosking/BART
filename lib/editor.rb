module Editor
  def text_parse(html_content)

  end

  def do_math(var)
    dataset_id,column,action = var.split("/")
    evaluate(dataset_id,column, action)
  end

  def self.evaluate(dataset_id, column, action) # var = "/dataset/column/action"
    dataset = Dataset.find(dataset_id)
      if action == 'sum'
        result = dataset.sum(column)
      elsif action == 'average'
        result = dataset.average(column)
      elsif action == 'percent'
        result = dataset.sum(column)
      elsif action == 'count'
        result = dataset.count(column)
      elsif action == 'length'
        result = dataset.list_length(column)
      end
      return result
  end

  def replace_var(content, original_var, new_var)
    return content.gsub(original_var, new_var)
  end

  def get_var(content, delimiter)
    content_variables = []
    if content.scan(/(?=#{delimiter})/).count.odd?
      raise "Unexpected #{delimiter} in text content"
    end

    while content.include? delimiter
      con_var =  content[/#{delimiter}(.*?)#{delimiter}/m, 1]
      content_variables << con_var
      content = content.split(delimiter+con_var+delimiter).join(" ")
    end
    return content_variables
  end
end
