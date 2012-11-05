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

  @status = 0
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
        status = 3
        imess = "Choose an interface"
        net_interfaces = `ls /sys/class/net | sed -e 's/^\(.*\)$/"\1"/' | paste -sd "," | tr -d '\n'`

        @monitormode = para imess, :align => 'center'
        @netcard_substack = stack :width=> -85, :height=>-25 do
          @netcard = list_box :items => net_interfaces.split(','), :width => 100 do
            @macadress.replace "Current mac on #{@netcard.text}: #{get_current_mac}"
            # Bug of shoes: If I hid @netcardmode_stack only, there's a problem on display.
            unless @net_interfaces == ""
              @mmode_text.replace "Choose a mode for #{@netcard.text}:"
            else
              @mmode_text.replace "Please choose a wifi interface"
            end
            @mmode_list.choose ""
            @mmode_text.show
            @netcardmode_substack.show
            @status = 1
          end
        end
        @netcard_substack.middle.centr
      end

      @netcardmode_stack = stack :width => "100%", :height => "10%" do
        border black, :strokewidth => 2
        @mmode_text = para "", :align => 'center', :hidden => true
        @netcardmode_substack = stack :width=> -85, :height=>-25, :hidden => true do
          @mmode_list = list_box :items => ["Monitor", ""], :width => 100 do
            if @mmode_list.text == "monitor"
              if system("sudo ifconfig #{@netcard.text} down") 
                if system("sudo iwconfig #{@netcard.text} mode monitor")
                  if system("sudo ifconfig #{@netcard.text} up")
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
        @netcardmode_substack.centr.middle
      end

      mac_stack = stack :width => "100%", :height => "25%" do
        border black, :strokewidth => 2
        background  gray(0.5)
        @macadress = para "Please choose a wifi interface", :align => 'center'
        @customac = edit_line "", :top => 80, :right => 34, :width => 120, :height => 20
        mac_first = button "Change mac adress", :top => 105, :right => 8 do

          if @status == 1
            if system("sudo ifconfig #{@netcard.text} down")
              if @customac.text == ""
                get_random_mac
                @macadress.replace "Current mac on #{@netcard.text}: #{get_current_mac}"
                # Notification status change
              else
                get_a_mac(@customac.text)
              end
              mac_first.remove
              mac_stack.append do 
                button "Change", :top => 105, :right => 100 do
                  if @customac.text == ""
                    get_random_mac
                    @macadress.replace "Current mac on #{@netcard.text}: #{get_current_mac}"
                    # Notification status change
                  else
                    get_a_mac(@customac.text)
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