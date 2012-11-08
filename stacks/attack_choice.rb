def attack_choice_stack_content
  para "Select a mode", :align => "center"
    @general_attack_mode_substack = stack :width=> -85, :height=>-25 do
      @general_attack_list = list_box :items => ["WEP", "WPA", "Disconnect", "Fake AP", "Fake AP + MiM"], :width => 100 do
        attack_mode = ""
        case @general_attack_list.text
        when "WEP"
          attack_mode = ["-p0841", "injection"]
          # Planning to add: "StKeys", "BBKeys", "Tecom AH4021/AH4222"
        when "WPA"
          attack_mode = ["Pyrit", "Reaver", "BBKeys"]
          # Planning to add: "Stkeys", "Alice Pirelli AGPF"
        end
        @specified_attack_list.items = attack_mode
        @attack_mode_para.show
        @specified_attack_substack.show
      end
    end
    @general_attack_mode_substack.centr.middle
end