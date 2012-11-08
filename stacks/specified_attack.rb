def specified_attack_stack_content
  
  @specified_attack_stack.append do
    para "Select an attack mode", :align => "center"
    @specified_attack_substack = stack :width=> -85, :height=> -25, :hidden => true do
      border black
      case @general_attack_list.text
        when "WEP"
          # For debugging only
            alert "Wep is chosen"
          attack_mode = ["ChopChop", "Bruteforce"]
        when "WPA"
          # For debugging only
            alert "WPA is chosen"
          attack_mode = ["Pyrit", "Reaver"]
      end
      specified_attack_list = list_box :items => attack_mode, :width => 100 do
      end
    end
  end
  # If line 20 is removed, it doesn't appear. Appending or Preppending a list_box within a stack to a new stack doesn't work.
  # Anyway, now the list_box is displayed, but there is an invisible line eating 2px of height between "Select an attack mode" and the list_box.

  # @specified_attack_substack.centr.middle
end