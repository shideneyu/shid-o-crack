module Shoes::Types
  def centr # milieu horizontal
   left=(self.parent.width-self.style[:width])/2
   self.move(left,self.top)
  end

  def middle # milieu vertical
   top=(self.parent.height-self.style[:height])
   self.move(self.left,top) 
  end
end

Shoes.app :width => 780, :height => 550 do
  require 'thread'
  require 'stacks/netcard'
  require 'stacks/netcard_mode'
  require 'stacks/mac_changing'
  require 'stacks/specified_attack'
  require 'stacks/attack_choice.rb'
  require 'modules/table.rb'
  require 'csv'
      

  @call_sac = proc { specified_attack_stack_content }
  @interface_set = 0
  semaphore = Mutex.new
  @wid = 780
  @hei = 550
  if "root\n" == `whoami`
    background rgb(100, 100, 200)
    
    # First Flow
    flow :width => "#{0.1*@wid}", :height => @hei do
      stack :width => "100%", :height => "30%" do
        border black, :strokewidth => 2
        banner "A poem"
      end
      stack :width => "100%", :height => "70%" do
        border black, :strokewidth => 2
        banner "A poem"
      end
    end

    # Second Flow
    flow :width => "#{0.65*@wid}", :height => @hei do
      stack :width => "100%", :height => "30%" do
        border black, :strokewidth => 2
        banner "Shid'o'Crack"
      end
      stack :width => "100%", :height => "5%" do
        border black, :strokewidth => 2
        banner "Name of this crack:"
      end
      stack :width => "100%", :height => "65%" do
        border black, :strokewidth => 2
        @data = []
        @header = []
        nb_ap = 0
        CSV.foreach("../fd-01.csv") do |row|
          # In the future, to retrieve header dynamically
          # @header << row if [1].include?(nb_ap)
          ids = [1,2,4,5,6,10,11,12,14]
          ids.sort.reverse.each {|id| row.delete_at(id) }
          @data << row unless [0,1].include?(nb_ap)
          nb_ap += 1
        @t=nil
        end
         # @header = @header[0]
        @t=nil
        @z=Proc.new {|x| alert x}
        @y=Proc.new {|x| alert "Hej: #{x}"}
        a = [["BSSID", 150], ["Chan", 50], [" Auth", 49], [" Pow", 50], [" # beacons", 50], [" ESSID", 120]]
        # To keep : BSSID, chan, auth, power, beacon, Essid (to show in first!)
        @t= table :top=>50, :left=>0, :rows=>6, :headers=>a,:items=>@data, :blk=>@f
      end
    end
    # 0 bssid
    # 1 First time seen
    # 2 Last time seen
    # 3 channel
    # 4 Speed
    # 5 Privacy
    # 6 Cipher
    # 7 Authentication
    # 8 Power
    # 9 beacon
    # 10 IV
    # 11 Lan IP
    # 12 ID-length
    # 13 ESSID
    # 14 Key
    # a = [["BSSID", 50],[" First time seen", 20],[" Last time seen", 20], ["channel", 10], [" Speed", 5], [" Privacy", 5], [" Cipher", 5], [" Authentication", 5], [" Power", 50], [" # beacons", 5], [" # IV", 5], [" LAN IP", 50], [" ID-length", 50], [" ESSID", 50], [" Key", 50]]



    # Third flow
    flow :width => "#{0.25*@wid}", :height => @hei do
      # Netcard list stack
      stack :width => "100%", :height => "10%" do
        border black, :strokewidth => 2
        # Calling netcard stack content
        netcard_stack_content
      end

      # Netcard mode stack
      netcard_mode_stack = stack :width => "100%", :height => "10%" do
        # Netcard mode stack
        border black, :strokewidth => 2
        # Calling netcard_mode stack content
        netcard_mode_stack_content
      end

      # Mac changing stack
      @mac_stack = stack :width => "100%", :height => "25%" do
        border black, :strokewidth => 2
        background  gray(0.5)
        # Calling mac changing stack content
        mac_changing_stack_content
      end
      
      # Attack choice stack
      stack :width => "100%", :height => "10%" do
        border black, :strokewidth => 2
        para "Select a mode", :align => "center"
        @general_attack_mode_substack = stack :width=> -85, :height=>-25 do
          border black
          @general_attack_list = list_box :items => ["WEP", "WPA", "Disconnect", "Man in the Middle"], :width => 100 do
            @call_sac.call
            @specified_attack_substack.show
          end
        end
        @general_attack_mode_substack.centr.middle
      end

      @specified_attack_stack = stack :width => "100%", :height => "10%" do
        border black, :strokewidth => 2
      end
      stack :width => "100%", :height => "35%" do
        border black, :strokewidth => 2
        banner "A poems"
      end
    end
  else
    alert("You have to be root to launch this tool, you are #{`whoami`}")
    exit
  end
end
