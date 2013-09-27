$(document).ready(function() {
	// beautify json
	var var_area = $('#var_area');

	if(var_area.length > 0) {
		var_area.val(
			JSON.stringify(JSON.parse(var_area.val()), null, 4)
			);
	}

	$('#variable-format-switch input').change(function() {
		if(this.id == 'yaml-format') {
			var json_data = JSON.parse(var_area.val())
			if(jQuery.isEmptyObject(json_data)) {
				var_area.val("")
			} else {
				var_area.val(
					jsyaml.safeDump(json_data)
				);
			}
		} else {
			var_area.val(
				JSON.stringify(jsyaml.safeLoad(var_area.val()) || {}, null, 4) 
			);
		}
	})

	$('#yaml-format').click()
})