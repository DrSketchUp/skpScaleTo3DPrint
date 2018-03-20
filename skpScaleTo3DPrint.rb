# Right click on anything to see a Hello World item.

printSubMenu = UI.menu("Plugins").add_submenu("Scale for 3D Print")

printSubMenu.add_item("Scale to Print") {
	model = ::Sketchup.active_model
	selection = ::Sketchup.active_model.selection
	if(selection.length == 1)
		entity = selection.first
		if entity.is_a? Sketchup::Group or Sketchup::ComponentInstance
			
			prompts = ['      1" =']
			defaults = ['10\'']
			input = UI.inputbox(prompts, defaults, "Scale to Print")

			scale = 0.0
						
			if input[0]
				scale = input[0]
				if scale[-1, 1] == "'"	
					scale = scale.chomp("'")
					scale = scale.to_f
				end
			end
			
			scale = 1.0 / scale / 12.0# * 12.0
			
			transform = Geom::Transformation.scaling(scale)
			entity.transform!(transform)
			
		end
	else
		UI.messagebox('Select a single group or component to scale')
	end
}
printSubMenu.add_item("Reset Scale") {
	model = ::Sketchup.active_model
	selection = ::Sketchup.active_model.selection
	if(selection.length == 1)
		entity = selection.first
		if entity.is_a? Sketchup::Group or Sketchup::ComponentInstance
			transform = entity.transformation
			if transform
				transform = transform.invert!
				#transform = Geom::Transformation.scaling(transform.scaling)
				entity.transform!(transform)
			else
				UI.messagebox('No scale found')
			end
		end
	else
		UI.messagebox('Select a single group or component to reset scale')
	end
}