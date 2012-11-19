def netcard_stack_content
  @net_interfaces = `ls /sys/class/net | sed -e 's/^\(.*\)$/"\1"/' | paste -sd "," | tr -d '\n'`
  para "Choose an interface:", :align => 'center'
  @netcard_substack = stack :width=> -85, :height=>-25 do
    @netcard_list = list_box :items => @net_interfaces.split(','), :width => 100 do
      @mac_adress_para.replace "Current mac on #{@netcard_list.text}: #{get_current_mac}"
      # Bug of shoes: If I hid the parent stack only, there's a problem on display.
      unless @net_interfaces == ""
        @netcard_mode_para.replace "Choose a mode for #{@netcard_list.text}:"
      else
        @netcard_mode_para.replace "Please choose a wifi interface"
      end
      # Next line is for debugging only -> It should display 0 or nothing unless if we choose "Monitor Mode". This whole block is called two times (issue)
      alert @mmode_switch
      @mmode_list.choose "" unless @mmode_switch == 1
      # Passing @mmode_switch at false in order that it is called only thanks to netcard_mode_stack_content behavior
      @mmode_switch = 0

      @netcard_mode_para.show
      @netcard_mode_substack.show
      @interface_set = 1
    end
  end
  @netcard_substack.middle.centr
end