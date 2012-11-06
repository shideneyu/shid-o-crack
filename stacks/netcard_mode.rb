def netcard_mode_stack_content
  @netcard_mode_para = para "", :align => 'center', :hidden => true
  @netcard_mode_substack = stack :width=> -85, :height=>-25, :hidden => true do
    @mmode_list = list_box :items => ["Monitor", ""], :width => 100 do
      if @mmode_list.text == "Monitor"
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