module V1
  class NewUsersController<ActionController::API
    def show
      #result=[]
      start_date=Date.new(2020,1)
      end_date=Date.new(Date.current.year, Date.current.month)

      months = (start_date..end_date).map{|date| date.strftime("%Y%m")}.uniq


      res= Customer.group("date_trunc('month',created_at)").count.sort
      ren_next=res.map{|k,v|[k.strftime("%Y%m"),v]}.to_h
      # res=res.map{|k,v|{category:k.strftime("%Y%m"),value:v}}



      # binding.pry

      result = months.map do |month|
        {
          'category' => Date.new(month[0..3].to_i, month[4..5].to_i).strftime("%Y-%m"),
          'value' => ren_next.fetch(month, 0)
        }
      end
      render json: {
        data: {
          attributes: {
            name: 'New users',
            value: result
          }
        }
      }
    end
  end
end