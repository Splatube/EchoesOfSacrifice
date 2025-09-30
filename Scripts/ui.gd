extends CanvasLayer

func limit_vision():
	$"Vignette Container/Vignette".material.set_shader_parameter("alpha", 1.0)
	print("blind")
	

func update_limbs(limbs):
	$"Top Left/Minifig/Head".color = "#ffffff" if limbs["head"] else "#ff0000"
	$"Top Left/Minifig/Body/Left Arm/Left Arm".color = "#ffffff" if limbs["arms"] else "#ff0000"
	$"Top Left/Minifig/Body/Left Arm/Left Hand".color = "#ffffff" if limbs["hands"] else "#ff0000"
	$"Top Left/Minifig/Body/Right Arm/Right Arm".color = "#ffffff" if limbs["arms"] else "#ff0000"
	$"Top Left/Minifig/Body/Right Arm/Right Hand".color = "#ffffff" if limbs["hands"] else "#ff0000"
	$"Top Left/Minifig/Legs/Left Leg/Left Leg".color = "#ffffff" if limbs["legs"] else "#ff0000"
	$"Top Left/Minifig/Legs/Left Leg/Left Foot".color = "#ffffff" if limbs["feet"] else "#ff0000"
	$"Top Left/Minifig/Legs/Right Leg/Right Leg".color = "#ffffff" if limbs["legs"] else "#ff0000"
	$"Top Left/Minifig/Legs/Right Leg/Right Foot".color = "#ffffff" if limbs["feet"] else "#ff0000"
