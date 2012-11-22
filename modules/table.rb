class Table < Shoes::Widget
  
  #state = :enabled (default) or :disabled
  #sets the table responsive or non-responsive to clicks
  attr_writer :state
  
  #selected - returns the number of the curently selected row
  attr_reader :selected
  
  #block - sets a new Proc object to be called when row is clicked
  attr_writer :block
 
  #Sets up the table
  #top, left - position of the top and left corner of the table
  #height - number of rows to show without the vertical scrolling bar
  #headers - array of arrays containing headers and widths of the collumns)
  #          in the form of ["title", width]
  #items - array of arrays containing data to be displayed
  #blk - optional Proc object with a block to be called when the row is clicked
  def initialize opts = {}
    
    @block=opts[:blk]||nil
    @selected=nil
    @state=:enabled
    @height=opts[:rows]
    @items=opts[:items] 
    @headers=opts[:headers]
    @columns=@headers.size
    mult = @items.size > @height ? 1:0
    debug(mult)
    #nostroke
    @width=0
    @item=[]
    @headers.each { |x| @width+=(x[1]+1)  }
    nostroke
    fill blue
    @top=opts[:top]
    @left=opts[:left]
    @rec=rect :top => 0, :left => 0, :width=>@width+mult*12+2, :height=>31*(@height+1)+4 
    @lefty=0  
    
    @header=flow do       
        @headers.each_with_index do |h,l|
          temp=(l==@headers.size-1 ? h[1]+12*mult : h[1])
          debug("#{l} -> #{temp}")
          flow :top=>2,:left=>@lefty+2,:width=>temp,:height=>29 do
            rect(:top=>0,:left=>1,:width=>temp,:height=>29, :fill=>lightgrey)
            p=para strong(h[0]), :top=>2,  :align=>'center'
            @lefty+=h[1]+1
          end
        end 
      end
     @flot1=stack :width=>@width+mult*12+2, :height=>40*(@height), :scroll=>true, :top=>33, :left=>1 do
        @items.each_with_index do |it, i|
          inscription " "
          @item[i]=stack :width=>@width-1, :top=>31*i, :left=>1 do
            @lefty=0
            rr=[]
            @columns.times do |ei|
                rr[ei]=rect(:top=>1, :left=>@lefty+1, :width=>@headers[ei][1]-1,:height=>29, :fill=>white)
                it[ei]=" " if not it[ei] or it[ei]==""
                inscription strong(it[ei]), :top=>31*i+3, :left=>@lefty+2, :width=>@headers[ei][1]-1, :align=>'center'
                @lefty+=@headers[ei][1]+1

            end

            # glitched!!
            #hover do
            #  if @state==:enabled
            #    @item[i].contents.each{|x| x.style(:fill=>dimgray)}
            #  end
            #end
            #leave do
            #  if @state==:enabled
            #    alert "leaving!"
            #    if @selected
            #      if @selected==i
            #        @item[i].contents.each{|x| x.style(:fill=>salmon)}
            #      else
            #        @item[i].contents.each{|x| x.style(:fill=>white)}
            #      end
            #    else
            #      @item[i].contents.each{|x| x.style(:fill=>white)}
            #    end
            #  end
            #end
            click do
              if @state==:enabled
                  @selected_item = @item[i].contents.each{|x| x.style(:fill=>red)}
                  #@selected=i
                  @old_item.contents.each{|x| x.style(:fill=>white)} if @old_item
                  @old_item = @item[i]
                  @selected = 1
                @block.call @items[i] if @selected
                #and @block
              end  
            end         
          end
        end
      end
  end
    
  
  #-------------------------------
  
  #Allows for manual selection of the row
  def set_selected(item_no)
    if @selected
      @selected=item_no
      @item[@selected].contents.each{|x| x.contents[1].style(:fill=>salmon)}
    end
  end
 
  #Updates the current list of items shown in the table
  # items - array of items to show
  # height - height of table in rows
  def update_items(items, height=items.size)
    height=height if height<=items.size
    @rec.remove
    @header.remove
    @flot1.remove
    initialize(:top=>@top, :left=>@left,:rows=>height, :headers=>@headers, :items=>items, :blk=>@block)
  end 
  
end
