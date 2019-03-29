class HomeController < ApplicationController
  def index
  end

  def result
    if params[:graph].present?
      input = params[:graph].split(", ")
    elsif params[:uploaded_file].present?
      input = File.read(params[:uploaded_file].tempfile).split(", ")
    end
    # input = "AB5, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7".split(", ")
    @graph = Hash[input.collect { |n| [n[0..1], n[2].to_i] }]

    # Output #1: 9
    if @graph["AB"] == nil || @graph["BC"] == nil
      @output1 = "NO SUCH ROUTE"
    else
      @output1 = @graph["AB"] + @graph["BC"]
    end

    # Output #2: 5
    if @graph["AD"] == nil
      @output2 = "NO SUCH ROUTE"
    else
      @output2 = @graph["AD"]
    end

    # Output #3: 13
    if @graph["AD"] == nil || @graph["DC"] == nil
      @output3 = "NO SUCH ROUTE"
    else
      @output3 = @graph["AD"] + @graph["DC"]
    end

    # Output #4: 22
    if @graph["AE"] == nil || @graph["EB"] == nil || @graph["BC"] == nil || @graph["CD"] == nil
      @output4 = "NO SUCH ROUTE"
    else
      @output4 = @graph["AE"] + @graph["EB"] + @graph["BC"] + @graph["CD"]
    end

    # Output #5: NO SUCH ROUTE
    if @graph["AE"] == nil || @graph["ED"] == nil
      @output5 = "NO SUCH ROUTE"
    else
      @output5 = @graph["AE"] + @graph["ED"]
    end

    # Output #6: 2
      def funcation_calcRoutes6(startStop, stopCount = 1)
        if startStop[1] == "C"
          return true
        end
        routes = @graph.keys.select { |route| route[0] == startStop[1] }
        stopCount += 1
        if stopCount > 3
          return
        else
          routes.map do |stop|
            calcRoutes6(stop, stopCount)
          end
        end
      end

      startStops6 = @graph.keys.select { |route| route[0] == "C" }
      @output6 = startStops6.map do |startStop|
        calcRoutes6(startStop)
      end
      @output6 = @output6.flatten.count(true)

    # Output #7: 3
    def calcRoutes7(startStop, stopCount = 1)
      if startStop[1] == "C" && stopCount == 4
        return true
      end
      routes = @graph.keys.select { |route| route[0] == startStop[1] }
      stopCount += 1
      if stopCount > 4
        return
      else
        routes.map do |stop|
          calcRoutes7(stop, stopCount)
        end
      end
    end
    startStops7 = @graph.keys.select { |route| route[0] == "A" }
    @output7 = startStops7.map do |startStop|
      calcRoutes7(startStop)
    end
    @output7 = @output7.flatten.count(true)

    # Output #8: 9
    def calcRoutes8(startStop, endStation, distance = 0, stopCount = 0)
      distance += @graph[startStop]
      stopCount += 1
      if startStop[1] == endStation
        return distance
      elsif stopCount > @graph.keys.size
        return Float::INFINITY
      else
        routes = @graph.keys.select { |route| route[0] == startStop[1] }
        routes.map do |stop|
          calcRoutes8(stop, endStation, distance, stopCount)
        end
      end
    end
    startStops8 = @graph.keys.select { |route| route[0] == "A" }
    @output8 = startStops8.map do |startStops|
      calcRoutes8(startStops, "C")
    end
    @output8 = @output8.flatten.min

    # Output #9: 9
    startStops9 = @graph.keys.select { |route| route[0] == "B" }
    @output9 = startStops9.map do |startStops|
      calcRoutes8(startStops, "B")
    end
    @output9 = @output9.flatten.min

    # Output #10: 7
    def calcRoutes10(startStop, distance = 0)
      distance += @graph[startStop]
      if distance >= 30
        return
      elsif startStop[1] == "C"
        @result.push(distance)
      end
        routes = @graph.keys.select { |route| route[0] == startStop[1] }
        routes.map do |stop|
          calcRoutes10(stop, distance)
      end
    end

    @result = []
    startStops10 = @graph.keys.select { |route| route[0] == "C" }
    startStops10.map do |startStops|
      calcRoutes10(startStops)
    end
    @output10 = @result.size


  end
end
