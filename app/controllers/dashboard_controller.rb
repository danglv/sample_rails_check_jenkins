class DashboardController < ApplicationController
  def show
    month = Time.now.month
    categories = (1..month).map do |i|
      month_name = (Time.now - (month - i).month).strftime("%B")
      {label: month_name}
    end
    data = (1..month).map do |i|
      start_time = (Time.now - (month - i).month).beginning_of_month
      end_time = (Time.now - (month - i).month).end_of_month
      {value: User.created_in_time(start_time, end_time).count}
    end

    @chart = Fusioncharts::Chart.new({
      width: "600",
      height: "400",
      type: "mscolumn2d",
      renderAt: "chartContainer",
      dataSource: {
        chart: {
        caption: "Number User created",
        subCaption: "",
        xAxisname: "Month",
        yAxisName: "Count",
        # numberPrefix: "$",
        theme: "fint",
        exportEnabled: "1",
        },
        categories: [{
          category: categories
        }],
        dataset: [
          {
              seriesname: "Number of User",
              data: data
          }
        ]
      }
    })
  end
end
