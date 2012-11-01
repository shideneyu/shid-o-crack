Shoes.app :width => 750, :height => 550 do
  require 'thread'
  require 'getmac'
  semaphore = Mutex.new
  @wid = 750
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
      stack :width => "100%", :height => "20%" do
        border black, :strokewidth => 2
        status = 3
        mmess = "Please set monitor mode on:"
        @monitormode = para mmess, :align => 'center'

        a = `ls /sys/class/net | sed -e 's/^\(.*\)$/"\1"/' | paste -sd "," | tr -d '\n'`
        @l = list_box :items => a.split(',') do
        if status
          mmmess = "Monitor mode enabled on #{@l.text} \n Change interface:"
        elsif status == 0
          mmess = "Monitor mode can't be set on #{@l.text} Change interface:"
        else
          mmess = "Please set monitor mode on: "
        end
          if system("sudo ifconfig #{@l.text} down") 
            if system("sudo iwconfig #{@l.text} mode monitor")
              if system("sudo ifconfig #{@l.text} up")
                @mmess.replace "Mode monitor enabled on #{@l.text}"
                @monitormode.text = mmess
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
      mac_stack = stack :width => "100%", :height => "25%" do
        border black, :strokewidth => 2
        background  gray(0.5)
        @macadress = para "Current mac: #{get_current_mac}", :align => 'center'
        @customac = edit_line "", :top => 80, :right => 34, :width => 120, :height => 20
        mac_first = button "Change mac adress", :top => 105, :right => 8 do
          if system("sudo ifconfig #{@l.text} down") 
            if @customac.text == ""
              get_random_mac
              @macadress.replace "Current mac: #{get_current_mac}"
            else
              get_a_mac(@customac.text)
            end
            mac_first.remove
            mac_stack.append do 
              button "Change", :top => 105, :right => 100 do
                if @customac.text == ""
                  get_random_mac
                  @macadress.replace "Current mac: #{get_current_mac}"
                else
                  get_a_mac(@customac.text)
                end
              end
              button "Restore", :top => 105, :right => 5 do
                get_permanent_mac
                @macadress.replace "Current mac: #{get_permanent_mac}"
              end
            end
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
