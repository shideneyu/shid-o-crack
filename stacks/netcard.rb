def netcard_stack_content
  net_interfaces = `ls /sys/class/net | sed -e 's/^\(.*\)$/"\1"/' | paste -sd "," | tr -d '\n'`
  para "Choose an interface:", :align => 'center'
  @netcard_substack = stack :width=> -85, :height=>-25 do
    @netcard_list = list_box :items => net_interfaces.split(','), :width => 100 do
      @mac_adress_para.replace "Current mac on #{@netcard_list.text}: #{get_current_mac}"
      # Bug of shoes: If I hid the parent stack (netcard_mode_stack instead of para and substack line 14 && 15), there's a problem on display.
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