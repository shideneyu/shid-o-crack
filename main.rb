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
      

  @call_sac = proc { specified_attack_stack_content }
  @interface_set = 0
  semaphore = Mutex.new
  @wid = 780
  @hei = 550
  if "root\n" == `whoami`
    background rgb(100, 100, 200)
    
    # First Flow
    flow :width => "#{0.30*@wid}", :height => @hei do
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
    flow :width => "#{0.45*@wid}", :height => @hei do
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
        banner "Shid'o'Crack"
      end
    end

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