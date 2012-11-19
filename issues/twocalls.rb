Shoes.app :width => 780, :height => 550 do
  flow :width => "100%", :height => "100%" do
    stack :width => "100%", :height => "30%" do
      border black, :strokewidth => 2
      @mmode_list = list_box :items => ["Monitor", ""], :width => 100 do
        alert "lol"
      end
      button "Change", :top => 105, :right => 100 do
        item = ["lulz", ""]
        @mmode_list.items = item
       end
       # When we click on the change button, there should be only ONE alert :/
    end
  end
end