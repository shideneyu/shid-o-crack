def specified_attack_stack_content
  @attack_mode_para = para "Select an attack mode", :align => "center", :hidden => true
  @specified_attack_substack = stack :width=> -85, :height=> -25, :hidden => true do
    @specified_attack_list = list_box :items => ["", ""], :width => 100 do
    end
  end
  @specified_attack_substack.centr.middle
end