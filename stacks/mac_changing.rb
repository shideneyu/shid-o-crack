require 'functions/getmac'
def mac_changing_stack_content
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
        @mac_stack.append do 
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