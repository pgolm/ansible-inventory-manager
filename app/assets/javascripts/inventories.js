$(document).ready(function() {
	// beautify json
	var var_area = $('#var_area');

	if(var_area.length > 0) {
		var_area.val(
			JSON.stringify(JSON.parse(var_area.val()), null, 4)
			);
	}
})