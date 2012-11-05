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
  require 'getmac'

  @interface_set = 0
  semaphore = Mutex.new
  @wid = 780
  @hei = 550
  if "root\n" == `whoami`
    background rgb(100, 100, 200)
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

    flow :width => "#{0.25*@wid}", :height => @hei do
      stack :width => "100%", :height => "10%" do
        border black, :strokewidth => 2
        net_interfaces = `ls /sys/class/net | sed -e 's/^\(.*\)$/"\1"/' | paste -sd "," | tr -d '\n'`
        para "Choose an interface:", :align => 'center'
        @netcard_substack = stack :width=> -85, :height=>-25 do
          @netcard_list = list_box :items => net_interfaces.split(','), :width => 100 do
            @mac_adress_para.replace "Current mac on #{@netcard_list.text}: #{get_current_mac}"
            # Bug of shoes: If I hid the parent stack only, there's a problem on display.
            unless @net_interfaces == ""
              @netcard_mode_para.replace "Choose a mode for #{@netcard_list.text}:"
            else
              @netcard_mode_para.replace "Please choose a wifi interface"
            end
            @mmode_list.choose ""
            @netcard_mode_para.show
            @netcard_mode_substack.show
            @interface_set = 1
          end
        end
        @netcard_substack.middle.centr
      end

      stack :width => "100%", :height => "10%" do
        border black, :strokewidth => 2
        @netcard_mode_para = para "", :align => 'center', :hidden => true
        @netcard_mode_substack = stack :width=> -85, :height=>-25, :hidden => true do
          @mmode_list = list_box :items => ["Monitor", ""], :width => 100 do
            if @mmode_list.text == "monitor"
              if system("sudo ifconfig #{@netcard_list.text} down") 
                if system("sudo iwconfig #{@netcard_list.text} mode monitor")
                  if system("sudo ifconfig #{@netcard_list.text} up")
                    # Notification status change
                  else
                    alert("Wifi interface canno't be restarted")
                    exit
                  end
                else
                  alert("Mode monitor not enabled")
                end
              else
                alert("The wifi interface canno't be closed.")
              end
            end
          end
        end
        @netcard_mode_substack.centr.middle
      end

      mac_stack = stack :width => "100%", :height => "25%" do
        border black, :strokewidth => 2
        background  gray(0.5)
        @mac_adress_para = para "Please choose a wifi interface", :align => 'center'
        @customac_para = edit_line "", :top => 80, :right => 34, :width => 120, :height => 20
        button_one_mac = button "Change mac adress", :top => 105, :right => 8 do

          if @interface_set == 1
            if system("sudo ifconfig #{@netcard_list.text} down")
              if @customac_para.text == ""
                get_random_mac
                # Notification status change
              else
                get_a_mac(@customac_para.text)
              end
              button_one_mac.remove
              mac_stack.append do 
                button "Change", :top => 105, :right => 100 do
                  if @customac_para.text == ""
                    get_random_mac
                    # Notification status change
                  else
                    get_a_mac(@customac_para.text)
                  end
                end
                button "Restore", :top => 105, :right => 5 do
                  get_a_mac(get_permanent_mac)
                  # Notification status change
                end
              end
            end
          else
            alert "You have to choose a network card first"
          end
        end
      end
      stack :width => "100%", :height => "10%" do
        border black, :strokewidth => 2
        banner "A poems"
      end
      stack :width => "100%", :height => "45%" do
        border black, :strokewidth => 2
        banner "A poems"
      end
    end
  else
    alert("You have to be root to launch this tool, you are #{`whoami`}")
    exit
  end
end