class GroupController < ApplicationController
	
  def group_home
  

  end
def create_group_function
    a=params[:fields]
    if a
      grp_name=params[:g_name]
      b=Group.new
      if grp_name.length!=0
        b.group_name=grp_name
        b.save
    
       
   
       
          i=0
          for x in a              
           k=GroupDatum.new
           k.group_name_ref=grp_name
           k.cg_email=x
           k.save     
           @f=1
          end
      
    
        redirect_to notices_path
      end
    else
     
      redirect_to group_group_home_path
    end
end
  def group_delete
    @custom_group=Group.pluck(:group_name)
    @list=[]
    @custom_group.each do |name|
      @list.push(name)
    end

    

  end

 def delete_group_btn
    b=params[:group]
    @course=b.fetch("id")
    Group.where(group_name: @course).destroy_all
    GroupDatum.where(group_name_ref: @course).destroy_all
    redirect_to notices_path
 end



end
